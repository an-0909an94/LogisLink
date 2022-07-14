USE [logislink]
GO
/****** Object:  StoredProcedure [dbo].[UPDATE_CALC_FINISH_CUST_20211215]    Script Date: 2022-07-14 오후 6:16:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UPDATE_CALC_FINISH_CUST_20211215] (
	@mngCustId		NVARCHAR(20)
  , @mngDeptId		NVARCHAR(20)
  , @custId			NVARCHAR(20)
  , @deptId			NVARCHAR(20)
  , @vehicId		NVARCHAR(20)
  , @driverId		NVARCHAR(20)
  , @calcTypeCode	NVARCHAR(20)
  , @sellBuySctn	NVARCHAR(20)
  , @fromDate		NVARCHAR(10)
  , @toDate			NVARCHAR(10)
  , @regid			NVARCHAR(20)
  , @retCode 		NVARCHAR(2) 	OUTPUT
  , @retMsg 		NVARCHAR(200) 	OUTPUT
)
AS 
BEGIN
	
	DECLARE @RET_OK		NVARCHAR(2) = '00'
	DECLARE @RET_ERR	NVARCHAR(2) = '99'
	
	DECLARE @orderId 	NVARCHAR(20)
	DECLARE @allocId	NVARCHAR(20)
	DECLARE @calcId		NVARCHAR(20)
	
	DECLARE @bankCode		NVARCHAR(5)
	DECLARE @bankCnnm		NVARCHAR(20)
	DECLARE @bankAccount	NVARCHAR(30)
	
	-- 매입정산 : 마감 이후 운송비 지급 프로세스를 위해 테이블에 INSERT 한다. 
	IF @sellBuySctn = '02' 
	BEGIN
		
		IF ISNULL(@vehicId, '') != '' AND ISNULL(@driverId, '') != ''			
		BEGIN
			SELECT @bankCode = BANK_CODE, @bankCnnm = BANK_CNNM, @bankAccount = BANK_ACCOUNT
			FROM T_DRIVER 
			WHERE DRIVER_ID = @driverId
		END
		
		IF ISNULL(@custId, '') != '' AND ISNULL(@deptId, '') != ''
		BEGIN			
			SELECT @bankCode = BANK_CODE, @bankCnnm = BANK_CNNM, @bankAccount = BANK_ACCOUNT
			FROM T_CUST_MST  
			WHERE CUST_ID = @custId
		END
		
		-- 정산 마감 후 지급 프로세스를 위해 테이블 INSERT
		INSERT INTO T_CALC_PAY (
				ORDER_ID	, ALLOC_ID		, MNG_CUST_ID	, MNG_DEPT_ID	, FINISH_DATE 
			  , FINISH_ID	, BUY_AMT		, PAYABLE_AMT 	, BANK_CNNM 
			  , BANK_CODE	, BANK_ACCOUNT 	, CAR_NUM		, DRIVER_NAME	, DRIVER_TEL 
			  , CUST_ID		, DEPT_ID		, DRIVER_ID		, VEHIC_ID		, PAY_STATE_CODE
				)	
		SELECT
				A.ORDER_ID	, A.ALLOC_ID	, A.MNG_CUST_ID	, A.MNG_DEPT_ID	, GETDATE()			
			  , @regid		, SUM(PAYABLE_AMT), SUM(PAYABLE_AMT), @bankCnnm
			  , @bankCode	, @bankAccount	, B.CAR_NUM 	, B.DRIVER_NAME , B.DRIVER_TEL 
			  , A.CUST_ID	, A.DEPT_ID 	, A.DRIVER_ID  	, A.VEHIC_ID 	, '00'
		FROM T_CALC A
			 INNER JOIN
			 T_ORDER_ALLOC B ON A.ORDER_ID = B.ORDER_ID AND A.ALLOC_ID = B.ALLOC_ID 
		WHERE 
			A.MNG_CUST_ID = @mngCustId AND A.USE_YN = 'Y' AND A.FINISH_YN = 'N'
			AND (CASE WHEN ISNULL(@mngDeptId, '') = '' THEN '' ELSE A.MNG_DEPT_ID END) = ISNULL(@mngDeptId, '')
			AND (CASE WHEN ISNULL(@custId, '') = '' THEN '' ELSE A.CUST_ID END) = ISNULL(@custId, '')
			AND (CASE WHEN ISNULL(@deptId, '') = '' THEN '' ELSE A.DEPT_ID END) = ISNULL(@deptId, '')
			AND (CASE WHEN ISNULL(@vehicId, '') = '' THEN '' ELSE A.VEHIC_ID END) = ISNULL(@vehicId, '')
			AND (CASE WHEN ISNULL(@driverId, '') = '' THEN '' ELSE A.DRIVER_ID END) = ISNULL(@driverId, '')
			AND (CASE WHEN ISNULL(@calcTypeCode, '') = '' THEN '' ELSE A.CALC_TYPE_CODE END) = ISNULL(@calcTypeCode, '')
			AND (CASE WHEN ISNULL(@sellBuySctn, '') = '' THEN '' ELSE A.SELL_BUY_SCTN END) = ISNULL(@sellBuySctn, '')
			AND ALLOC_DATE BETWEEN @fromDate AND @toDate + ' 23:59:59'
		GROUP BY 
			A.ORDER_ID, A.ALLOC_ID, A.MNG_CUST_ID, A.MNG_DEPT_ID, B.CAR_NUM, B.DRIVER_NAME, B.DRIVER_TEL
		  , A.CUST_ID, A.DEPT_ID , A.DRIVER_ID  , A.VEHIC_ID
	END	
	
	-- 정산 마감 처리
	UPDATE 
			T_CALC
	SET 
			FINISH_YN = 'Y',
			CALC_DATE = GETDATE(),
			DEPOSIT_AMT = UNPAID_AMT,
			WITHDRAWAL_AMT = PAYABLE_AMT,
			UNPAID_AMT = 0,
			PAYABLE_AMT = 0,
			FINISH_USER_ID = @regid
	FROM T_CALC A
		 INNER JOIN
		 T_ORDER_ALLOC B ON A.ORDER_ID = B.ORDER_ID AND A.ALLOC_ID = B.ALLOC_ID 
	WHERE 
		A.MNG_CUST_ID = @mngCustId AND A.USE_YN = 'Y' AND A.FINISH_YN = 'N'
		AND (CASE WHEN ISNULL(@mngDeptId, '') = '' THEN '' ELSE A.MNG_DEPT_ID END) = ISNULL(@mngDeptId, '')
		AND (CASE WHEN ISNULL(@custId, '') = '' THEN '' ELSE A.CUST_ID END) = ISNULL(@custId, '')
		AND (CASE WHEN ISNULL(@deptId, '') = '' THEN '' ELSE A.DEPT_ID END) = ISNULL(@deptId, '')
		AND (CASE WHEN ISNULL(@vehicId, '') = '' THEN '' ELSE A.VEHIC_ID END) = ISNULL(@vehicId, '')
		AND (CASE WHEN ISNULL(@driverId, '') = '' THEN '' ELSE A.DRIVER_ID END) = ISNULL(@driverId, '')
		AND (CASE WHEN ISNULL(@calcTypeCode, '') = '' THEN '' ELSE A.CALC_TYPE_CODE END) = ISNULL(@calcTypeCode, '')
		AND (CASE WHEN ISNULL(@sellBuySctn, '') = '' THEN '' ELSE A.SELL_BUY_SCTN END) = ISNULL(@sellBuySctn, '')
		AND ALLOC_DATE BETWEEN @fromDate AND @toDate + ' 23:59:59'
		
	SET @retCode = @RET_OK
	SET @retMsg = '정산 내역이 마감되었습니다.'
			
END
GO
