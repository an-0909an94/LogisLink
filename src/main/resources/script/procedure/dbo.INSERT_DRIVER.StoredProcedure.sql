USE [logislink]
GO
/****** Object:  StoredProcedure [dbo].[INSERT_DRIVER]    Script Date: 2022-07-14 오후 6:16:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- 배차 단계에서 신규 기사인 경우 호출 프로시저
CREATE PROCEDURE [dbo].[INSERT_DRIVER]
(
	@driverId		NVARCHAR(20)
  , @driverName 	NVARCHAR(20)
  , @mobile 		NVARCHAR(13)
  , @cid 			NVARCHAR(13)
  , @telnum 		NVARCHAR(13)
  , @bankCode 		NVARCHAR(5)
  , @bankCnnm		NVARCHAR(20)
  , @bankAccount	NVARCHAR(20)
  , @regId 			NVARCHAR(20)
  , @retCode 		NVARCHAR(2)		OUTPUT
  , @retMsg 		NVARCHAR(200) 	OUTPUT
  , @retId			NVARCHAR(20)	OUTPUT
)
AS
BEGIN
	
	
	DECLARE @RET_OK NVARCHAR(2) = '00'		-- 성공
	DECLARE @RET_ERR NVARCHAR(2) = '99'		-- Error
	DECLARE @preVehicId NVARCHAR(20)
	
	-- 기사 연락처가 중복된 경우 driverId 할당
	SELECT @driverId = DRIVER_ID, @preVehicId = VEHIC_ID
	FROM T_DRIVER
	WHERE MOBILE = REPLACE(@mobile,'-','') AND USE_YN = 'Y'
	
	IF isNull(@driverId, '') = ''
		BEGIN
			SET @driverId = 'DR' + convert(varchar, getDate(), 112) + replace(convert(varchar, getDate(), 108), ':', '') + '001'
	
			INSERT INTO dbo.T_DRIVER(
        		DRIVER_ID,
        		MOBILE,    		
        		CID,	   		TELNUM,		
        		BANK_CODE,	
        		BANK_CNNM,		BANK_ACCOUNT,	REGDATE, REGID,
        		DRIVER_NAME)
			VALUES(
				@driverId,
				REPLACE(@mobile,'-',''),
				REPLACE(@mobile,'-',''),			REPLACE(@telnum,'-',''),
				@bankCode,
				@bankCnnm,		@bankAccount,	GETDATE(), @regid,
				@driverName)
		END
	

	set @retCode = @RET_OK
	set @retMsg = '기사 정보가 추가되었습니다.'
	set @retId = @driverId
	
END
GO
