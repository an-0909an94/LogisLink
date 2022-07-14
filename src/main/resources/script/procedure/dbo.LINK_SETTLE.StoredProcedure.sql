USE [logislink]
GO
/****** Object:  StoredProcedure [dbo].[LINK_SETTLE]    Script Date: 2022-07-14 오후 6:16:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[LINK_SETTLE]
(
	@orderId		NVARCHAR(20)
  , @allocId 		NVARCHAR(20)
  , @editid			NVARCHAR(20)
  , @retCode 		NVARCHAR(2)		OUTPUT
  , @retMsg 		NVARCHAR(200) 	OUTPUT
)
AS 
BEGIN
	DECLARE @RET_OK NVARCHAR(2) = '00'		-- 성공
	DECLARE @RET_ERR NVARCHAR(2) = '99'		-- Error
	
	IF EXISTS(
			SELECT A.ORDER_ID , B.LINK_SETTLE_YN 
			FROM T_LINK A
			INNER JOIN T_ORDER_ALLOC B ON A.ORDER_ID = B.ORDER_ID 
			WHERE A.ALLOC_ID = B.ALLOC_ID 
			AND A.ORDER_ID = @orderId
			AND B.LINK_YN = 'Y'
			AND B.LINK_CODE != '99'
	   		AND B.ALLOC_STATE = '01'
		)
			BEGIN
				UPDATE T_ORDER_ALLOC SET
				LINK_SETTLE_YN = 'Y',
				EDITDATE = GETDATE(),
				EDITID = @editid
			    WHERE ORDER_ID = @orderId 
			    AND ALLOC_ID = @allocId
			    AND LINK_YN ='Y'
			    
			    set @retCode = @RET_OK
				set @retMsg = '확정처리 되었습니다.'
			END
		ELSE
			BEGIN
			    set @retCode = @RET_OK
				set @retMsg = '확정할 수 없습니다.'
			END
END
GO
