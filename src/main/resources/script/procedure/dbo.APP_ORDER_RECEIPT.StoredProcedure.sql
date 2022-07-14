USE [logislink]
GO
/****** Object:  StoredProcedure [dbo].[APP_ORDER_RECEIPT]    Script Date: 2022-07-14 오후 6:16:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/* 인수증 등록 */
CREATE PROCEDURE [dbo].[APP_ORDER_RECEIPT]
(
	@orderId		NVARCHAR(20)
  , @allocId		NVARCHAR(20)
  , @driverId		NVARCHAR(20)
  , @retCode		NVARCHAR(2)		OUTPUT
  , @retMsg			NVARCHAR(200)	OUTPUT
)
AS 
BEGIN
	
	DECLARE @RET_OK		NVARCHAR(2) = '00'
	DECLARE @RET_ERR	NVARCHAR(2) = '99'
	
	DECLARE @receiptYn	NVARCHAR(1)
	
	SELECT @receiptYn = RECEIPT_YN 
	FROM T_ORDER 
	WHERE ORDER_ID = @orderId
	
	IF ISNULL(@receiptYn, 'N') = 'N'
	BEGIN 
		UPDATE 
				T_ORDER
		SET
				RECEIPT_YN = 'Y'
			  , RECEIPT_DATE = GETDATE()
			  , EDITID = @driverId
			  , EDITDATE = GETDATE()
		WHERE
				ORDER_ID = @orderId
			
		EXEC INSERT_SMS_SEND 'RECEIPTOK', @orderId, @allocId, '', '', '00000000000000';	
			
	END
		
	set @retCode = @RET_OK
	set @retMsg = '인수증이 접수되었습니다.'	
	
END
GO
