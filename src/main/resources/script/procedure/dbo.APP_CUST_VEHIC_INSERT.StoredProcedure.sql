USE [logislink]
GO
/****** Object:  StoredProcedure [dbo].[APP_CUST_VEHIC_INSERT]    Script Date: 2022-07-14 오후 6:16:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[APP_CUST_VEHIC_INSERT]
(
	@custId			NVARCHAR(20)		
  ,	@deptId			NVARCHAR(20)
  , @driverName		NVARCHAR(20)
  , @mobile			NVARCHAR(13)
  ,	@carNum			NVARCHAR(10)
  , @regid			NVARCHAR(20)
  , @retCode 		NVARCHAR(2)		OUTPUT
  , @retMsg 		NVARCHAR(200) 	OUTPUT
)
AS
	DECLARE @RET_OK 	NVARCHAR(2) = '00'		-- 성공
	DECLARE @RET_ERR 	NVARCHAR(2) = '99'		-- Error
	DECLARE @spId1		NVARCHAR(20)
	DECLARE @spId2		NVARCHAR(20)	
	DECLARE @spRet		NVARCHAR(2)
	DECLARE @spMsg		NVARCHAR(200)
	DECLARE @vehicId 	NVARCHAR(20)
	DECLARE @driverId 	NVARCHAR(20)
	
BEGIN
	-- 기사 정보 저장
	EXEC INSERT_DRIVER NULL, @driverName, @mobile, @mobile, NULL, NULL, NULL, NULL, @regid, @spRet OUTPUT, @spMsg OUTPUT, @spId2 OUTPUT
			
	SET @driverId = @spId2
	-- 차량 정보 저장
	EXEC INSERT_VEHIC NULL, @driverId, @custId, @deptId, @carNum, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @regid, NULL, @spRet OUTPUT, @spMsg  OUTPUT, @spId1 OUTPUT
			
	SET @vehicId = @spId1
		
	IF @spRet = '00'
		BEGIN
			set @retCode = @RET_OK
			set @retMsg = '기사 정보가 추가되었습니다.'			
		END
	ELSE 
		BEGIN 
			set @retCode = @RET_ERR
			set @retMsg = '오류가 발생했습니다.'
		END
END
GO
