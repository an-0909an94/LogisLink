USE [logislink]
GO
/****** Object:  StoredProcedure [dbo].[OAPI_ORDER_INSERT]    Script Date: 2022-07-14 오후 6:16:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[OAPI_ORDER_INSERT]
(
	@orderId		NVARCHAR(20)
  , @reqCustId		NVARCHAR(20)
  , @reqDeptId		NVARCHAR(20)
  , @reqStaff		NVARCHAR(20)
  , @reqTel			NVARCHAR(13)
  , @custId			NVARCHAR(20)
  , @deptId			NVARCHAR(20)
  , @inOutSctn		NVARCHAR(2)
  , @truckTypeCode	NVARCHAR(2)
  , @sComName		NVARCHAR(50)
  , @sSido			NVARCHAR(10)
  , @sGungu			NVARCHAR(20)
  , @sDong			NVARCHAR(20)
  , @sAddr			NVARCHAR(50)
  , @sAddrDetail	NVARCHAR(50)
  , @sDate			NVARCHAR(20)
  , @sStaff			NVARCHAR(20)
  , @sTel			NVARCHAR(13)
  , @sMemo			NVARCHAR(1000)  
  , @eComName		NVARCHAR(50)
  , @eSido			NVARCHAR(10)
  , @eGungu			NVARCHAR(20)
  , @eDong			NVARCHAR(20)
  , @eAddr			NVARCHAR(50)
  , @eAddrDetail	NVARCHAR(50)
  , @eDate			NVARCHAR(20)
  , @eStaff			NVARCHAR(20)
  , @eTel			NVARCHAR(13)
  , @eMemo			NVARCHAR(1000)
  , @sLat			DECIMAL(16,13)
  , @sLon			DECIMAL(16,12)
  , @eLat			DECIMAL(16,13)
  , @eLon			DECIMAL(16,12)
  , @goodsName		NVARCHAR(100)
  , @goodsWeight	FLOAT
  , @goodsQty		BIGINT  
  , @qtyUnitCode	NVARCHAR(20)
  , @sWayCode		NVARCHAR(20)
  , @eWayCode		NVARCHAR(20)
  , @mixYn			NVARCHAR(1)
  , @mixSize		NVARCHAR(20)
  , @returnYn		NVARCHAR(1)
  , @carTonCode		NVARCHAR(20)
  , @carTypeCode	NVARCHAR(20)
  , @chargeType		NVARCHAR(20)
  , @distance		FLOAT
  , @time			INT
  , @reqMemo		NVARCHAR(1000)
  , @driverMemo		NVARCHAR(1000)
  , @itemCode		NVARCHAR(10)
  , @allocCharge	INT
  --, @allocFee		INT  
  --, @sellWeight		NVARCHAR(100)
  , @regid			NVARCHAR(20)
  , @retId			NVARCHAR(20)	OUTPUT
  , @retCode		NVARCHAR(2)		OUTPUT
  , @retMsg			NVARCHAR(200)	OUTPUT
)
AS 
BEGIN
	
	DECLARE @RET_OK		NVARCHAR(2) = '00'
	DECLARE @RET_ERR	NVARCHAR(2) = '99'
	DECLARE @timestamp	NVARCHAR(14) = ''
	
	DECLARE @allocId	NVARCHAR(20)
	
	DECLARE @buyStaffId		NVARCHAR(20)
	DECLARE @buyStaffTel	NVARCHAR(13)
	
	DECLARE @finishCnt	INT
	DECLARE @orderCnt	INT
	
	IF isNull(@orderId, '') = ''
		BEGIN
			SET @timestamp = convert(varchar, getDate(), 112) + replace(convert(varchar, getDate(), 108), ':', '')
			SET @orderId = 'T' + @timestamp + '001'
			SET @allocId = 'A' + @timestamp + '001'
			
			IF ISNULL(@buyStaffId, '') = ''
			BEGIN 
				SELECT @buyStaffId = MANAGER 
				FROM T_CUST_DTL 
				WHERE CUST_ID = @reqCustId AND DEPT_ID = @reqDeptId AND MNG_CUST_ID = @custId AND MNG_DEPT_ID = @deptId 
					 AND SELL_BUY_SCTN = '01' AND USE_YN = 'Y';
			END
			
			IF ISNULL(@buyStaffTel, '') = ''
			BEGIN 
				SELECT @buyStaffTel = MOBILE
				from T_USER 
				where USER_ID = @buyStaffId;
			END
			
			INSERT INTO T_ORDER 
						(
							  ORDER_ID		, REQ_CUST_ID		, REQ_DEPT_ID		, REQ_STAFF_ID	, REQ_TEL
							, CUST_ID		, DEPT_ID			, IN_OUT_SCTN
							, TRUCK_TYPE_CODE, S_COM_NAME		, S_SIDO			, S_GUNGU		, S_ADDR
							, S_ADDR_DETAIL	, S_DATE			, S_STAFF			, S_TEL			, S_MEMO
							, E_COM_NAME	, E_SIDO			, E_GUNGU			, E_ADDR		, E_ADDR_DETAIL
							, E_DATE		, E_STAFF			, E_TEL				, E_MEMO		, S_LAT
							, S_LON			, E_LAT				, E_LON				, ORDER_STATE	, GOODS_NAME
							, GOODS_WEIGHT	, GOODS_QTY			, S_WAY_CODE		, E_WAY_CODE	, MIX_YN
							, MIX_SIZE		, RETURN_YN			, CAR_TON_CODE		, CAR_TYPE_CODE	, CHARGE_TYPE
							, DISTANCE		, TIME				, WEIGHT_UNIT_CODE	, QTY_UNIT_CODE	, REQ_MEMO
							, DRIVER_MEMO	, ITEM_CODE			, REGID				, S_DONG		, E_DONG
						)
			VALUES
						(
							  @orderId		, @reqCustId		, @reqDeptId		, @reqStaff		, @reqTel
							, @custId			, @deptId		, @inOutSctn
							, @truckTypeCode, @sComName			, @sSido			, @sGungu		, @sAddr
							, @sAddrDetail	, CONVERT(DATETIME, @sDate), @sStaff	, @sTel			, @sMemo
							, @eComName		, @eSido			, @eGungu			, @eAddr		, @eAddrDetail
							, CONVERT(DATETIME, @eDate), @eStaff, @eTel				, @eMemo		, @sLat
							, @sLon			, @eLat				, @eLon				, '00'			, @goodsName
							, @goodsWeight*1000	, @goodsQty			, @sWayCode			, @eWayCode		, @mixYn
							, @mixSize		, @returnYn			, @carTonCode		, @carTypeCode	, @chargeType
							, @distance		, @time				, 'TON'				, @qtyUnitCode	, @reqMemo
							, @driverMemo	, @itemCode			, @regid			, @sDong		, @eDong
						)
								
	
			INSERT INTO T_ORDER_ALLOC 
						(
							ALLOC_ID		, ORDER_ID			, SELL_CUST_ID		, SELL_DEPT_ID	, BUY_CUST_ID
						  , BUY_DEPT_ID		, ALLOC_CHARGE		, ALLOC_FEE			, ALLOC_STATE	, REGID
						  , REGDATE			, SELL_STAFF_ID 	, BUY_STAFF_ID		, SELL_STAFF_TEL, BUY_STAFF_TEL
						  , ALLOC_DATE		--, SELL_WEIGHT
						)
			VALUES
						(
							@allocId		, @orderId			, @reqCustId		, @reqDeptId	, @custId
						  , @deptId			, @allocCharge		, 0					, '10'			, @regid
						  , GETDATE()		, @reqStaff			, @buyStaffId		, @reqTel		, @buyStaffTel
						  , GETDATE()		--, @sellWeight
						)
						
			--화주가 오더 등록한 경우, 주선사/운송사에게 알림톡 발송
	/*		IF @reqStaff = @regid
			BEGIN
				EXEC INSERT_SMS_SEND 'ORDERNOTI', @orderId, @allocId, '', '', '00000000000000';
			END*/
			
	
			IF (@@ERROR <> 0)
				BEGIN
					SET @retCode = @RET_ERR
			    	SET @retMsg = '오더등록에 실패했습니다.'
				END
		    ELSE		
		    	BEGIN						
					-- app에서 등록/수정 후, 바로 배차화면으로 넘어가기 위해 msg에 allocID를 리턴한다.						
			    	SET @retCode = @RET_OK
				    SET @retMsg = '오더가 등록되었습니다.'
				    SET @retId = @orderId
		    	END
		END
	ELSE
		BEGIN
			
			
			SELECT @finishCnt = COUNT(1)
			FROM T_CALC 
			WHERE ORDER_ID = @orderId AND USE_YN = 'Y' AND FINISH_YN = 'Y'
			
			IF ISNULL(@reqCustId, '') != '' AND ISNULL(@reqDeptId, '') != ''
			BEGIN
				SELECT @allocId = ALLOC_ID 
				FROM T_ORDER_ALLOC 
				WHERE ORDER_ID = @orderId
					AND SELL_CUST_ID = @reqCustId AND SELL_DEPT_ID = @reqDeptId
			END
			
			IF ISNULL(@custId, '') != '' AND ISNULL(@deptId, '') != ''
			BEGIN
				SELECT @allocId = ALLOC_ID 
				FROM T_ORDER_ALLOC 
				WHERE ORDER_ID = @orderId
					AND BUY_CUST_ID = @custId AND BUY_DEPT_ID = @deptId
			END
			
			IF @finishCnt = 0 AND ISNULL(@allocId, '') != ''
			BEGIN 	
				UPDATE 
						T_ORDER
				SET
					    REQ_STAFF_ID	= @reqStaff
					  , REQ_TEL			= @reqTel
					  , IN_OUT_SCTN		= @inOutSctn
					  , TRUCK_TYPE_CODE = @truckTypeCode
					  , S_COM_NAME		= @sComName
					  , S_SIDO			= @sSido
					  , S_GUNGU			= @sGungu
					  , S_DONG			= @sDong
					  , S_ADDR			= @sAddr
					  , S_ADDR_DETAIL	= @sAddrDetail
					  , S_STAFF			= @sStaff
					  , S_TEL			= @sTel
					  , S_MEMO			= @sMemo
					  ,	S_DATE 			= @sDate
					  , E_COM_NAME		= @eComName
					  , E_SIDO			= @eSido
					  , E_GUNGU			= @eGungu
					  , E_DONG			= @eDong
					  , E_ADDR			= @eAddr
					  , E_ADDR_DETAIL	= @eAddrDetail
					  , E_STAFF			= @eStaff
					  , E_TEL			= @eTel
					  , E_MEMO			= @eMemo
					  ,	E_DATE 			= @eDate
					  , S_LAT			= @sLat
					  , S_LON			= @sLon
					  , E_LAT			= @eLat
					  , E_LON			= @eLon			
					  , GOODS_NAME		= @goodsName
					  , GOODS_WEIGHT	= @goodsWeight * 1000
					  , GOODS_QTY		= @goodsQty
					  , S_WAY_CODE		= @sWayCode
					  , E_WAY_CODE		= @eWayCode
					  , MIX_YN			= @mixYn	
					  , MIX_SIZE		= @mixSize
					  , RETURN_YN		= @returnYn
					  , CAR_TON_CODE	= @carTonCode
					  , CAR_TYPE_CODE	= @carTypeCode
					  , CHARGE_TYPE		= @chargeType
					  , DISTANCE		= @distance
					  , TIME			= @time
					  , QTY_UNIT_CODE	= @qtyUnitCode
					  , REQ_MEMO		= @reqMemo
					  , DRIVER_MEMO		= @driverMemo
					  , ITEM_CODE		= @itemCode
					  , EDITDATE 		= GETDATE()
					  , EDITID			= @regid
				WHERE
						ORDER_ID = @orderId
						
					
				UPDATE 
						T_ORDER_ALLOC
				SET
						
						SELL_STAFF_ID	= @reqStaff	
					  ,	SELL_STAFF_TEL	= @reqTel	
					  , BUY_STAFF_ID	= @buyStaffId	
					  ,	ALLOC_CHARGE 	= @allocCharge				  	
					  --, ALLOC_FEE		= @allocFee
					  --, SELL_WEIGHT		= @sellWeight
					  , EDITDATE		= GETDATE()
					  , EDITID			= @regid
				WHERE 
						ORDER_ID = @orderId
						AND ALLOC_ID = @allocId
		
					
						
				-- app에서 등록/수정 후, 바로 배차화면으로 넘어가기 위해 msg에 allocID를 리턴한다.						
		    	SET @retCode = @RET_OK
			    SET @retMsg = '오더가 등록되었습니다.'
			    SET @retId = @orderId
			END 
			ELSE 
			BEGIN 
				IF @finishCnt = 0
				BEGIN 
					set @retCode = @RET_ERR
				    set @retMsg = '이미 마감된 정산 내역이 있어 오더를 수정할 수 없습니다.'
				END
				
				IF ISNULL(@allocId, '') = '' 
				BEGIN 
					set @retCode = @RET_ERR
				    set @retMsg = '오더 정보가 없습니다.'
				END
			END		  
					
		END
END
GO
