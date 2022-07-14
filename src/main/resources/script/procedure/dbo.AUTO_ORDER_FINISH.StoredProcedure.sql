USE [logislink]
GO
/****** Object:  StoredProcedure [dbo].[AUTO_ORDER_FINISH]    Script Date: 2022-07-14 오후 6:16:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	하차일 지난 오더 일괄 도착 처리
-- =============================================
CREATE PROCEDURE [dbo].[AUTO_ORDER_FINISH]
AS

BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	UPDATE T_ORDER_ALLOC 
	SET ALLOC_STATE = '05', EDITDATE = GETDATE(), EDITID = 'SYSTEM'
	WHERE  ALLOC_STATE IN ('01', '04', '12')
		AND ORDER_ID IN 
				(SELECT ORDER_ID 
				 FROM T_ORDER 
				 WHERE ORDER_STATE IN ('01', '04', '12') AND  E_DATE < CONVERT(VARCHAR(10), GETDATE(), 112));

				
	IF @@ROWCOUNT > 0
	BEGIN
		
		UPDATE T_ORDER SET ORDER_STATE = '05',
						START_DATE = CASE WHEN START_DATE IS NULL THEN S_DATE ELSE START_DATE END,
						FINISH_DATE = E_DATE,
						EDITDATE = GETDATE(),
						EDITID = 'SYSTEM'
		WHERE ORDER_STATE IN ('01', '04', '12') AND  E_DATE < CONVERT(VARCHAR(10), GETDATE(), 112);
		
		UPDATE T_ORDER_STOP SET FINISH_YN = 'Y', FINISH_DATE = B.E_DATE
		FROM T_ORDER_STOP A 
			 INNER JOIN
			 T_ORDER B ON A.ORDER_ID = B.ORDER_ID AND A.FINISH_YN = 'N'  AND B.ORDER_STATE = '05'
		WHERE 
			 B.E_DATE < CONVERT(VARCHAR(10), GETDATE(), 112);
	END
					 
END
GO
