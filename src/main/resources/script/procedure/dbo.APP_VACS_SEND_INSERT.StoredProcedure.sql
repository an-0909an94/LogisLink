USE [logislink]
GO
/****** Object:  StoredProcedure [dbo].[APP_VACS_SEND_INSERT]    Script Date: 2022-07-14 오후 6:16:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/**
 * 기사 앱 예금주 조회
 */
CREATE PROCEDURE [dbo].[APP_VACS_SEND_INSERT]
(
	@module			VARCHAR(2)
  , @driverId		NVARCHAR(20)
  , @vehicId		NVARCHAR(20)
  , @trCd			VARCHAR(4)		-- 2000 : 펌뱅킹 실시간 이체 / 2001 : 가상계좌 성명조회
  , @ibankCd		CHAR(3)
  , @iacctNo		CHAR(16)
  , @iacctNm		CHAR(20)
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
	DECLARE @oacctNo	CHAR(16) = '100053575650'
	--DECLARE @oacctNo	CHAR(16) = '100028820176'  --테스트 출금계좌
	DECLARE @oacctNm	CHAR(20) = '이스턴물류'
	
	DECLARE @seq		INT
	DECLARE @trNo		VARCHAR(6)
	
	SELECT @seq = NEXT VALUE FOR SEQ_VACS_SEND;
	SELECT @trNo = RIGHT('000000' + CAST(@seq AS VARCHAR), 6) 
	
	IF @module = 'VA'
	BEGIN 
		SET @orgCd = '20070123';
	END
	
	-- 가상계좌 예금주 조회 요청
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
			              , DRIVER_ID	
			              , VEHIC_ID	
			              , SEND_CNT
			              , TR_CD
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
              , 0
              , 0
              , '0'
              , @driverId
              , @vehicId
              , 0
              , @trCd
              , @regid
             );
            
    set @retTrNo = @trNo
	set @retCode = @RET_OK
    set @retMsg = '예금주 조회 요청을 했습니다.'
END
GO
