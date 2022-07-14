USE [logislink]
GO
/****** Object:  StoredProcedure [dbo].[INSERT_MENU]    Script Date: 2022-07-14 오후 6:16:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[INSERT_MENU]
(
	@menuSeq INT
  , @parentSeq INT
  , @menuName NVARCHAR(30)
  , @menuCode NVARCHAR(5)
  , @depth INT
  , @authType NVARCHAR(9)
  , @pageUrl NVARCHAR(50)
  , @mode NVARCHAR(1)
  , @retCode INT OUTPUT
  ,	@retMsg NVARCHAR(200) OUTPUT
)
AS
BEGIN
	DECLARE @RET_OK NVARCHAR(2) = '00'		-- 성공
	DECLARE @RET_ERR NVARCHAR(2) = '99'		-- Error
	
	IF @mode = 'N'
		BEGIN
			SELECT * FROM T_MENU WHERE MENU_CODE = @menuCode
			IF @@ROWCOUNT=0
				BEGIN 
					INSERT 
							T_MENU (
									MENU_SEQ    
								  , PARENT_SEQ
								  , MENU_NAME
								  , MENU_CODE   
								  , DEPTH 		    
								  , AUTH_TYPE
								  , ASORT		
								  , PAGE_URL          
								  , REGDATE
								)
						VALUES
								(
									@menuSeq 
								  , ISNULL(convert(varchar(255),@parentSeq), '0')
								  , @menuName
				                  , @menuCode
				                  , @depth         
				                  , @authType
				                  , (SELECT ISNULL(MAX(ASORT), 0) + 1
				                    FROM T_MENU WHERE DEPTH = @depth 
				                  	AND ISNULL(convert(varchar(255),@parentSeq), '0') = 
				                  		ISNULL(convert(varchar(255),@parentSeq), '0'))
				                  , @pageUrl    
				                  , GETDATE()
								)
					set @retCode = @RET_OK
			        set @retMsg = '메뉴를 추가했습니다.'
				END
			ELSE 
				BEGIN 
				    set @retCode = @RET_ERR
				    set @retMsg = '이미 존재하는 메뉴코드입니다.'
				END
		END
	ELSE IF @mode = 'E'
		BEGIN 
			UPDATE 
			        T_MENU
			SET     
			        PARENT_SEQ = ISNULL(convert(varchar(255),@parentSeq), '0')
			      , MENU_NAME = @menuName
			      , AUTH_TYPE = @authType
			      , PAGE_URL = @pageUrl  
			WHERE
			        MENU_SEQ = @menuSeq 
			        
			set @retCode = @RET_OK
	        set @retMsg = '메뉴를 수정했습니다.'
		END
	IF @mode = 'D'	
		BEGIN
			IF ISNULL(@parentSeq, 0) = 0
				BEGIN 
					UPDATE T_MENU
						SET USE_YN = 'N'
					WHERE MENU_SEQ = @menuSeq 
					OR PARENT_SEQ = @menuSeq
					
					set @retCode = @RET_OK
			        set @retMsg = '메뉴를 삭제했습니다.'
				END
			ELSE 
				BEGIN
					UPDATE T_MENU
						SET USE_YN = 'N'
					WHERE MENU_SEQ = @menuSeq 
					
					set @retCode = @RET_OK
			        set @retMsg = '메뉴를 삭제했습니다.'
				END
		END
END 
GO
