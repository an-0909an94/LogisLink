USE [logislink]
GO
/****** Object:  StoredProcedure [dbo].[UPDATE_PAPER_RECEIPT]    Script Date: 2022-07-14 오후 6:16:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UPDATE_PAPER_RECEIPT]
(
	@mode			NVARCHAR(1)
  , @orderList		NVARCHAR(2000)
  , @retCode		NVARCHAR(2)		OUTPUT
  , @retMsg			NVARCHAR(200)	OUTPUT
)
AS 
BEGIN
	DECLARE @RET_OK		NVARCHAR(2) = '00'
	DECLARE @RET_ERR	NVARCHAR(2) = '99'
	
	DECLARE @data NVARCHAR(MAX), @delimiter NVARCHAR(5)
	
	DECLARE @orderId NVARCHAR(20)
	DECLARE @allocId NVARCHAR(20)
	DECLARE @receiptYn NVARCHAR(1)
	SELECT @data = @orderList,@delimiter = ','
	
	--알림톡 추후 반영 예정
	/*DECLARE cur CURSOR FOR
	SELECT A.ORDER_ID, B.ALLOC_ID, A.RECEIPT_YN 
	FROM T_ORDER A
	INNER JOIN 
	T_ORDER_ALLOC B ON A.ORDER_ID = B.ORDER_ID 
	WHERE A.ORDER_ID IN (SELECT VALUE FROM STRING_SPLIT(@data, ','))
	
	OPEN cur
	
	FETCH NEXT FROM CUR INTO @orderId, @allocId, @receiptYn
	
	WHILE(@@FETCH_STATUS = 0) 
	BEGIN 
		IF @receiptYn = 'N'
		BEGIN 
			IF @mode = 'Y'
			BEGIN 
				EXEC INSERT_SMS_SEND 'RECEIPTOK', @orderId, @allocId, '', '', '00000000000000';
			END
		END
		FETCH NEXT FROM cur INTO @orderId, @allocId, @receiptYn
	END 
	CLOSE cur 
	DEALLOCATE cur*/
	
	DECLARE cur CURSOR FOR
	SELECT ORDER_ID
	FROM T_ORDER 
	WHERE ORDER_ID IN (SELECT VALUE FROM STRING_SPLIT(@data, ','))
	OPEN cur
	FETCH NEXT FROM CUR INTO @orderId
	
	WHILE(@@FETCH_STATUS = 0) 
	BEGIN 
		IF @mode = 'N'
			BEGIN
				UPDATE 
					T_ORDER 
				SET 
					RECEIPT_YN = 'N',
					PAPER_RECEIPT_DATE = NULL
				WHERE ORDER_ID = @orderId
				
				set @retCode = @RET_OK
				set @retMsg = '인수증이 취소되었습니다.'
			END
		ELSE IF @mode = 'Y'
			BEGIN
				UPDATE 
					T_ORDER 
				SET 
					RECEIPT_YN = 'P',
					PAPER_RECEIPT_DATE = GETDATE()
				WHERE ORDER_ID = @orderId			
				
				set @retCode = @RET_OK
				set @retMsg = '인수증이 등록되었습니다.'
			END
		FETCH NEXT FROM cur INTO @orderId
	END 
	CLOSE cur 
	DEALLOCATE cur
END
GO
