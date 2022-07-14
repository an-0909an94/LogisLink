USE [logislink]
GO
/****** Object:  StoredProcedure [dbo].[INSERT_PUSH_MSG_SEND]    Script Date: 2022-07-14 오후 6:16:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[INSERT_PUSH_MSG_SEND]
(
	@custId 	NVARCHAR(20)
  , @deptId 	NVARCHAR(20)
  , @orderId 	NVARCHAR(20)
  , @allocId	NVARCHAR(20)
  , @title		NVARCHAR(100)
  , @contents	NVARCHAR(300)
  , @userId		NVARCHAR(20)
  , @driverId	NVARCHAR(20)
  , @regid		NVARCHAR(20)
)
AS 
BEGIN
	
	DECLARE @RET_OK NVARCHAR(2) = '00'		-- 성공
	DECLARE @RET_ERR NVARCHAR(2) = '99'		-- Error
	DECLARE @msgSeq BIGINT
	DECLARE @pushId	NVARCHAR(200)
	
	IF ISNULL(@userId, '') != ''
	BEGIN
		SELECT @pushId = B.PUSH_ID 
		FROM T_USER A 
			 INNER JOIN
			 T_USER_APP B ON A.USER_ID = B.USER_ID 
		WHERE A.USER_ID = @userId AND A.USE_YN = 'Y' AND A.CUST_ID = @custId AND A.DEPT_ID = @deptId
			AND B.PUSH_YN = 'Y' AND ISNULL(B.PUSH_ID, '') != ''
	END
	
	-- 기사 푸시 수신 N인 경우, APP 에서 필터
	IF ISNULL(@driverId, '') != ''
	BEGIN 
		SELECT @pushId = PUSH_ID 
		FROM T_DRIVER
		WHERE DRIVER_ID = @driverId AND USE_YN = 'Y' AND ISNULL(PUSH_ID, '') != ''
	END
	
	IF ISNULL(@pushId, '') != ''
	BEGIN 
		INSERT INTO T_PUSH_MSG (CUST_ID, DEPT_ID, ORDER_ID, ALLOC_ID, TITLE, CONTENTS, REGDATE, REGID, IS_DONE)
		VALUES (@custId, @deptId, @orderId, @allocId, @title, @contents, GETDATE(), @regid, 'N')
		
		SELECT @msgSeq = @@IDENTITY
		
		INSERT INTO T_PUSH_SEND (MSG_SEQ, CUST_ID, DEPT_ID, ORDER_ID, ALLOC_ID, USER_ID, DRIVER_ID, PUSH_ID, SEND_DATE, IS_DONE, REGDATE, REGID)
		VALUES (@msgSeq, @custId, @deptId, @orderId, @allocId, @userId, @driverId, @pushId, GETDATE(), 'N', GETDATE(), @regid)
	END
END
GO
