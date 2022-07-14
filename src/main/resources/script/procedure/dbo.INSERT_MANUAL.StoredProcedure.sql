USE [logislink]
GO
/****** Object:  StoredProcedure [dbo].[INSERT_MANUAL]    Script Date: 2022-07-14 오후 6:16:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[INSERT_MANUAL]
(
	@manualSeq 		INT
  , @manualCode 	NVARCHAR(4)
  , @manualTitle 	NVARCHAR(50)
  , @manualVersion  NVARCHAR(5)
  , @manualType 	NVARCHAR(1)
  , @manualUrl 		NVARCHAR(100)
  , @manualUseYn 	NVARCHAR(1)
  , @regid 			NVARCHAR(100)
  , @mode 			NVARCHAR(1)
  ,	@outManualSeq 	INT OUTPUT
  , @retCode		NVARCHAR(2)		OUTPUT
  , @retMsg			NVARCHAR(200)	OUTPUT
)
AS
BEGIN
	
	DECLARE @RET_OK NVARCHAR(2) = '00'		-- 성공
	DECLARE @RET_ERR NVARCHAR(2) = '99'		-- Error
	DECLARE @oldManualCode NVARCHAR(4)
	DECLARE @asort INT
	DECLARE @oldAsort INT
	
	
	
	SELECT TOP(1) @asort = MANUAL_ASORT + 1
	FROM T_APP_MANUAL_DTL
	WHERE MANUAL_CODE = @manualCode
	ORDER BY MANUAL_ASORT DESC;

	IF @mode = 'N'
		BEGIN
			INSERT INTO T_APP_MANUAL_DTL 
				(
					MANUAL_CODE,		MANUAL_TITLE,		MANUAL_VERSION,
					MANUAL_TYPE,		MANUAL_URL,			MANUAL_ASORT,
					USE_YN,				REGDATE,			REGID 
				)
			VALUES
				(
					@manualCode,		@manualTitle,		@manualVersion,
					@manualType,		@manualUrl,			ISNULL(@asort,1),
					@manualUseYn,		GETDATE(),			@regId
				)
				
			SELECT @outManualSeq = MANUAL_SEQ FROM T_APP_MANUAL_DTL 
			WHERE MANUAL_CODE = @manualCode AND MANUAL_TITLE = @manualTitle;
	                    
            set @retCode = @RET_OK
            set @retMsg = '메뉴얼이 추가되었습니다.'
		END
	ELSE
		BEGIN
			SELECT @oldManualCode = MANUAL_CODE 
			FROM T_APP_MANUAL_DTL
			WHERE MANUAL_SEQ = @manualSeq;
			
			IF @oldManualCode <> @manualCode
				BEGIN
					SELECT @oldAsort = MANUAL_ASORT
					FROM T_APP_MANUAL_DTL
					WHERE MANUAL_SEQ = @manualSeq;
				
					UPDATE T_APP_MANUAL_DTL
					SET MANUAL_CODE = @manualCode
					  , MANUAL_TITLE = @manualTitle
					  , MANUAL_VERSION = @manualVersion
					  , MANUAL_TYPE = @manualType
					  , MANUAL_URL = CASE @manualUrl WHEN NULL THEN MANUAL_URL WHEN '' THEN MANUAL_URL ELSE @manualUrl END
					  , MANUAL_ASORT = ISNULL(@asort,1)
					  , USE_YN = @manualUseYn
					  , EDITDATE = GETDATE()
					  , EDITID = @regId
					WHERE MANUAL_SEQ = @manualSeq;
				
					UPDATE T_APP_MANUAL_DTL 
					SET MANUAL_ASORT = MANUAL_ASORT-1
					WHERE MANUAL_ASORT > @oldAsort
					AND MANUAL_CODE = @manualCode;
				END
			ELSE
				BEGIN
					UPDATE T_APP_MANUAL_DTL
					SET MANUAL_TITLE = @manualTitle
					  , MANUAL_VERSION = @manualVersion
					  , MANUAL_TYPE = @manualType
					  , MANUAL_URL = CASE @manualUrl WHEN NULL THEN MANUAL_URL WHEN '' THEN MANUAL_URL ELSE @manualUrl END  
					  , USE_YN = @manualUseYn
					  , EDITDATE = GETDATE()
					  , EDITID = @regId
					WHERE MANUAL_SEQ = @manualSeq; 
				END
				
	                    
            set @retCode = @RET_OK
            set @retMsg = '메뉴얼이 수정되었습니다.'
		END
END
GO
