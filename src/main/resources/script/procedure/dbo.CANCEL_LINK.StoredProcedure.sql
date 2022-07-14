USE [logislink]
GO
/****** Object:  StoredProcedure [dbo].[CANCEL_LINK]    Script Date: 2022-07-14 오후 6:16:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[CANCEL_LINK]
(
    @orderId        NVARCHAR(20)
  , @redId			NVARCHAR(20)
  , @retCode		NVARCHAR(2)		OUTPUT
  , @retMsg			NVARCHAR(200)	OUTPUT
)
AS 
BEGIN
	
	DECLARE @RET_OK NVARCHAR(2) = '00'		-- 성공
	DECLARE @RET_ERR NVARCHAR(2) = '99'		-- Error
	
	UPDATE T_LINK 
	SET LINK_STATUS = '11'
	WHERE ORDER_ID = @orderId
	
	INSERT INTO T_LINK_API (ALLOC_ID, LINK_TYPE, LINK_STATUS, ORDER_ID, COMMAND)
	SELECT ALLOC_ID, LINK_TYPE, '11', ORDER_ID, 'CANCELORDER'
	FROM T_LINK 
	WHERE ORDER_ID = @orderId
	
    set @retCode = @RET_OK
    set @retMsg = '정보망이 취소되었습니다.'
END
GO
