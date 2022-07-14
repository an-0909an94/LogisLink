USE [logislink]
GO
/****** Object:  StoredProcedure [dbo].[OAPI_ORDER_ALLOC_INSERT]    Script Date: 2022-07-14 오후 6:16:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[OAPI_ORDER_ALLOC_INSERT]
(
	@orderId		NVARCHAR(20)
  , @sellCustId		NVARCHAR(20)
  , @sellDeptId		NVARCHAR(20)
  , @sellStaff		NVARCHAR(20)
  , @sellStaffTel	NVARCHAR(13)
  , @allocCharge	INT
  , @carNum			NVARCHAR(10)
  , @carTonCode		NVARCHAR(20)
  , @carTypeCode	NVARCHAR(20)
  , @driverName		NVARCHAR(20)
  , @driverTel		NVARCHAR(13)
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
	
	DECLARE @driverId	NVARCHAR(20)
	DECLARE @vehicId	NVARCHAR(20)

	DECLARE @custId		NVARCHAR(20)
	DECLARE @deptId		NVARCHAR(20)
	
	DECLARE @allocState	NVARCHAR(2)	= '00'
	DECLARE @orderState NVARCHAR(2)	
	
	SET @timestamp = convert(varchar, getDate(), 112) + replace(convert(varchar, getDate(), 108), ':', '')
	SET @allocId = 'A' + @timestamp + '001'
	
	BEGIN TRY 	
		
		SELECT @orderState = ORDER_STATE, @custId = CUST_ID, @deptID = DEPT_ID
		FROM T_ORDER
		WHERE ORDER_ID = @orderId
		
		IF @orderState <> '00'
		BEGIN
			THROW 50001, 'ALREADY_ALLOC', 1
		END 
		
		IF @custId != @sellCustId OR @deptId != @sellDeptId 
		BEGIN
			THROW 50001, '부서 정보를 확인해주세요.', 1	
		END 
	
		-- 등록된 기사가 아닌 경우, 기사 정보 저장
		IF ISNULL(@driverTel, '') <> ''
			BEGIN 
				EXEC INSERT_DRIVER @driverId, @driverName, @driverTel, @driverTel, NULL, NULL, NULL, NULL, @regid, @spRet OUTPUT, @spMsg OUTPUT, @spId2 OUTPUT
				
				SET @driverId = @spId2
			END
			
		-- 등록된 차량번호가 아닐 경우 차량 마스터에 차량번호 저장
		IF ISNULL(@carNum, '') <> '' 
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
					  , @allocCharge	ALLOC_CHARGE 
					  --, @allocFee		ALLOC_FEE 
					  , @allocState		ALLOC_STATE 
					  , @vehicId		VEHIC_ID 
					  , @driverId		DRIVER_ID 
					  , @carNum			CAR_NUM 
					  , @carTonCode		CAR_TON_CODE 
					  , @carTypeCode	CAR_TYPE_CODE 
					  , @driverName		DRIVER_NAME 
					  , @driverTel		DRIVER_TEL 
	--				  , @payType		PAY_TYPE
					  , @regid			REGID 
					  
			) D
		ON A.ORDER_ID = D.ORDER_ID AND A.SELL_CUST_ID = D.SELL_CUST_ID AND A.SELL_DEPT_ID = D.SELL_DEPT_ID
		WHEN MATCHED THEN 
			UPDATE SET A.SELL_STAFF_ID = D.SELL_STAFF_ID
					 , A.SELL_STAFF_TEL = D.SELL_STAFF_TEL
					 , A.ALLOC_CHARGE = D.ALLOC_CHARGE
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
	--				 , A.PAY_TYPE = D.PAY_TYPE
					 , A.EDITID = D.REGID
					 , A.EDITDATE = GETDATE()
					 , A.ALLOC_DATE = CASE @allocState WHEN '01' THEN GETDATE() WHEN '10' THEN GETDATE() ELSE A.ALLOC_DATE END
		WHEN NOT MATCHED THEN 
			INSERT (
						ALLOC_ID		, ORDER_ID			, SELL_CUST_ID		, SELL_DEPT_ID	, SELL_STAFF_ID
					  , ALLOC_CHARGE	
					  , ALLOC_STATE		, VEHIC_ID			, DRIVER_ID			, CAR_NUM		, CAR_TON_CODE
					  , CAR_TYPE_CODE	, DRIVER_NAME		, DRIVER_TEL		, REGID			, REGDATE
					  , ALLOC_DATE		, SELL_STAFF_TEL
					)
			VALUES (
						D.ALLOC_ID		, D.ORDER_ID		, D.SELL_CUST_ID	, D.SELL_DEPT_ID, D.SELL_STAFF_ID
					  , D.ALLOC_CHARGE
					  , D.ALLOC_STATE	, D.VEHIC_ID		, D.DRIVER_ID		, D.CAR_NUM		, D.CAR_TON_CODE
					  , D.CAR_TYPE_CODE	, D.DRIVER_NAME		, D.DRIVER_TEL		, D.REGID		, GETDATE()
					  , CASE WHEN @allocState = '01' THEN GETDATE() WHEN @allocState = '10' THEN GETDATE() ELSE NULL END
					  , D.SELL_STAFF_TEL
					);		
			
					
		SELECT @allocId = ALLOC_ID
		FROM T_ORDER_ALLOC
		WHERE ORDER_ID = @orderId AND SELL_CUST_ID = @sellCustId AND SELL_DEPT_ID = @sellDeptId;
			 	
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
					  , @vehicId		AS VEHIC_ID
					  , @driverId		AS DRIVER_ID
					  , CALC_TYPE_CODE	AS CALC_TYPE_CODE 
					  , ADD_CHARGE		AS PAYABLE_AMT
					  , MEMO			AS MEMO 
					  , @regid			AS REGID 
					FROM T_ORDER_ALLOC_ADD 
					WHERE ORDER_ID = @orderId
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
		   			  , D.VEHIC_ID
		   			  , D.DRIVER_ID
		   			  , D.MNG_CUST_ID
		   			  , D.MNG_DEPT_ID
		   			  , (CASE WHEN D.PAYABLE_AMT = 0 THEN 'N' ELSE 'Y' END)
					  , GETDATE()
					  , D.REGID
		   			);
		END 
	
    	SET @retCode = @RET_OK
	    SET @retMsg = '배차가 등록되었습니다.'
	END TRY
	BEGIN CATCH 
		IF CAST(ERROR_NUMBER() AS VARCHAR(10)) = '50001' 
		BEGIN 				
		    set @retCode = @RET_ERR
		    set @retMsg = ERROR_MESSAGE()
		END 
		ELSE
		BEGIN
		    set @retCode = @RET_ERR
		    set @retMsg = '배차에 실패했습니다.'
		END
	END CATCH 
	
END    	
GO
