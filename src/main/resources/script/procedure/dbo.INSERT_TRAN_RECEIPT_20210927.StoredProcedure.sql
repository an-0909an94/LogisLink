USE [logislink]
GO
/****** Object:  StoredProcedure [dbo].[INSERT_TRAN_RECEIPT_20210927]    Script Date: 2022-07-14 오후 6:16:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[INSERT_TRAN_RECEIPT_20210927]
(
    @loginCustId	NVARCHAR(20)
  , @loginDeptId	NVARCHAR(20)
  , @custId			NVARCHAR(20)
  , @deptId			NVARCHAR(20)
  , @vehicId		NVARCHAR(20)
  , @driverId		NVARCHAR(20)
  , @fromDate		NVARCHAR(20)
  , @toDate			NVARCHAR(20)
  , @sellBuySctn	NVARCHAR(2)
  , @regId			NVARCHAR(20)
  , @retCode		NVARCHAR(2)		OUTPUT
  , @retMsg			NVARCHAR(200)	OUTPUT
)
AS
BEGIN
		
	DECLARE @RET_OK		NVARCHAR(2) = '00'
	DECLARE @RET_ERR	NVARCHAR(2) = '99'
	DECLARE @timestamp	NVARCHAR(14) = ''
	DECLARE @receiptId	NVARCHAR(20) = ''
	
	SET @timestamp = convert(varchar, getDate(), 112) + replace(convert(varchar, getDate(), 108), ':', '')
	SET @receiptId = 'R' + @timestamp + '001'
	
	DECLARE @frBizNum       NVARCHAR(20) = ''
	DECLARE @frBizNumSub    NVARCHAR(20) = ''
	DECLARE @frBizName      NVARCHAR(20) = ''
	DECLARE @frCeo          NVARCHAR(20) = ''
	DECLARE @frTelNum       NVARCHAR(20) = ''
	DECLARE @frBizCond      NVARCHAR(20) = ''
	DECLARE @frBizKind      NVARCHAR(20) = ''
	DECLARE @frAddr         NVARCHAR(20) = ''
	DECLARE @frAddrDetail   NVARCHAR(20) = ''
	
	DECLARE @toBizNum       NVARCHAR(20) = ''
	DECLARE @toBizNumSub    NVARCHAR(20) = ''
	DECLARE @toBizName      NVARCHAR(20) = ''
	DECLARE @toCeo          NVARCHAR(20) = ''
	DECLARE @toTelNum       NVARCHAR(20) = ''
	DECLARE @toBizCond      NVARCHAR(20) = ''
	DECLARE @toBizKind      NVARCHAR(20) = ''
	DECLARE @toAddr         NVARCHAR(20) = ''
	DECLARE @toAddrDetail   NVARCHAR(20) = ''
	
	DECLARE @charge			BIGINT = 0
	DECLARE @vat			BIGINT = 0
	DECLARE @amt			BIGINT = 0
	
	DECLARE @frCustId		NVARCHAR(20)
	DECLARE @frDeptId		NVARCHAR(20)	
	DECLARE @toCustId		NVARCHAR(20)
	DECLARE @toDeptId		NVARCHAR(20)
	
	IF @sellBuySctn = '01' 
	BEGIN
		SET @frCustId = @loginCustId
		SET @frDeptId = @loginDeptId
		SET @toCustId = @custId
		SET @toDeptId = @deptId
			
		SELECT TOP 1
			@frBizNum = CM.BIZ_NUM,
			@frBizNumSub = CM.BIZ_NUM_SUB,
			@frBizName = CM.BIZ_NAME,
			@frCeo = CM.CEO,
			@frTelNum = ISNULL(TCD.TELNUM, TCD.MOBILE),
			@frBizCond = CM.BIZ_COND,
			@frBizKind = CM.BIZ_KIND,
			@frAddr = CM.BIZ_ADDR,
			@frAddrDetail = CM.BIZ_ADDR_DETAIL
		FROM T_CUST_MST CM,
			 T_CUST_DTL TCD 
		WHERE CM.CUST_ID = TCD.CUST_ID 
			AND TCD.MNG_CUST_ID = @toCustId AND TCD.MNG_DEPT_ID = @toDeptId
			AND CM.CUST_ID = @frCustId AND TCD.DEPT_ID = @frDeptId 	
	END
	ELSE 
	BEGIN
		SET @frCustId = @custId
		SET @frDeptId = @deptId
		SET @toCustId = @loginCustId
		SET @toDeptId = @loginDeptId
		
		IF ISNULL(@driverId, '') = '' AND ISNULL(@vehicId, '') = ''
		BEGIN
			SELECT TOP 1
				@frBizNum = CM.BIZ_NUM,
				@frBizNumSub = CM.BIZ_NUM_SUB,
				@frBizName = CM.BIZ_NAME,
				@frCeo = CM.CEO,
				@frTelNum = ISNULL(TCD.TELNUM, TCD.MOBILE),
				@frBizCond = CM.BIZ_COND,
				@frBizKind = CM.BIZ_KIND,
				@frAddr = CM.BIZ_ADDR,
				@frAddrDetail = CM.BIZ_ADDR_DETAIL
			FROM T_CUST_MST CM,
				 T_CUST_DTL TCD 
		WHERE CM.CUST_ID = TCD.CUST_ID 
				AND TCD.MNG_CUST_ID = @toCustId AND TCD.MNG_DEPT_ID = @toDeptId
				AND CM.CUST_ID = @frCustId AND TCD.DEPT_ID = @frDeptId 		
		END 
		ELSE 
		BEGIN
			SELECT @frBizNum = B.BIZ_NUM ,
				   @frBizNumSub = B.SUB_BIZ_NUM,
				   @frBizName = B.BIZ_NAME,
				   @frCeo = B.CEO,
				   @frTelNum = A.MOBILE,
				   @frBizCond = B.BIZ_COND,
				   @frBizKind = B.BIZ_KIND,
				   @frAddr = B.BIZ_ADDR,
				   @frAddrDetail = B.BIZ_ADDR_DETAIL 
			FROM T_DRIVER A
				 INNER JOIN 
				 T_VEHIC_MST B ON A.VEHIC_ID = B.VEHIC_ID 
			WHERE A.DRIVER_ID = @driverId AND B.VEHIC_ID = @vehicId 
		END
	END
	
	SELECT TOP 1
		@toBizNum = CM.BIZ_NUM,
		@toBizNumSub = CM.BIZ_NUM_SUB,
		@toBizName = CM.BIZ_NAME,
		@toCeo = CM.CEO,
		@toTelNum = ISNULL(TCD.TELNUM, TCD.MOBILE),
		@toBizCond = CM.BIZ_COND,
		@toBizKind = CM.BIZ_KIND,
		@toAddr = CM.BIZ_ADDR,
		@toAddrDetail = CM.BIZ_ADDR_DETAIL
	FROM T_CUST_MST CM,
		 T_CUST_DTL TCD 
	WHERE CM.CUST_ID = TCD.CUST_ID 
		AND TCD.MNG_CUST_ID = @frCustId AND TCD.MNG_DEPT_ID = @frDeptId
		AND CM.CUST_ID = @toCustId AND TCD.DEPT_ID = @toDeptId
	
	-- 사업자 번호가 없으면 발행 안됨		
	IF ISNULL(@frBizNum, '') = '' OR ISNULL(@toBizNum, '') = ''
	BEGIN 
		set @retCode = @RET_ERR
		set @retMsg = '거래명세서를 발행할 사업자 정보가 없습니다.'
	END 
	ELSE 
	BEGIN
		IF ISNULL(@driverId, '') = '' AND ISNULL(@vehicId, '') = ''
		BEGIN
			SELECT 
				@charge = SUM(charge),
				@vat = SUM(vat)
			FROM (
				SELECT
					-- CASE WHEN CM.BIZ_TYPE_CODE = '02' THEN (ISNULL(C.UNPAID_AMT, 0) + ISNULL(C.PAYABLE_AMT, 0)) ELSE ((ISNULL(C.UNPAID_AMT, 0) + ISNULL(C.PAYABLE_AMT, 0)) - (ISNULL(C.UNPAID_AMT, 0) + ISNULL(C.PAYABLE_AMT, 0)) / 10) END charge,
					ISNULL(C.UNPAID_AMT, 0) + ISNULL(C.PAYABLE_AMT, 0) charge,
					CASE WHEN CM.BIZ_TYPE_CODE = '02' THEN 0 ELSE (ISNULL(C.UNPAID_AMT, 0) + ISNULL(C.PAYABLE_AMT, 0)) / 10 END vat	
				FROM T_CALC C, T_CUST_MST CM
				WHERE 
					C.MNG_CUST_ID = CM.CUST_ID
					AND MNG_CUST_ID = @loginCustId 
					AND MNG_DEPT_ID = @loginDeptId 
					AND C.CUST_ID = @custId
					AND C.DEPT_ID = @deptId
					AND CONVERT(CHAR(10), C.REGDATE, 23) BETWEEN @fromDate AND @toDate
				GROUP BY C.CALC_ID, C.UNPAID_AMT, C.PAYABLE_AMT, CM.BIZ_TYPE_CODE
				) T
				
			SET @amt = @charge + @vat	
				
			INSERT INTO T_TRAN_RECEIPT(RECEIPT_ID, TO_CUST_ID, TO_DEPT_ID, FR_CUST_ID, FR_DEPT_ID, 
								FR_BIZ_NUM, FR_BIZ_NUM_SUB, FR_BIZ_NAME, FR_CEO, FR_TELNUM, 
								FR_BIZ_COND, FR_BIZ_KIND, FR_ADDR, FR_ADDR_DETAIL, TO_BIZ_NUM, 
								TO_BIZ_NUM_SUB, TO_BIZ_NAME, TO_CEO, TO_TELNUM, TO_BIZ_COND, 
								TO_BIZ_KIND, TO_ADDR, TO_ADDR_DETAIL, 
								CHARGE, VAT, AMT,
								TRAN_S_DATE, TRAN_E_DATE, REGDATE, REGID, USE_YN)
			VALUES(@receiptId, @toCustId, @toDeptId, @frCustId, @frDeptId,
					@frBizNum, @frBizNumSub, @frBizName, @frCeo, @frTelNum, 
					@frBizCond, @frBizKind, @frAddr, @frAddrDetail, @toBizNum, 
					@toBizNumSub, @toBizName, @toCeo, @toTelNum, @toBizCond, 
					@toBizKind, @toAddr, @toAddrDetail, 
					@charge, @vat, @amt,
					@fromDate, @toDate, getdate(), @regId, 'Y')
					
			INSERT INTO T_TRAN_RECEIPT_DTL(RECEIPT_ID, CALC_ID, ALLOC_ID, ORDER_ID, ALLOC_CHARGE, ALLOC_VAT, ALLOC_AMT)
			SELECT @receiptId, A.CALC_ID, A.ALLOC_ID, A.ORDER_ID, 
			(CASE (SELECT BIZ_TYPE_CODE FROM T_CUST_MST WHERE CUST_ID = A.MNG_CUST_ID) WHEN '02' THEN (ISNULL(A.UNPAID_AMT, 0) + ISNULL(A.PAYABLE_AMT, 0)) ELSE ((ISNULL(A.UNPAID_AMT, 0) + ISNULL(A.PAYABLE_AMT, 0)) - (ISNULL(A.UNPAID_AMT, 0) + ISNULL(A.PAYABLE_AMT, 0)) / 10) END),
			(CASE (SELECT BIZ_TYPE_CODE FROM T_CUST_MST WHERE CUST_ID = A.MNG_CUST_ID) WHEN '02' THEN 0 ELSE (ISNULL(A.UNPAID_AMT, 0) + ISNULL(A.PAYABLE_AMT, 0)) / 10 END),
			(ISNULL(A.UNPAID_AMT, 0) + ISNULL(A.PAYABLE_AMT, 0))
			FROM T_CALC A, T_ORDER_ALLOC B
			WHERE 
				A.ORDER_ID = B.ORDER_ID AND A.ALLOC_ID = B.ALLOC_ID
				AND A.MNG_CUST_ID = @loginCustId 
				AND A.MNG_DEPT_ID = @loginDeptId 
				AND A.CUST_ID = @custId
				AND A.DEPT_ID = @deptId 
				AND CONVERT(CHAR(10), B.ALLOC_DATE, 23) BETWEEN @fromDate AND @toDate 
				
			UPDATE T_CALC
			SET
				RECEIPT_YN = 'Y'
			FROM T_CALC C, T_ORDER_ALLOC A
			WHERE
				C.ORDER_ID = A.ORDER_ID AND C.ALLOC_ID = A.ALLOC_ID AND
				C.MNG_CUST_ID = @loginCustId 
				AND C.MNG_DEPT_ID = @loginDeptId 
				AND C.CUST_ID = @custId
				AND C.DEPT_ID = @deptId 
				AND CONVERT(CHAR(10), A.ALLOC_DATE, 23) BETWEEN @fromDate AND @toDate
		END 
		ELSE 
		BEGIN
			SELECT 
				@charge = SUM(charge),
				@vat = SUM(vat)
			FROM (
				SELECT
					-- CASE WHEN CM.BIZ_TYPE_CODE = '02' THEN (ISNULL(C.UNPAID_AMT, 0) + ISNULL(C.PAYABLE_AMT, 0)) ELSE ((ISNULL(C.UNPAID_AMT, 0) + ISNULL(C.PAYABLE_AMT, 0)) - (ISNULL(C.UNPAID_AMT, 0) + ISNULL(C.PAYABLE_AMT, 0)) / 10) END charge,
					ISNULL(C.UNPAID_AMT, 0) + ISNULL(C.PAYABLE_AMT, 0) charge,
					(ISNULL(C.UNPAID_AMT, 0) + ISNULL(C.PAYABLE_AMT, 0)) / 10 vat	
				FROM T_CALC C
				WHERE 
					MNG_CUST_ID = @loginCustId 
					AND MNG_DEPT_ID = @loginDeptId 
					AND C.VEHIC_ID = @vehicId
					AND C.DRIVER_ID = @driverId
					AND CONVERT(CHAR(10), C.REGDATE, 23) BETWEEN @fromDate AND @toDate
				GROUP BY C.CALC_ID, C.UNPAID_AMT, C.PAYABLE_AMT
				) T
				
			SET @amt = @charge + @vat	
				
			INSERT INTO T_TRAN_RECEIPT(RECEIPT_ID, TO_CUST_ID, TO_DEPT_ID, FR_CUST_ID, FR_DEPT_ID, 
								FR_BIZ_NUM, FR_BIZ_NUM_SUB, FR_BIZ_NAME, FR_CEO, FR_TELNUM, 
								FR_BIZ_COND, FR_BIZ_KIND, FR_ADDR, FR_ADDR_DETAIL, TO_BIZ_NUM, 
								TO_BIZ_NUM_SUB, TO_BIZ_NAME, TO_CEO, TO_TELNUM, TO_BIZ_COND, 
								TO_BIZ_KIND, TO_ADDR, TO_ADDR_DETAIL, 
								CHARGE, VAT, AMT,
								TRAN_S_DATE, TRAN_E_DATE, REGDATE, REGID, USE_YN, FR_VEHIC_ID, FR_DRIVER_ID)
			VALUES(@receiptId, @toCustId, @toDeptId, @frCustId, @frDeptId,
					@frBizNum, @frBizNumSub, @frBizName, @frCeo, @frTelNum, 
					@frBizCond, @frBizKind, @frAddr, @frAddrDetail, @toBizNum, 
					@toBizNumSub, @toBizName, @toCeo, @toTelNum, @toBizCond, 
					@toBizKind, @toAddr, @toAddrDetail, 
					@charge, @vat, @amt,
					@fromDate, @toDate, getdate(), @regId, 'Y', @vehicId, @driverId)
					
			INSERT INTO T_TRAN_RECEIPT_DTL(RECEIPT_ID, CALC_ID, ALLOC_ID, ORDER_ID, ALLOC_CHARGE, ALLOC_VAT, ALLOC_AMT)
			SELECT @receiptId, A.CALC_ID, A.ALLOC_ID, A.ORDER_ID, 
			ISNULL(A.UNPAID_AMT, 0) + ISNULL(A.PAYABLE_AMT, 0),
			(ISNULL(A.UNPAID_AMT, 0) + ISNULL(A.PAYABLE_AMT, 0)) / 10,
			((ISNULL(A.UNPAID_AMT, 0) + ISNULL(A.PAYABLE_AMT, 0)) + ((ISNULL(A.UNPAID_AMT, 0) + ISNULL(A.PAYABLE_AMT, 0)) / 10))
			FROM T_CALC A, T_ORDER_ALLOC B
			WHERE 
				A.ORDER_ID = B.ORDER_ID AND A.ALLOC_ID = B.ALLOC_ID
				AND A.MNG_CUST_ID = @loginCustId 
				AND A.MNG_DEPT_ID = @loginDeptId 
				AND A.VEHIC_ID = @vehicId
				AND A.DRIVER_ID = @driverId
				AND CONVERT(CHAR(10), B.ALLOC_DATE, 23) BETWEEN @fromDate AND @toDate 
				
			UPDATE T_CALC
			SET
				RECEIPT_YN = 'Y'
			FROM T_CALC C, T_ORDER_ALLOC A
			WHERE
				C.ORDER_ID = A.ORDER_ID AND C.ALLOC_ID = A.ALLOC_ID AND
				C.MNG_CUST_ID = @loginCustId 
				AND C.MNG_DEPT_ID = @loginDeptId 
				AND C.VEHIC_ID = @vehicId
				AND C.DRIVER_ID = @driverId
				AND CONVERT(CHAR(10), A.ALLOC_DATE, 23) BETWEEN @fromDate AND @toDate
		END
		set @retCode = @RET_OK
		set @retMsg = '거래명세서가 등록되었습니다.'
	END 
		
END
GO
