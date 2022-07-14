USE [logislink]
GO
/****** Object:  StoredProcedure [dbo].[UPDATE_PAPER_TAX]    Script Date: 2022-07-14 오후 6:16:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UPDATE_PAPER_TAX]
(
	@mode			NVARCHAR(1)
  , @calcList		NVARCHAR(2000)
  , @retCode		NVARCHAR(2)		OUTPUT
  , @retMsg			NVARCHAR(200)	OUTPUT
)
AS 
BEGIN
	DECLARE @RET_OK		NVARCHAR(2) = '00'
	DECLARE @RET_ERR	NVARCHAR(2) = '99'
	
	DECLARE @data NVARCHAR(MAX), @delimiter NVARCHAR(5)
	
	DECLARE @calcId NVARCHAR(20)
	DECLARE @orderId NVARCHAR(20)
	DECLARE @allocId NVARCHAR(20)
	DECLARE @taxinvYn NVARCHAR(1)
	SELECT @data = @calcList ,@delimiter = ','
	
	-- 알림톡 추후 예정
	/*DECLARE cur CURSOR FOR
	SELECT ORDER_ID, ALLOC_ID, TAXINV_YN 
	FROM T_CALC
	WHERE CALC_ID IN (SELECT VALUE FROM STRING_SPLIT(@data, ','))
	
	OPEN cur
	
	FETCH NEXT FROM CUR INTO @orderId, @allocId, @taxinvYn
	
	WHILE(@@FETCH_STATUS = 0) 
	
	BEGIN 
		IF @taxinvYn = 'N'
		BEGIN 
			IF @mode = 'Y'
			BEGIN 
				EXEC INSERT_SMS_SEND 'TAXOK', @orderId, @allocId, '', '', '00000000000000';
			END
		END
		FETCH NEXT FROM cur INTO @orderId, @allocId, @taxinvYn
	END 
	CLOSE cur 
	DEALLOCATE cur*/
	
	DECLARE cur CURSOR FOR
	SELECT CALC_ID 
	FROM T_CALC
	WHERE CALC_ID IN (SELECT VALUE FROM STRING_SPLIT(@data, ','))
	OPEN cur
	FETCH NEXT FROM CUR INTO @calcId
	
	WHILE(@@FETCH_STATUS = 0) 
	BEGIN 
		IF @mode = 'N'
			BEGIN
				UPDATE 
					T_CALC 
				SET
					TAXINV_YN = 'N',
					TAXINV_DATE = NULL
				WHERE CALC_ID = @calcId
				
				set @retCode = @RET_OK
				set @retMsg = '세금계산서가 취소되었습니다.'
			END
		ELSE IF @mode = 'Y'
			BEGIN
				UPDATE 
					T_CALC 
				SET
					TAXINV_YN = 'P',
					TAXINV_DATE = GETDATE()
				WHERE CALC_ID = @calcId
								
				set @retCode = @RET_OK
				set @retMsg = '세금계산서가 등록되었습니다.'
			END
		FETCH NEXT FROM cur INTO @calcId
	END 
	CLOSE cur 
	DEALLOCATE cur
END
GO
