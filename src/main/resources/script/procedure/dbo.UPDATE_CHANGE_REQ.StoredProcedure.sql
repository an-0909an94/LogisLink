USE [logislink]
GO
/****** Object:  StoredProcedure [dbo].[UPDATE_CHANGE_REQ]    Script Date: 2022-07-14 오후 6:16:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UPDATE_CHANGE_REQ]
(
	@custId NVARCHAR(20)
  ,	@deptId NVARCHAR(20)
  , @manager NVARCHAR(20)
  ,	@orderList NVARCHAR(3000)
  , @allocList NVARCHAR(3000)
  , @bizAddr NVARCHAR(50)
  , @bizAddrDetail NVARCHAR(50)
  , @mobile NVARCHAR(13)
  , @memo NVARCHAR(1000)
  , @loginCustId NVARCHAR(20)
  ,	@loginDeptId NVARCHAR(20)
  , @retCode NVARCHAR(2) OUTPUT
  , @retMsg NVARCHAR(200) OUTPUT
)
AS 
	DECLARE @finishCnt  INT
BEGIN
		
	DECLARE @RET_OK		NVARCHAR(2) = '00'
	DECLARE @RET_ERR	NVARCHAR(2) = '99'
	
	SELECT @finishCnt = COUNT(1)
	FROM T_CALC 
	WHERE ALLOC_ID IN (SELECT VALUE FROM STRING_SPLIT(@allocList, ','))
		 AND USE_YN = 'Y' AND FINISH_YN = 'Y';
		
	IF @finishCnt > 0
	BEGIN
		set @retCode = @RET_ERR
		set @retMsg = '이미 마감된 정산 내역이 있어 화주 변경을 할 수 없습니다.';
	END
	ELSE
	SELECT * FROM T_ORDER
	WHERE ORDER_ID IN (SELECT VALUE FROM STRING_SPLIT(@orderList,','))
	AND CUST_ID != @loginCustId 
	AND DEPT_ID != @loginDeptId	
	IF @@ROWCOUNT = 0
		BEGIN
			UPDATE 
				T_ORDER
			SET  
				REQ_CUST_ID = @custId
			  , REQ_DEPT_ID = @deptId
			  , REQ_STAFF_ID = @manager
			  , REQ_ADDR = @bizAddr
			  , REQ_ADDR_DETAIL = @bizAddrDetail
			  , REQ_TEL = @mobile
			  , REQ_MEMO = @memo
			WHERE 
				ORDER_ID IN (SELECT VALUE FROM STRING_SPLIT(@orderList,','))
			AND CUST_ID = @loginCustId
			--AND DEPT_ID = @loginDeptId
				
			UPDATE 
				T_ORDER_ALLOC 
			SET 
				SELL_CUST_ID = @custId
			  , SELL_DEPT_ID = @deptId
			  , SELL_STAFF_ID = @manager
			WHERE 
				ALLOC_ID IN (SELECT VALUE FROM STRING_SPLIT(@allocList, ','))
				
			UPDATE 
				T_CALC
			SET 
			    MNG_CUST_ID = @custId
			  , MNG_DEPT_ID = @deptId
			WHERE 
				ORDER_ID IN (SELECT VALUE FROM STRING_SPLIT(@orderList,','))
			AND CUST_ID = @loginCustId
			--AND	DEPT_ID = @loginDeptId
			AND SELL_BUY_SCTN = '02'
			
			UPDATE 
				T_CALC
			SET  
			  	CUST_ID = @custId 
			  , DEPT_ID = @deptId 
			WHERE 
				ORDER_ID IN (SELECT VALUE FROM STRING_SPLIT(@orderList,','))
			AND MNG_CUST_ID = @loginCustId
			--AND	MNG_DEPT_ID = @loginDeptId
			AND SELL_BUY_SCTN = '01'
				
			
			set @retCode = @RET_OK
			set @retMsg = '화주가 변경되었습니다.'
		END
	ELSE 
		BEGIN 
			set @retCode = @RET_ERR
			set @retMsg = '화주를 변경할 수 없는 오더입니다.'
		END
END;
GO
