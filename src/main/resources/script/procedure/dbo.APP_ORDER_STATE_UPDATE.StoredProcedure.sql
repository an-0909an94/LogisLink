USE [logislink]
GO
/****** Object:  StoredProcedure [dbo].[APP_ORDER_STATE_UPDATE]    Script Date: 2022-07-14 오후 6:16:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[APP_ORDER_STATE_UPDATE]
(
	@orderId		NVARCHAR(20)
  , @orderState		NVARCHAR(20)
  , @regid			NVARCHAR(20)
  , @retCode		NVARCHAR(2)		OUTPUT
  , @retMsg			NVARCHAR(200)	OUTPUT
)
AS
BEGIN
	DECLARE @RET_OK		NVARCHAR(2) = '00'
	DECLARE @RET_ERR	NVARCHAR(2) = '99'
	
	DECLARE @allocCnt		INT		= 0
	DECLARE @reqCustId		NVARCHAR(20)
	DECLARE @reqDeptId		NVARCHAR(20)
	
	--오더 취소일 경우, 운송사 지정이나 배차받은 오더가 없어야함.
	IF @orderState = '09'
	BEGIN
		SELECT @reqCustId = REQ_CUST_ID, @reqDeptId = REQ_DEPT_ID
		FROM T_ORDER 
		WHERE ORDER_ID = @orderId
		
		SELECT @allocCnt = COUNT(1)
		FROM T_ORDER_ALLOC toa 
		WHERE ORDER_ID = @orderId 
			AND (SELL_CUST_ID != @reqCustId AND SELL_DEPT_ID != @reqDeptId)
			AND ALLOC_STATE != '00'
	END
	
	IF @allocCnt = 0
	BEGIN 
		UPDATE T_ORDER 
		SET ORDER_STATE = @orderState
		  , EDITDATE = GETDATE()
		  , EDITID = @regid		
		WHERE ORDER_ID = @orderId
				
		set @retCode = @RET_OK
		set @retMsg = '오더 상태가 변경되었습니다.'	
	END
	ELSE 
	BEGIN 
		
		set @retCode = @RET_ERR
		set @retMsg = '배차가 이미 진행중입니다.'	
	END
	
END
GO
