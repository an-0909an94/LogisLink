USE [logislink]
GO
/****** Object:  StoredProcedure [dbo].[APP_ORDER_FILE_DELETE]    Script Date: 2022-07-14 오후 6:16:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[APP_ORDER_FILE_DELETE]
(
	@orderId		NVARCHAR(20)
  , @allocId		NVARCHAR(20)	
  , @fileSeq		bigint
  , @driverId		NVARCHAR(20)
  , @retCode		NVARCHAR(2)		OUTPUT
  , @retFilePath	NVARCHAR(100)	OUTPUT
  , @retMsg			NVARCHAR(200)	OUTPUT
)
AS 
BEGIN
	
	DECLARE @RET_OK		NVARCHAR(2) = '00'
	DECLARE @RET_ERR	NVARCHAR(2) = '99'
	
	DECLARE @finishYn 	NVARCHAR(1)
	DECLARE @receiptCnt	INT
		
	SELECT @finishYn = FINISH_YN 
	FROM T_CALC 
	WHERE ORDER_ID = @orderId AND ALLOC_ID = @allocId AND DRIVER_ID = @driverId
		AND CALC_TYPE_CODE = '0002' AND USE_YN = 'Y'
	
	IF ISNULL(@finishYn, 'Y') ='Y'	
	BEGIN
		SET @retCode = @RET_ERR
    	SET @retMsg = '정산이 마감되어 인수증을 삭제할 수 없습니다.'
	END
	ELSE 
	BEGIN 
		SELECT
				@retFilePath = FILE_PATH + FILE_NAME 
		FROM 
				T_ORDER_FILE 
		WHERE 
				ORDER_ID = @orderId AND FILE_SEQ = @fileSeq
		
		IF ISNULL(@retFilePath, '') != '' 
		BEGIN 
			DELETE FROM T_ORDER_FILE 
			WHERE ORDER_ID = @orderId AND FILE_SEQ = @fileSeq
			
			SELECT @receiptCnt = COUNT(1)
			FROM T_ORDER_FILE 
			WHERE ORDER_ID = @orderId 
			
			-- 인수증 접수 여부를 업데이트한다.
			IF @receiptCnt = 0 
			BEGIN 
				UPDATE T_ORDER SET RECEIPT_YN = CASE WHEN RECEIPT_YN = 'P' THEN 'P' ELSE 'N' END,
									RECEIPT_DATE = NULL 
				WHERE 
						ORDER_ID = @orderId
			END
			
			SET @retCode = @RET_OK
	    	SET @retMsg = '인수증을 삭제했습니다.'
		END
		ELSE 
		BEGIN 
			SET @retCode = @RET_ERR
	    	SET @retMsg = '인수증이 존재하지 않습니다.'
		END
				
	END
	
	
	
END
GO
