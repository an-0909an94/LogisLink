USE [logislink]
GO
/****** Object:  StoredProcedure [dbo].[APP_REQ_PAY_UPDATE_20211208]    Script Date: 2022-07-14 오후 6:16:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[APP_REQ_PAY_UPDATE_20211208]
(
	@orderId		NVARCHAR(20)
  , @allocId		NVARCHAR(20)
  , @driverId		NVARCHAR(20)
  , @vehicId		NVARCHAR(20)
  , @retCode		NVARCHAR(2)		OUTPUT
  , @retMsg			NVARCHAR(200)	OUTPUT
)
AS 
BEGIN
	
	DECLARE @RET_OK		NVARCHAR(2) = '00'
	DECLARE @RET_ERR	NVARCHAR(2) = '99'
	
	DECLARE @orderCnt	INT			= 0
	
	DECLARE @bankCode		NVARCHAR(5)
	DECLARE @bankCnnm		NVARCHAR(20)
	DECLARE @bankAccount	NVARCHAR(30)
	
	SELECT @orderCnt = COUNT(1)
	FROM T_ORDER_ALLOC 
	WHERE ORDER_ID = @orderId AND ALLOC_ID = @allocId AND DRIVER_ID= @driverId AND VEHIC_ID = @vehicId AND PAY_TYPE = 'Y'
	
	SELECT @bankCode = BANK_CODE, @bankCnnm = BANK_CNNM, @bankAccount = BANK_ACCOUNT
	FROM T_DRIVER 
	WHERE DRIVER_ID = @driverId
	
	IF @orderCnt = 0 
	BEGIN 
		set @retCode = @RET_ERR
		set @retMsg = '빠른 지급을 신청할 수 없는 오더입니다.'	
	END
	ELSE IF ISNULL(@bankCode, '') = '' OR ISNULL(@bankCnnm, '') = '' OR ISNULL(@bankAccount, '') = ''
	BEGIN 
		set @retCode = @RET_ERR
		set @retMsg = '[내정보]에서 계좌정보 입력 후 신청할 수 있습니다.'
	END
	ELSE 
	BEGIN 
		UPDATE T_ORDER_ALLOC 
		SET REQ_PAY_YN = 'Y',
			REQ_PAY_DATE = GETDATE(),
			EDITID = @driverId,
			EDITDATE = GETDATE()
		WHERE ALLOC_ID = @allocId
		
		
		-- 빠른 지급 신청 후, 기사에게 알림톡 전송
		EXEC INSERT_SMS_SEND 'PAYREQ', @orderId, @allocId, '', '', '00000000000000';
		
		
		set @retCode = @RET_OK
		set @retMsg = '빠른 지급 신청이 완료되었습니다.'	
	END
	
END
GO
