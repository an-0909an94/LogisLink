USE [logislink]
GO
/****** Object:  StoredProcedure [dbo].[UPDATE_ALLOC_STATE_20220331]    Script Date: 2022-07-14 오후 6:16:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UPDATE_ALLOC_STATE_20220331]
(
	@orderId		NVARCHAR(20)
  , @allocId		NVARCHAR(20)
  , @allocState		NVARCHAR(20)
  , @regid			NVARCHAR(20)
  , @enterDate		NVARCHAR(19)
  , @retCode		NVARCHAR(2)		OUTPUT
  , @retMsg			NVARCHAR(200)	OUTPUT
)
AS
BEGIN
		
	DECLARE @RET_OK		NVARCHAR(2) = '00'
	DECLARE @RET_ERR	NVARCHAR(2) = '99'
	DECLARE @OLD_STATE	NVARCHAR(20)
	DECLARE @ALLOC_CNT 	INT = 0
	DECLARE @BUY_CUST_ID NVARCHAR(20)
	DECLARE @BUY_DEPT_ID NVARCHAR(20)
	
	SELECT @OLD_STATE = ALLOC_STATE, @BUY_CUST_ID = BUY_CUST_ID, @BUY_DEPT_ID = BUY_DEPT_ID FROM T_ORDER_ALLOC WHERE ORDER_ID = @orderId AND ALLOC_ID = @allocId;
	
	IF @OLD_STATE <> @allocState 
		BEGIN
			IF @allocState = '01'
				BEGIN
					UPDATE T_ORDER 
					SET ORDER_STATE = '01'
					  , EDITID = @regid
					WHERE ORDER_ID = @orderId;
				END
			IF @allocState = '04'
				BEGIN
					UPDATE T_ORDER 
					SET ORDER_STATE = '04'
					  , START_DATE = GETDATE()
					  , EDITID = @regid
					  , EDITDATE = GETDATE()
					WHERE ORDER_ID = @orderId;
				END
			IF @allocState = '05'
				BEGIN
					UPDATE T_ORDER 
					SET ORDER_STATE = '05'
					  , FINISH_DATE = GETDATE()
					  , EDITID = @regid
					  , EDITDATE = GETDATE()
					WHERE ORDER_ID = @orderId;
					
					-- 오더 도착일 경우, 미처리된 경유지 상태도 도착으로 변경된다.
					UPDATE T_ORDER_STOP SET FINISH_YN = 'Y', FINISH_DATE = GETDATE()
					WHERE ORDER_ID = @orderId AND FINISH_YN != 'Y';
				END
				
				
			IF @allocState = '12'
				BEGIN
					UPDATE T_ORDER 
					SET ORDER_STATE = '12'
					  , ENTER_DATE = ISNULL(@enterDate ,GETDATE())
					  , EDITID = @regid
					  , EDITDATE = GETDATE()
					WHERE ORDER_ID = @orderId;
				END
							
			IF @allocState = '21'				--배차 취소일 경우, 배차상태/오더상태는 접수상태로 변경된다.
				BEGIN 
					set @allocState = '00'	
					
					-- 하위 배차 내역이 있는 경우 취소 불가
					SELECT @ALLOC_CNT = COUNT(1)
					FROM T_ORDER_ALLOC 
					WHERE ORDER_ID = @orderId AND SELL_CUST_ID = @BUY_CUST_ID AND SELL_DEPT_ID = @BUY_DEPT_ID
						AND ALLOC_STATE != '00';
					
					IF @ALLOC_CNT > 0
						BEGIN		
							set @retCode = @RET_ERR
							set @retMsg = '배차가 이미 진행중입니다.'	
						END		
					ELSE
						BEGIN							
							UPDATE T_ORDER 
							SET ORDER_STATE = '00'
							  , ALLOC_DATE = NULL 
							  , START_DATE = NULL
							  , FINISH_DATE = NULL
							  , ENTER_DATE  = NULL
							  , EDITID = @regid
							  , EDITDATE = GETDATE()
							WHERE ORDER_ID = @orderId;
						
							UPDATE 
								T_ORDER_ALLOC 
							SET 
									VEHIC_ID = NULL
								  , DRIVER_ID = NULL 
								  , CAR_NUM = NULL 
								  , DRIVER_NAME = NULL 
								  , DRIVER_TEL = NULL
								  , BUY_CUST_ID = NULL 
								  , BUY_DEPT_ID = NULL 
								  , BUY_STAFF_ID = NULL
								  , BUY_STAFF_TEL = NULL
								  , ALLOC_DATE = NULL
								  , ALLOC_STATE = @allocState
								  , LINK_YN = 'N'
								  , LINK_CODE = '99'
								  , EDITDATE = GETDATE()
								  , EDITID = @regid
							WHERE 
									ORDER_ID = @orderId 
									AND ALLOC_ID = @allocId;							
						END
				
					
				END
			ELSE	
				BEGIN
					
					UPDATE 
							T_ORDER_ALLOC 
					SET 
							ALLOC_STATE = @allocState
						  , ALLOC_DATE = CASE @allocState WHEN '01' THEN GETDATE() WHEN '10' THEN GETDATE() ELSE ALLOC_DATE END
						  , EDITDATE = GETDATE()
						  , EDITID = @regid
					WHERE 
							ORDER_ID = @orderId 
							AND ALLOC_ID = @allocId;
		
				END
			
		END
	
	IF ISNULL(@retCode, '')	 = '' 
		BEGIN
			set @retCode = @RET_OK
			set @retMsg = '배차 상태가 변경되었습니다.'
		END	
		
END
GO
