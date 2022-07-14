USE [logislink]
GO
/****** Object:  StoredProcedure [dbo].[OAPI_ORDER_STATE_UPDATE]    Script Date: 2022-07-14 오후 6:16:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[OAPI_ORDER_STATE_UPDATE]
(
	@orderId		NVARCHAR(20)
  , @reqCustId		NVARCHAR(20)	
  , @reqDeptId		NVARCHAR(20)	
  , @custId			NVARCHAR(20)	
  , @deptId			NVARCHAR(20)	
  , @orderState		NVARCHAR(20)
  , @regid			NVARCHAR(20)
  , @retCode		NVARCHAR(2)		OUTPUT
  , @retMsg			NVARCHAR(200)	OUTPUT
)
AS
BEGIN
	DECLARE @RET_OK		NVARCHAR(2) = '00'
	DECLARE @RET_ERR	NVARCHAR(2) = '99'
	
	DECLARE @orderCnt		INT
	DECLARE @preOrderState	NVARCHAR(20)
	DECLARE @allocId		NVARCHAR(20)
		
	BEGIN TRY				
			
		IF ISNULL(@reqCustId, '') != '' AND ISNULL(@reqDeptId, '') != ''
		BEGIN
			SELECT @preOrderState = ORDER_STATE  
			FROM T_ORDER
			WHERE ORDER_ID = @orderId
				AND REQ_CUST_ID = @reqCustId AND REQ_DEPT_ID = @reqDeptId
				--AND ALLOC_STATE != '00'
		END
		
		IF ISNULL(@custId, '') != '' AND ISNULL(@deptId, '') != ''
		BEGIN
			SELECT @preOrderState = ORDER_STATE 
			FROM T_ORDER
			WHERE ORDER_ID = @orderId
				AND CUST_ID = @custId AND DEPT_ID = @deptId
				
			SELECT @allocId = ALLOC_ID
			FROM T_ORDER_ALLOC 
			WHERE ORDER_ID = @orderId
				AND SELL_CUST_ID = @custId AND SELL_DEPT_ID = @deptId AND ALLOC_STATE != '00'
		END
				
		IF ISNULL(@preOrderState, '') = ''
		BEGIN 
			THROW 50001, '오더 정보가 없습니다.', 1
		END
		
		
		IF @preOrderState = '09' AND @orderState = '09' 
		BEGIN 
			THROW 50001, '이미 취소된 오더입니다.', 1	
		END
		
		IF @preOrderState != '00' AND @orderState = '09' 
		BEGIN 
			THROW 50001, '배차가 이미 진행중입니다.', 1	
		END
		
		IF @orderState = '00' 
		BEGIN 
			IF @preOrderState = '00'
			BEGIN 
				THROW 50001, '오더가 이미 접수상태입니다.', 1	
			END
			
			IF ISNULL(@allocId, '') = '' 
			BEGIN 
				THROW 50001, '배차 정보가 없습니다.', 1	
			END
			
			UPDATE T_ORDER_ALLOC 
			SET ALLOC_STATE = @orderState
			  , VEHIC_ID = NULL 
			  , DRIVER_ID = NULL 
			  , CAR_NUM = NULL 
			  , DRIVER_NAME = NULL 
			  , DRIVER_TEL = NULL 
			  , CAR_TON_CODE = NULL 
			  , CAR_TYPE_CODE = NULL
			  , EDITDATE = GETDATE()
			  , EDITID = @regid		
			WHERE 
				ORDER_ID = @orderId 
				AND ALLOC_ID = @allocId 
		END
			
		UPDATE T_ORDER 
		SET ORDER_STATE = @orderState
		  , ALLOC_DATE = CASE WHEN @orderState = '09' THEN ALLOC_DATE ELSE NULL END
		  , EDITDATE = GETDATE()
		  , EDITID = @regid		
		WHERE ORDER_ID = @orderId
				
		set @retCode = @RET_OK
		set @retMsg = '오더 상태가 변경되었습니다.'	
		
	END TRY
	BEGIN CATCH 
		IF CAST(ERROR_NUMBER() AS VARCHAR(10)) = '50001' 
		BEGIN 				
		    set @retCode = @RET_ERR
		    set @retMsg = ERROR_MESSAGE()
		END 
		ELSE
		BEGIN
		    set @retCode = @RET_ERR
		    set @retMsg = '상태변경에 실패했습니다.'
		END
	END CATCH
END
GO
