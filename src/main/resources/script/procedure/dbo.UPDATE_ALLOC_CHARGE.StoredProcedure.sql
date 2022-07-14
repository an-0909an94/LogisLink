USE [logislink]
GO
/****** Object:  StoredProcedure [dbo].[UPDATE_ALLOC_CHARGE]    Script Date: 2022-07-14 오후 6:16:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UPDATE_ALLOC_CHARGE]
(
    @allocCharge	NVARCHAR(20)
  ,	@loginCustId	NVARCHAR(20)
  , @loginDeptId	NVARCHAR(20)
  , @allocList		NVARCHAR(3000)
  --, @custId			NVARCHAR(20)
  --, @deptId			NVARCHAR(20)
  --, @fromDate		NVARCHAR(20)
  --, @toDate			NVARCHAR(20)
  , @retCode		NVARCHAR(2)		OUTPUT
  , @retMsg			NVARCHAR(200)	OUTPUT
)
AS
	DECLARE @finishCnt  INT
BEGIN
		
	DECLARE @RET_OK		NVARCHAR(2) = '00'
	DECLARE @RET_ERR	NVARCHAR(2) = '99'
	
	SELECT @finishCnt = COUNT(1)
	FROM T_CALC 
	WHERE ALLOC_ID IN (SELECT VALUE FROM STRING_SPLIT(@allocList, ','))
		 AND USE_YN = 'Y' AND (FINISH_YN = 'Y'  OR TAXINV_YN IN ('P', 'Y'));
		
	IF @finishCnt > 0
	BEGIN
		set @retCode = @RET_ERR
		set @retMsg = '이미 마감된 정산 내역이 있어 운송비 변경을 할 수 없습니다.';
	END
	ELSE 
	BEGIN
		
		UPDATE 
			T_ORDER_ALLOC
		SET 
			ALLOC_CHARGE = CONVERT(INT,@allocCharge)
		WHERE
			ALLOC_ID IN (
				SELECT VALUE FROM STRING_SPLIT(@allocList, ',')
				/*SELECT B.ALLOC_ID 
				FROM T_CALC A, T_ORDER_ALLOC B
				WHERE 
					A.ORDER_ID = B.ORDER_ID AND A.ALLOC_ID = B.ALLOC_ID
					AND A.MNG_CUST_ID = @loginCustId 
					AND A.MNG_DEPT_ID = @loginDeptId 
					AND A.CUST_ID = @custId
					AND A.DEPT_ID = @deptId 
					AND CONVERT(CHAR(10), B.ALLOC_DATE, 23) BETWEEN @fromDate AND @toDate 
					AND A.SELL_BUY_SCTN = '02' AND A.CALC_STATE = '00' AND A.USE_YN = 'Y'
					AND A.CALC_TYPE_CODE = '0002'
					AND A.FINISH_YN = 'N'*/
			)
		
			
			-- 매입 정산 정보 업데이트
			UPDATE T_CALC SET PAYABLE_AMT = @allocCharge 
			WHERE CALC_TYPE_CODE = '0002' AND SELL_BUY_SCTN = '02'
				 AND USE_YN = 'Y' AND FINISH_YN = 'N'
				AND ALLOC_ID IN (SELECT VALUE FROM STRING_SPLIT(@allocList, ','));
				
			-- 매출 정산 정보 업데이트
			UPDATE T_CALC SET UNPAID_AMT = @allocCharge 
			WHERE CALC_TYPE_CODE = '0002' AND SELL_BUY_SCTN = '01'
				 AND USE_YN = 'Y' AND FINISH_YN = 'N'
				AND ALLOC_ID IN (SELECT VALUE FROM STRING_SPLIT(@allocList, ','));
			
		/*	-- 매입 정산 정보 업데이트
			UPDATE T_CALC SET PAYABLE_AMT = @allocCharge 
			WHERE CALC_TYPE_CODE = '0002' AND SELL_BUY_SCTN = '02'
				AND ALLOC_ID IN (
				SELECT B.ALLOC_ID 
				FROM T_CALC A, T_ORDER_ALLOC B
				WHERE 
					A.ORDER_ID = B.ORDER_ID AND A.ALLOC_ID = B.ALLOC_ID
					AND A.MNG_CUST_ID = @loginCustId 
					AND A.MNG_DEPT_ID = @loginDeptId 
					AND A.CUST_ID = @custId
					AND A.DEPT_ID = @deptId 
					AND CONVERT(CHAR(10), B.ALLOC_DATE, 23) BETWEEN @fromDate AND @toDate 
					AND A.SELL_BUY_SCTN = '02' AND A.CALC_STATE = '00' AND A.USE_YN = 'Y'
					AND A.CALC_TYPE_CODE = '0002'
					AND A.FINISH_YN = 'N');
			
	
			-- 매출 정산 정보 업데이트
			UPDATE T_CALC SET UNPAID_AMT = @allocCharge 
			WHERE CALC_TYPE_CODE = '0002' AND SELL_BUY_SCTN = '01'
				AND ALLOC_ID IN (
				SELECT B.ALLOC_ID 
				FROM T_CALC A, T_ORDER_ALLOC B
				WHERE 
					A.ORDER_ID = B.ORDER_ID AND A.ALLOC_ID = B.ALLOC_ID
					AND A.MNG_CUST_ID = @loginCustId 
					AND A.MNG_DEPT_ID = @loginDeptId 
					AND A.CUST_ID = @custId
					AND A.DEPT_ID = @deptId 
					AND CONVERT(CHAR(10), B.ALLOC_DATE, 23) BETWEEN @fromDate AND @toDate 
					AND A.SELL_BUY_SCTN = '02' AND A.CALC_STATE = '00' AND A.USE_YN = 'Y'
					AND A.CALC_TYPE_CODE = '0002'
					AND A.FINISH_YN = 'N');
			*/
		
		
		set @retCode = @RET_OK
		set @retMsg = '운송비가 변경되었습니다.'
	END
		
END
GO
