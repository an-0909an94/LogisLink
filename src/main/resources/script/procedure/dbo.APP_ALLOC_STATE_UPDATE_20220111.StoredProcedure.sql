USE [logislink]
GO
/****** Object:  StoredProcedure [dbo].[APP_ALLOC_STATE_UPDATE_20220111]    Script Date: 2022-07-14 오후 6:16:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- 배차상태 변경
CREATE PROCEDURE [dbo].[APP_ALLOC_STATE_UPDATE_20220111]
(
	@orderId		NVARCHAR(20)
  , @allocId		NVARCHAR(20)
  , @allocState		NVARCHAR(20)
  , @regid			NVARCHAR(20)
  , @retCode		NVARCHAR(2)		OUTPUT
  , @retMsg			NVARCHAR(200)	OUTPUT
)
AS 
BEGIN
	
	DECLARE @RET_OK		NVARCHAR(2) = '00'
	DECLARE @RET_ERR	NVARCHAR(2) = '99'
	DECLARE @OLD_STATE	NVARCHAR(20)
	DECLARE @ALLOC_CNT 	INT = 0
	DECLARE @BUY_CUST_ID NVARCHAR(20)
	DECLARE @BUY_DEPT_ID NVARCHAR(20)
	
	SELECT @OLD_STATE = ALLOC_STATE, @BUY_CUST_ID = BUY_CUST_ID, @BUY_DEPT_ID = BUY_DEPT_ID FROM T_ORDER_ALLOC WHERE ORDER_ID = @orderId AND ALLOC_ID = @allocId;

	IF @OLD_STATE = '05' OR @OLD_STATE = '00'
	BEGIN
		-- 출차 시간 관리(상태는 관리 안함)
		IF @OLD_STATE = '05' AND @allocState = '06'
		BEGIN
			UPDATE T_ORDER 
			SET LEAVE_DATE = GETDATE()
			  , EDITID = @regid
			  , EDITDATE = GETDATE()
			WHERE ORDER_ID = @orderId;
		
			-- 배차 상태는 변경하지 않는다.
			SET @allocState = '05'
		END 
		ELSE 
		BEGIN 
			set @retCode = @RET_ERR
			set @retMsg = '배차 상태를 변경할 수 없습니다.'
		END	
	END

	IF @OLD_STATE <> @allocState AND (@OLD_STATE <> '05' OR @OLD_STATE <> '00')
		BEGIN
			IF @allocState = '04'			-- 출발
				BEGIN
					UPDATE T_ORDER 
					SET ORDER_STATE = '04'
					  , START_DATE = GETDATE()
					  , EDITID = @regid
					  , EDITDATE = GETDATE()
					WHERE ORDER_ID = @orderId;
				
					--하차지 담당자에게 도착예정시간 알림톡 발송
					EXEC INSERT_SMS_SEND 'STARTINFO', @orderId, @allocId, '', '', '00000000000000';
				END
			IF @allocState = '05'			-- 도착
				BEGIN
					UPDATE T_ORDER 
					SET ORDER_STATE = '05'
					  , FINISH_DATE = GETDATE()
					  , EDITID = @regid
					  , EDITDATE = GETDATE()
					WHERE ORDER_ID = @orderId;
				
					-- 오더 도착일 경우, 미처리된 경유지 상태도 도착으로 변경된다.
					UPDATE T_ORDER_STOP SET FINISH_YN = 'Y', FINISH_DATE = GETDATE()
					WHERE ORDER_ID = @orderId AND FINISH_YN != 'Y';
				
					-- 오더 도착인 경우, 알림톡 발송
					EXEC INSERT_SMS_SEND 'ALLOCFINISH', @orderId, @allocId, '', '', '00000000000000';
				END	
			
				
				
			IF @allocState = '12'
				BEGIN
					UPDATE T_ORDER 
					SET ORDER_STATE = '12'
					  , ENTER_DATE = GETDATE()
					  , EDITID = @regid
					  , EDITDATE = GETDATE()
					WHERE ORDER_ID = @orderId;
				END
			
			IF @allocState = '00'				--배차 취소일 경우, 배차상태/오더상태는 접수상태로 변경된다.
				BEGIN 
					
					-- 하위 배차 내역이 있는 경우 취소 불가
					SELECT @ALLOC_CNT = COUNT(1)
					FROM T_ORDER_ALLOC 
					WHERE ORDER_ID = @orderId AND SELL_CUST_ID = @BUY_CUST_ID AND SELL_DEPT_ID = @BUY_DEPT_ID
						AND ALLOC_STATE != '00';
					
					IF @ALLOC_CNT > 0
						BEGIN		
							set @retCode = @RET_ERR
							set @retMsg = '배차가 이미 진행중입니다.'	
						END		
					ELSE
						BEGIN							
							UPDATE T_ORDER 
							SET ORDER_STATE = '00'
							  , ALLOC_DATE = NULL 
							  , START_DATE = NULL
							  , FINISH_DATE = NULL
							  , ENTER_DATE  = NULL
							  , EDITID = @regid
							  , EDITDATE = GETDATE()
							WHERE ORDER_ID = @orderId;
						
							UPDATE 
								T_ORDER_ALLOC 
							SET 
									VEHIC_ID = NULL
								  , DRIVER_ID = NULL 
								  , CAR_NUM = NULL 
								  , DRIVER_NAME = NULL 
								  , DRIVER_TEL = NULL
								  , BUY_CUST_ID = NULL 
								  , BUY_DEPT_ID = NULL 
								  , BUY_STAFF_ID = NULL
								  , ALLOC_DATE = NULL
								  , ALLOC_STATE = @allocState
								  , EDITDATE = GETDATE()
								  , EDITID = @regid
							WHERE 
									ORDER_ID = @orderId 
									AND ALLOC_ID = @allocId;							
						END
				
					
				END
			ELSE	
				BEGIN
					
					UPDATE 
							T_ORDER_ALLOC 
					SET 
							ALLOC_STATE = @allocState
						  , ALLOC_DATE = CASE @allocState WHEN '01' THEN GETDATE() WHEN '10' THEN GETDATE() ELSE ALLOC_DATE END
						  , EDITDATE = GETDATE()
						  , EDITID = @regid
					WHERE 
							ORDER_ID = @orderId 
							AND ALLOC_ID = @allocId;
		
				END
	
		END
			
		
	IF ISNULL(@retCode, '')	 = '' 
		BEGIN
			set @retCode = @RET_OK
			set @retMsg = '배차 상태가 변경되었습니다.'
		END	
		
END
GO
