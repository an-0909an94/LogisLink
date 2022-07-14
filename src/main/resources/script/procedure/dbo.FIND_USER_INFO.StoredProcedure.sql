USE [logislink]
GO
/****** Object:  StoredProcedure [dbo].[FIND_USER_INFO]    Script Date: 2022-07-14 오후 6:16:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[FIND_USER_INFO]
(
    @userName 		NVARCHAR(30)
  , @userPhone 		NVARCHAR(13)
  , @userId 		NVARCHAR(20)
  , @mode 			NVARCHAR(2)
  , @passWord		NVARCHAR(6)
  , @shaPassWord	NVARCHAR(256)
  , @retCode		NVARCHAR(2)		OUTPUT
  , @retMsg 		NVARCHAR(200) 	OUTPUT
)
AS
BEGIN
	DECLARE @RET_OK NVARCHAR(2) = '00'		-- 성공
	DECLARE @RET_ERR NVARCHAR(2) = '99'		-- Error
	
	IF @mode = 'pw'
		BEGIN
			IF NOT EXISTS 
				(
					SELECT 
						PASSWD 
					FROM 
						T_USER 
					WHERE USER_ID = @userId 
						AND MOBILE = @userPhone 
						AND USER_NAME = @userName
						AND USE_YN = 'Y'
				) 
				BEGIN 
			    	set @retCode = @RET_ERR
				    set @retMsg = '입력하신 정보로 비밀번호를 찾을 수 없습니다.'
				END
			ELSE 
				BEGIN
					UPDATE T_USER 
					SET PASSWD = @shaPassWord
					WHERE USER_ID = @userId 
						AND MOBILE = @userPhone 
						AND USER_NAME = @userName
						AND USE_YN = 'Y'
					
					EXEC INSERT_SMS_SEND_SERVICE 'PWDINFO', @userPhone, @userName, @userId, @passWord, '00000000000000'
					
			    	set @retCode = @RET_OK
				    set @retMsg = '알림톡으로 임시 비밀번호를 전송했습니다.'
				END
		END
	ELSE IF @mode = 'id'
		BEGIN
			IF NOT EXISTS 
				(
					SELECT 
						USER_ID 
					FROM 
						T_USER 
					WHERE MOBILE = @userPhone 
						AND USER_NAME = @userName
						AND USE_YN = 'Y'
				) 
				BEGIN 
			    	set @retCode = @RET_ERR
				    set @retMsg = '입력하신 정보로 아이디를 찾을 수 없습니다.'
				END
			ELSE 
				BEGIN
					SELECT @userId = USER_ID 
					FROM T_USER 
					WHERE MOBILE = @userPhone 
						AND USER_NAME = @userName
						AND USE_YN = 'Y'
					
					EXEC INSERT_SMS_SEND_SERVICE 'IDINFO', @userPhone, @userName, @userId, '', '00000000000000' 
					
			    	set @retCode = @RET_OK
				    set @retMsg = '알림톡으로 아이디를 전송했습니다.'
				END
		END
END
GO
