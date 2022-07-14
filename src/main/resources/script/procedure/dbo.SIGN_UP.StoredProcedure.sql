USE [logislink]
GO
/****** Object:  StoredProcedure [dbo].[SIGN_UP]    Script Date: 2022-07-14 오후 6:16:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SIGN_UP]
(
	@custId NVARCHAR(20)
  , @deptId NVARCHAR(20)
  , @bizNum NVARCHAR(10)
  , @userName NVARCHAR(30)
  , @mobile NVARCHAR(13)
  , @email NVARCHAR(30)
  , @userId NVARCHAR(20)
  , @passwd NVARCHAR(256)
  , @authSeq int
  , @bizName NVARCHAR(30)
  , @custTypeCode NVARCHAR(5)
  , @bizCond NVARCHAR(40)
  , @bizKind NVARCHAR(40)
  , @bizTypeCode NVARCHAR(5)
  , @ceo NVARCHAR(30)
  , @bankCode NVARCHAR(5)
  , @bankCnnm NVARCHAR(20)
  , @bankAccount NVARCHAR(20)
  , @deptName NVARCHAR(30)
  , @retCode INT OUTPUT
  , @retMsg NVARCHAR(200) OUTPUT
)
AS
BEGIN
	
	DECLARE @RET_OK NVARCHAR(2) = '00'		-- 성공
	DECLARE @RET_ERR NVARCHAR(2) = '99'		-- Error
	DECLARE @timestamp	NVARCHAR(14) = ''
	
	SET @timestamp = convert(varchar, getDate(), 112) + replace(convert(varchar, getDate(), 108), ':', '')
	
	IF @custId = ''
		BEGIN
			SET @custId = 'C' + @timestamp + '001'
			
			INSERT INTO T_CUST_MST
				(
					CUST_ID		, BIZ_NAME 		, CUST_TYPE_CODE
				  , BIZ_NUM		, CEO			, BIZ_COND
				  , BIZ_KIND 	, REGDATE 		, REGID 
				  , USE_YN 		, BIZ_TYPE_CODE , BIZ_NUM_SUB 
				  , BANK_CODE   , BANK_CNNM 	, BANK_ACCOUNT 
				)
			VALUES
				(
					@custId		, @bizName		, @custTypeCode
				  , @bizNum		, @ceo			, @bizCond
				  , @bizKind	, GETDATE()		, 'SYSTEM'
				  , 'Y'			, @bizTypeCode	, '0000'
				  , @bankCode	, @bankCnnm		, @bankAccount
				)
		END
	IF @deptId = ''
		BEGIN
			SET @deptId = 'D' + @timestamp + '001'
			
			INSERT INTO T_CUST_DEPT
				(
					CUST_ID		, DEPT_ID 		, DEPT_NAME
				  , USE_YN 		, REGDATE 		, REGID 
				)
			VALUES 
				(
					@custId		, @deptId		, @deptName
				  , 'Y'			, GETDATE()		, 'SYSTEM'
				)
		END
	INSERT INTO T_USER
		(
			CUST_ID		, DEPT_ID		, USER_ID
		  , PASSWD		, USER_NAME		, EMAIL
		  , MOBILE		, USE_YN 		, REGDATE 
		  , REGID 		, AUTH_SEQ
		)
	VALUES
		(
			@custId		, @deptId		, @userId
		  , @passwd		, @userName		, @email
		  , @mobile		, 'W'			, GETDATE()
		  , 'SYSTEM'	, @authSeq
		)	
		
	--신청 완료 후 알림톡 전송
	EXEC INSERT_SMS_SEND_SERVICE 'JOIN', @mobile, @userName, @userId, '', '00000000000000'	
		    
	set @retCode = @RET_OK
    set @retMsg = '이용신청이 정상 처리 되었습니다.'
END
GO
