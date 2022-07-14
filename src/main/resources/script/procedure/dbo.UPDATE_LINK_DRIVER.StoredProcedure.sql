USE [logislink]
GO
/****** Object:  StoredProcedure [dbo].[UPDATE_LINK_DRIVER]    Script Date: 2022-07-14 오후 6:16:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UPDATE_LINK_DRIVER]
(
    @allocId		NVARCHAR(20)
  ,	@orderId		NVARCHAR(20)
  , @driverTel		NVARCHAR(13)
  , @driverName		NVARCHAR(20)
  , @carNum			NVARCHAR(10)
  , @regId			NVARCHAR(20)
  ,	@custId			NVARCHAR(20)
  , @deptId			NVARCHAR(20)
  , @retCode		NVARCHAR(2)		OUTPUT
  , @retMsg			NVARCHAR(200)	OUTPUT
)
AS 
BEGIN
	DECLARE @RET_OK 	NVARCHAR(2) = '00'		-- 성공
	DECLARE @RET_ERR 	NVARCHAR(2) = '99'		-- Error
	DECLARE @driverId 	NVARCHAR(20) = ''
	DECLARE @vehicId 	NVARCHAR(20) = ''
	
	DECLARE @spRet		INT
	DECLARE @spMsg		NVARCHAR(200)
	DECLARE @spId1		NVARCHAR(20)
	DECLARE @spId2		NVARCHAR(20)
	
	SELECT @driverId = DRIVER_ID FROM T_DRIVER WHERE MOBILE = @driverTel
	SELECT @vehicId = VEHIC_ID FROM T_VEHIC_MST WHERE CAR_NUM = @carNum
	
	IF ISNULL(@driverId, '') = '' AND ISNULL(@driverTel, '') <> ''
		BEGIN 
			EXEC INSERT_DRIVER @driverId, @driverName, @driverTel, @driverTel, NULL, NULL, NULL, NULL, @regid, @spRet OUTPUT, @spMsg OUTPUT, @spId2 OUTPUT
			
			SET @driverId = @spId2
		END
	
	IF ISNULL(@vehicId, '') = '' AND ISNULL(@carNum, '') <> '' 
		BEGIN 
			EXEC INSERT_VEHIC @vehicId, @driverId, @custId, @deptId, @carNum, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @regid, NULL, @spRet OUTPUT, @spMsg  OUTPUT, @spId1 OUTPUT
			
			SET @vehicId = @spId1
		END
		 
	UPDATE T_ORDER_ALLOC 
	SET DRIVER_ID = @driverId
	  , VEHIC_ID = @vehicId
	  , CAR_NUM = @carNum
	  , DRIVER_NAME = @driverName
	  , DRIVER_TEL = @driverTel
	WHERE ORDER_ID = @orderId
	AND ALLOC_ID = @allocId
	
	UPDATE T_CALC 
	SET DRIVER_ID = @driverId
	  , VEHIC_ID = @vehicId
	WHERE ALLOC_ID = @allocId
	AND ORDER_ID = @orderId
	
	IF (@@ERROR <> 0)
		BEGIN 
			SET @retCode = @RET_ERR
	    	SET @retMsg = '배차에 실패했습니다.'
		END
    ELSE		
    	BEGIN 
	    	SET @retCode = @RET_OK
		    SET @retMsg = '배차가 등록되었습니다.'
    	END
END
GO
