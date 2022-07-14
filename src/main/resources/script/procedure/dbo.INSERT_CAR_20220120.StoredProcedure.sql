USE [logislink]
GO
/****** Object:  StoredProcedure [dbo].[INSERT_CAR_20220120]    Script Date: 2022-07-14 오후 6:16:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[INSERT_CAR_20220120]
(
	@custVehicSeq BIGINT
  ,	@driverId NVARCHAR(20)
  , @vehicId NVARCHAR(20)
  , @custId NVARCHAR(20)
  , @deptId NVARCHAR(20)
  , @userId NVARCHAR(30)
  , @carSctnCode NVARCHAR(20)
  , @carNum NVARCHAR(10)
  , @carTypeCode NVARCHAR(10)
  , @carTonCode NVARCHAR(10)
  , @bizName NVARCHAR(50)
  , @bizNum NVARCHAR(12)
  , @subBizNum NVARCHAR(10)
  , @ceo NVARCHAR(20)
  , @bizPost NVARCHAR(50)
  , @bizAddr NVARCHAR(50)
  , @bizAddrDetail NVARCHAR(50)
  , @bizCond NVARCHAR(20)
  , @bizKind NVARCHAR(20)
  , @driverName NVARCHAR(20)
  , @mobile NVARCHAR(13)
  , @telNum NVARCHAR(13)
  , @cid NVARCHAR(13)
  , @pushYn NVARCHAR(1)
  , @talkYn NVARCHAR(1)
  , @forkliftYn NVARCHAR(1)
  , @foreignLicenseYn NVARCHAR(1)
  , @chemicalsYn NVARCHAR(1)
  , @dangerGoodsYn NVARCHAR(1)
  , @cargoBox NVARCHAR(30)
  , @bankCode NVARCHAR(5)
  , @bankCnnm NVARCHAR(20)
  , @bankAccount NVARCHAR(30)
  , @useYn NVARCHAR(1)
  , @memo NVARCHAR(1000)
  , @mode NVARCHAR(10)
  , @carMngCode NVARCHAR(2)
  , @carMngMemo NVARCHAR(1000)
  , @mixPreferYn NVARCHAR(1)
  , @payType NVARCHAR(1)
  , @payMemo NVARCHAR(1000)
  , @driverEmail NVARCHAR(50)
  , @taxjoinDate NVARCHAR(10)
  , @regid		NVARCHAR(20)
  , @retCode NVARCHAR(2) OUTPUT
  , @retMsg NVARCHAR(200) OUTPUT
)
AS 
BEGIN
	
	DECLARE @RET_OK NVARCHAR(2) = '00'		-- 성공
	DECLARE @RET_ERR NVARCHAR(2) = '99'		-- Error
	DECLARE @timestamp	NVARCHAR(14) = ''
	DECLARE @v_mobile NVARCHAR(13) = REPLACE(@mobile,'-','')
	DECLARE @v_bizNum NVARCHAR(12) = REPLACE(@bizNum,'-','')
	DECLARE @v_telNum NVARCHAR(13) = REPLACE(@telNum,'-','')
	DECLARE @v_cid NVARCHAR(13) = REPLACE(@cid,'-','')
	DECLARE @preDriverId NVARCHAR(20)
	DECLARE @vehicCnt INT	= 0
	
	SELECT @v_cid = CASE WHEN @v_cid = '' THEN @v_mobile ELSE @v_cid END
	
	IF @mode = 'N'
	BEGIN			
				
		-- 기사 연락처가 중복된 경우 driverId 할당
		SELECT @driverId = DRIVER_ID
		FROM T_DRIVER
		WHERE REPLACE(MOBILE, '-', '') = @v_mobile AND USE_YN = 'Y'
		
		-- 마스터에 이미 등록되어 있는 차량번호일 경우, @vehicId 할당
		SELECT @vehicId = VEHIC_ID,	 @preDriverId = DRIVER_ID
		FROM T_VEHIC_MST A 
		WHERE CAR_NUM = @carNum AND USE_YN = 'Y'
		
		
		-- 거래처에서 이미 등록한 차량인지 검증
		IF ISNULL(@driverId, '') <> '' AND ISNULL(@vehicId, '') <> ''
		BEGIN
			SELECT @vehicCnt = COUNT(1)
			FROM T_CUST_VEHIC
			WHERE CUST_ID = @custId AND DEPT_ID = @deptId AND VEHIC_ID = @vehicId AND DRIVER_ID = @driverId
		END		
		
		IF @vehicCnt > 0 
		BEGIN 
			set @retCode = @RET_ERR
			set @retMsg = '이미 등록된 차량입니다.'
		END
		ELSE 
		BEGIN
			
			IF isNull(@driverId, '') = ''
			BEGIN
				SET @driverId = 'DR' + convert(varchar, getDate(), 112) + replace(convert(varchar, getDate(), 108), ':', '') + '001'
		
				INSERT INTO dbo.T_DRIVER(
	        		DRIVER_ID,
	        		MOBILE,    		
	        		CID,	   		TELNUM,		
	        		BANK_CODE,		DRIVER_EMAIL,	TAXJOIN_DATE,
	        		BANK_CNNM,		BANK_ACCOUNT,	REGDATE, REGID,
	        		DRIVER_NAME,	PUSH_YN,		TALK_YN)
				VALUES(
					@driverId,
					@v_mobile,
					@v_cid,			@v_telNum,
					@bankCode,		@driverEmail,	@taxjoinDate,
					@bankCnnm,		@bankAccount,	GETDATE(), @regid,
					@driverName,  	ISNULL(@pushYn,'N'), ISNULL(@talkYn,'N'))
			END
				
			IF isNull(@vehicId, '') = ''
			BEGIN
								
				SET @vehicId = 'V' + convert(varchar, getDate(), 112) + replace(convert(varchar, getDate(), 108), ':', '') + '001'
				
				INSERT INTO dbo.T_VEHIC_MST(
				        		VEHIC_ID,		DRIVER_ID,
					        	CAR_NUM,		CAR_TYPE_CODE,	CAR_TON_CODE,
								BIZ_NAME,		BIZ_NUM, 		CEO,
								BIZ_POST, 		BIZ_ADDR, 		BIZ_ADDR_DETAIL,
								REGDATE, 		SUB_BIZ_NUM,	BIZ_COND,
								BIZ_KIND,		REGID,			DANGER_GOODS_YN, CARGO_BOX, 
								CHEMICALS_YN,	FOREIGN_LICENSE_YN, FORKLIFT_YN, MIX_PREFER_YN)
				VALUES(
								@vehicId,		@driverId,
								@carNum,		@carTypeCode,	@carTonCode,
								@bizName,		@v_bizNum,		@ceo,
								@bizPost,		@bizAddr,		@bizAddrDetail,
								GETDATE(),		@subBizNum,		@bizCond,
								@bizKind, 		@regid,			@dangerGoodsYn, @cargoBox,
								@chemicalsYn,	@foreignLicenseYn, @forkliftYn, @mixPreferYn)
			END
			ELSE 
			BEGIN	
				-- 기사 차량정보가 바꼈을 경우, 새로 매칭
				IF isNull(@preDriverId, '') <> @driverId
				BEGIN
					UPDATE T_VEHIC_MST 
						SET DRIVER_ID = @driverId,
							EDITDATE = GETDATE(),
							EDITID = @regid
					WHERE VEHIC_ID = @vehicId
				END
			END
			
			
			INSERT INTO dbo.T_CUST_VEHIC(
        		VEHIC_ID,		DRIVER_ID, 		CUST_ID,		DEPT_ID,	
        		USE_YN,			CAR_SCTN_CODE,	REGDATE,		REGID,
        		MANAGER,		MEMO, 			CAR_MNG_CODE,	CAR_MNG_MEMO,
        		PAY_TYPE,		PAY_MEMO)
			VALUES(
				@vehicId, 		@driverId, 		@custId, 		@deptId,
				'Y',			@carSctnCode,	GETDATE(),		@regid,
				@userId,		@memo, 			@carMngCode,	@carMngMemo,
				@payType,		@payMemo)
			
			set @retCode = @RET_OK
        	set @retMsg = '차량 정보가 추가되었습니다.'
		END
		
		
	END
	ELSE 
	BEGIN 
		
		-- 기사 연락처가 중복된 경우 driverId 할당
		SELECT @preDriverId = DRIVER_ID
		FROM T_DRIVER
		WHERE REPLACE(MOBILE, '-', '') = REPLACE(@mobile,'-','') AND USE_YN = 'Y'
		IF ISNULL(@preDriverId, '') <> '' 
		BEGIN
			SELECT 0
			Set @driverId = @preDriverId
		END
		
		
		UPDATE dbo.T_VEHIC_MST 
		SET
			DRIVER_ID = @driverId,
			CAR_TYPE_CODE = @carTypeCode,
			CAR_TON_CODE = @carTonCode,
			BIZ_NAME = @bizName,
			BIZ_NUM = @v_bizNum,
			CEO = @ceo,
			BIZ_POST = @bizPost,
			BIZ_ADDR = @bizAddr,
			BIZ_ADDR_DETAIL = @bizAddrDetail,
			--USE_YN = @v_useYn,
			SUB_BIZ_NUM = @subBizNum,
			EDITDATE = (SELECT GETDATE()),
			BIZ_COND = @bizCond,
			BIZ_KIND = @bizKind,
			EDITID = @regid,
			DANGER_GOODS_YN = @dangerGoodsYn,
			CHEMICALS_YN = @chemicalsYn,
			FOREIGN_LICENSE_YN = @foreignLicenseYn,
			FORKLIFT_YN = @forkliftYn,
			CARGO_BOX = @cargoBox,
			MIX_PREFER_YN = @mixPreferYn
		WHERE VEHIC_ID = @vehicId;
	
		UPDATE dbo.T_DRIVER
		SET
			MOBILE = @v_mobile,
			CID = @v_cid,
			--USE_YN = @v_useYn,
			TELNUM = @v_telNum,
			PUSH_YN = ISNULL(@pushYn,'N'),
			TALK_YN = ISNULL(@talkYn,'N'),
			BANK_CODE = @bankCode,
			BANK_CNNM = @bankCnnm,
			BANK_ACCOUNT = @bankAccount,
			EDITDATE =	GETDATE(),
			DRIVER_NAME = @driverName,
			EDITID = @regid			,
			DRIVER_EMAIL = @driverEmail,
			TAXJOIN_DATE = @taxjoinDate
		WHERE 
			DRIVER_ID = @driverId;
		
		
		
		UPDATE dbo.T_CUST_VEHIC
		SET
			VEHIC_ID = @vehicId,
			DRIVER_ID = @driverId,
			USE_YN =  @useYn,			
			CAR_SCTN_CODE = @carSctnCode,	
			EDITDATE = GETDATE(),
			MANAGER = @userId,		
			MEMO = @memo,
			CAR_MNG_CODE = @carMngCode,
			CAR_MNG_MEMO = @carMngMemo,
			DISUSE_DATE = CASE @useYn WHEN 'N' THEN GETDATE() WHEN 'Y' THEN NULL END,
			EDITID = @regid,
			PAY_TYPE = @payType,
			PAY_MEMO = @payMemo
		WHERE 
			CUST_VEHIC_SEQ  = @custVehicSeq;
		

    	set @retCode = @RET_OK
	    set @retMsg = '차량 정보가 수정되었습니다.'
	END
END
GO
