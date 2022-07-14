USE [logislink]
GO
/****** Object:  StoredProcedure [dbo].[APP_CUST_ADDR_UPDATE]    Script Date: 2022-07-14 오후 6:16:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[APP_CUST_ADDR_UPDATE]
(
	@addrSeq BIGINT
  , @custId NVARCHAR(20)
  , @deptId NVARCHAR(20)
  , @addrName NVARCHAR(50)
  , @addr NVARCHAR(50)
  , @addrDetail NVARCHAR(50)
  , @lat NVARCHAR(16)
  , @lon NVARCHAR(16)
  , @staffName NVARCHAR(30)
  , @staffTel NVARCHAR(13)
  , @orderMemo NVARCHAR(1000)
  , @regId NVARCHAR(20)
  , @sido NVARCHAR(10)
  , @gungu NVARCHAR(20)
  , @dong NVARCHAR(20)
  , @retCode NVARCHAR(2) OUTPUT
  ,	@retMsg NVARCHAR(200) OUTPUT
)
AS
BEGIN
	
	DECLARE @RET_OK NVARCHAR(2) = '00'		-- 성공
	DECLARE @RET_ERR NVARCHAR(2) = '99'		-- Error
	DECLARE @conLat decimal(16,13) = CONVERT(decimal(16,13), @lat) --위도
	DECLARE @conLon decimal(16,12) = CONVERT(decimal(16,12), @lon) --경도
	
	If IsNull(@addrSeq, 0) = 0 
		BEGIN
			INSERT INTO dbo.T_CUST_ADDR 
				(
					CUST_ID, DEPT_ID, ADDR_NAME, ADDR, 
					ADDR_DETAIL, LAT, LON, STAFF_NAME, STAFF_TEL, 
					ORDER_MEMO, REGDATE, REGID, USE_YN, SIDO, GUNGU, DONG
				)
            VALUES
            	(
            		@custId, @deptId, @addrName, @addr, 
            		@addrDetail, @conLat, @conLon, @staffName, @staffTel, 
            		@orderMemo, GETDATE(), @regId, 'Y', @sido, @gungu, @dong
            	)
                    
            set @retCode = @RET_OK
            set @retMsg = '주소지 정보가 추가되었습니다.'
		END
	ELSE
		BEGIN 
			
			UPDATE dbo.T_CUST_ADDR
		    SET 
				ADDR_NAME = @addrName
			  , ADDR = @addr
			  , ADDR_DETAIL = @addrDetail
			  , LAT = @conLat
			  , LON = @conLon
			  , STAFF_NAME = @staffName
			  , STAFF_TEL = @staffTel
			  , ORDER_MEMO = @orderMemo
			  , SIDO = @sido
			  , GUNGU = @gungu
			  , DONG = @dong
		    WHERE ADDR_SEQ = @addrSeq
		    
		    set @retCode = @RET_OK
		    set @retMsg = '주소지 정보가 수정되었습니다.'
		END
END
GO
