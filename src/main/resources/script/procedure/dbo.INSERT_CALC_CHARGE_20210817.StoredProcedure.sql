USE [logislink]
GO
/****** Object:  StoredProcedure [dbo].[INSERT_CALC_CHARGE_20210817]    Script Date: 2022-07-14 오후 6:16:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[INSERT_CALC_CHARGE_20210817]
(
	@calcId			NVARCHAR(20)
  , @calcTypeCode	NVARCHAR(20)
  , @calcCharge		NVARCHAR(20)
  , @memo			NVARCHAR(1000)
  , @regId			NVARCHAR(20)
  , @retCode		NVARCHAR(2)		OUTPUT
  , @retMsg			NVARCHAR(200)	OUTPUT
)
AS
BEGIN
		
	DECLARE @RET_OK		NVARCHAR(2) = '00'
	DECLARE @RET_ERR	NVARCHAR(2) = '99'
	DECLARE @timestamp	NVARCHAR(14) = ''
	DECLARE @seq		INT
	DECLARE @newCalcId		NVARCHAR(20)
	
	SET @timestamp = convert(varchar, getDate(), 112) + replace(convert(varchar, getDate(), 108), ':', '')
	SELECT @seq = NEXT VALUE FOR SEQ_CALC
	SET @newCalcId = 'C' + @timestamp + RIGHT('00' + @seq, 3)

	INSERT INTO T_CALC 
			   (CALC_ID, ALLOC_ID, ORDER_ID, CALC_TYPE_CODE, 
				SELL_BUY_SCTN, UNPAID_AMT, PAYABLE_AMT, DEPOSIT_AMT, 
				WITHDRAWAL_AMT, CALC_STATE, FINISH_YN, MEMO, 
				CALC_DATE, RECEIPT_YN, TAXINV_YN, MNG_CUST_ID, 
				MNG_DEPT_ID, CUST_ID, DEPT_ID, REGDATE, REGID, 
				VEHIC_ID, DRIVER_ID, USE_YN)
	SELECT	
				@newCalcId, ALLOC_ID, ORDER_ID, @calcTypeCode, 
				SELL_BUY_SCTN, (CASE SELL_BUY_SCTN WHEN '01' THEN CONVERT(BIGINT,@calcCharge) ELSE UNPAID_AMT END), (CASE SELL_BUY_SCTN WHEN '02' THEN CONVERT(BIGINT,@calcCharge) ELSE PAYABLE_AMT END), DEPOSIT_AMT, 
				WITHDRAWAL_AMT, CALC_STATE, FINISH_YN, @memo, 
				CALC_DATE, RECEIPT_YN, TAXINV_YN, MNG_CUST_ID, 
				MNG_DEPT_ID, CUST_ID, DEPT_ID, getdate(), @regId, 
				VEHIC_ID, DRIVER_ID, USE_YN
	FROM 
				T_CALC 
	WHERE 
				CALC_ID = @calcId
		
	set @retCode = @RET_OK
	set @retMsg = '정산 내역이 추가되었습니다.'
END
GO
