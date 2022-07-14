USE [logislink]
GO
/****** Object:  StoredProcedure [dbo].[INSERT_BOARD_20220321]    Script Date: 2022-07-14 오후 6:16:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[INSERT_BOARD_20220321]
(
	@boardSeq INT
  , @custId NVARCHAR(20)
  , @userName NVARCHAR(20)
  , @title NVARCHAR(100)
  , @content NVARCHAR(4000)
  , @mode NVARCHAR(1)
  , @regId NVARCHAR(20) 
  , @editId NVARCHAR(20)
  , @retCode INT OUTPUT
  , @retMsg NVARCHAR(200) OUTPUT
)
AS 
BEGIN
	DECLARE @RET_OK NVARCHAR(2) = '00'		-- 성공
	DECLARE @RET_ERR NVARCHAR(2) = '99'		-- Error
	
	IF @mode = 'N'
	BEGIN
		INSERT INTO dbo.T_BOARD(
			CUST_ID 	, USER_NAME		, TITLE  	, CONTENT 	
		  , REGDATE 	, REGID 		, USE_YN	, READ_CNT)
		VALUES(
			@custId		, @userName		, @title	, @content	
		  , getDate()	, @regId		,'Y'		, 0);
					  
		set @retCode = @RET_OK
        set @retMsg = '공지사항이 등록되었습니다.'
	END
ELSE IF @mode = 'E'
	BEGIN 
		UPDATE T_BOARD SET
			TITLE = @title
		  , CONTENT	= @content
		  , EDITDATE = getDate()
		  , EDITID = @regId
		WHERE BOARD_SEQ = @boardSeq
		
		set @retCode = @RET_OK
        set @retMsg = '공지사항이 수정되었습니다.'
	END
END
GO
