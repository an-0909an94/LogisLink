USE [logislink]
GO
/****** Object:  StoredProcedure [dbo].[INSERT_COMP]    Script Date: 2022-07-14 오후 6:16:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[INSERT_COMP]
(
	@inCustId NVARCHAR(20)
  , @bizName NVARCHAR(30)
  , @custTypeCode NVARCHAR(5)
  , @bizNum NVARCHAR(10)
  , @bizNumSub NVARCHAR(10)
  , @ceo NVARCHAR(30)
  , @bizCond NVARCHAR(20)
  , @bizKind NVARCHAR(20)
  , @bizAddr NVARCHAR(50)
  , @regId NVARCHAR(20)
  , @bizTypeCode  NVARCHAR(5)
  , @bizPost NVARCHAR(7)
  , @bizAddrDetail NVARCHAR(50)
  , @editId NVARCHAR(20)
  , @bankCode NVARCHAR(5)
  , @bankCnnm NVARCHAR(20)
  , @bankAccount NVARCHAR(20)
  , @retCode INT OUTPUT
  , @retMsg NVARCHAR(200) OUTPUT
  , @custId NVARCHAR(20) OUTPUT
)
AS
BEGIN
	
	DECLARE @RET_OK NVARCHAR(2) = '00'		-- 성공
	DECLARE @RET_ERR NVARCHAR(2) = '99'		-- Error
	DECLARE @timestamp	NVARCHAR(14) = ''
	
	IF @bizNumSub = ''
		BEGIN 
			SET @bizNumSub = '0000'
		END
	
	IF @inCustId = ''
		BEGIN
			SET @timestamp = convert(varchar, getDate(), 112) + replace(convert(varchar, getDate(), 108), ':', '')
			SET @inCustId = 'C' + @timestamp + '001'
			
			INSERT INTO dbo.T_CUST_MST 
				(
					CUST_ID, BIZ_NAME, CUST_TYPE_CODE, BIZ_NUM, CEO, 
					BIZ_COND, BIZ_KIND, BIZ_POST, BIZ_ADDR, BIZ_ADDR_DETAIL, 
					REGID, BIZ_NUM_SUB, BIZ_TYPE_CODE, REGDATE, BANK_CODE,
					BANK_CNNM, BANK_ACCOUNT 
				)
		    VALUES
		    	(
		    		@inCustId, @bizName, @custTypeCode, @bizNum, @ceo, 
		    		@bizCond, @bizKind, @bizPost, @bizAddr, @bizAddrDetail, 
		    		@regId, @bizNumSub, @bizTypeCode, GETDATE(), @bankCode,
		    		@bankCnnm, @bankAccount
		    	)
		    
		    set @retCode = @RET_OK
		    set @retMsg = '조직 정보가 추가되었습니다.'
		    set @custId = @inCustId
		END
	ELSE
		BEGIN
			UPDATE dbo.T_CUST_MST
		    SET 
		        BIZ_NAME = @bizName,
		        CUST_TYPE_CODE = @custTypeCode,
		        CEO = @ceo,
		        BIZ_TYPE_CODE = @bizTypeCode,
		        BIZ_COND = @bizCond,
		        BIZ_KIND = @bizKind,
		        BIZ_POST = @bizPost,
		        BIZ_ADDR = @bizAddr,
		        BIZ_ADDR_DETAIL = @bizAddrDetail,
		        BIZ_NUM_SUB = @bizNumSub,
		        EDITID = @editId,
		        EDITDATE = GETDATE(),  
		        BANK_CODE = @bankCode,
				BANK_CNNM = @bankCnnm, 
				BANK_ACCOUNT = @bankAccount 
		    WHERE CUST_ID = @inCustId
		    
		    set @retCode = @RET_OK
		    set @retMsg = '조직 정보가 수정되었습니다.'
		    set @custId = @inCustId
		END
END
GO
