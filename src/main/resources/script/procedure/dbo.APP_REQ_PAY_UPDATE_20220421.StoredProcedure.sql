USE [logislink]
GO
/****** Object:  StoredProcedure [dbo].[APP_REQ_PAY_UPDATE_20220421]    Script Date: 2022-07-14 오후 6:16:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[APP_REQ_PAY_UPDATE_20220421]
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
	
	-- DECLARE @orderCnt	INT			= 0
	DECLARE @payType		NVARCHAR(1) = 'N'
	
	DECLARE @bankCode		NVARCHAR(5)
	DECLARE @bankCnnm		NVARCHAR(20)
	DECLARE @bankAccount	NVARCHAR(30)
	
	DECLARE @sellCustId		NVARCHAR(20)
	DECLARE @sellDeptId		NVARCHAR(20)
	DECLARE @allocCharge	INT
	DECLARE @calcAmt		INT
	
	DECLARE @timestamp		NVARCHAR(14) = ''
	DECLARE @seq			INT
	DECLARE @newCalcId		NVARCHAR(20)
	
	SELECT @payType = PAY_TYPE, @sellCustId = SELL_CUST_ID, @sellDeptId = SELL_DEPT_ID --,  @allocCharge = ALLOC_CHARGE
	FROM T_ORDER_ALLOC 
	WHERE ORDER_ID = @orderId AND ALLOC_ID = @allocId AND DRIVER_ID= @driverId AND VEHIC_ID = @vehicId 
	
	SELECT @bankCode = BANK_CODE, @bankCnnm = BANK_CNNM, @bankAccount = BANK_ACCOUNT
	FROM T_DRIVER 
	WHERE DRIVER_ID = @driverId
	
	IF ISNULL(@payType, 'N') != 'Y' 
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
		SET @timestamp = convert(varchar, getDate(), 112) + replace(convert(varchar, getDate(), 108), ':', '')
		SELECT @seq = NEXT VALUE FOR SEQ_CALC
		SET @newCalcId = 'C' + @timestamp + RIGHT('00' + @seq, 3)
		
		SELECT @allocCharge = SUM(PAYABLE_AMT)
		FROM T_CALC  
		WHERE ALLOC_ID = @allocId AND USE_YN = 'Y'
	
		UPDATE T_ORDER_ALLOC 
		SET REQ_PAY_YN = 'Y',
			REQ_PAY_DATE = GETDATE(),
			EDITID = @driverId,
			EDITDATE = GETDATE()
		WHERE ALLOC_ID = @allocId
		
		-- 빠른지급 동의 
		INSERT INTO T_DRIVER_AGREE (DRIVER_ID, ALLOC_ID, CAR_NUM, DRIVER_TEL, DRIVER_NAME, AGREE_DATE, CID)
		SELECT @driverId, @allocId, B.CAR_NUM, A.MOBILE, A.DRIVER_NAME, GETDATE(), A.CID 
		FROM T_DRIVER A
			 INNER JOIN
			 T_VEHIC_MST B ON A.DRIVER_ID = B.DRIVER_ID AND A.DRIVER_ID = @driverId AND B.VEHIC_ID = @vehicId
			 
		-- 서비스 수수료 계산
		SELECT @calcAmt = CEILING(CONVERT(FLOAT, FEE) * @allocCharge / 100) 
		FROM T_CUST_FEE 
		WHERE CUST_ID = @sellCustId AND S_DATE < GETDATE() AND ISNULL(E_DATE, GETDATE()) >= GETDATE()
		
		-- 정산 등록
		INSERT INTO T_CALC 
				   (CALC_ID, ALLOC_ID, ORDER_ID, CALC_TYPE_CODE, SELL_BUY_SCTN,
				    PAYABLE_AMT, CALC_STATE, FINISH_YN,	MNG_CUST_ID, MNG_DEPT_ID, 
				    REGDATE, REGID,	VEHIC_ID, DRIVER_ID, USE_YN)
		VALUES (@newCalcId, @allocId, @orderId, '0901', '02',
				@calcAmt * (-1), '00', 'N', @sellCustId, @sellDeptId, 
				GETDATE(), @driverId, @vehicId, @driverId, 'Y')
		
		
		
		-- 빠른 지급 신청 후, 기사에게 알림톡 전송
		EXEC INSERT_SMS_SEND 'PAYREQ', @orderId, @allocId, '', '', '00000000000000';
		
		
		set @retCode = @RET_OK
		set @retMsg = '빠른 지급 신청이 완료되었습니다.'	
	END
	
END
GO
