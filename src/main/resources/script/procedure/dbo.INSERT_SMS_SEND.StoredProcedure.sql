USE [logislink]
GO
/****** Object:  StoredProcedure [dbo].[INSERT_SMS_SEND]    Script Date: 2022-07-14 오후 6:16:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/**
 * 알림톡 전송 프로시저
 * @sendType 
 * ALLOCINFO(배차알림), ALLOCCANCEL(배차취소), ALLOCFINISH(운송완료), PAYREQ(빠른지급신청), RECEIPTOK (인수증접수완료), TAXOK(세금계산서접수완료), PAYINFO(운임지급알림), STARTINFO(도착예정시간알림)
 * SMARTBILLJOIN(스마트빌회원가입요청), ORDERNOTI(화주오더등록), ALLOCNOTI(주선사배차완료)
 */
CREATE PROCEDURE [dbo].[INSERT_SMS_SEND]
(
	@sendType		NVARCHAR(20)
  , @orderId		NVARCHAR(20)
  , @allocId		NVARCHAR(20)
  , @driverId		NVARCHAR(20)
  , @vehicId		NVARCHAR(20)
  , @sendTime		CHAR(14)			-- DEFAULT : '00000000000000'(YYYYmmddHHMMss)
)
AS 
BEGIN
	DECLARE @userCode		CHAR(30)		= 'logislink'
	DECLARE @deptCode		CHAR(30)		= 'MY-I3K-U4'
	DECLARE @yellowidKey	VARCHAR(40)		= '966b6917171e03d8c418164201f61c9ea3b88519'
	DECLARE @reqPhone		varchar(20)		= ''
	DECLARE @carNum			NVARCHAR(10)
	DECLARE @driverName		NVARCHAR(20)
	DECLARE @driverTel		NVARCHAR(13)
	DECLARE @sAddr			NVARCHAR(50)
	DECLARE @sAddrDetail	NVARCHAR(50)
	DECLARE @sMemo			NVARCHAR(100)
	DECLARE @eAddr			NVARCHAR(50)
	DECLARE @eAddrDetail	NVARCHAR(50)
	DECLARE @eMemo			NVARCHAR(100)
	DECLARE @goodsName		NVARCHAR(100)
	DECLARE @charge			INT
	DECLARE @fee			INT
	DECLARE @payType		NVARCHAR(1)
	DECLARE @template		NVARCHAR(20)
	DECLARE @talkYN			NVARCHAR(1)	
	DECLARE @reqPayYn		NVARCHAR(1)
	
	DECLARE @time			INT
	DECLARE @eTel			NVARCHAR(13)
	DECLARE @eStaff			NVARCHAR(20)
	DECLARE @stopAddr		NVARCHAR(50)
	DECLARE @stopAddrDetail	NVARCHAR(50)
	DECLARE @stopTel		NVARCHAR(13)
	DECLARE @stopSe			VARCHAR(1)
	DECLARE @stopStaff		NVARCHAR(20)
	DECLARE @sDate			DATETIME
	DECLARE @arrivalTime	NVARCHAR(10)
	
	DECLARE @buyStaffTel	NVARCHAR(13)
	DECLARE @sellCustId		NVARCHAR(20)
	DECLARE @sellDeptId		NVARCHAR(20)
	DECLARE @sellStaffId	NVARCHAR(20)
	DECLARE @sellStaffTel	NVARCHAR(13)
	DECLARE @buyCustId		NVARCHAR(20)
	DECLARE @buyDeptId		NVARCHAR(20)
	DECLARE @custName		NVARCHAR(30)
	DECLARE @userName		NVARCHAR(30)
	DECLARE @regid			NVARCHAR(20)
	
	DECLARE @mngCustId		NVARCHAR(20)
	DECLARE @mngDeptId		NVARCHAR(20)
	
	DECLARE @msg			VARCHAR(4000) = '';

	DECLARE @allocLink		VARCHAR(300) = 'https://app.logis-link.co.kr/nonmember/search/order?orderId=' + @orderId + '&allocId=' + @allocId
	DECLARE @tmsAllocLink	VARCHAR(300) = 'https://app.logis-link.co.kr/nonmember/search/link/tmsOrder?allocId=' + @allocId
	DECLARE @omsAllocLink	VARCHAR(300) = 'https://app.logis-link.co.kr/nonmember/search/link/omsOrder?orderId=' + @orderId
	DECLARE @taxLink		VARCHAR(300) = 'https://app.logis-link.co.kr/nonmember/search/link/tax?allocId=' + @allocId
	DECLARE @imgReceiptLink VARCHAR(300) = 'https://app.logis-link.co.kr/nonmember/search/link/receipt?allocId=' + @allocId
	DECLARE @payLink		VARCHAR(300) = 'https://app.logis-link.co.kr/nonmember/search/link/order?allocId=' + @allocId
	
	DECLARE @allocBtnTitle 	VARCHAR(56) = '배차정보 조회하기' 
	DECLARE @taxBtnTitle 	VARCHAR(56) = '세금계산서 발행하기' 
	DECLARE @imgBtnTitle 	VARCHAR(56) = '사진인수증 등록하기' 
	DECLARE @payTitle 		VARCHAR(56) = '빠른지급 신청하기' 
	
	DECLARE @adminTel		NVARCHAR(13) = '01026909876'
	--DECLARE @adminTel		NVARCHAR(13) = '01073999372'
	
	DECLARE @result			VARCHAR(1)  = '0';

	IF @sendTime != '00000000000000'	
	BEGIN 
		SET @result = 'R'
	END	
	
	SELECT
			@carNum			= B.CAR_NUM 
		  , @driverName		= B.DRIVER_NAME 
		  , @driverTel		= B.DRIVER_TEL 
		  , @sAddr			= A.S_ADDR 
		  , @sAddrDetail	= ISNULL(A.S_ADDR_DETAIL, '') 
		  , @eAddr			= A.E_ADDR 
		  , @eAddrDetail	= ISNULL(A.E_ADDR_DETAIL, '') 
		  , @sMemo			= A.S_MEMO 
		  , @eMemo			= A.E_MEMO 
		  , @goodsName		= A.GOODS_NAME 
		  , @charge			= ISNULL(B.ALLOC_CHARGE, 0)
		  , @payType		= ISNULL(B.PAY_TYPE, 'N') 
		  , @talkYN			= ISNULL(C.TALK_YN, 'N') 
		  , @time			= A.[TIME] 
		  , @eTel			= A.E_TEL 
		  , @eStaff			= A.E_STAFF
		  , @sDate			= A.START_DATE
		  , @reqPayYn		= ISNULL(B.REQ_PAY_YN, 'N') 
		  , @buyStaffTel	= ISNULL(B.BUY_STAFF_TEL, '')
		  , @sellCustId		= B.SELL_CUST_ID 
		  , @sellDeptId		= B.SELL_DEPT_ID
		  , @sellStaffId	= B.SELL_STAFF_ID 
		  , @sellStaffTel	= ISNULL(B.SELL_STAFF_TEL , '')
		  , @buyCustId		= B.BUY_CUST_ID 
		  , @buyDeptId		= B.BUY_DEPT_ID
		  , @regid			= A.REGID
		  , @mngCustId		= A.CUST_ID 
		  , @mngDeptId		= A.DEPT_ID 
	FROM 
			T_ORDER A 
			INNER JOIN
			T_ORDER_ALLOC B ON A.ORDER_ID = B.ORDER_ID AND A.ORDER_ID = @orderId AND B.ALLOC_ID = @allocId
			LEFT OUTER JOIN 
			T_DRIVER C ON B.DRIVER_ID = C.DRIVER_ID 
	
	IF @sendType = 'ALLOCCANCEL'
	BEGIN
		SELECT @carNum = A.CAR_NUM, @driverName = B.DRIVER_NAME, @driverTel = B.MOBILE,  @talkYN = ISNULL(B.TALK_YN, 'N') 
		FROM T_VEHIC_MST A
			 INNER JOIN 
			 T_DRIVER B ON A.DRIVER_ID = B.DRIVER_ID 
		WHERE A.VEHIC_ID = @vehicId AND A.DRIVER_ID = @driverId 
	END 
	
	IF @sendType = 'SMARTBILLJOIN'
	BEGIN 
		SET @msg = '[로지스링크](스마트빌회원가입신청)' + CHAR(13) + CHAR(10)  + CHAR(13) + CHAR(10)				
		SET @msg = @msg + '▶ 차량번호 : ' + @carNum		 
		SET @msg = @msg + CHAR(13) + CHAR(10)
		SET @msg = @msg + '▶ 차량기사 : ' + @driverName
		SET @msg = @msg + CHAR(13) + CHAR(10)
		SET @msg = @msg + '▶ 기사번호 : ' + @driverTel 
		SET @msg = @msg + CHAR(13) + CHAR(10)
		SET @msg = @msg + '▶ 배차번호 : ' + @orderId
		
		SET @template = 'LOGISLINK_011'
				
		INSERT INTO logislink_sms.dbo.SUREData (USERCODE, BIZTYPE, YELLOWID_KEY, REQNAME, REQPHONE, CALLNAME, CALLPHONE, MSG, RESULT, KIND, DEPTCODE,
												REQTIME, RESEND, TEMPLATECODE)
		VALUES (@userCode, 'at', @yellowidKey, '로지스링크', @reqPhone, '관리자', @adminTel, @msg, @result, 'T', @deptCode,
				@sendTime, 'N', @template)
				
		set @talkYN = 'N'		
	END
	ELSE IF @sendType = 'ORDERNOTI' 	-- 화주->주선사 오더 알림
	BEGIN
		IF @buyStaffTel != '' 
		BEGIN 
			SELECT @custName = CUST_NAME 
			FROM T_CUST_DTL 
			WHERE MNG_CUST_ID = @buyCustId AND MNG_DEPT_ID = @buyDeptId AND CUST_ID = @sellCustId AND DEPT_ID = @sellDeptId
			
			SELECT @userName = USER_NAME 
			FROM T_USER 
			WHERE USER_ID = @sellStaffId
			
			SET @msg = '[로지스링크](오더등록알림)' + CHAR(13) + CHAR(10) 
			SET @msg = @msg + '안녕하세요 로지스링크입니다.' + CHAR(13) + CHAR(10)
			SET @msg = @msg + @custName + ', ' + @userName + '님이 오더를 등록하였습니다.' + CHAR(13) + CHAR(10) + CHAR(13) + CHAR(10)
			SET @msg = @msg + '▶ 상차지 : ' + @sAddr + ' ' + @sAddrDetail ; 
			SET @msg = @msg + CASE WHEN ISNULL(@sMemo, '') <> '' THEN '(' + @sMemo + ')' ELSE '' END 
			SET @msg = @msg + CHAR(13) + CHAR(10)
			SET @msg = @msg + '▶ 하차지 : ' + @eAddr + ' ' + @eAddrDetail ;
			SET @msg = @msg + CASE WHEN ISNULL(@eMemo, '') <> '' THEN '(' + @eMemo + ')' ELSE '' END 
			SET @msg = @msg + CHAR(13) + CHAR(10)
			SET @msg = @msg + '▶ 화물 : ' + @goodsName		 
			SET @msg = @msg + CHAR(13) + CHAR(10)
			SET @msg = @msg + '▶ 화주운임 : ' + FORMAT(@charge, N'#,0') + '원'
			SET @msg = @msg + CHAR(13) + CHAR(10)
			SET @msg = @msg + '▶ 배차번호 : ' + @orderId
			SET @msg = @msg + CHAR(13) + CHAR(10) + CHAR(13) + CHAR(10)
			SET @msg = @msg + '* 앱 설치 방법 : 구글플레이스토어에서 "로지스링크" 검색 ▷ "주선사/운송사용" 선택 후 설치'
					
			SET @template = 'LOGISLINK_009'
					
			INSERT INTO logislink_sms.dbo.SUREData (USERCODE, BIZTYPE, YELLOWID_KEY, REQNAME, REQPHONE, CALLNAME, CALLPHONE, MSG, RESULT, KIND, DEPTCODE,
													REQTIME, RESEND, TEMPLATECODE, BTN_TYPE_01, BTN_NM_01, BTN_01_URL_01, BTN_01_URL_02)
			VALUES (@userCode, 'at', @yellowidKey, '로지스링크', @reqPhone, @buyStaffTel, @buyStaffTel, @msg, @result, 'T', @deptCode,
					@sendTime, 'N', @template, 'WL', @allocBtnTitle, @tmsAllocLink, '')
		END
	END
	ELSE IF @sendType = 'ALLOCNOTI'		-- 주선사->화주 배차알림
	BEGIN
		
		SELECT @sellStaffTel = SELL_STAFF_TEL, @sellStaffId = SELL_STAFF_ID
		FROM T_ORDER_ALLOC 
		WHERE ORDER_ID = @orderId AND BUY_CUST_ID = @sellCustId AND BUY_DEPT_ID = @sellDeptId
		
		--화주가 올린 오더에 대해서만 배차알림톡 발송
		IF @sellStaffId = @regid 
		BEGIN 
			SET @msg = '[로지스링크] (배차알림)' + CHAR(13) + CHAR(10) 
			SET @msg = @msg + '안녕하세요 로지스링크입니다.' + CHAR(13) + CHAR(10)
			SET @msg = @msg + '등록하신 오더에 대한 배차가 확정되었습니다.' + CHAR(13) + CHAR(10) + CHAR(13) + CHAR(10)
			SET @msg = @msg + '▶ 상차지 : ' + @sAddr + ' ' + @sAddrDetail ; 
			SET @msg = @msg + CASE WHEN ISNULL(@sMemo, '') <> '' THEN '(' + @sMemo + ')' ELSE '' END 
			SET @msg = @msg + CHAR(13) + CHAR(10)
			SET @msg = @msg + '▶ 하차지 : ' + @eAddr + ' ' + @eAddrDetail ;
			SET @msg = @msg + CASE WHEN ISNULL(@eMemo, '') <> '' THEN '(' + @eMemo + ')' ELSE '' END 
			SET @msg = @msg + CHAR(13) + CHAR(10)
			SET @msg = @msg + '▶ 화물 : ' + @goodsName		 
			SET @msg = @msg + CHAR(13) + CHAR(10)		
			SET @msg = @msg + '▶ 차량번호 : ' + @carNum		 
			SET @msg = @msg + CHAR(13) + CHAR(10)
			SET @msg = @msg + '▶ 차량기사 : ' + @driverName
			SET @msg = @msg + CHAR(13) + CHAR(10)
			SET @msg = @msg + '▶ 기사번호 : ' + @driverTel 
			SET @msg = @msg + CHAR(13) + CHAR(10)
			SET @msg = @msg + '▶ 배차번호 : ' + @orderId
			SET @msg = @msg + CHAR(13) + CHAR(10) + CHAR(13) + CHAR(10)
			SET @msg = @msg + '* 앱 설치 방법 : 구글플레이스토어에서 "로지스링크" 검색 ▷ "화주용" 선택 후 설치'
			
			SET @template = 'LOGISLINK_010'
			
			INSERT INTO logislink_sms.dbo.SUREData (USERCODE, BIZTYPE, YELLOWID_KEY, REQNAME, REQPHONE, CALLNAME, CALLPHONE, MSG, RESULT, KIND, DEPTCODE,
													REQTIME, RESEND, TEMPLATECODE, BTN_TYPE_01, BTN_NM_01, BTN_01_URL_01, BTN_01_URL_02)
			VALUES (@userCode, 'at', @yellowidKey, '로지스링크', @reqPhone, @sellStaffTel, @sellStaffTel, @msg, @result, 'T', @deptCode,
					@sendTime, 'N', @template, 'WL', @allocBtnTitle, @omsAllocLink, '')
		END
		
	END
			
	IF ISNULL(@driverTel, '') != '' AND @talkYN = 'Y'
	BEGIN
		IF @sendType = 'ALLOCINFO' AND @mngCustId = @sellCustId AND @mngDeptId = @sellDeptId 	--직배차인 경우에만 배차 알림톡 발송
		BEGIN
			-- [배차알림-빠른지급]
			IF @payType = 'Y' 
			BEGIN
				SET @msg = '[로지스링크](배차알림)' + CHAR(13) + CHAR(10) 
						+ @carNum + '차주님, 신규 화물이 배차되었습니다.' + CHAR(13) + CHAR(10) + CHAR(13) + CHAR(10)
						+ '본 화물은 [빠른지급]을 신청하시면 운임을 빨리 받을 수 있습니다.' + CHAR(13) + CHAR(10)
						+ '(문의전화 : 1600-1495)' + CHAR(13) + CHAR(10) + CHAR(13) + CHAR(10) 
						+ '▶ 상차지 : ' + @sAddr + ' ' + @sAddrDetail ; 
				SET @msg = @msg + CASE WHEN ISNULL(@sMemo, '') <> '' THEN '(' + @sMemo + ')' ELSE '' END 
				SET @msg = @msg + CHAR(13) + CHAR(10)
				SET @msg = @msg + '▶ 하차지 : ' + @eAddr + ' ' + @eAddrDetail ;
				SET @msg = @msg + CASE WHEN ISNULL(@eMemo, '') <> '' THEN '(' + @eMemo + ')' ELSE '' END 
				SET @msg = @msg + CHAR(13) + CHAR(10)
				SET @msg = @msg + '▶ 화물 : ' + @goodsName		 
				SET @msg = @msg + CHAR(13) + CHAR(10)
				SET @msg = @msg + '▶ 배차번호 : ' + @orderId
				--SET @msg = @msg + CHAR(13) + CHAR(10) + CHAR(13) + CHAR(10)
				--SET @msg = @msg + '* 앱 설치 방법 : 구글플레이스토어에서 "로지스링크" 검색 ▷ "차주용" 선택 후 설치'
				
				SET @template = 'LOGISLINK_601'
						
				INSERT INTO logislink_sms.dbo.SUREData (USERCODE, BIZTYPE, YELLOWID_KEY, REQNAME, REQPHONE, CALLNAME, CALLPHONE, MSG, RESULT, KIND, DEPTCODE,
														REQTIME, RESEND, TEMPLATECODE, BTN_TYPE_01, BTN_NM_01, BTN_01_URL_01, BTN_01_URL_02)
				VALUES (@userCode, 'at', @yellowidKey, '로지스링크', @reqPhone, @driverName, @driverTel, @msg, @result, 'T', @deptCode,
						@sendTime, 'N', @template, 'WL', @allocBtnTitle, @allocLink, '')
			END 
			-- [배차알림]
			ELSE
			BEGIN
				SET @msg = '[로지스링크](배차알림)' + CHAR(13) + CHAR(10) 
						+ @carNum + '차주님, 신규 화물이 배차되었습니다.' + CHAR(13) + CHAR(10) + CHAR(13) + CHAR(10)
						+ '(문의전화 : 1600-1495)' + CHAR(13) + CHAR(10) + CHAR(13) + CHAR(10) 
						+ '▶ 상차지 : ' + @sAddr + ' ' + @sAddrDetail ; 
				SET @msg = @msg + CASE WHEN ISNULL(@sMemo, '') <> '' THEN '(' + @sMemo + ')' ELSE '' END 
				SET @msg = @msg + CHAR(13) + CHAR(10)
				SET @msg = @msg + '▶ 하차지 : ' + @eAddr + ' ' + @eAddrDetail ;
				SET @msg = @msg + CASE WHEN ISNULL(@eMemo, '') <> '' THEN '(' + @eMemo + ')' ELSE '' END 
				SET @msg = @msg + CHAR(13) + CHAR(10)
				SET @msg = @msg + '▶ 화물 : ' + @goodsName		 
				SET @msg = @msg + CHAR(13) + CHAR(10)
				SET @msg = @msg + '▶ 배차번호 : ' + @orderId
				--SET @msg = @msg + CHAR(13) + CHAR(10) + CHAR(13) + CHAR(10)
				--SET @msg = @msg + '* 앱 설치 방법 : 구글플레이스토어에서 "로지스링크" 검색 ▷ "차주용" 선택 후 설치'
				
				SET @template = 'LOGISLINK_601N'
						
				INSERT INTO logislink_sms.dbo.SUREData (USERCODE, BIZTYPE, YELLOWID_KEY, REQNAME, REQPHONE, CALLNAME, CALLPHONE, MSG, RESULT, KIND, DEPTCODE,
														REQTIME, RESEND, TEMPLATECODE, BTN_TYPE_01, BTN_NM_01, BTN_01_URL_01, BTN_01_URL_02)
				VALUES (@userCode, 'at', @yellowidKey, '로지스링크', @reqPhone, @driverName, @driverTel, @msg, @result, 'T', @deptCode,
						@sendTime, 'N', @template, 'WL', @allocBtnTitle, @allocLink, '')
			END
		END
		-- [배차취소알림]
		ELSE IF @sendType = 'ALLOCCANCEL' AND @mngCustId = @sellCustId AND @mngDeptId = @sellDeptId 	--직배차인 경우에만 배차 알림톡 발송
		BEGIN
			SET @msg = '[로지스링크](배차취소)' + CHAR(13) + CHAR(10) 
					+ @carNum + '차주님, 배차가 취소되었습니다.' + CHAR(13) + CHAR(10) + CHAR(13) + CHAR(10)
					+ '▶ 상차지 : ' + @sAddr + ' ' + @sAddrDetail ; 
			SET @msg = @msg + CHAR(13) + CHAR(10)
			SET @msg = @msg + '▶ 하차지 : ' + @eAddr + ' ' + @eAddrDetail
			SET @msg = @msg + CHAR(13) + CHAR(10)
			SET @msg = @msg + '▶ 화물 : ' + @goodsName		 
			SET @msg = @msg + CHAR(13) + CHAR(10)
			SET @msg = @msg + '▶ 취소배차번호 : ' + @orderId
			--SET @msg = @msg + CHAR(13) + CHAR(10) + CHAR(13) + CHAR(10)
			--SET @msg = @msg + '* 앱 설치 방법 : 구글플레이스토어에서 "로지스링크" 검색 ▷ "차주용" 선택 후 설치'
			
			SET @template = 'LOGISLINK_602'
			
			INSERT INTO logislink_sms.dbo.SUREData (USERCODE, BIZTYPE, YELLOWID_KEY, REQNAME, REQPHONE, CALLNAME, CALLPHONE, MSG, RESULT, KIND, DEPTCODE,
													REQTIME, RESEND, TEMPLATECODE)
			VALUES (@userCode, 'at', @yellowidKey, '로지스링크', @reqPhone, @driverName, @driverTel, @msg, @result, 'T', @deptCode,
					@sendTime, 'N', @template)
		END	
		ELSE IF @sendType = 'ALLOCFINISH' AND @mngCustId = @sellCustId AND @mngDeptId = @sellDeptId 	--직배차인 경우에만 배차 알림톡 발송
		BEGIN
			-- [운송완료-빠른지급]
			IF @payType = 'Y' 
			BEGIN
				SET @msg = '[로지스링크](운송완료)' + CHAR(13) + CHAR(10) 
					+ @carNum + '차주님, 운행하신 화물의 운송이 완료되었습니다.' + CHAR(13) + CHAR(10) + CHAR(13) + CHAR(10)
					+ '본 화물은 [빠른지급]을 신청하시면 운임을 빨리 받을 수 있습니다.' + CHAR(13) + CHAR(10)
					+ '(문의전화 : 1600-1495)' + CHAR(13) + CHAR(10) + CHAR(13) + CHAR(10) 
					+ '▶ 상차지 : ' + @sAddr + ' ' + @sAddrDetail ; 
				SET @msg = @msg + CHAR(13) + CHAR(10)
				SET @msg = @msg + '▶ 하차지 : ' + @eAddr + ' ' + @eAddrDetail
				SET @msg = @msg + CASE WHEN ISNULL(@eMemo, '') <> '' THEN '(' + @eMemo + ')' ELSE '' END 
				SET @msg = @msg + CHAR(13) + CHAR(10)
				SET @msg = @msg + '▶ 화물 : ' + @goodsName
				SET @msg = @msg + CHAR(13) + CHAR(10)
				SET @msg = @msg + '▶ 배차번호 : ' + @orderId
				--SET @msg = @msg + CHAR(13) + CHAR(10) + CHAR(13) + CHAR(10)
				--SET @msg = @msg + '* 앱 설치 방법 : 구글플레이스토어에서 "로지스링크" 검색 ▷ "차주용" 선택 후 설치'
			
				SET @template = 'LOGISLINK_603'
				
				INSERT INTO logislink_sms.dbo.SUREData (USERCODE, BIZTYPE, YELLOWID_KEY, REQNAME, REQPHONE, CALLNAME, CALLPHONE, MSG, RESULT, KIND, DEPTCODE,
														REQTIME, RESEND, TEMPLATECODE, BTN_TYPE_01, BTN_NM_01, BTN_01_URL_01, BTN_01_URL_02,
														BTN_TYPE_02, BTN_NM_02, BTN_02_URL_01, BTN_02_URL_02,
														BTN_TYPE_03, BTN_NM_03, BTN_03_URL_01, BTN_03_URL_02)
				VALUES (@userCode, 'at', @yellowidKey, '로지스링크', @reqPhone, @driverName, @driverTel, @msg, @result, 'T', @deptCode,
						@sendTime, 'N', @template, 'WL', @imgBtnTitle, @imgReceiptLink, '', 
						'WL', @taxBtnTitle, @taxLink, '', 
						'WL', @payTitle, @payLink, '')
			END
			-- [운송완료]
			ELSE
			BEGIN
				SET @msg = '[로지스링크](운송완료)' + CHAR(13) + CHAR(10) 
					+ @carNum + '차주님, 운행하신 화물의 운송이 완료되었습니다.' + CHAR(13) + CHAR(10) + CHAR(13) + CHAR(10)
					+ '(문의전화 : 1600-1495)' + CHAR(13) + CHAR(10) + CHAR(13) + CHAR(10) 
					+ '▶ 상차지 : ' + @sAddr + ' ' + @sAddrDetail ; 
				SET @msg = @msg + CHAR(13) + CHAR(10)
				SET @msg = @msg + '▶ 하차지 : ' + @eAddr + ' ' + @eAddrDetail
				SET @msg = @msg + CASE WHEN ISNULL(@eMemo, '') <> '' THEN '(' + @eMemo + ')' ELSE '' END 
				SET @msg = @msg + CHAR(13) + CHAR(10)
				SET @msg = @msg + '▶ 화물 : ' + @goodsName	
				SET @msg = @msg + CHAR(13) + CHAR(10)
				SET @msg = @msg + '▶ 배차번호 : ' + @orderId
				--SET @msg = @msg + CHAR(13) + CHAR(10) + CHAR(13) + CHAR(10)
				--SET @msg = @msg + '* 앱 설치 방법 : 구글플레이스토어에서 "로지스링크" 검색 ▷ "차주용" 선택 후 설치'
			
				SET @template = 'LOGISLINK_603N'
				
				INSERT INTO logislink_sms.dbo.SUREData (USERCODE, BIZTYPE, YELLOWID_KEY, REQNAME, REQPHONE, CALLNAME, CALLPHONE, MSG, RESULT, KIND, DEPTCODE,
														REQTIME, RESEND, TEMPLATECODE, BTN_TYPE_01, BTN_NM_01, BTN_01_URL_01, BTN_01_URL_02,
														BTN_TYPE_02, BTN_NM_02, BTN_02_URL_01, BTN_02_URL_02)
				VALUES (@userCode, 'at', @yellowidKey, '로지스링크', @reqPhone, @driverName, @driverTel, @msg, @result, 'T', @deptCode,
						@sendTime, 'N', @template, 'WL', @imgBtnTitle, @imgReceiptLink, '', 
						'WL', @taxBtnTitle, @taxLink, '')
			END
		END
		-- [빠른지급신청완료]
		ELSE IF @sendType = 'PAYREQ'
		BEGIN		
			
			SELECT @charge = ISNULL(SUM(PAYABLE_AMT), 0)
			FROM T_CALC
			WHERE ALLOC_ID = @allocId AND USE_YN = 'Y'
			
			SET @msg = '[로지스링크](빠른지급신청완료)' + CHAR(13) + CHAR(10) 
				+ @carNum + '차주님, 빠른지급 신청이 완료되었습니다.' + CHAR(13) + CHAR(10) + CHAR(13) + CHAR(10)
				+ '[인수증접수], [세금계산서발행] 하시면 운임이 지급됩니다. (영업일 기준 3일 내 지급 예정, 문의전화 : 1600-1495)' + CHAR(13) + CHAR(10) + CHAR(13) + CHAR(10)
				+ '▶ 상차지 : ' + @sAddr + ' ' + @sAddrDetail ; 
			SET @msg = @msg + CHAR(13) + CHAR(10)
			SET @msg = @msg + '▶ 하차지 : ' + @eAddr + ' ' + @eAddrDetail
			SET @msg = @msg + CHAR(13) + CHAR(10)
			SET @msg = @msg + '▶ 화물 : ' + @goodsName	
			SET @msg = @msg + CHAR(13) + CHAR(10)
			SET @msg = @msg + '▶ 빠른운임 : ' + FORMAT(@charge, N'#,0') + '원 (이용료제외)'
			SET @msg = @msg + CHAR(13) + CHAR(10)
			SET @msg = @msg + '▶ 배차번호 : ' + @orderId
			--SET @msg = @msg + CHAR(13) + CHAR(10) + CHAR(13) + CHAR(10)
			--SET @msg = @msg + '* 앱 설치 방법 : 구글플레이스토어에서 "로지스링크" 검색 ▷ "차주용" 선택 후 설치'
		
			SET @template = 'LOGISLINK_604'
			
			INSERT INTO logislink_sms.dbo.SUREData (USERCODE, BIZTYPE, YELLOWID_KEY, REQNAME, REQPHONE, CALLNAME, CALLPHONE, MSG, RESULT, KIND, DEPTCODE,
													REQTIME, RESEND, TEMPLATECODE, BTN_TYPE_01, BTN_NM_01, BTN_01_URL_01, BTN_01_URL_02,
													BTN_TYPE_02, BTN_NM_02, BTN_02_URL_01, BTN_02_URL_02)
			VALUES (@userCode, 'at', @yellowidKey, '로지스링크', @reqPhone, @driverName, @driverTel, @msg, @result, 'T', @deptCode,
					@sendTime, 'N', @template, 'WL', @imgBtnTitle, @imgReceiptLink, '', 
					'WL', @taxBtnTitle, @taxLink, '')
		END	
		ELSE IF @sendType = 'RECEIPTOK'
		BEGIN
			-- [인수증접수완료-빠른지급]
			IF @payType = 'Y' 
			BEGIN
				SET @msg = '[로지스링크](인수증접수완료)' + CHAR(13) + CHAR(10) 
					+ @carNum + '차주님, 인수증이 접수되었습니다.' + CHAR(13) + CHAR(10) + CHAR(13) + CHAR(10)
					+ '본 화물은 [빠른지급]을 신청하시면 운임을 빨리 받을 수 있습니다.' + CHAR(13) + CHAR(10)
					+ '(문의전화 : 1600-1495)' + CHAR(13) + CHAR(10) + CHAR(13) + CHAR(10) 
					+ '▶ 상차지 : ' + @sAddr + ' ' + @sAddrDetail ; 
				SET @msg = @msg + CHAR(13) + CHAR(10)
				SET @msg = @msg + '▶ 하차지 : ' + @eAddr + ' ' + @eAddrDetail
				SET @msg = @msg + CHAR(13) + CHAR(10)
				SET @msg = @msg + '▶ 화물 : ' + @goodsName	
				SET @msg = @msg + CHAR(13) + CHAR(10)
				SET @msg = @msg + '▶ 배차번호 : ' + @orderId
				--SET @msg = @msg + CHAR(13) + CHAR(10) + CHAR(13) + CHAR(10)
				--SET @msg = @msg + '* 앱 설치 방법 : 구글플레이스토어에서 "로지스링크" 검색 ▷ "차주용" 선택 후 설치'
			
				SET @template = 'LOGISLINK_605'
				
				INSERT INTO logislink_sms.dbo.SUREData (USERCODE, BIZTYPE, YELLOWID_KEY, REQNAME, REQPHONE, CALLNAME, CALLPHONE, MSG, RESULT, KIND, DEPTCODE,
														REQTIME, RESEND, TEMPLATECODE, BTN_TYPE_01, BTN_NM_01, BTN_01_URL_01, BTN_01_URL_02,
														BTN_TYPE_02, BTN_NM_02, BTN_02_URL_01, BTN_02_URL_02)
				VALUES (@userCode, 'at', @yellowidKey, '로지스링크', @reqPhone, @driverName, @driverTel, @msg, @result, 'T', @deptCode,
						@sendTime, 'N', @template, 'WL', @taxBtnTitle, @taxLink, '', 
						'WL', @payTitle, @payLink, '')
			END
			-- [인수증접수완료]
			ELSE
			BEGIN
				SET @msg = '[로지스링크](인수증접수완료)' + CHAR(13) + CHAR(10) 
					+ @carNum + '차주님, 인수증이 접수되었습니다.' + CHAR(13) + CHAR(10) + CHAR(13) + CHAR(10)
					+ '(문의전화 : 1600-1495)' + CHAR(13) + CHAR(10) + CHAR(13) + CHAR(10) 
					+ '▶ 상차지 : ' + @sAddr + ' ' + @sAddrDetail ; 
				SET @msg = @msg + CHAR(13) + CHAR(10)
				SET @msg = @msg + '▶ 하차지 : ' + @eAddr + ' ' + @eAddrDetail
				SET @msg = @msg + CHAR(13) + CHAR(10)
				SET @msg = @msg + '▶ 화물 : ' + @goodsName	
				SET @msg = @msg + CHAR(13) + CHAR(10)
				SET @msg = @msg + '▶ 배차번호 : ' + @orderId
				--SET @msg = @msg + CHAR(13) + CHAR(10) + CHAR(13) + CHAR(10)
				--SET @msg = @msg + '* 앱 설치 방법 : 구글플레이스토어에서 "로지스링크" 검색 ▷ "차주용" 선택 후 설치'
			
				SET @template = 'LOGISLINK_605N'
				
				INSERT INTO logislink_sms.dbo.SUREData (USERCODE, BIZTYPE, YELLOWID_KEY, REQNAME, REQPHONE, CALLNAME, CALLPHONE, MSG, RESULT, KIND, DEPTCODE,
														REQTIME, RESEND, TEMPLATECODE, BTN_TYPE_01, BTN_NM_01, BTN_01_URL_01, BTN_01_URL_02)
				VALUES (@userCode, 'at', @yellowidKey, '로지스링크', @reqPhone, @driverName, @driverTel, @msg, @result, 'T', @deptCode,
						@sendTime, 'N', @template, 'WL', @taxBtnTitle, @taxLink, '')
			END
		END
		ELSE IF @sendType = 'TAXOK'
		BEGIN
			
			SELECT @charge = ISNULL(SUM(WITHDRAWAL_AMT), 0) + ISNULL(SUM(PAYABLE_AMT), 0)
			FROM T_CALC
			WHERE ALLOC_ID = @allocId AND USE_YN = 'Y'
			
			-- [세금계산서접수완료-빠른지급]
			IF @reqPayYn = 'Y' 
			BEGIN
				SET @msg = '[로지스링크](세금계산서접수완료)' + CHAR(13) + CHAR(10) 
					+ @carNum + '차주님, 세금계산서가 접수되었습니다.' + CHAR(13) + CHAR(10) + CHAR(13) + CHAR(10)
					+ '▶ 상차지 : ' + @sAddr + ' ' + @sAddrDetail ; 
				SET @msg = @msg + CHAR(13) + CHAR(10)
				SET @msg = @msg + '▶ 하차지 : ' + @eAddr + ' ' + @eAddrDetail
				SET @msg = @msg + CHAR(13) + CHAR(10)
				SET @msg = @msg + '▶ 화물 : ' + @goodsName	
				SET @msg = @msg + CHAR(13) + CHAR(10)
				SET @msg = @msg + '▶ 빠른운임 : ' + FORMAT(@charge, N'#,0') + '원 (이용료제외)'
				SET @msg = @msg + CHAR(13) + CHAR(10)
				SET @msg = @msg + '▶ 배차번호 : ' + @orderId
				--SET @msg = @msg + CHAR(13) + CHAR(10) + CHAR(13) + CHAR(10)
				--SET @msg = @msg + '* 앱 설치 방법 : 구글플레이스토어에서 "로지스링크" 검색 ▷ "차주용" 선택 후 설치'
			
				SET @template = 'LOGISLINK_606'
				
				INSERT INTO logislink_sms.dbo.SUREData (USERCODE, BIZTYPE, YELLOWID_KEY, REQNAME, REQPHONE, CALLNAME, CALLPHONE, MSG, RESULT, KIND, DEPTCODE,
														REQTIME, RESEND, TEMPLATECODE, BTN_TYPE_01, BTN_NM_01, BTN_01_URL_01, BTN_01_URL_02)
				VALUES (@userCode, 'at', @yellowidKey, '로지스링크', @reqPhone, @driverName, @driverTel, @msg, @result, 'T', @deptCode,
						@sendTime, 'N', @template, 'WL', @imgBtnTitle, @imgReceiptLink, '')
			END
			-- [세금계산서접수완료]
			ELSE
			BEGIN
				SET @msg = '[로지스링크](세금계산서접수완료)' + CHAR(13) + CHAR(10) 
					+ @carNum + '차주님, 세금계산서가 접수되었습니다.' + CHAR(13) + CHAR(10) + CHAR(13) + CHAR(10)
					+ '▶ 상차지 : ' + @sAddr + ' ' + @sAddrDetail ; 
				SET @msg = @msg + CHAR(13) + CHAR(10)
				SET @msg = @msg + '▶ 하차지 : ' + @eAddr + ' ' + @eAddrDetail
				SET @msg = @msg + CHAR(13) + CHAR(10)
				SET @msg = @msg + '▶ 화물 : ' + @goodsName	
				SET @msg = @msg + CHAR(13) + CHAR(10)
				SET @msg = @msg + '▶ 운임 : ' + FORMAT(@charge, N'#,0') + '원'
				SET @msg = @msg + CHAR(13) + CHAR(10)
				SET @msg = @msg + '▶ 배차번호 : ' + @orderId
				--SET @msg = @msg + CHAR(13) + CHAR(10) + CHAR(13) + CHAR(10)
				--SET @msg = @msg + '* 앱 설치 방법 : 구글플레이스토어에서 "로지스링크" 검색 ▷ "차주용" 선택 후 설치'
			
				SET @template = 'LOGISLINK_606N'
				
				INSERT INTO logislink_sms.dbo.SUREData (USERCODE, BIZTYPE, YELLOWID_KEY, REQNAME, REQPHONE, CALLNAME, CALLPHONE, MSG, RESULT, KIND, DEPTCODE,
														REQTIME, RESEND, TEMPLATECODE, BTN_TYPE_01, BTN_NM_01, BTN_01_URL_01, BTN_01_URL_02)
				VALUES (@userCode, 'at', @yellowidKey, '로지스링크', @reqPhone, @driverName, @driverTel, @msg, @result, 'T', @deptCode,
						@sendTime, 'N', @template, 'WL', @imgBtnTitle, @imgReceiptLink, '')
			END
		END
		-- [운임지급알림]
		ELSE IF @sendType = 'PAYINFO'
		BEGIN		
			
/*			SELECT @fee = WITHDRAWAL_AMT * (-1)
			FROM T_CALC 
			WHERE ALLOC_ID = @allocId AND USE_YN = 'Y' AND CALC_TYPE_CODE = '0901'
			
			SELECT @charge = SUM(WITHDRAWAL_AMT)
			FROM T_CALC
			WHERE ALLOC_ID = @allocId AND USE_YN = 'Y' AND CALC_TYPE_CODE != '0901'*/
			
			SELECT @charge = WITHDRAWAL_AMT 
			FROM T_CALC_PAY 
			WHERE ALLOC_ID = @allocId
			
			SET @msg = '[로지스링크](운임지급알림)' + CHAR(13) + CHAR(10) 
				+ @carNum + '차주님, 운행하신 화물의 운임이 지급되었습니다.' + CHAR(13) + CHAR(10) + CHAR(13) + CHAR(10)
				+ '▶ 상차지 : ' + @sAddr + ' ' + @sAddrDetail ; 
			SET @msg = @msg + CHAR(13) + CHAR(10)
			SET @msg = @msg + '▶ 하차지 : ' + @eAddr + ' ' + @eAddrDetail  
			SET @msg = @msg + CHAR(13) + CHAR(10)
			SET @msg = @msg + '▶ 화물 : ' + @goodsName		 
			SET @msg = @msg + CHAR(13) + CHAR(10)
			SET @msg = @msg + '▶ 지급운임 : ' + FORMAT(@charge, '##,##0') + '원'
			SET @msg = @msg + CHAR(13) + CHAR(10)
			SET @msg = @msg + '▶ 배차번호 : ' + @orderId
			--SET @msg = @msg + CHAR(13) + CHAR(10) + CHAR(13) + CHAR(10)
			--SET @msg = @msg + '* 앱 설치 방법 : 구글플레이스토어에서 "로지스링크" 검색 ▷ "차주용" 선택 후 설치'
			
			SET @template = 'LOGISLINK_607'
			
			INSERT INTO logislink_sms.dbo.SUREData (USERCODE, BIZTYPE, YELLOWID_KEY, REQNAME, REQPHONE, CALLNAME, CALLPHONE, MSG, RESULT, KIND, DEPTCODE,
													REQTIME, RESEND, TEMPLATECODE)
			VALUES (@userCode, 'at', @yellowidKey, '로지스링크', @reqPhone, @driverName, @driverTel, @msg, @result, 'T', @deptCode,
					@sendTime, 'N', @template)
		END		
		-- [도착예정시간알림]
		ELSE IF @sendType = 'STARTINFO'
		BEGIN
			
			IF @time > 0 
			BEGIN
				SET @time = @time + 60
			
				DECLARE CUR CURSOR FOR
				SELECT STOP_SE, E_ADDR, E_ADDR_DETAIL, E_TEL, E_STAFF 
				FROM T_ORDER_STOP
				WHERE ORDER_ID = @orderId AND USE_YN = 'Y'
				ORDER BY STOP_NO ASC			
				
				OPEN CUR
				FETCH NEXT FROM CUR INTO @stopSe, @stopAddr, @stopAddrDetail, @stopTel, @stopStaff 
				
				WHILE @@FETCH_STATUS = 0
				BEGIN
					IF @stopSe = 'E' AND ISNULL(@stopTel, '') <> '' 
					BEGIN
						SELECT @arrivalTime = REPLACE(CONVERT(VARCHAR(5), DATEADD(MI, @time, @sDate), 8), ':', '시 ') + '분'
						
						SET @msg = '[로지스링크] (도착예정알림)' + CHAR(13) + CHAR(10) 
								+ '안녕하세요 로지스링크입니다. 화물을 실은 차량이 하차지로 출발하였습니다. '							
								+ '도착예정시간은 ' + @arrivalTime + '입니다.' + CHAR(13) + CHAR(10)
						SET @msg = @msg + CHAR(13) + CHAR(10)
						SET @msg = @msg + '* 도로 및 화물기사님의 사정으로 일부 변경될 수 있습니다. 이해 부탁드립니다.' + CHAR(13) + CHAR(10)
						SET @msg = @msg + CHAR(13) + CHAR(10)
						SET @msg = @msg + '▶ 상차지 : ' + @sAddr + ' ' + @sAddrDetail ;
						SET @msg = @msg + CHAR(13) + CHAR(10)
						SET @msg = @msg + '▶ 하차지 : ' + @stopAddr + ' ' + @stopAddrDetail ;
						SET @msg = @msg + CHAR(13) + CHAR(10)
						SET @msg = @msg + '▶ 차량번호 : ' + @carNum		 
						SET @msg = @msg + CHAR(13) + CHAR(10)
						SET @msg = @msg + '▶ 차량기사 : ' + @driverName
						SET @msg = @msg + CHAR(13) + CHAR(10)
						SET @msg = @msg + '▶ 기사번호 : ' + @driverTel
						
						SET @template = 'LOGISLINK_008'
						
						INSERT INTO logislink_sms.dbo.SUREData (USERCODE, BIZTYPE, YELLOWID_KEY, REQNAME, REQPHONE, CALLNAME, CALLPHONE, MSG, RESULT, KIND, DEPTCODE,
																REQTIME, RESEND, TEMPLATECODE)
						VALUES (@userCode, 'at', @yellowidKey, '로지스링크', @reqPhone, @stopStaff, @stopTel, @msg, @result, 'T', @deptCode,
								@sendTime, 'N', @template)
					END
					
					SET @time = @time + 30 
					FETCH NEXT FROM CUR INTO @stopSe, @stopAddr, @stopAddrDetail, @stopTel, @stopStaff 
				END	
				CLOSE CUR
		
				DEALLOCATE CUR		
				
				IF ISNULL(@eTel, '') != ''
				BEGIN
					
						SELECT @arrivalTime = REPLACE(CONVERT(VARCHAR(5), DATEADD(MI, @time, @sDate), 8), ':', '시 ') + '분'
						
						SET @msg = '[로지스링크] (도착예정알림)' + CHAR(13) + CHAR(10) 
								+ '안녕하세요 로지스링크입니다. 화물을 실은 차량이 하차지로 출발하였습니다. '							
								+ '도착예정시간은 ' + @arrivalTime + '입니다.' + CHAR(13) + CHAR(10)
						SET @msg = @msg + CHAR(13) + CHAR(10)
						SET @msg = @msg + '* 도로 및 화물기사님의 사정으로 일부 변경될 수 있습니다. 이해 부탁드립니다.' + CHAR(13) + CHAR(10)
						SET @msg = @msg + CHAR(13) + CHAR(10)
						SET @msg = @msg + '▶ 상차지 : ' + @sAddr + ' ' + @sAddrDetail ;
						SET @msg = @msg + CHAR(13) + CHAR(10)
						SET @msg = @msg + '▶ 하차지 : ' + @eAddr + ' ' + @eAddrDetail ;
						SET @msg = @msg + CHAR(13) + CHAR(10)
						SET @msg = @msg + '▶ 차량번호 : ' + @carNum		 
						SET @msg = @msg + CHAR(13) + CHAR(10)
						SET @msg = @msg + '▶ 차량기사 : ' + @driverName
						SET @msg = @msg + CHAR(13) + CHAR(10)
						SET @msg = @msg + '▶ 기사번호 : ' + @driverTel
						
						SET @template = 'LOGISLINK_008'
						
						INSERT INTO logislink_sms.dbo.SUREData (USERCODE, BIZTYPE, YELLOWID_KEY, REQNAME, REQPHONE, CALLNAME, CALLPHONE, MSG, RESULT, KIND, DEPTCODE,
																REQTIME, RESEND, TEMPLATECODE)
						VALUES (@userCode, 'at', @yellowidKey, '로지스링크', @reqPhone, @eStaff, @eTel, @msg, @result, 'T', @deptCode,
								@sendTime, 'N', @template)
				END 	
			END
			
		END
	END
		
END
GO
