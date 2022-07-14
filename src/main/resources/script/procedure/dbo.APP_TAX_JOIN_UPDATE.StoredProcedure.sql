USE [logislink]
GO
/****** Object:  StoredProcedure [dbo].[APP_TAX_JOIN_UPDATE]    Script Date: 2022-07-14 오후 6:16:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/**
 * 스마트빌 가입요청 알림톡
 */
CREATE PROCEDURE [dbo].[APP_TAX_JOIN_UPDATE] (	
	@orderId		NVARCHAR(20)
  , @allocId		NVARCHAR(20)
  , @driverId		NVARCHAR(20)
  , @vehicId		NVARCHAR(20)
  , @retCode		NVARCHAR(2)		OUTPUT
  , @retMsg			NVARCHAR(200)	OUTPUT
)
AS
	DECLARE @taxreqDate		VARCHAR(8)
	DECLARE @RET_OK		NVARCHAR(2) = '00'
	DECLARE @RET_ERR	NVARCHAR(2) = '99'
BEGIN

	SELECT @taxreqDate = CONVERT(VARCHAR(8), TAXREQ_DATE, 112)  
	FROM T_DRIVER	
	WHERE DRIVER_ID = @driverId 
	
	IF ISNULL(@taxreqDate, '') = '' 
	BEGIN 
		EXEC INSERT_SMS_SEND 'SMARTBILLJOIN', @orderId, @allocId, @driverId, @vehicId, '00000000000000';
		
		UPDATE T_DRIVER SET TAXREQ_DATE = GETDATE()
		WHERE DRIVER_ID = @driverId
	
		set @retCode = @RET_OK
		set @retMsg = '가입신청이 접수되었습니다. 가입절차를 도와드릴 수 있도록 곧 연락드리겠습니다. (유선 또는 톡)'
	END
	ELSE 
	BEGIN 
		set @retCode = @RET_OK
		set @retMsg = '이미 가입신청 되었습니다.'
	END
	
END
GO
