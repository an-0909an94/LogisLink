USE [logislink]
GO
/****** Object:  StoredProcedure [dbo].[INSERT_TRAN_RECEIPT_FOR_DRIVER]    Script Date: 2022-07-14 오후 6:16:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[INSERT_TRAN_RECEIPT_FOR_DRIVER]
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
  , @bizTypeCd		NVARCHAR(2)
  , @orderList		NVARCHAR(2000)
  , @writeDate      NVARCHAR(20)
  , @regId			NVARCHAR(20)
  , @retId			NVARCHAR(20)	OUTPUT
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
	
	SET @frCustId = @loginCustId
	SET @frDeptId = @loginDeptId
	SET @toCustId = @custId
	SET @toDeptId = @deptId
	
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
		 T_VEHIC_MST B ON A.DRIVER_ID = B.DRIVER_ID
	WHERE A.DRIVER_ID = @driverId AND B.VEHIC_ID = @vehicId 
	
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
		AND TCD.MNG_CUST_ID = @frCustId
		AND (CASE WHEN ISNULL(@frDeptId, '') = '' THEN '' ELSE TCD.MNG_DEPT_ID END) =  (CASE WHEN ISNULL(@frDeptId, '') = '' THEN '' ELSE @frDeptId END)
		AND CM.CUST_ID = @toCustId 
		AND (CASE WHEN ISNULL(@toDeptId, '') = '' THEN '' ELSE TCD.DEPT_ID END) =  (CASE WHEN ISNULL(@toDeptId, '') = '' THEN '' ELSE @toDeptId END)
	
	-- 사업자 번호가 없으면 발행 안됨		
		
	IF ISNULL(@frBizNum, '') = '' OR ISNULL(@toBizNum, '') = ''
	BEGIN 
		set @retCode = @RET_ERR
		set @retMsg = '거래명세서를 발행할 사업자 정보가 없습니다.'
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
				AND (CASE WHEN ISNULL(@loginDeptId, '') = '' THEN '' ELSE MNG_DEPT_ID END) =  (CASE WHEN ISNULL(@loginDeptId, '') = '' THEN '' ELSE @loginDeptId END) 
			 	AND C.VEHIC_ID = @vehicId
				AND C.DRIVER_ID = @driverId
				AND CONVERT(CHAR(10), C.REGDATE, 23) BETWEEN @fromDate AND @toDate
				AND C.USE_YN = 'Y' AND C.SELL_BUY_SCTN = '02'
				AND C.ORDER_ID = @orderList
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
		SELECT @receiptId, MIN(AA.CALC_ID), AA.ALLOC_ID ,AA.ORDER_ID 
			  , SUM(AA.ALLOC_CHARGE), SUM(AA.ALLOC_VAT), SUM(AA.ALLOC_AMT)
		FROM (
				SELECT A.CALC_ID, A.ALLOC_ID, A.ORDER_ID, 
					   ISNULL(C.UNPAID_AMT, 0) + ISNULL(C.PAYABLE_AMT, 0) ALLOC_CHARGE,
					   (ISNULL(C.UNPAID_AMT, 0) + ISNULL(C.PAYABLE_AMT, 0)) / 10 ALLOC_VAT,
					   ((ISNULL(C.UNPAID_AMT, 0) + ISNULL(C.PAYABLE_AMT, 0)) + ((ISNULL(C.UNPAID_AMT, 0) + ISNULL(C.PAYABLE_AMT, 0)) / 10)) ALLOC_AMT
				FROM 
						T_CALC A
						INNER JOIN 
						T_ORDER_ALLOC B ON A.ORDER_ID = B.ORDER_ID AND A.ALLOC_ID = B.ALLOC_ID
						INNER JOIN 
						T_CALC C ON A.ORDER_ID = C.ORDER_ID
				WHERE 
					A.MNG_CUST_ID = @loginCustId 
					AND (CASE WHEN ISNULL(@loginDeptId, '') = '' THEN '' ELSE A.MNG_DEPT_ID END) =  (CASE WHEN ISNULL(@loginDeptId, '') = '' THEN '' ELSE @loginDeptId END) 
					AND A.CUST_ID = @custId
					AND (CASE WHEN ISNULL(@deptId, '') = '' THEN '' ELSE A.DEPT_ID END) =  (CASE WHEN ISNULL(@deptId, '') = '' THEN '' ELSE @deptId END)
					AND CONVERT(CHAR(10), B.ALLOC_DATE, 23) BETWEEN @fromDate AND @toDate 
					AND A.USE_YN = 'Y' AND A.SELL_BUY_SCTN = @sellBuySctn
					AND A.ORDER_ID = @orderList
					AND C.VEHIC_ID = @vehicId
					AND C.DRIVER_ID = @driverId
					AND C.SELL_BUY_SCTN = '02'
			) AA
		GROUP BY AA.ALLOC_ID ,AA.ORDER_ID
						
		UPDATE T_CALC
		SET
			RECEIPT_YN = 'Y',
			RECEIPT_DATE = GETDATE()
		FROM T_CALC C, T_ORDER_ALLOC A
		WHERE
			C.ORDER_ID = A.ORDER_ID AND C.ALLOC_ID = A.ALLOC_ID AND
			C.MNG_CUST_ID = @loginCustId 
			AND (CASE WHEN ISNULL(@loginDeptId, '') = '' THEN '' ELSE C.MNG_DEPT_ID END) =  (CASE WHEN ISNULL(@loginDeptId, '') = '' THEN '' ELSE @loginDeptId END) 
			AND C.CUST_ID = @custId
			AND (CASE WHEN ISNULL(@deptId, '') = '' THEN '' ELSE C.DEPT_ID END) =  (CASE WHEN ISNULL(@deptId, '') = '' THEN '' ELSE @deptId END)
			AND CONVERT(CHAR(10), A.ALLOC_DATE, 23) BETWEEN @fromDate AND @toDate
			AND C.USE_YN = 'Y' AND C.SELL_BUY_SCTN = @sellBuySctn
			
		
		set @retId = @receiptId
		set @retCode = @RET_OK
		set @retMsg = '거래명세서가 등록되었습니다.'
		
	END
END
GO
