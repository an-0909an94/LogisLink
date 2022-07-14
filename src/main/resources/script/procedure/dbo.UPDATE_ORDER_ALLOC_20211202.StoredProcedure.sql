USE [logislink]
GO
/****** Object:  StoredProcedure [dbo].[UPDATE_ORDER_ALLOC_20211202]    Script Date: 2022-07-14 오후 6:16:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UPDATE_ORDER_ALLOC_20211202]
(
	@orderId		NVARCHAR(20)
  , @allocId		NVARCHAR(20)
  , @sellCustId		NVARCHAR(20)
  , @sellDeptId		NVARCHAR(20)
  , @sellStaff		NVARCHAR(20)
  , @sellStaffTel	NVARCHAR(13)
  , @buyCustId		NVARCHAR(20)
  , @buyDeptId		NVARCHAR(20)
  , @buyStaff		NVARCHAR(20)
  , @buyStaffTel	NVARCHAR(13)
  , @allocCharge	INT
  , @allocFee		INT
  , @vehicId		NVARCHAR(20)
  , @driverId		NVARCHAR(20)
  , @carNum			NVARCHAR(10)
  , @carTonCode		NVARCHAR(20)
  , @carTypeCode	NVARCHAR(20)
  , @driverName		NVARCHAR(20)
  , @driverTel		NVARCHAR(13)
  , @regid			NVARCHAR(20)
  , @cargoBox		NVARCHAR(30)
  , @sellWeight		NVARCHAR(100)
  , @linkSelect 	NVARCHAR(2)
  , @payType		NVARCHAR(2)
  , @retCode		NVARCHAR(2)		OUTPUT
  , @retMsg			NVARCHAR(200)	OUTPUT
)
AS
BEGIN
	DECLARE @RET_OK		NVARCHAR(2) = '00'
	DECLARE @RET_ERR	NVARCHAR(2) = '99'
	-- DECLARE @allocId	NVARCHAR(20) = ''
	DECLARE @timestamp	NVARCHAR(14) = ''
	
	DECLARE @spRet		INT
	DECLARE @spMsg		NVARCHAR(200)
	DECLARE @spId1		NVARCHAR(20)
	DECLARE @spId2		NVARCHAR(20)
	
	DECLARE @allocState	NVARCHAR(2)	= '00'
	DECLARE @oldState	NVARCHAR(2)
	DECLARE @seq		INT
	DECLARE @linkYn		NVARCHAR(1)
	DECLARE @linkCode	NVARCHAR(2)
	
	-- 등록된 기사가 아닌 경우, 기사 정보 저장
	IF ISNULL(@driverId, '') = '' AND ISNULL(@driverTel, '') <> ''
		BEGIN 
			EXEC INSERT_DRIVER @driverId, @driverName, @driverTel, @driverTel, NULL, NULL, NULL, NULL, @regid, @spRet OUTPUT, @spMsg OUTPUT, @spId2 OUTPUT
			
			SET @driverId = @spId2
		END
		
	-- 등록된 차량번호가 아닐 경우 차량 마스터에 차량번호 저장
	IF ISNULL(@vehicId, '') = '' AND ISNULL(@carNum, '') <> '' 
		BEGIN 
			EXEC INSERT_VEHIC @vehicId, @driverId, @sellCustId, @sellDeptId, @carNum, @carTypeCode, @carTonCode, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @regid, @cargoBox, @spRet OUTPUT, @spMsg  OUTPUT, @spId1 OUTPUT
			
			SET @vehicId = @spId1
		END
		
	-- 접수 상태 + 지정된 차량이 있을 경우, 배차 상태 : 배차
	IF ISNULL(@vehicId, '') <> '' 
		BEGIN 
			SET @allocState = '01';
			
			UPDATE T_ORDER 
			SET ORDER_STATE = @allocState
			  , ALLOC_DATE = GETDATE()
			  , EDITID = @regid
			  , EDITDATE = GETDATE()
			WHERE ORDER_ID = @orderId
				AND ORDER_STATE = '00';
			
		END
	
	IF ISNULL(@buyCustId, '') != '' AND ISNULL(@buyDeptId, '') != ''
		BEGIN 
			SET @allocState = '10';
		END
	
	IF ISNULL(@buyCustId, '') != '' AND ISNULL(@buyDeptId, '') != ''
		BEGIN 
			SET @allocState = '10';
		END
		
	IF ISNULL(@linkSelect, '') != '' 
		BEGIN
			SET @linkYn = 'S'
			set @linkCode = @linkSelect
		END
	ELSE 
		BEGIN
			SET @linkYn = 'N'
			set @linkCode = '99' 
		END
	
	IF ISNULL(@allocId, '') = ''
		BEGIN
			SET @timestamp = convert(varchar, getDate(), 112) + replace(convert(varchar, getDate(), 108), ':', '')
			SELECT @seq = NEXT VALUE FOR SEQ_ORDER_ALLOC;
			SET @allocId = 'A' + @timestamp + RIGHT('00' + @seq, 3)
			
			MERGE INTO 	T_ORDER_ALLOC AS A 
			USING
				(
					SELECT 
							@allocId		ALLOC_ID
						  , @orderId		ORDER_ID 
						  , @sellCustId		SELL_CUST_ID 
						  , @sellDeptId		SELL_DEPT_ID
						  , @sellStaff		SELL_STAFF_ID
						  , @sellStaffTel	SELL_STAFF_TEL 
						  , @buyCustId		BUY_CUST_ID
						  , @buyDeptId		BUY_DEPT_ID 
						  , @buyStaff		BUY_STAFF_ID
						  , @buyStaffTel	BUY_STAFF_TEL
						  , @allocCharge	ALLOC_CHARGE 
						  , @allocFee		ALLOC_FEE 
						  , @allocState		ALLOC_STATE 
						  , @vehicId		VEHIC_ID 
						  , @driverId		DRIVER_ID 
						  , @carNum			CAR_NUM 
						  , @carTonCode		CAR_TON_CODE 
						  , @carTypeCode	CAR_TYPE_CODE 
						  , @driverName		DRIVER_NAME 
						  , @driverTel		DRIVER_TEL 
						  , @regid			REGID 
						  , @sellWeight		SELL_WEIGHT 
						  , @linkYn			LINK_YN 
						  , @linkCode		LINK_CODE 
						  , @payType		PAY_TYPE 
				) D
			ON A.ORDER_ID = D.ORDER_ID AND A.SELL_CUST_ID = D.SELL_CUST_ID AND A.SELL_DEPT_ID = D.SELL_DEPT_ID
			WHEN MATCHED THEN 
				UPDATE SET A.SELL_STAFF_ID = D.SELL_STAFF_ID
						 , A.SELL_STAFF_TEL = D.SELL_STAFF_TEL
						 , A.BUY_CUST_ID = D.BUY_CUST_ID
						 , A.BUY_DEPT_ID = D.BUY_DEPT_ID
						 , A.BUY_STAFF_ID = D.BUY_STAFF_ID
						 , A.BUY_STAFF_TEL = D.BUY_STAFF_TEL
						 , A.ALLOC_CHARGE = D.ALLOC_CHARGE
						 , A.ALLOC_FEE = D.ALLOC_FEE
						 , A.ALLOC_STATE = D.ALLOC_STATE 
						 , A.VEHIC_ID = D.VEHIC_ID
						 , A.DRIVER_ID = D.DRIVER_ID
						 , A.CAR_NUM = D.CAR_NUM
						 , A.CAR_TON_CODE = D.CAR_TON_CODE
						 , A.CAR_TYPE_CODE = D.CAR_TYPE_CODE
						 , A.DRIVER_NAME = D.DRIVER_NAME
						 , A.DRIVER_TEL = D.DRIVER_TEL
						 , A.LINK_YN = D.LINK_YN
						 , A.LINK_CODE = D.LINK_CODE
						 , A.EDITID = D.REGID
						 , A.EDITDATE = GETDATE()
						 , A.ALLOC_DATE = CASE @allocState WHEN '01' THEN GETDATE() WHEN '10' THEN GETDATE() ELSE NULL END
						 , A.SELL_WEIGHT = D.SELL_WEIGHT
						 , A.LINK_SETTLE_YN = 'N'
						 , A.PAY_TYPE = D.PAY_TYPE
			WHEN NOT MATCHED THEN 
				INSERT (
							ALLOC_ID		, ORDER_ID			, SELL_CUST_ID		, SELL_DEPT_ID	, SELL_STAFF_ID
						  , BUY_CUST_ID		, BUY_DEPT_ID		, BUY_STAFF_ID		, ALLOC_CHARGE	, ALLOC_FEE		
						  , ALLOC_STATE		, VEHIC_ID			, DRIVER_ID			, CAR_NUM		, CAR_TON_CODE
						  , CAR_TYPE_CODE	, DRIVER_NAME		, DRIVER_TEL		, REGID			, REGDATE
						  , SELL_STAFF_TEL	, BUY_STAFF_TEL		, SELL_WEIGHT		, LINK_YN 		, LINK_CODE 
						  , LINK_SETTLE_YN  , PAY_TYPE
						  , ALLOC_DATE		 
						)
				VALUES (
							D.ALLOC_ID		, D.ORDER_ID		, D.SELL_CUST_ID	, D.SELL_DEPT_ID, D.SELL_STAFF_ID
						  , D.BUY_CUST_ID	, D.BUY_DEPT_ID		, D.BUY_STAFF_ID	, D.ALLOC_CHARGE, D.ALLOC_FEE		
						  , D.ALLOC_STATE	, D.VEHIC_ID		, D.DRIVER_ID		, D.CAR_NUM		, D.CAR_TON_CODE
						  , D.CAR_TYPE_CODE	, D.DRIVER_NAME		, D.DRIVER_TEL		, D.REGID		, GETDATE()
						  , D.SELL_STAFF_TEL, D.BUY_STAFF_TEL	, D.SELL_WEIGHT		, D.LINK_YN		, D.LINK_CODE
						  , 'N'				, D.PAY_TYPE
						  , CASE @allocState WHEN '01' THEN GETDATE() WHEN '10' THEN GETDATE() ELSE NULL END
						);
			SELECT @allocId = ALLOC_ID FROM T_ORDER_ALLOC WHERE ORDER_ID = @orderId AND SELL_CUST_ID = @sellCustId	AND SELL_DEPT_ID = @sellDeptId 		
					
			-- 매입 정산 정보 업데이트
			UPDATE T_CALC SET PAYABLE_AMT = @allocCharge 
			WHERE ALLOC_ID = @allocId AND CALC_TYPE_CODE = '0002' AND SELL_BUY_SCTN = '02';
			
			-- 매출 정산 정보 업데이트
			UPDATE T_CALC SET UNPAID_AMT = @allocCharge 
			WHERE ALLOC_ID = @allocId AND CALC_TYPE_CODE = '0002' AND SELL_BUY_SCTN = '01';		
		END
	
	ELSE
		BEGIN
			SELECT @oldState = ALLOC_STATE FROM T_ORDER_ALLOC WHERE ALLOC_ID = @allocId
			
			IF @oldState = '11' AND @allocState = '00' 
			BEGIN
				SET @allocState = '11'
			END 
			
			UPDATE T_ORDER_ALLOC
			SET	SELL_STAFF_ID = @sellStaff
			  , SELL_STAFF_TEL = @sellStaffTel
			  ,	BUY_CUST_ID = @buyCustId
			  , BUY_DEPT_ID = @buyDeptId
			  , BUY_STAFF_ID = @buyStaff
			  , BUY_STAFF_TEL = @buyStaffTel
			  , ALLOC_CHARGE = @allocCharge
			  , ALLOC_FEE = @allocFee
			  , VEHIC_ID = @vehicId
			  , DRIVER_ID = @driverId
			  , CAR_NUM = @carNum
			  , DRIVER_NAME = @driverName
			  , DRIVER_TEL = @driverTel
			  , ALLOC_STATE = CASE WHEN ALLOC_STATE = '00' THEN @allocState WHEN ALLOC_STATE = '11' THEN @allocState ELSE ALLOC_STATE END
			  , ALLOC_DATE = CASE WHEN ALLOC_STATE = '00' AND (@allocState = '01' OR @allocState = '10') THEN GETDATE() WHEN ALLOC_STATE = '11' AND (@allocState = '01' OR @allocState = '10') THEN GETDATE() ELSE ALLOC_DATE END
			  , LINK_YN = CASE WHEN LINK_YN = 'Y' THEN 'Y' ELSE @linkYn END
			  , LINK_CODE = @linkCode
			  , EDITDATE  = GETDATE()
			  , EDITID = @regid
			  , SELL_WEIGHT = @sellWeight
			  , LINK_SETTLE_YN = (SELECT LINK_SETTLE_YN T_ORDER_ALLOC WHERE ORDER_ID = @orderId AND ALLOC_ID = @allocId)
			  , PAY_TYPE = @payType
			WHERE ORDER_ID = @orderId AND ALLOC_ID = @allocId
			
			-- 매입 정산 정보 업데이트
			UPDATE T_CALC SET PAYABLE_AMT = @allocCharge 
			WHERE ALLOC_ID = @allocId AND CALC_TYPE_CODE = '0002' AND SELL_BUY_SCTN = '02';
			
			-- 매출 정산 정보 업데이트
			UPDATE T_CALC SET UNPAID_AMT = @allocCharge 
			WHERE ALLOC_ID = @allocId AND CALC_TYPE_CODE = '0002' AND SELL_BUY_SCTN = '01';	
		END
	
						
	IF (@@ERROR <> 0)
		BEGIN 
			SET @retCode = @RET_ERR
	    	SET @retMsg = '배차에 실패했습니다.'
		END
    ELSE		
    	BEGIN 
	    	SET @retCode = @RET_OK
		    SET @retMsg = '배차가 등록되었습니다.'
    	END
END
GO
