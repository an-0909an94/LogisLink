USE [logislink]
GO
/****** Object:  StoredProcedure [dbo].[INSERT_MANUAL_GROUP]    Script Date: 2022-07-14 오후 6:16:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[INSERT_MANUAL_GROUP]
(
	@appKind 		NVARCHAR(1)
  , @manualName 	NVARCHAR(30)
  , @manualCode  	NVARCHAR(4)
  , @useYn	 		NVARCHAR(1)
  , @regid			NVARCHAR(20)
  , @mode 			NVARCHAR(1)
  , @retCode 		INT OUTPUT
  ,	@retMsg 		NVARCHAR(200) OUTPUT
)
AS
BEGIN
	
	DECLARE @RET_OK NVARCHAR(2) = '00'		-- 성공
	DECLARE @RET_ERR NVARCHAR(2) = '99'		-- Error
	DECLARE @oldAppKind NVARCHAR(1)
	DECLARE @asort INT
	DECLARE @oldAsort INT
	
	SELECT TOP(1) @asort = ASORT + 1
	FROM T_APP_MANUAL_MST
	WHERE APP_KIND = @appKind
	ORDER BY ASORT DESC;

	IF @mode = 'N'
		IF @@ROWCOUNT=0
			BEGIN 
				INSERT INTO T_APP_MANUAL_MST 
					(
						MANUAL_CODE, 		APP_KIND,	 	MANUAL_NAME,
						ASORT,				USE_YN,		 	REGDATE,
						REGID 
					)
	            VALUES
	            	(
	            		@manualCode,	 	@appKind, 		@manualName,
	            		@asort,				@useYn,			GETDATE(),
	            		@regId
	            	)
	                    
	            set @retCode = @RET_OK
	            set @retMsg = '메뉴얼그룹이 추가되었습니다.'
			END
		ELSE 
			BEGIN
			    set @retCode = @RET_ERR
			    set @retMsg = '이미 존재하는 메뉴얼그룹입니다.'
			END
	ELSE 
		BEGIN
			SELECT @oldAppKind = APP_KIND 
			FROM T_APP_MANUAL_MST
			WHERE MANUAL_CODE = @manualCode;
			
			IF @oldAppKind <> @appKind
				BEGIN
					SELECT @oldAsort = ASORT
					FROM T_APP_MANUAL_MST
					WHERE MANUAL_CODE = @manualCode;
				
					UPDATE T_APP_MANUAL_MST
					SET APP_KIND = @appKind
					  , MANUAL_NAME = @manualName
					  , ASORT = @asort
					  , USE_YN = @useYn
					WHERE MANUAL_CODE = @manualCode;
				
					UPDATE T_APP_MANUAL_MST
					SET ASORT = ASORT-1
					WHERE ASORT > @oldAsort
					AND APP_KIND = @oldAppKind;
				END 
			ELSE 
				BEGIN 
					UPDATE T_APP_MANUAL_MST
					SET APP_KIND = @appKind
					  , MANUAL_NAME = @manualName
					  , USE_YN = @useYn
					WHERE MANUAL_CODE = @manualCode
				
				END
			set @retCode = @RET_OK
	        set @retMsg = '메뉴얼그룹이 수정되었습니다'
		END
END
GO
