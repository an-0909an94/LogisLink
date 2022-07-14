USE [logislink]
GO
/****** Object:  StoredProcedure [dbo].[INSERT_VACS_SEND_20220112]    Script Date: 2022-07-14 오후 6:16:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/**
 * 세틀뱅크 전문 요청 프로시저
 * module : FM (펌뱅킹) / VA(가상계좌)
 */
CREATE PROCEDURE [dbo].[INSERT_VACS_SEND_20220112]
(
	@module			VARCHAR(2)
  ,	@trAmt			INT	
  , @custId			NVARCHAR(20)
  , @deptId			NVARCHAR(20)
  , @driverId		NVARCHAR(20)
  , @vehicId		NVARCHAR(20)
  , @trCd			VARCHAR(4)		-- 2000 : 펌뱅킹 실시간 이체 / 2001 : 가상계좌 성명조회
  , @mngCustId		NVARCHAR(20)
  , @mngDeptId		NVARCHAR(20)
  , @paySeq			BIGINT
  , @regid			NVARCHAR(100)
  , @retTrNo		NVARCHAR(6)		OUTPUT
  , @retCode		NVARCHAR(2)		OUTPUT
  , @retMsg			NVARCHAR(200)	OUTPUT
)
AS
BEGIN
	DECLARE @RET_OK NVARCHAR(2) = '00'		-- 성공
	DECLARE @RET_ERR NVARCHAR(2) = '99'		-- Error

	DECLARE @orgCd		CHAR(8) = '41000415'
	DECLARE @obankCd	CHAR(3) = '088'
	DECLARE @oacctNo	CHAR(16) = '100035575650'
	--DECLARE @oacctNo	CHAR(16) = '100028820176'  --테스트 출금계좌
	DECLARE @oacctNm	CHAR(20) = '이스턴물류'
	DECLARE @ibankCd	CHAR(3)
	DECLARE @iacctNo	CHAR(16)
	DECLARE @iacctNm	CHAR(20)
	
	DECLARE @seq		INT
	DECLARE @trNo		VARCHAR(6)
	DECLARE @cnt		INT
	DECLARE @trFee		INT
	
	IF ISNULL(@driverId, '') != '' 
	BEGIN
		SELECT @ibankCd = BANK_CODE, @iacctNo = BANK_ACCOUNT, @iacctNm = BANK_CNNM 
		FROM T_DRIVER td 
		WHERE DRIVER_ID = @driverId
	END
	
	IF @module = 'VA'
	BEGIN 
		SET @orgCd = '20070123';
	END
	
	--테스트 입금계좌 
	-- 하나은행 14391028489407
	--SET @ibankCd = '088' 
	--SET @iacctNo = '110472727793'	
	
	SELECT @seq = NEXT VALUE FOR SEQ_VACS_SEND;
	SELECT @trNo = RIGHT('000000' + CAST(@seq AS VARCHAR), 6) 
	
	-- 펌뱅킹 출금 요청
    INSERT INTO VACS_SEND (
    						MODULE
			    		  ,	ORG_CD		
			    		  , TR_NO			
			    		  , TR_IL			
			    		  , TR_SI			
			    		  , OBANK_CD
			              , OACCT_NO	
			              , OACCT_NM		
			              , IBANK_CD		
			              , IACCT_NO		
			              , IACCT_NM
			              , TR_AMT		
			              , TR_FEE		
			              , INP_ST		
			              , CUST_ID		
			              , DEPT_ID
			              , DRIVER_ID	
			              , VEHIC_ID		
			              , MNG_CUST_ID	
			              , MNG_DEPT_ID	
			              , SEND_CNT
			              , TR_CD
			              , PAY_SEQ
			              , REGID)
    VALUES	(
    			@module
    		  , @orgCd		
    		  , @trNo	
    		  , CONVERT(CHAR(8), GETDATE(), 112)
    		  , REPLACE(CONVERT(CHAR(8), GETDATE(), 8), ':', '')
              , @obankCd
              , @oacctNo
              , @oacctNm
              , @ibankCd
              , @iacctNo
              , @iacctNm
              , @trAmt
              , @trFee
              , '0'
              , @custId
              , @deptId
              , @driverId
              , @vehicId
              , @mngCustId
              , @mngDeptId
              , 0
              , @trCd
              , @paySeq
              , @regid
             );
            
	
    set @retTrNo = @trNo
	set @retCode = @RET_OK
    set @retMsg = '출금 요청을 완료했습니다.'            
END
GO
