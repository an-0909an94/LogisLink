USE [logislink]
GO
/****** Object:  StoredProcedure [dbo].[UPDATE_MENU_SORT]    Script Date: 2022-07-14 오후 6:16:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
	CREATE PROCEDURE [dbo].[UPDATE_MENU_SORT]
(
	@menuSeq		INT
  ,	@parentSeq		INT
  ,	@gbn			NVARCHAR(10)
  , @retCode		NVARCHAR(2)		OUTPUT
  , @retMsg			NVARCHAR(200)	OUTPUT
	
)
AS 
BEGIN
	 DECLARE @RET_OK NVARCHAR(2) = '00'		-- 성공
	 DECLARE @RET_ERR NVARCHAR(2) = '99'		-- 실패
	 DECLARE @RET_NO_CHANGE NVARCHAR(2) = '10'-- 변경불가
	 
     BEGIN
	 	 IF OBJECT_ID('tempdb..#MENU_SORT') IS NOT NULL DROP TABLE #MENU_SORT
	 	
         SELECT A.ASORT, A.PREV_SEQ, A.PREV_SORT, A.NEXT_SEQ, A.NEXT_SORT
         INTO #MENU_SORT 
         FROM (
             SELECT MENU_SEQ
                   , ASORT
                   , LAG(MENU_SEQ, 1) OVER(ORDER BY ASORT) PREV_SEQ
                   , LAG(ASORT, 1) OVER(ORDER BY ASORT) PREV_SORT
                   , LEAD(MENU_SEQ, 1) OVER(ORDER BY ASORT) NEXT_SEQ
                   , LEAD(ASORT, 1) OVER(ORDER BY ASORT) NEXT_SORT
             FROM T_MENU
             WHERE ISNULL(PARENT_SEQ, '0') = ISNULL(@parentSeq, '0')  ) A
         WHERE A.MENU_SEQ = @menuSeq
     END
     IF @gbn = 'up'
     	BEGIN 
	    	SELECT PREV_SEQ FROM #MENU_SORT WHERE PREV_SEQ IS NOT NULL
	    IF @@ROWCOUNT = 0
		    BEGIN
		 	    set @retCode = @RET_NO_CHANGE 
		     	set @retMsg = '더이상 변경할 수 없습니다.';
		    END
		ELSE
			BEGIN
				UPDATE T_MENU SET ASORT = (SELECT ASORT FROM #MENU_SORT)
				WHERE MENU_SEQ = (SELECT PREV_SEQ FROM #MENU_SORT)
				
				UPDATE T_MENU SET ASORT = (SELECT PREV_SORT FROM #MENU_SORT)
				WHERE MENU_SEQ = @menuSeq
				set @retCode = @RET_OK 
			END
		END
    IF @gbn = 'down'
		BEGIN
		SELECT NEXT_SEQ FROM #MENU_SORT WHERE NEXT_SEQ IS NOT NULL
	    IF @@ROWCOUNT = 0
			BEGIN
			  	set @retCode = @RET_NO_CHANGE 
	        	set @retMsg = '더이상 변경할 수 없습니다.';
			END
		ELSE
			BEGIN
		       UPDATE T_MENU SET ASORT = (SELECT ASORT FROM #MENU_SORT) 
		       WHERE MENU_SEQ = (SELECT NEXT_SEQ FROM #MENU_SORT)
		        
		       UPDATE T_MENU SET ASORT = (SELECT NEXT_SORT FROM #MENU_SORT)
		       WHERE MENU_SEQ = @menuSeq
			   set @retCode = @RET_OK 
			END
		END
	IF OBJECT_ID('tempdb..#MENU_SORT') IS NOT NULL DROP TABLE #MENU_SORT
END
	
GO
