USE [logislink]
GO
/****** Object:  StoredProcedure [dbo].[INSERT_DEPT]    Script Date: 2022-07-14 오후 6:16:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[INSERT_DEPT]
(
  	@inCustId NVARCHAR(20)
  , @inDeptId NVARCHAR(20)
  , @deptName NVARCHAR(30)
  , @regId NVARCHAR(20)
  , @retCode INT OUTPUT
  , @retMsg NVARCHAR(200) OUTPUT
  , @custId NVARCHAR(20) OUTPUT
  , @deptId NVARCHAR(20) OUTPUT
)
AS
BEGIN
	
	DECLARE @RET_OK NVARCHAR(2) = '00'		-- 성공
	DECLARE @RET_ERR NVARCHAR(2) = '99'		-- Error
	DECLARE @timestamp	NVARCHAR(14) = ''
	
	IF @inDeptId = ''
		BEGIN
			SELECT * FROM dbo.T_CUST_DEPT WHERE CUST_ID = @inCustId AND DEPT_NAME = @deptName
			
			IF @@ROWCOUNT=0
				BEGIN 
					SET @timestamp = convert(varchar, getDate(), 112) + replace(convert(varchar, getDate(), 108), ':', '')
					SET @inDeptId = 'D' + @timestamp + '001'
			
					INSERT 
					INTO T_CUST_DEPT 
				        (	
			        		CUST_ID
						  , DEPT_ID
						  , DEPT_NAME
						  , USE_YN
						  , REGID
				        )
					VALUES 
						(
							@inCustId
						  , @inDeptId
						  , @deptName
						  , 'Y'
						  , @regId
						)
						
					set @retCode = @RET_OK
		            set @retMsg = '부서 정보가 추가되었습니다.'
		            set @custId = @inCustId
		            set @deptId = @inDeptId
				END
			ELSE
				BEGIN
					set @retCode = @RET_ERR
		            set @retMsg = '이미 등록된 부서입니다.'
		            set @custId = @inCustId
		            set @deptId = ''
				END
		END
	ELSE
		BEGIN
			set @retCode = @RET_ERR
            set @retMsg = '이미 등록된 부서입니다.'
            set @custId = @inCustId
            set @deptId = @inDeptId
		END
END
GO
