USE [logislink]
GO
/****** Object:  StoredProcedure [dbo].[DELETE_CUST_FRTCOST]    Script Date: 2022-07-14 오후 6:16:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[DELETE_CUST_FRTCOST]
(
	@custId			NVARCHAR(20)
  , @deptId			NVARCHAR(20)
  , @mngCustId		NVARCHAR(20)
  , @mngDeptId		NVARCHAR(20)
  , @sellBuySctn	NVARCHAR(2)
  , @retCode 		NVARCHAR(2)		OUTPUT
  , @retMsg 		NVARCHAR(200) 	OUTPUT
)
AS
BEGIN
		
	DECLARE @RET_OK NVARCHAR(2) = '00'		-- 성공
	DECLARE @RET_ERR NVARCHAR(2) = '99'		-- Error
	
	DECLARE @CNT INT
	
	SELECT @CNT = COUNT(1)
	FROM T_CUST_DTL
	WHERE CUST_ID = @custId AND DEPT_ID = @deptId AND MNG_CUST_ID = @mngCustId and MNG_DEPT_ID = @mngDeptId AND SELL_BUY_SCTN = @sellBuySctn
	
	IF @CNT <> 0
		BEGIN 
			IF @sellBuySctn = '01'				-- 매출처 삭제 시,
				BEGIN 
					DELETE FROM T_CUST_FRTCOST
					WHERE SELL_CUST_ID = @custId AND SELL_DEPT_ID = @deptId AND BUY_CUST_ID = @mngCustId AND BUY_DEPT_ID = @mngDeptId
				END
			ELSE
				BEGIN
					DELETE FROM T_CUST_FRTCOST
					WHERE SELL_CUST_ID = @mngCustId AND SELL_DEPT_ID = @mngDeptId AND BUY_CUST_ID = @custId AND BUY_DEPT_ID = @deptId
				END
			
			SET @retCode = @RET_OK
		END
	ELSE
		BEGIN 
			SET @retCode = @RET_ERR
			SET @retMsg  = '유효하지 않은 값입니다.'  
		END
END 
GO
