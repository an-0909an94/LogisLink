USE [logislink]
GO
/****** Object:  StoredProcedure [dbo].[DELETE_TRAN_RECEIPT]    Script Date: 2022-07-14 오후 6:16:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[DELETE_TRAN_RECEIPT]
(
	@receiptId		NVARCHAR(20)
  , @delId			NVARCHAR(20)
  , @retCode		NVARCHAR(2)		OUTPUT
  , @retMsg			NVARCHAR(200)	OUTPUT
)
AS
	DECLARE @invId			NVARCHAR(20)
	DECLARE @docAttr		CHAR(1)
	DECLARE @loadstatus		INT
BEGIN
	
	DECLARE @RET_OK NVARCHAR(2) = '00'		-- 성공
	DECLARE @RET_ERR NVARCHAR(2) = '99'		-- Error
	
	BEGIN TRY
		SELECT @invId = INV_ID, @docAttr = DOC_ATTR, @loadstatus = LOADSTATUS
		FROM T_TAX_INVOICE
		WHERE RECEIPT_ID = @receiptId AND USE_YN = 'Y'
		
		IF @loadstatus = 1 and @docAttr != 'D'
		BEGIN 
			THROW 50001, '매출 전자세금계산서가 기발행된 거래명세서를 재발행하는 경우, 해당 매출 전자세금계산서를 취소 후 거래명세서를 재발행하시기 바랍니다.', 1
		END
		ELSE 
		BEGIN 
			UPDATE T_TAX_INVOICE
			SET USE_YN = 'N'
			WHERE INV_ID = @invId AND LOADSTATUS = 0
		END
		
		
		UPDATE 
				T_TRAN_RECEIPT 
		SET 
				USE_YN = 'N'
			  , DELID = @delId
			  , DELDATE = GETDATE()
		WHERE 
				RECEIPT_ID = @receiptId
		
				
		UPDATE 
				T_CALC
		SET
				RECEIPT_YN = 'N'
			  , RECEIPT_DATE = NULL 
		FROM 
				T_CALC A, T_TRAN_RECEIPT_DTL B
		WHERE 
				A.ORDER_ID = B.ORDER_ID AND A.ALLOC_ID = B.ALLOC_ID AND B.RECEIPT_ID = @receiptId
		
		set @retCode = @RET_OK
		set @retMsg = '거래명세서를 삭제했습니다.'		
		
	END TRY 
	BEGIN CATCH 
		IF CAST(ERROR_NUMBER() AS VARCHAR(10)) = '50001' 
		BEGIN 				
		    set @retCode = @RET_ERR
		    set @retMsg = ERROR_MESSAGE()
		END 
		ELSE
		BEGIN
		    set @retCode = @RET_ERR
		    set @retMsg = '오류가 발생했습니다. 관리자에게 문의하세요.'		
		END
	END CATCH 
	
END
GO
