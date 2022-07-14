USE [logislink]
GO
/****** Object:  StoredProcedure [dbo].[UPDATE_ALLOC_OUTSIDE]    Script Date: 2022-07-14 오후 6:16:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*
 * 화물맨 -> 로지스링크 배차처리
 */
CREATE PROCEDURE [dbo].[UPDATE_ALLOC_OUTSIDE]
(
  	@allocId		NVARCHAR(20)
  , @allocState		NVARCHAR(20)
  , @carNum			NVARCHAR(10)
  , @carTonCode		NVARCHAR(20)
  , @carTypeCode	NVARCHAR(20)
  , @carBizNum		NVARCHAR(10)
  , @driverName		NVARCHAR(20)
  , @driverTel		NVARCHAR(13)
  , @linkCode		NVARCHAR(2)
  , @regid			NVARCHAR(20)
  , @retCode		NVARCHAR(2)		OUTPUT
  , @retMsg			NVARCHAR(200)	OUTPUT
)
AS
BEGIN
	DECLARE @RET_OK		NVARCHAR(2) = '00'
	DECLARE @RET_ERR	NVARCHAR(2) = '99'
	
	DECLARE @orderId	NVARCHAR(20)
	DECLARE @oldState 	NVARCHAR(20)
	DECLARE @custId 	NVARCHAR(20)
	DECLARE @deptId 	NVARCHAR(20)
	DECLARE @driverId	NVARCHAR(20)
	DECLARE @vehicId 	NVARCHAR(20)
	DECLARE @allocCarNum	NVARCHAR(10) = ''
	
	DECLARE @vCarTonCode NVARCHAR(20)
	DECLARE @vCarTypeCode NVARCHAR(20)
	
	SELECT @orderId = ORDER_ID, @oldState = ALLOC_STATE, @custId = SELL_CUST_ID, @deptId = SELL_DEPT_ID FROM T_ORDER_ALLOC WHERE ALLOC_ID = @allocId
	SELECT @vCarTonCode = CODE FROM T_CODE WHERE GCODE = 'CAR_TON_MAN' AND CNAME = @carTonCode
	SELECT @vCarTypeCode = CODE FROM T_CODE WHERE GCODE = 'CAR_TYPE_MAN' AND CNAME = @carTypeCode
	
	
	IF @allocState = '01' 
	BEGIN 
		IF @oldState NOT IN ('11', '13', '24')
		BEGIN
			SET @retCode = @RET_ERR
			SET @retMsg = '이미 배차된 오더입니다.'
			
			-- 24시콜 : 배차 취소 요청을 하기 위해 API 테이블에 인서트해야한다.
			-- 화물맨 : 오류 리턴해주면 화물맨에서 처리한다.
			IF @linkCode = '03'
			BEGIN 				
				UPDATE T_LINK 
		        SET LINK_STATUS = '11', COMMAND ='CANCELORDER'		-- api 접수 상태로 업데이트 해야 스케줄러에서 재전송함
		        WHERE ALLOC_ID = @allocId AND LINK_TYPE = @linkCode
		        
		        INSERT INTO T_LINK_API (ALLOC_ID, LINK_TYPE, LINK_STATUS, ORDER_ID, COMMAND, ORDNO)
		        SELECT ALLOC_ID, LINK_TYPE, '11', ORDER_ID, 'CANCELORDER', ORDNO 
		        FROM T_LINK 
		        WHERE ALLOC_ID = @allocId AND LINK_TYPE = @linkCode
			END
			
			RETURN;
		END
		
		SET @driverId	= 'DR' + convert(varchar, getDate(), 112) + replace(convert(varchar, getDate(), 108), ':', '') + '001'
		SET @vehicId	= 'V' + convert(varchar, getDate(), 112) + replace(convert(varchar, getDate(), 108), ':', '') + '001'

		SELECT @driverId = DRIVER_ID FROM T_DRIVER WHERE USE_YN = 'Y' AND MOBILE = REPLACE(@driverTel, '-', '') 
		SELECT @vehicId = VEHIC_ID FROM T_VEHIC_MST WHERE USE_YN = 'Y' AND CAR_NUM = @carNum
		-- 기사 정보 업데이트
		MERGE INTO	T_DRIVER AS M 
		USING
			(
				SELECT
						@driverId		DRIVER_ID
					  ,	@driverName		DRIVER_NAME
					  , @driverTel		MOBILE
			) D 
		ON M.DRIVER_ID = D.DRIVER_ID 
		WHEN MATCHED THEN
			UPDATE SET M.DRIVER_NAME = D.DRIVER_NAME
					 , M.EDITDATE = GETDATE()
					 , M.EDITID = @regid
		WHEN NOT MATCHED THEN
			INSERT (DRIVER_ID	, MOBILE	, CID		, DRIVER_NAME	,	REGDATE	,	REGID)
			VALUES (D.DRIVER_iD , D.MOBILE	, D.MOBILE	, D.DRIVER_NAME	,	GETDATE(),	'정보망');
		-- 차량 정보 업데이트
		MERGE INTO T_VEHIC_MST AS M
		USING 
			(
				SELECT 
						@vehicId			VEHIC_ID
					  , @driverId			DRIVER_ID
					  , @carNum				CAR_NUM
					  , @vCarTonCode			CAR_TON_CODE
					  , @vCarTypeCode		CAR_TYPE_CODE
					  , @carBizNum			BIZ_NUM						
			) D
		ON M.VEHIC_ID = D.VEHIC_ID
		WHEN MATCHED THEN
			UPDATE SET M.DRIVER_ID = D.DRIVER_ID 
					 , M.CAR_TON_CODE = D.CAR_TON_CODE
					 , M.CAR_TYPE_CODE = D.CAR_TYPE_CODE
					 , M.BIZ_NUM = D.BIZ_NUM
					 , M.EDITDATE = GETDATE()
					 , M.EDITID = @regid
		WHEN NOT MATCHED THEN
			INSERT (VEHIC_ID, DRIVER_ID, CAR_NUM, CAR_TON_CODE, CAR_TYPE_CODE, BIZ_NUM, REGDATE, REGID)
			VALUES (D.VEHIC_ID, D.DRIVER_ID, D.CAR_NUM, D.CAR_TON_CODE, D.CAR_TYPE_CODE, D.BIZ_NUM, GETDATE(),  @regid);

		MERGE INTO T_CUST_VEHIC AS M
		USING
			(
				SELECT 
						@custId		AS CUST_ID
					  , @deptId		AS DEPT_ID
					  , @vehicId	AS VEHIC_ID
					  , @driverId	AS DRIVER_ID
					  , '11'		AS CAR_SCTN_CODE
			) D
		ON M.CUST_ID = D.CUST_ID AND M.DEPT_ID = D.DEPT_ID AND M.VEHIC_ID = D.VEHIC_ID				
		WHEN NOT MATCHED THEN 
			INSERT (CUST_ID, DEPT_ID, VEHIC_ID, DRIVER_ID, CAR_SCTN_CODE, USE_YN, REGDATE, REGID )
			VALUES (D.CUST_ID, D.DEPT_ID, D.VEHIC_ID, D.DRIVER_ID, D.CAR_SCTN_CODE, 'Y', GETDATE(),  @regid)
		WHEN MATCHED THEN
			UPDATE SET DRIVER_ID = D.DRIVER_ID 
					 , CAR_SCTN_CODE = D.CAR_SCTN_CODE
					 , USE_YN = 'Y'
					 , EDITDATE = GETDATE()
					 , EDITID = @regid ;
		
		UPDATE T_ORDER_ALLOC 
		SET DRIVER_ID = @driverId, VEHIC_ID = @vehicId, LINK_YN = 'Y', LINK_CODE = @linkCode
		  , ALLOC_DATE = GETDATE(), ALLOC_STATE = '01', CAR_NUM = @carNum, CAR_TON_CODE = @vCarTonCode, CAR_TYPE_CODE = @vCarTypeCode
		  , DRIVER_NAME = @driverName, DRIVER_TEL = @driverTel, EDITDATE = GETDATE(), EDITID = @regid
		WHERE ALLOC_ID = @allocId
		
		UPDATE T_ORDER SET ALLOC_DATE = GETDATE(), ORDER_STATE = '01', EDITDATE = GETDATE(), EDITID = @regid
		WHERE ORDER_ID = @orderId
		
		
		UPDATE T_LINK SET ORDSTATUS = '배차', LINK_STATUS = '01'
		WHERE ALLOC_ID = @allocId AND LINK_TYPE = @linkCode
		
		IF @linkCode = '21'
		BEGIN 
			DELETE FROM	T_LINK_MONITOR
			WHERE ORDER_ID = @orderId AND	ALLOC_ID = @allocId AND MONITOR_TYPE = '9' AND LINK_TYPE  = @linkCode
		END
		
		-- 타 정보망에 배차 요청된 오더가 있을 경우, 배차 취소 요청
		UPDATE T_LINK 
        SET LINK_STATUS = '11', COMMAND ='CANCELORDER'		-- api 접수 상태로 업데이트 해야 스케줄러에서 재전송함
        WHERE ALLOC_ID = @allocId AND LINK_TYPE != @linkCode
        
        INSERT INTO T_LINK_API (ALLOC_ID, LINK_TYPE, LINK_STATUS, ORDER_ID, COMMAND, ORDNO)
        SELECT ALLOC_ID, LINK_TYPE, '11', ORDER_ID, 'CANCELORDER', ORDNO 
        FROM T_LINK 
        WHERE ALLOC_ID = @allocId AND LINK_TYPE != @linkCode
			
		
		SET @retCode = @RET_OK
		SET @retMsg = '배차 처리 되었습니다.'
	END
	ELSE IF @allocState = '11'
	BEGIN 
		/*SELECT @allocCarNum = CAR_NUM 
		FROM T_ORDER_ALLOC 
		WHERE ALLOC_ID = @allocId AND LINK_YN = 'Y' AND LINK_CODE = @linkCode
		
		IF (@allocCarNum <> ISNULL(@carNum, 'NOCAR')) OR @allocCarNum = '' 
		BEGIN 
			SET @retCode = @RET_ERR
			SET @retMsg = '잘못된 차량정보입니다.'
		END
		ELSE
		BEGIN*/
			UPDATE T_ORDER_ALLOC 
			SET ALLOC_STATE = @allocState,
				VEHIC_ID = NULL,
			    DRIVER_ID = NULL, 
			    CAR_NUM = NULL, 
			    DRIVER_NAME = NULL, 
			    DRIVER_TEL = NULL,
			    LINK_YN = 'N',
			    LINK_CODE = '99',
			    ALLOC_DATE = NULL,
			    LINK_SETTLE_YN = 'N'
			WHERE ALLOC_ID = @allocId
			  	AND LINK_YN = 'Y' AND LINK_CODE = @linkCode
						  	
			IF @@ROWCOUNT > 0
			BEGIN 
				UPDATE T_ORDER SET ALLOC_DATE = NULL, START_DATE = NULL, FINISH_DATE = NULL, ORDER_STATE = '00', EDITDATE = GETDATE(), EDITID = @regid
				WHERE ORDER_ID = @orderId
			END
			  	
			UPDATE T_LINK SET ORDSTATUS = '화물등록접수', LINK_STATUS = '00'
			WHERE ALLOC_ID = @allocId AND LINK_TYPE = @linkCode
			
			IF @linkCode = '21'
			BEGIN 
				INSERT INTO T_LINK_MONITOR (ORDER_ID, ALLOC_ID, MONITOR_TYPE, LINK_TYPE, LINK_STATUS, STARTPLANDT, REGDATE)
				SELECT ORDER_ID, ALLOC_ID, '9', @linkCode, LINK_STATUS, STARTPLANDT, GETDATE()
				FROM T_LINK
				WHERE ALLOC_ID = @allocId AND LINK_TYPE = @linkCode
			END	
			
			SET @retCode = @RET_OK
			SET @retMsg = '배차 취소 되었습니다.'
		/*END*/
	END
	ELSE IF @allocState = '21'
	BEGIN 
			  -- AND LINK_YN = 'Y' AND LINK_CODE = @linkCode
			  
		UPDATE T_LINK SET ORDSTATUS = '취소', LINK_STATUS = '21'
		WHERE ALLOC_ID = @allocId AND LINK_TYPE = @linkCode
		
		IF @@ROWCOUNT > 0 
		BEGIN 
			UPDATE T_ORDER_ALLOC 
			SET ALLOC_STATE = '00', LINK_YN = 'N', LINK_CODE = '99', LINK_SETTLE_YN = 'N'
			WHERE ALLOC_ID = @allocId				
		END
		
		IF @linkCode = '21'
		BEGIN 
			DELETE FROM	T_LINK_MONITOR
			WHERE ORDER_ID = @orderId AND	ALLOC_ID = @allocId AND MONITOR_TYPE = '9' AND LINK_TYPE  = @linkCode
		END
			
		
		SET @retCode = @RET_OK
		SET @retMsg = '오더 취소 되었습니다.'
	END
	ELSE IF @allocState = '04'		-- 출발
	BEGIN 
		SELECT @allocCarNum = CAR_NUM 
		FROM T_ORDER_ALLOC 
		WHERE ALLOC_ID = @allocId AND LINK_YN = 'Y' AND LINK_CODE = @linkCode
		
		IF @allocCarNum <> ISNULL(@carNum, 'NOCAR')
		BEGIN 
			SET @retCode = @RET_ERR
			SET @retMsg = '잘못된 차량정보입니다.'
			RETURN;
		END
		ELSE
		BEGIN
			UPDATE T_ORDER_ALLOC 
			SET ALLOC_STATE = @allocState
			  , EDITDATE = GETDATE()
			  , EDITID = @regid
			WHERE ALLOC_ID = @allocId
			  	AND LINK_YN = 'Y' AND LINK_CODE = @linkCode
			
			IF @@ROWCOUNT > 0
			BEGIN 
				UPDATE T_ORDER SET ORDER_STATE = @allocState, START_DATE = GETDATE(), EDITDATE = GETDATE(), EDITID = @regid
				WHERE ORDER_ID = @orderId
			END
			
			
			SET @retCode = @RET_OK
			SET @retMsg = '출발 처리 되었습니다.'
		END
	END
	ELSE IF @allocState = '05'		-- 도착
	BEGIN 
		SELECT @allocCarNum = CAR_NUM 
		FROM T_ORDER_ALLOC 
		WHERE ALLOC_ID = @allocId AND LINK_YN = 'Y' AND LINK_CODE = @linkCode
		
		IF @allocCarNum <> ISNULL(@carNum, 'NOCAR')
		BEGIN 
			SET @retCode = @RET_ERR
			SET @retMsg = '잘못된 차량정보입니다.'
			RETURN;
		END
		ELSE
		BEGIN
			UPDATE T_ORDER_ALLOC 
			SET ALLOC_STATE = @allocState
			  , EDITDATE = GETDATE()
			  , EDITID = @regid
			WHERE ALLOC_ID = @allocId
			  	AND LINK_YN = 'Y' AND LINK_CODE = @linkCode
			
			IF @@ROWCOUNT > 0
			BEGIN 
				UPDATE T_ORDER SET ORDER_STATE = @allocState, FINISH_DATE = GETDATE(), EDITDATE = GETDATE(), EDITID = @regid
				WHERE ORDER_ID = @orderId
			END
			
			
			SET @retCode = @RET_OK
			SET @retMsg = '도착 처리 되었습니다.'
		END
	END
	
	
END

GO
