USE [logislink]
GO
/****** Object:  StoredProcedure [dbo].[APP_ORDER_ALLOC_INSERT_20210824]    Script Date: 2022-07-14 오후 6:16:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[APP_ORDER_ALLOC_INSERT_20210824]
(
	@orderId		NVARCHAR(20)
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
  , @wayPointMemo	NVARCHAR(1000)
  , @wayPointCharge	INT
  , @stayMemo		NVARCHAR(1000)
  , @stayCharge		INT
  , @handWorkMemo	NVARCHAR(1000)
  , @handWorkCharge	INT
  , @roundMemo		NVARCHAR(1000)
  , @roundCharge	INT
  , @otherAddMemo	NVARCHAR(1000)
  , @otherAddCharge	INT
  , @regid			NVARCHAR(20)
  , @retCode		NVARCHAR(2)		OUTPUT
  , @retMsg			NVARCHAR(200)	OUTPUT
)
AS
BEGIN
		
	DECLARE @RET_OK		NVARCHAR(2) = '00'
	DECLARE @RET_ERR	NVARCHAR(2) = '99'
	DECLARE @allocId	NVARCHAR(20) = ''
	DECLARE @timestamp	NVARCHAR(14) = ''
	
	DECLARE @spRet		INT
	DECLARE @spMsg		NVARCHAR(200)
	DECLARE @spId1		NVARCHAR(20)
	DECLARE @spId2		NVARCHAR(20)
	
	DECLARE @allocState	NVARCHAR(2)	= '00'
	
	
	SET @timestamp = convert(varchar, getDate(), 112) + replace(convert(varchar, getDate(), 108), ':', '')
	SET @allocId = 'A' + @timestamp + '001'

	--SELECT @sellStaff = USER_NAME FROM T_USER WHERE USER_ID = @regid;
	 

	-- 등록된 기사가 아닌 경우, 기사 정보 저장
	IF ISNULL(@driverId, '') = '' AND ISNULL(@driverTel, '') <> ''
		BEGIN 
			EXEC INSERT_DRIVER @driverId, @driverName, @driverTel, @driverTel, NULL, NULL, NULL, NULL, @regid, @spRet OUTPUT, @spMsg OUTPUT, @spId2 OUTPUT
			
			SET @driverId = @spId2
		END
		
	-- 등록된 차량번호가 아닐 경우 차량 마스터에 차량번호 저장
	IF ISNULL(@vehicId, '') = '' AND ISNULL(@carNum, '') <> '' 
		BEGIN 
			EXEC INSERT_VEHIC @vehicId, @driverId, @sellCustId, @sellDeptId, @carNum, @carTypeCode, @carTonCode, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @regid, NULL, @spRet OUTPUT, @spMsg  OUTPUT, @spId1 OUTPUT
			
			SET @vehicId = @spId1
		END
		
	-- 지정된 차량이 있을 경우, 배차 상태 : 배차
	IF ISNULL(@vehicId, '') <> '' 
		BEGIN 
			SET @allocState = '01';
			
			UPDATE T_ORDER 
			SET ORDER_STATE = @allocState
			  , ALLOC_DATE = GETDATE()
			  , EDITID = @regid
			  , EDITDATE = GETDATE()
			WHERE ORDER_ID = @orderId;
		
		END
		
	
	IF ISNULL(@buyCustId, '') != '' AND ISNULL(@buyDeptId, '') != ''
		BEGIN 
			SET @allocState = '10';
		END
		
		
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
				 , A.LINK_YN = 'N'
				 , A.LINK_CODE = NULL
				 , A.EDITID = D.REGID
				 , A.EDITDATE = GETDATE()
				 , A.ALLOC_DATE = CASE @allocState WHEN '01' THEN GETDATE() WHEN '10' THEN GETDATE() ELSE A.ALLOC_DATE END
	WHEN NOT MATCHED THEN 
		INSERT (
					ALLOC_ID		, ORDER_ID			, SELL_CUST_ID		, SELL_DEPT_ID	, SELL_STAFF_ID
				  , BUY_CUST_ID		, BUY_DEPT_ID		, BUY_STAFF_ID		, ALLOC_CHARGE	, ALLOC_FEE		
				  , ALLOC_STATE		, VEHIC_ID			, DRIVER_ID			, CAR_NUM		, CAR_TON_CODE
				  , CAR_TYPE_CODE	, DRIVER_NAME		, DRIVER_TEL		, REGID			, REGDATE
				  , ALLOC_DATE		, SELL_STAFF_TEL	, BUY_STAFF_TEL
				)
		VALUES (
					D.ALLOC_ID		, D.ORDER_ID		, D.SELL_CUST_ID	, D.SELL_DEPT_ID, D.SELL_STAFF_ID
				  , D.BUY_CUST_ID	, D.BUY_DEPT_ID		, D.BUY_STAFF_ID	, D.ALLOC_CHARGE, D.ALLOC_FEE		
				  , D.ALLOC_STATE	, D.VEHIC_ID		, D.DRIVER_ID		, D.CAR_NUM		, D.CAR_TON_CODE
				  , D.CAR_TYPE_CODE	, D.DRIVER_NAME		, D.DRIVER_TEL		, D.REGID		, GETDATE()
				  , CASE WHEN @allocState = '01' THEN GETDATE() WHEN @allocState = '10' THEN GETDATE() ELSE NULL END
				  , D.SELL_STAFF_TEL, D.BUY_STAFF_TEL
				);		
		
				
	SELECT @allocId = ALLOC_ID
	FROM T_ORDER_ALLOC
	WHERE ORDER_ID = @orderId AND SELL_CUST_ID = @sellCustId AND SELL_DEPT_ID = @sellDeptId;
		 
	
	-- 추가 운임비 등록
	MERGE INTO T_ORDER_ALLOC_ADD A 
	USING (
			SELECT 
					@allocId		AS ALLOC_ID
				  , @orderId		AS ORDER_ID
				  , '0023'			AS CALC_TYPE_CODE 
				  ,	@wayPointMemo 	AS MEMO 
				  ,	@wayPointCharge	AS ADD_CHARGE
				  , @regid			AS REGID 
		 ) D
	ON A.ORDER_ID = D.ORDER_ID AND A.ALLOC_ID = D.ALLOC_ID AND A.CALC_TYPE_CODE = D.CALC_TYPE_CODE
	WHEN MATCHED THEN 
		UPDATE SET A.ADD_CHARGE = D.ADD_CHARGE
				 , A.MEMO = D.MEMO
				 , EDITDATE = GETDATE()
				 , EDITID = D.REGID
	WHEN NOT MATCHED THEN 
		INSERT (ORDER_ID	, ALLOC_ID	, CALC_TYPE_CODE	, ADD_CHARGE 	, MEMO	, REGDATE 	, REGID)
		VALUES (D.ORDER_ID	, D.ALLOC_ID, D.CALC_TYPE_CODE	, D.ADD_CHARGE	, D.MEMO, GETDATE() , D.REGID);
		
	
	MERGE INTO T_ORDER_ALLOC_ADD A 
	USING (
			SELECT 
					@allocId		AS ALLOC_ID
				  , @orderId		AS ORDER_ID
				  , '0025'			AS CALC_TYPE_CODE 
				  ,	@stayMemo 		AS MEMO 
				  ,	@stayCharge		AS ADD_CHARGE
				  , @regid			AS REGID 
		 ) D
	ON A.ORDER_ID = D.ORDER_ID AND A.ALLOC_ID = D.ALLOC_ID AND A.CALC_TYPE_CODE = D.CALC_TYPE_CODE
	WHEN MATCHED THEN 
		UPDATE SET A.ADD_CHARGE = D.ADD_CHARGE
				 , A.MEMO = D.MEMO
				 , EDITDATE = GETDATE()
				 , EDITID = D.REGID
	WHEN NOT MATCHED THEN 
		INSERT (ORDER_ID	, ALLOC_ID	, CALC_TYPE_CODE	, ADD_CHARGE 	, MEMO	, REGDATE 	, REGID)
		VALUES (D.ORDER_ID	, D.ALLOC_ID, D.CALC_TYPE_CODE	, D.ADD_CHARGE	, D.MEMO, GETDATE() , D.REGID);
			
	
	MERGE INTO T_ORDER_ALLOC_ADD A 
	USING (
			SELECT 
					@allocId		AS ALLOC_ID
				  , @orderId		AS ORDER_ID
				  , '0371'			AS CALC_TYPE_CODE 
				  ,	@handWorkMemo 	AS MEMO 
				  ,	@handWorkCharge	AS ADD_CHARGE
				  , @regid			AS REGID 
		 ) D
	ON A.ORDER_ID = D.ORDER_ID AND A.ALLOC_ID = D.ALLOC_ID AND A.CALC_TYPE_CODE = D.CALC_TYPE_CODE
	WHEN MATCHED THEN 
		UPDATE SET A.ADD_CHARGE = D.ADD_CHARGE
				 , A.MEMO = D.MEMO
				 , EDITDATE = GETDATE()
				 , EDITID = D.REGID
	WHEN NOT MATCHED THEN 
		INSERT (ORDER_ID	, ALLOC_ID	, CALC_TYPE_CODE	, ADD_CHARGE 	, MEMO	, REGDATE 	, REGID)
		VALUES (D.ORDER_ID	, D.ALLOC_ID, D.CALC_TYPE_CODE	, D.ADD_CHARGE	, D.MEMO, GETDATE() , D.REGID);
			
	
	MERGE INTO T_ORDER_ALLOC_ADD A 
	USING (
			SELECT 
					@allocId		AS ALLOC_ID
				  , @orderId		AS ORDER_ID
				  , '0372'			AS CALC_TYPE_CODE 
				  ,	@roundMemo	 	AS MEMO 
				  ,	@roundCharge	AS ADD_CHARGE
				  , @regid			AS REGID 
		 ) D
	ON A.ORDER_ID = D.ORDER_ID AND A.ALLOC_ID = D.ALLOC_ID AND A.CALC_TYPE_CODE = D.CALC_TYPE_CODE
	WHEN MATCHED THEN 
		UPDATE SET A.ADD_CHARGE = D.ADD_CHARGE
				 , A.MEMO = D.MEMO
				 , EDITDATE = GETDATE()
				 , EDITID = D.REGID
	WHEN NOT MATCHED THEN 
		INSERT (ORDER_ID	, ALLOC_ID	, CALC_TYPE_CODE	, ADD_CHARGE 	, MEMO	, REGDATE 	, REGID)
		VALUES (D.ORDER_ID	, D.ALLOC_ID, D.CALC_TYPE_CODE	, D.ADD_CHARGE	, D.MEMO, GETDATE() , D.REGID);
			
	
	MERGE INTO T_ORDER_ALLOC_ADD A 
	USING (
			SELECT 
					@allocId		AS ALLOC_ID
				  , @orderId		AS ORDER_ID
				  , '0294'			AS CALC_TYPE_CODE 
				  ,	@otherAddMemo 	AS MEMO 
				  ,	@otherAddCharge	AS ADD_CHARGE
				  , @regid			AS REGID 
		 ) D
	ON A.ORDER_ID = D.ORDER_ID AND A.ALLOC_ID = D.ALLOC_ID AND A.CALC_TYPE_CODE = D.CALC_TYPE_CODE
	WHEN MATCHED THEN 
		UPDATE SET A.ADD_CHARGE = D.ADD_CHARGE
				 , A.MEMO = D.MEMO
				 , EDITDATE = GETDATE()
				 , EDITID = D.REGID
	WHEN NOT MATCHED THEN 
		INSERT (ORDER_ID	, ALLOC_ID	, CALC_TYPE_CODE	, ADD_CHARGE 	, MEMO	, REGDATE 	, REGID)
		VALUES (D.ORDER_ID	, D.ALLOC_ID, D.CALC_TYPE_CODE	, D.ADD_CHARGE	, D.MEMO, GETDATE() , D.REGID);
				
	
	IF @allocState = '01' 
	BEGIN
		MERGE INTO T_CALC A
		USING (
				SELECT
					RIGHT ('00' + CONVERT(VARCHAR(8),ADD_SEQ), 3) AS SEQ
				  ,	@orderId		AS ORDER_ID
				  , @allocId		AS ALLOC_ID
				  ,	@sellCustId		AS MNG_CUST_ID
				  , @sellDeptId		AS MNG_DEPT_ID
				  , @buyCustId		AS CUST_ID
				  , @buyDeptId		AS DEPT_ID
				  , @vehicId		AS VEHIC_ID
				  , @driverId		AS DRIVER_ID
				  , CALC_TYPE_CODE	AS CALC_TYPE_CODE 
				  , ADD_CHARGE		AS PAYABLE_AMT
				  , MEMO			AS MEMO 
				  , @regid			AS REGID 
				FROM T_ORDER_ALLOC_ADD 
				WHERE ORDER_ID = @orderId AND ALLOC_ID = @allocId
			) D
		ON A.ORDER_ID = D.ORDER_ID  AND A.ALLOC_ID = D.ALLOC_ID AND A.CALC_TYPE_CODE = D.CALC_TYPE_CODE
		WHEN MATCHED THEN 
			UPDATE SET A.PAYABLE_AMT = D.PAYABLE_AMT
					 , A.MEMO = D.MEMO
					 , A.USE_YN = (CASE WHEN D.PAYABLE_AMT = 0 THEN 'N' ELSE 'Y' END)
		WHEN NOT MATCHED THEN
			INSERT
				(
					CALC_ID
				  , ORDER_ID
				  , ALLOC_ID
				  , SELL_BUY_SCTN
				  , CALC_TYPE_CODE
				  , PAYABLE_AMT
				  , MEMO
				  , CUST_ID
				  , DEPT_ID
				  , VEHIC_ID
				  , DRIVER_ID
				  , MNG_CUST_ID
				  , MNG_DEPT_ID
				  , USE_YN
				  , REGDATE
				  , REGID
				)
	   		VALUES
	   			(
	   				'C' + @timestamp + D.SEQ
	   			  , D.ORDER_ID
	   			  , D.ALLOC_ID
	   			  , '02'
	   			  , D.CALC_TYPE_CODE	
	   			  , D.PAYABLE_AMT	
	   			  , D.MEMO
	   			  , D.CUST_ID
	   			  , D.DEPT_ID
	   			  , D.VEHIC_ID
	   			  , D.DRIVER_ID
	   			  , D.MNG_CUST_ID
	   			  , D.MNG_DEPT_ID
	   			  , (CASE WHEN D.PAYABLE_AMT = 0 THEN 'N' ELSE 'Y' END)
				  , GETDATE()
				  , D.REGID
	   			);
	END 
		/*
	INSERT INTO T_ORDER_ALLOC 
				(
					ALLOC_ID		, ORDER_ID			, SELL_CUST_ID		, SELL_DEPT_ID	, SELL_STAFF_ID
				  , BUY_CUST_ID		, BUY_DEPT_ID		, BUY_STAFF_ID		, ALLOC_CHARGE	, ALLOC_FEE		
				  , ALLOC_STATE		, VEHIC_ID			, DRIVER_ID			, CAR_NUM		, CAR_TON_CODE
				  , CAR_TYPE_CODE	, DRIVER_NAME		, DRIVER_TEL		, REGID			, REGDATE
				  , ALLOC_DATE
				)
	VALUES
				(
					@allocId		, @orderId			, @sellCustId		, @sellDeptId	, @sellStaff
				  , @buyCustId		, @buyDeptId		, @buyStaff			, @allocCharge	, @allocFee
				  , @allocState		, @vehicId			, @driverId			, @carNum		, @carTonCode
				  , @carTypeCode	, @driverName		, @driverTel		, @regid		, GETDATE()
				  , CASE @allocState WHEN '01' THEN GETDATE() WHEN '10' THEN GETDATE() ELSE NULL END
				)
				*/
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
