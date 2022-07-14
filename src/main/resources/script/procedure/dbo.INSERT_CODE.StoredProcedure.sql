USE [logislink]
GO
/****** Object:  StoredProcedure [dbo].[INSERT_CODE]    Script Date: 2022-07-14 오후 6:16:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[INSERT_CODE]
(
	@codeSeq INT
  , @gCode NVARCHAR(30)
  , @code NVARCHAR(20)
  , @cname NVARCHAR(100)
  , @pcCode NVARCHAR(20)
  , @psCode NVARCHAR(20)
  , @memo NVARCHAR(300)
  , @filter1 NVARCHAR(100)
  , @filter2 NVARCHAR(100)
  , @filter3 NVARCHAR(100)
  , @mode NVARCHAR(1)
  , @retCode INT OUTPUT
  ,	@retMsg NVARCHAR(200) OUTPUT
)
AS
BEGIN
	
	DECLARE @RET_OK NVARCHAR(2) = '00'		-- 성공
	DECLARE @RET_ERR NVARCHAR(2) = '99'		-- Error
	DECLARE @CODE_CNT INT = 0
	
	IF @gCode = ''
		BEGIN
			set @retCode = @RET_ERR
	        set @retMsg = '그룹코드를 선택해주세요.'
		END
	ELSE
		BEGIN 
			SELECT GCODE, CODE FROM dbo.T_CODE WHERE GCODE = @gCode AND CODE = @code
			IF @mode = 'N'
				IF @@ROWCOUNT=0
					BEGIN 
						SELECT @CODE_CNT = COUNT(*) FROM dbo.T_CODE WHERE GCODE = @gCode
						
						INSERT INTO dbo.T_CODE 
							(
								GCODE, CODE, CNAME, PC_CODE, PS_CODE, USE_YN,
								MEMO, FILTER1, FILTER2, FILTER3, ASORT
							)
			            VALUES
			            	(
			            		@gCode, @code, @cname, @pcCode, @psCode, 'Y',
			            		@memo, @filter1, @filter2, @filter3, (@CODE_CNT+1)
			            	)
			                    
			            set @retCode = @RET_OK
			            set @retMsg = '코드가 추가되었습니다.'
					END
				ELSE 
					BEGIN
					    set @retCode = @RET_ERR
					    set @retMsg = '이미 존재하는 코드입니다.'
					END
			ELSE 
				BEGIN 
					UPDATE T_CODE 
					SET GCODE = @gCode
					  , CODE = @code
					  , CNAME = @cname
					  , PC_CODE = @pcCode
					  , PS_CODE = @psCode
					  , MEMO = @memo
					  , FILTER1 = @filter1
					  , FILTER2 = @filter2
					  , FILTER3 = @filter3
					WHERE CODE_SEQ = @codeSeq 
					  
					set @retCode = @RET_OK
			        set @retMsg = '코드가 수정되었습니다.'
				END
		END
END
GO
