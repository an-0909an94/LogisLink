USE [logislink]
GO
/****** Object:  StoredProcedure [dbo].[INSERT_USER]    Script Date: 2022-07-14 오후 6:16:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[INSERT_USER]
(
	@custId NVARCHAR(20)
  , @deptId NVARCHAR(20)
  , @authSeq int
  , @userId NVARCHAR(20)
  , @passwd NVARCHAR(256)
  , @userName NVARCHAR(30)
  , @telNum NVARCHAR(13)
  , @email NVARCHAR(30)
  , @talkYn NVARCHAR(1)
  , @mobile NVARCHAR(13)
  , @grade NVARCHAR(10)
  , @masterYn NVARCHAR(1)
  , @useYn NVARCHAR(1)
  , @memo NVARCHAR(1000)
  , @regId NVARCHAR(20)
  , @editId NVARCHAR(20)
  , @link24Id NVARCHAR(100)
  , @douzoneId NVARCHAR(100)
  , @retCode INT OUTPUT
  , @retMsg NVARCHAR(200) OUTPUT
)
AS
BEGIN
	
	DECLARE @RET_OK NVARCHAR(2) = '00'		-- 성공
	DECLARE @RET_ERR NVARCHAR(2) = '99'		-- Error
	
	DECLARE @prev_passwd NVARCHAR(256) = ''
	
	SELECT @prev_passwd = PASSWD FROM T_USER WHERE USER_ID = @userId
	
	IF @passwd = ''
		BEGIN 
			SET @passwd = @prev_passwd
		END

	SELECT *
    FROM dbo.T_USER
    WHERE USER_ID = @userId

    IF @@ROWCOUNT=0
    	BEGIN 
            INSERT INTO dbo.T_USER (CUST_ID, DEPT_ID, AUTH_SEQ, USER_ID, PASSWD, USER_NAME, TELNUM, EMAIL, TALK_YN, MOBILE, GRADE, MASTER_YN, USE_YN, MEMO, REGDATE, REGID, LINK24_ID, DOUZONE_ID)
            VALUES(@custId, @deptId, @authSeq, REPLACE(@userId,' ',''), @passwd, @userName, @telNum, @email, @talkYn, @mobile, @grade, ISNULL(@masterYn, 'N'), 'Y', @memo, GETDATE(), @regId, @link24Id, @douzoneId)
            
            set @retCode = @RET_OK
            set @retMsg = '사용자 정보가 추가되었습니다.'
    	END
	ELSE
	    BEGIN
		    UPDATE dbo.T_USER
		    SET 
		        -- CUST_ID = @custId,
		        DEPT_ID = @deptId,
		        AUTH_SEQ = @authSeq,
		        PASSWD = Case When ISNULL(@passwd, '') = '' THEN PASSWD ELSE @passwd END,
		        USER_NAME = @userName,
		        TELNUM = @telNum,
		        EMAIL = @email,
		        TALK_YN = @talkYn,
		        MOBILE = @mobile,
		        GRADE = @grade,
		        MASTER_YN = ISNULL(@masterYn, 'N'),
		        USE_YN = @useYn,
		        MEMO = @memo,
		        EDITDATE = GETDATE(),
		        EDITID = @editId,
		        LINK24_ID = @link24Id,
		        DOUZONE_ID = @douzoneId
		    WHERE USER_ID = @userId
		    
			set @retCode = @RET_OK
		    set @retMsg = '사용자 정보가 수정되었습니다.'
	    END
END
GO
