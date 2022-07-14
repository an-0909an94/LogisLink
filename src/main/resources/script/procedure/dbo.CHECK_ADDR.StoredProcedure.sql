USE [logislink]
GO
/****** Object:  StoredProcedure [dbo].[CHECK_ADDR]    Script Date: 2022-07-14 오후 6:16:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CHECK_ADDR]
(
	@custId NVARCHAR(20)
  ,	@deptId NVARCHAR(20)
  , @addrName NVARCHAR(50)
  , @addr NVARCHAR(50)
  , @addrDetail NVARCHAR(50)
  --, @lat NVARCHAR(16)
  --, @lon NVARCHAR(16)
  , @sido NVARCHAR(10)
  , @gungu NVARCHAR(20)
  , @dong NVARCHAR(20)
  , @staffName NVARCHAR(30)
  , @staffTel NVARCHAR(13)
  , @retCode NVARCHAR(2) OUTPUT
)
AS
BEGIN
	
	DECLARE @RET_OK NVARCHAR(2) = '00'		-- 성공
	DECLARE @RET_ERR NVARCHAR(2) = '99'		-- Error
	

	SELECT 
	ADDR_SEQ AS addrSeq, 
	CUST_ID AS custId,
	DEPT_ID AS deptId, 
	ADDR_NAME AS addrName, 
	ADDR AS addr, 
	ADDR_DETAIL AS addrDetail, 
	--LAT AS lat, 
	--LON AS lon, 
	STAFF_NAME AS staffName, 
	STAFF_TEL AS staffTel, 
	ORDER_MEMO AS orderMemo, 
	REGDATE AS regDate, 
	USE_YN AS useYn, 
	SIDO AS sido, 
	GUNGU AS gungu,
	DONG AS dong 
FROM T_CUST_ADDR 
WHERE 
	CUST_ID = @custId
	AND DEPT_ID = @deptId
	AND ADDR_NAME = @addrName
	AND ADDR = @addr
	AND ADDR_DETAIL = @addrDetail
	--AND LAT = @lat
	--AND LON = @lon
	AND SIDO = @sido
	AND GUNGU = @gungu
	AND DONG = @dong
	AND STAFF_NAME = @staffName
	AND STAFF_TEL = @staffTel
	AND USE_YN = 'Y'

    IF @@ROWCOUNT=0
    	BEGIN 
	    	set @retCode = @RET_OK
		    SELECT @retCode retCode
    	END
    ELSE
    	BEGIN
	    	--SELECT @retCode = 0, @retMsg = ''
	    	set @retCode = @RET_ERR
		    SELECT @retCode retCode
    	END
END
GO
