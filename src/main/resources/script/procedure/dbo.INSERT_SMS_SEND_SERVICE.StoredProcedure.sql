USE [logislink]
GO
/****** Object:  StoredProcedure [dbo].[INSERT_SMS_SEND_SERVICE]    Script Date: 2022-07-14 오후 6:16:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/**
 * 서비스 이용 관련 알림톡 발송
 * @sendType
 * JOIN(이용신청), IDINFO(아이디알림), PWDINFO(비밀번호알림)
 */
CREATE PROCEDURE [dbo].[INSERT_SMS_SEND_SERVICE] 
(
	@sendType			NVARCHAR(20)
  , @receiveTel			NVARCHAR(13)
  , @receiveName		NVARCHAR(20)
  , @userId				NVARCHAR(20)
  , @userPwd			NVARCHAR(10)
  , @sendTime			CHAR(14)			-- DEFAULT : '00000000000000'(YYYYmmddHHMMss)
)
AS 
BEGIN
	DECLARE @userCode		CHAR(30)		= 'logislink'
	DECLARE @deptCode		CHAR(30)		= 'MY-I3K-U4'
	DECLARE @yellowidKey	VARCHAR(40)		= '966b6917171e03d8c418164201f61c9ea3b88519'
	DECLARE @reqPhone		varchar(20)		= ''
	DECLARE @template		NVARCHAR(20)
	
	DECLARE @adminTel		NVARCHAR(13) = '01026909876'
	
	DECLARE @msg			VARCHAR(4000) = '';

	DECLARE @result			VARCHAR(1)  = '0';

	IF @sendTime != '00000000000000'	
	BEGIN 
		SET @result = 'R'
	END	
	
	IF @sendType = 'JOIN'
	BEGIN
			SET @msg = @receiveName + '님, 안녕하세요.' + CHAR(13) + CHAR(10) + CHAR(13) + CHAR(10)
					+ '로지스링크 이용 신청해주셔서 감사합니다.' + CHAR(13) + CHAR(10) + CHAR(13) + CHAR(10)
					+ '- 접속아이디 : ' + @userId + CHAR(13) + CHAR(10) + CHAR(13) + CHAR(10); 
			SET @msg = @msg + 'PC 뿐만아니라 앱으로도 이용 가능하니 많은 이용 부탁드립니다.' + CHAR(13) + CHAR(10) + CHAR(13) + CHAR(10)
			SET @msg = @msg + '☞ 문의전화 : 1600-1495' + CHAR(13) + CHAR(10) + CHAR(13) + CHAR(10)
			SET @msg = @msg + '* 링크 : abt.logis-link.co.kr'
			SET @msg = @msg + CHAR(13) + CHAR(10)
			SET @msg = @msg + '* 앱 설치 방법 :' + CHAR(13) + CHAR(10)
			SET @msg = @msg + '구글플레이스토어에서 "로지스링크" 검색 후 설치'
			
			SET @template = 'LOGISLINK_014'
			
			INSERT INTO logislink_sms.dbo.SUREData (USERCODE, BIZTYPE, YELLOWID_KEY, REQNAME, REQPHONE, CALLNAME, CALLPHONE, MSG, RESULT, KIND, DEPTCODE,
													REQTIME, RESEND, TEMPLATECODE)
			VALUES (@userCode, 'at', @yellowidKey, '로지스링크', @reqPhone, @receiveName, @receiveTel, @msg, @result, 'T', @deptCode,
					@sendTime, 'N', @template);
					
			INSERT INTO logislink_sms.dbo.SUREData (USERCODE, BIZTYPE, YELLOWID_KEY, REQNAME, REQPHONE, CALLNAME, CALLPHONE, MSG, RESULT, KIND, DEPTCODE,
													REQTIME, RESEND, TEMPLATECODE)
			VALUES (@userCode, 'at', @yellowidKey, '로지스링크', @reqPhone, '관리자', @adminTel, @msg, @result, 'T', @deptCode,
					@sendTime, 'N', @template);
		
	END
	ELSE IF @sendType = 'IDINFO'
	BEGIN		
			SET @msg = @receiveName + '님의 로지스링크 이용 계정은 아래와 같습니다.' + CHAR(13) + CHAR(10) + CHAR(13) + CHAR(10)
					+ '- 접속아이디 : ' + @userId + CHAR(13) + CHAR(10) + CHAR(13) + CHAR(10); 
			SET @msg = @msg + 'PC 뿐만아니라 앱으로도 이용 가능하니 많은 이용 부탁드립니다.' + CHAR(13) + CHAR(10) + CHAR(13) + CHAR(10)
			SET @msg = @msg + '☞ 문의전화 : 1600-1495' + CHAR(13) + CHAR(10) + CHAR(13) + CHAR(10)
			SET @msg = @msg + '* 링크 : abt.logis-link.co.kr'
			SET @msg = @msg + CHAR(13) + CHAR(10)
			SET @msg = @msg + '* 앱 설치 방법 :' + CHAR(13) + CHAR(10)
			SET @msg = @msg + '구글플레이스토어에서 "로지스링크" 검색 후 설치'
			
			SET @template = 'LOGISLINK_015'
			
			INSERT INTO logislink_sms.dbo.SUREData (USERCODE, BIZTYPE, YELLOWID_KEY, REQNAME, REQPHONE, CALLNAME, CALLPHONE, MSG, RESULT, KIND, DEPTCODE,
													REQTIME, RESEND, TEMPLATECODE)
			VALUES (@userCode, 'at', @yellowidKey, '로지스링크', @reqPhone, @receiveName, @receiveTel, @msg, @result, 'T', @deptCode,
					@sendTime, 'N', @template);
				
			INSERT INTO logislink_sms.dbo.SUREData (USERCODE, BIZTYPE, YELLOWID_KEY, REQNAME, REQPHONE, CALLNAME, CALLPHONE, MSG, RESULT, KIND, DEPTCODE,
													REQTIME, RESEND, TEMPLATECODE)
			VALUES (@userCode, 'at', @yellowidKey, '로지스링크', @reqPhone, '관리자', @adminTel, @msg, @result, 'T', @deptCode,
					@sendTime, 'N', @template);
	END
	ELSE IF @sendType =	'PWDINFO'
	BEGIN	
			SET @msg = @receiveName + '님의 로지스링크 비밀번호가 아래와 같이 초기화되었습니다.' + CHAR(13) + CHAR(10)
					+ '로그인 후에는 비밀번호를 변경하시기 바랍니다.' + CHAR(13) + CHAR(10) + CHAR(13) + CHAR(10)
					+ '- 접속아이디 : ' + @userId + CHAR(13) + CHAR(10)
					+ '- 패스워드  : ' + @userPwd + CHAR(13) + CHAR(10) + CHAR(13) + CHAR(10)
			SET @msg = @msg + 'PC 뿐만아니라 앱으로도 이용 가능하니 많은 이용 부탁드립니다.' + CHAR(13) + CHAR(10) + CHAR(13) + CHAR(10)
			SET @msg = @msg + '☞ 문의전화 : 1600-1495' + CHAR(13) + CHAR(10) + CHAR(13) + CHAR(10)
			SET @msg = @msg + '* 링크 : abt.logis-link.co.kr'
			SET @msg = @msg + CHAR(13) + CHAR(10)
			SET @msg = @msg + '* 앱 설치 방법 :' + CHAR(13) + CHAR(10)
			SET @msg = @msg + '구글플레이스토어에서 "로지스링크" 검색 후 설치'
			
			SET @template = 'LOGISLINK_016'
			
			INSERT INTO logislink_sms.dbo.SUREData (USERCODE, BIZTYPE, YELLOWID_KEY, REQNAME, REQPHONE, CALLNAME, CALLPHONE, MSG, RESULT, KIND, DEPTCODE,
													REQTIME, RESEND, TEMPLATECODE)
			VALUES (@userCode, 'at', @yellowidKey, '로지스링크', @reqPhone, @receiveName, @receiveTel, @msg, @result, 'T', @deptCode,
					@sendTime, 'N', @template);
				
			INSERT INTO logislink_sms.dbo.SUREData (USERCODE, BIZTYPE, YELLOWID_KEY, REQNAME, REQPHONE, CALLNAME, CALLPHONE, MSG, RESULT, KIND, DEPTCODE,
													REQTIME, RESEND, TEMPLATECODE)
			VALUES (@userCode, 'at', @yellowidKey, '로지스링크', @reqPhone, '관리자', @adminTel, @msg, @result, 'T', @deptCode,
					@sendTime, 'N', @template);
	END
END
GO
