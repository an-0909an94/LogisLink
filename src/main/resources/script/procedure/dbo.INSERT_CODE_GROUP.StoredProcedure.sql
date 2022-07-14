USE [logislink]
GO
/****** Object:  StoredProcedure [dbo].[INSERT_CODE_GROUP]    Script Date: 2022-07-14 오후 6:16:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[INSERT_CODE_GROUP]
(
	@codeSeq INT
  , @gCode NVARCHAR(30)
  , @gName NVARCHAR(100)
  , @memo NVARCHAR(300)
  , @mode NVARCHAR(1)
  , @retCode INT OUTPUT
  ,	@retMsg NVARCHAR(200) OUTPUT
)
AS
BEGIN
	
	DECLARE @RET_OK NVARCHAR(2) = '00'		-- 성공
	DECLARE @RET_ERR NVARCHAR(2) = '99'		-- Error
	IF @gCode = ''
		BEGIN
			set @retCode = @RET_ERR
	        set @retMsg = '그룹코드를 입력해주세요.'
		END
	ELSE
		BEGIN 
			SELECT GCODE FROM dbo.T_CODE_GROUP WHERE GCODE = @gCode
			IF @mode = 'N'
				IF @@ROWCOUNT=0
					BEGIN 
						INSERT INTO dbo.T_CODE_GROUP 
							(
								GCODE, GNAME, MEMO, USE_YN
							)
			            VALUES
			            	(
			            		@gCode, @gName, @memo, 'Y'
			            	)
			                    
			            set @retCode = @RET_OK
			            set @retMsg = '코드그룹이 추가되었습니다.'
					END
				ELSE 
					BEGIN
					    set @retCode = @RET_ERR
					    set @retMsg = '이미 존재하는 코드그룹입니다.'
					END
			ELSE 
				BEGIN
					UPDATE T_CODE_GROUP
					SET GCODE = @gCode
					  , GNAME = @gName
					  , MEMO = @memo
					WHERE CODE_SEQ = @codeSeq
					
					set @retCode = @RET_OK
			        set @retMsg = '코드그룹이 수정되었습니다.'
				END
		END
END
GO
