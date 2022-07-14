USE [logislink]
GO
/****** Object:  StoredProcedure [dbo].[INSERT_VEHIC]    Script Date: 2022-07-14 오후 6:16:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- 배차 단계에서 신규 차량인 경우 호출 프로시저
CREATE PROCEDURE [dbo].[INSERT_VEHIC]
(
	@vehicId		NVARCHAR(20)
  , @driverId		NVARCHAR(20)
  , @custId			NVARCHAR(20)
  , @deptId			NVARCHAR(20)
  ,	@carNum			NVARCHAR(10)
  , @carTypeCode	NVARCHAR(10)
  , @carTonCode		NVARCHAR(10)
  , @bizName		NVARCHAR(50)
  , @bizNum			NVARCHAR(10)
  , @ceo			NVARCHAR(20)
  , @bizPost		NVARCHAR(7)
  , @bizAddr		NVARCHAR(50)
  , @bizAddrDetail	NVARCHAR(50)
  , @subBizNum		NVARCHAR(10)
  , @bizCond		NVARCHAR(20)
  , @bizKind		NVARCHAR(20)
  , @regid			NVARCHAR(20)
  , @cargoBox		NVARCHAR(30)
  , @retCode 		NVARCHAR(2)		OUTPUT
  , @retMsg 		NVARCHAR(200) 	OUTPUT
  , @retId			NVARCHAR(20)	OUTPUT
)
AS 
BEGIN
	DECLARE @RET_OK NVARCHAR(2) = '00'		-- 성공
	DECLARE @RET_ERR NVARCHAR(2) = '99'		-- Error
	
	DECLARE @preDriverId NVARCHAR(20)
	
	-- 이미 등록된 차량번호일 경우, @vehicId 할당
	SELECT @vehicId = VEHIC_ID, @preDriverId = DRIVER_ID
	FROM T_VEHIC_MST
	WHERE CAR_NUM = @carNum AND USE_YN = 'Y'
	
	IF isNull(@vehicId, '') = ''
		BEGIN
						
			SET @vehicId = 'V' + convert(varchar, getDate(), 112) + replace(convert(varchar, getDate(), 108), ':', '') + '001'
			
			INSERT INTO dbo.T_VEHIC_MST(
			        		VEHIC_ID,		DRIVER_ID,
				        	CAR_NUM,		CAR_TYPE_CODE,	CAR_TON_CODE,
							BIZ_NAME,		BIZ_NUM, 		CEO,
							BIZ_POST, 		BIZ_ADDR, 		BIZ_ADDR_DETAIL,
							REGDATE, 		SUB_BIZ_NUM,	BIZ_COND, 		
							BIZ_KIND,		CARGO_BOX,		REGID)
			VALUES(
							@vehicId,		@driverId,
							@carNum,		@carTypeCode,	@carTonCode,
							@bizName,		@bizNum,		@ceo,
							@bizPost,		@bizAddr,		@bizAddrDetail,
							GETDATE(),		@subBizNum,		@bizCond,		
							@bizKind, 		@cargoBox,		@regid)
							
		END
	ELSE
		BEGIN
			-- 기사 차량정보가 바꼈을 경우, 새로 매칭
			IF isNull(@preDriverId, '') <> @driverId
				BEGIN
					UPDATE T_VEHIC_MST
						SET DRIVER_ID = @driverId,
							EDITDATE = GETDATE(),
							EDITID = @regid
					WHERE VEHIC_ID = @vehicId
				END
		END		
	
	-- 배차 됐을 경우, 거래처 차량 목록에 추가
	IF isNull(@custId, '') <> '' AND isNull(@deptId, '') <> ''
		BEGIN 
			MERGE INTO
					T_CUST_VEHIC A
			USING
					(
						SELECT
								@custId		AS CUST_ID
							  , @deptId		AS DEPT_ID
							  , @vehicId	AS VEHIC_ID
							  , @driverId	AS DRIVER_ID
							  , @regid		AS REGID
					) T
			ON
					(A.CUST_ID = T.CUST_ID AND A.DEPT_ID = T.DEPT_ID AND A.VEHIC_ID = T.VEHIC_ID)
			WHEN NOT MATCHED THEN 
				INSERT (CUST_ID, DEPT_ID, VEHIC_ID, DRIVER_ID, USE_YN, REGDATE, REGID )
				VALUES (T.CUST_ID, T.DEPT_ID, T.VEHIC_ID, T.DRIVER_ID, 'Y', GETDATE(), T.REGID)
			WHEN MATCHED THEN
				UPDATE SET DRIVER_ID = T.DRIVER_ID 
						 , USE_YN = 'Y'
						 , EDITDATE = GETDATE()
						 , EDITID = T.REGID ;
		END
	
		
	set @retCode = @RET_OK
	set @retMsg = '차량 정보가 추가되었습니다.'
	set @retId = @vehicId
END
GO
