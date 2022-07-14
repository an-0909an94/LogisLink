USE [logislink]
GO
/****** Object:  StoredProcedure [dbo].[CHECK_DEPT_ID]    Script Date: 2022-07-14 오후 6:16:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[CHECK_DEPT_ID]
(
	@deptId NVARCHAR(20)
  , @retCode INT OUTPUT
  , @retMsg NVARCHAR(200) OUTPUT
)
AS
BEGIN
	
	DECLARE @RET_OK NVARCHAR(2) = '00'		-- 성공
	DECLARE @RET_ERR NVARCHAR(2) = '99'		-- Error
	

	SELECT DEPT_ID deptId
	FROM T_CUST_DEPT
	WHERE DEPT_ID = @deptId

    IF @@ROWCOUNT=0
    	BEGIN 
	    	set @retCode = @RET_OK
		    set @retMsg = ''
		    select @retCode as retCode, @retMsg as retMsg
    	END
    ELSE
    	BEGIN
	    	--SELECT @retCode = 0, @retMsg = ''
	    	set @retCode = @RET_ERR
		    set @retMsg = '이미 존재하는 부서입니다.'
		    select @retCode as retCode, @retMsg as retMsg
    	END
END
GO
