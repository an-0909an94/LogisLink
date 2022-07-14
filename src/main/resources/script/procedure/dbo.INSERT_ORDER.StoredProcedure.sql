USE [logislink]
GO
/****** Object:  StoredProcedure [dbo].[INSERT_ORDER]    Script Date: 2022-07-14 오후 6:16:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- 운송사/주선사용 오더 등록
CREATE PROCEDURE [dbo].[INSERT_ORDER]
(
	@mode			NVARCHAR(2)
  , @reqCustId		NVARCHAR(20)
  , @orderId		NVARCHAR(20)
  , @allocId		NVARCHAR(20)
  , @sellAllocId	NVARCHAR(20)
  , @reqDeptId		NVARCHAR(20)
  , @reqStaffId		NVARCHAR(20)
  , @reqTel			NVARCHAR(13)
  , @reqAddr		NVARCHAR(50)
  , @reqAddrDetail	NVARCHAR(50)
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
  , @sDateDay		NVARCHAR(10)
  , @sDateTime		NVARCHAR(10)
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
  , @eDateDay		NVARCHAR(10)
  , @eDateTime		NVARCHAR(10)
  , @eStaff			NVARCHAR(20)
  , @eTel			NVARCHAR(13)
  , @eMemo			NVARCHAR(1000)
  , @sLat			DECIMAL(16,13)
  , @sLon			DECIMAL(16,12)
  , @eLat			DECIMAL(16,13)
  , @eLon			DECIMAL(16,12)
  , @goodsName		NVARCHAR(100)
  , @goodsWeight	NVARCHAR(10)
  , @weightUnitCode	NVARCHAR(20)
  , @goodsQty		INT  
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
  , @sellCharge		INT
  , @buyCharge		INT
  , @sellFee		INT
  , @buyFee			INT
  , @buyCustId		NVARCHAR(20)
  , @buyDeptId		NVARCHAR(20)
  , @buyStaffId		NVARCHAR(20)
  , @buyStaffTel	NVARCHAR(13)
  , @buyVehicId		NVARCHAR(20)
  , @buyDriverId	NVARCHAR(20)
  , @buyCarNum		NVARCHAR(10)
  , @buyDriverName	NVARCHAR(20)
  , @buyDriverTel	NVARCHAR(13)
  , @carSctnCode	NVARCHAR(10)
  , @regid			NVARCHAR(20)
  , @editId			NVARCHAR(20)
  , @loginId		NVARCHAR(20)
  , @allocDate		NVARCHAR(20)
  , @memo			NVARCHAR(1000)
  , @buyCarTypeCode	NVARCHAR(20)
  , @buyCarTonCode  NVARCHAR(20)
  , @buyCargoBox	NVARCHAR(30)
  , @sellWeight		NVARCHAR(100)
  , @sellCustId		NVARCHAR(20)
  , @sellDeptId		NVARCHAR(20)
  , @unitPriceType	NVARCHAR(2)
  , @unitCharge		INT
  , @carMngCode		NVARCHAR(2)
  , @carMngMemo		NVARCHAR(1000)
  , @linkSelect		NVARCHAR(2)
  , @payType		NVARCHAR(2)
  , @dangerGoodsYn	NVARCHAR(2)
  , @chemicalsYn	NVARCHAR(2)
  , @foreignLicenseYn NVARCHAR(2)
  , @outBuyTaxCnt	INT				OUTPUT
  , @outSellTaxCnt	INT				OUTPUT
  , @buyAllocId		NVARCHAR(20)	OUTPUT
  , @sellOutAllocId	NVARCHAR(20)	OUTPUT
  , @retId			NVARCHAR(20)	OUTPUT
  , @retCode		NVARCHAR(2)		OUTPUT
  , @retMsg			NVARCHAR(200)	OUTPUT
)
AS 
BEGIN
	DECLARE @RET_OK NVARCHAR(2) = '00'		-- 성공
	DECLARE @RET_ERR NVARCHAR(2) = '99'		-- Error
	DECLARE @timestamp	NVARCHAR(14) = ''
	DECLARE @staffId 	NVARCHAR(20);
	DECLARE @staffTel	NVARCHAR(13);
--	DECLARE @oldPayType NVARCHAR(1);
	DECLARE @oldOrderId	NVARCHAR(20);	

	SET @timestamp = convert(varchar, getDate(), 112) + replace(convert(varchar, getDate(), 108), ':', '')
	SET @sDate = CONVERT(CHAR(10),@sDateDay, 23) +' '+ CONVERT(CHAR(10),@sDateTime, 24)
	SET @eDate = CONVERT(CHAR(10),@eDateDay, 23) +' '+ CONVERT(CHAR(10),@eDateTime, 24)
	SET @payType = CASE WHEN @payType = 'Y' THEN 'Y' ELSE 'N' END
	
	DECLARE @spRet		INT
	DECLARE @spMsg		NVARCHAR(200)
	DECLARE @spId1		NVARCHAR(20)
	DECLARE @spId2		NVARCHAR(20)	
	DECLARE @seq		VARCHAR(20)
	
	DECLARE @buyFinishCnt	INT
	DECLARE @sellFinishCnt	INT
	DECLARE @buyTaxCnt	INT
	DECLARE @sellTaxCnt	INT
	
	SELECT @staffTel = MOBILE
	from T_USER 
	where USER_ID = @loginId;
	
		
	IF @mode = 'N'
		BEGIN
			-- SET @allocId = 'A'+@timestamp+'001' 
			SELECT @seq = NEXT VALUE FOR SEQ_ORDER;
			SET @orderId = 'O'+ @timestamp  + RIGHT('00' + @seq, 3);
			
			INSERT INTO T_ORDER (
				ORDER_ID,				REQ_CUST_ID,			REQ_DEPT_ID,
				REQ_STAFF_ID,			REQ_TEL,				REQ_ADDR,
				REQ_ADDR_DETAIL,		IN_OUT_SCTN,			TRUCK_TYPE_CODE,
				S_COM_NAME,				S_SIDO,					S_GUNGU,
				S_DONG,					S_ADDR,					S_ADDR_DETAIL,
				S_DATE,					S_STAFF,				S_TEL,
				S_MEMO,					E_COM_NAME,				E_SIDO,
				E_GUNGU,				E_DONG,					E_ADDR,
				E_ADDR_DETAIL,			E_DATE,					E_STAFF,
				E_TEL,					E_MEMO,					S_LAT,
				S_LON,					E_LAT,					E_LON,
				GOODS_NAME,				GOODS_WEIGHT,			WEIGHT_UNIT_CODE,
				GOODS_QTY,				QTY_UNIT_CODE,			S_WAY_CODE,
				E_WAY_CODE,				MIX_YN,					MIX_SIZE,
				RETURN_YN,				CAR_TON_CODE,			CAR_TYPE_CODE,
				CHARGE_TYPE,			DISTANCE,				[TIME],
				REQ_MEMO,				DRIVER_MEMO,			ITEM_CODE,
				REGID,					REGDATE,				CUST_ID,
				DEPT_ID,				MEMO,					UNIT_PRICE_TYPE,
				UNIT_CHARGE,			DANGER_GOODS_YN,		CHEMICALS_YN,
				FOREIGN_LICENSE_YN,		ALLOC_DATE)
			VALUES (
				@orderId,				@reqCustId,				@reqDeptId,
				@reqStaffId,			@reqTel,				@reqAddr,
				@reqAddrDetail, 		@inOutSctn,				@truckTypeCode,
				@sComName,				@sSido,					@sGungu,
				@sDong,					@sAddr,					@sAddrDetail,
				@sDate,					@sStaff,				@sTel,
				@sMemo,					@eComName,				@eSido,
				@eGungu,				@eDong,					@eAddr,
				@eAddrDetail,			@eDate,					@eStaff,
				@eTel,					@eMemo,					ISNULL(@sLat,0),
				ISNULL(@sLon,0),		ISNULL(@eLat,0),		ISNULL(@eLon,0),
				@goodsName,				CONVERT(float,@goodsWeight) * 1000,	@weightUnitCode,
				@goodsQty,				@qtyUnitCode,			@sWayCode,
				@eWayCode,				ISNULL(@mixYn,'N'),		@mixSize,
				ISNULL(@returnYn,'N'),	@carTonCode,			@carTypeCode,
				@chargeType,			@distance,				@time,
				@reqMemo,				@driverMemo,			@itemCode,
				@regId,					GETDATE(),				@custId,
				@deptId,				@memo,					@unitPriceType,
				@unitCharge,			ISNULL(@dangerGoodsYn,'N'),	ISNULL(@chemicalsYn,'N'),
				ISNULL(@foreignLicenseYn,'N'), @allocDate);
			
			-- 매출처 배차 등록/수정
			EXEC UPDATE_ORDER_ALLOC @orderId, @sellAllocId, @reqCustId, @reqDeptId, @reqStaffId, @reqTel
			         			  , @custId, @deptId, @loginId, @staffTel, @sellCharge, @sellFee
			         			  , NULL, NULL, NULL, NULL, NULL
			         			  , NULL, NULL, @regId, @buyCargoBox, @sellWeight, NULL, NULL, @spId1  OUTPUT, @spMsg OUTPUT;
		
			         			 
			SELECT @sellOutAllocId = ALLOC_ID
			FROM T_ORDER_ALLOC
			WHERE ORDER_ID = @orderId AND SELL_CUST_ID = @sellCustId AND SELL_DEPT_ID = @sellDeptId;
			         			 
			IF @buyCustId <> '' OR @buyCharge <> 0 OR @buyCarNum <> ''
			BEGIN 
				-- 매입처 배차 등록/수정
				-- 매입처 배차 수수료 0원 (05.19 수정)
				EXEC UPDATE_ORDER_ALLOC @orderId, @allocId, @custId, @deptId, @loginId, @staffTel
									  , @buyCustId, @buyDeptId, @buyStaffId, @buyStaffTel, @buyCharge, 0
									  , @buyVehicId, @buyDriverId, @buyCarNum, @buyCarTonCode, @buyCarTypeCode
									  , @buyDriverName, @buyDriverTel, @regId, @buyCargoBox, NULL, @linkSelect, @payType, @spId1  OUTPUT, @spMsg OUTPUT;
									 
				
				SELECT @buyAllocId = ALLOC_ID, @buyDriverId = DRIVER_ID, @buyVehicId = VEHIC_ID
				FROM T_ORDER_ALLOC
				WHERE ORDER_ID = @orderId AND SELL_CUST_ID = @custId AND SELL_DEPT_ID = @deptId;
							
				UPDATE T_CUST_VEHIC 
				SET CAR_SCTN_CODE = CASE WHEN ISNULL(@carSctnCode, '') = '' THEN CAR_SCTN_CODE ELSE @carSctnCode END
				  , CAR_MNG_CODE = @carMngCode
				  , CAR_MNG_MEMO = @carMngMemo
				  , PAY_TYPE  =  @payType
				WHERE CUST_ID = @custId AND DEPT_ID = @deptId AND DRIVER_ID = @buyDriverId AND VEHIC_ID = @buyVehicId;
			
				
				--혼적오더 배차 차량이 혼적선호 Y가 아닐 때 Y로 변경
				IF @mixYn = 'Y'
				BEGIN
					UPDATE T_VEHIC_MST 
					SET CAR_TYPE_CODE = @buyCarTypeCode, CAR_TON_CODE = @buyCarTonCode, CARGO_BOX = @buyCargoBox, MIX_PREFER_YN = @mixYn
					WHERE VEHIC_ID = @buyVehicId AND DRIVER_ID = @buyDriverId
				END
				ELSE
				BEGIN 
					UPDATE T_VEHIC_MST 
					SET CAR_TYPE_CODE = @buyCarTypeCode, CAR_TON_CODE = @buyCarTonCode, CARGO_BOX = @buyCargoBox
					WHERE VEHIC_ID = @buyVehicId AND DRIVER_ID = @buyDriverId
				END
			END
			
			
				
	    	set @retCode = @RET_OK;
		 set @retMsg = '오더가 등록되었습니다.';
		END
	IF @mode = 'E'
		BEGIN	
			SELECT @buyFinishCnt = COUNT(1)
			FROM T_CALC
			WHERE ORDER_ID = @orderId
			AND MNG_CUST_ID = @sellCustId
			AND MNG_DEPT_ID = @sellDeptId
			AND SELL_BUY_SCTN = '02'
			AND USE_YN = 'Y' 
			AND FINISH_YN = 'Y'
			
			SELECT @sellFinishCnt = COUNT(1)
			FROM T_CALC
			WHERE ORDER_ID = @orderId
			AND MNG_CUST_ID = @custId
			AND MNG_DEPT_ID = @deptId
			AND SELL_BUY_SCTN = '01'
			AND USE_YN = 'Y' 
			AND FINISH_YN = 'Y'
			
			SELECT @buyTaxCnt = COUNT(1)
			FROM T_CALC 
			WHERE ORDER_ID = @orderId 
			AND ALLOC_ID = @allocId
			AND USE_YN = 'Y'
			AND TAXINV_YN != 'N'
			
			SELECT @sellTaxCnt = COUNT(1)
			FROM T_CALC 
			WHERE ORDER_ID = @orderId 
			AND ALLOC_ID = @sellAllocId
			AND USE_YN = 'Y'
			AND TAXINV_YN != 'N'
			
			UPDATE T_ORDER 
			SET		
				REQ_STAFF_ID = @reqStaffId,
				REQ_TEL = @reqTel,
				S_COM_NAME = @sComName,		
				S_SIDO = @sSido,		
				S_GUNGU = @sGungu,
				S_DONG = @sDong,		
				S_ADDR = @sAddr,		
				S_ADDR_DETAIL = @sAddrDetail,
				S_DATE = @sDate,		
				S_STAFF = @sStaff,		
				S_TEL = @sTel,
				S_MEMO = @sMemo,		
				E_COM_NAME = @eComName,		
				E_SIDO = @eSido,
				E_GUNGU = @eGungu,		
				E_DONG = @eDong,			
				E_ADDR = @eAddr,
				E_ADDR_DETAIL = @eAddrDetail,		
				E_DATE = @eDate,			
				E_STAFF = @eStaff,
				E_TEL = @eTel,		
				E_MEMO = @eMemo,			
				S_LAT = ISNULL(@sLat,0),
				S_LON = ISNULL(@sLon,0),		
				E_LAT = ISNULL(@eLat,0),		
				E_LON = ISNULL(@eLon,0),
				WEIGHT_UNIT_CODE = @weightUnitCode,
				QTY_UNIT_CODE = @qtyUnitCode,		
				DISTANCE = @distance,		
				[TIME] = @time,
				REQ_MEMO = @reqMemo,		
				EDITID = @editId,			
				EDITDATE = GETDATE(),
				MEMO = @memo,
				ALLOC_DATE = @allocDate
			WHERE 
				ORDER_ID = @orderId;
			
			IF @sellFinishCnt = 0
			BEGIN
				IF @sellTaxCnt = 0
				BEGIN
					UPDATE T_ORDER 
					SET		
						UNIT_PRICE_TYPE = @unitPriceType,
						UNIT_CHARGE = @unitCharge,
						CHARGE_TYPE = @chargeType,
						IN_OUT_SCTN = @inOutSctn,
						TRUCK_TYPE_CODE = @truckTypeCode,
						GOODS_NAME = @goodsName,
						GOODS_WEIGHT = CONVERT(float,@goodsWeight) * 1000,
						GOODS_QTY = @goodsQty,			
						S_WAY_CODE = @sWayCode,
						E_WAY_CODE = @eWayCode,		
						MIX_YN = ISNULL(@mixYn,'N'),		
						MIX_SIZE = @mixSize,
						RETURN_YN = ISNULL(@returnYn,'N'),		 
						CAR_TON_CODE = @carTonCode,		
						CAR_TYPE_CODE = @carTypeCode,	
						ITEM_CODE = @itemCode,
						DANGER_GOODS_YN = ISNULL(@dangerGoodsYn,'N'),
						CHEMICALS_YN = ISNULL(@chemicalsYn,'N'),
						FOREIGN_LICENSE_YN = ISNULL(@foreignLicenseYn,'N')
					WHERE 
						ORDER_ID = @orderId
						
					-- 매출처 배차 등록/수정
					EXEC UPDATE_ORDER_ALLOC @orderId, @sellAllocId, @reqCustId, @reqDeptId, @reqStaffId, @reqTel
					         			  , @custId, @deptId, @loginId, @staffTel, @sellCharge, @sellFee
					         			  , NULL, NULL, NULL, NULL, NULL
					         			  , NULL, NULL, @regId, @buyCargoBox, @sellWeight, NULL, NULL, @spId1  OUTPUT, @spMsg OUTPUT;
				END
				ELSE 
				BEGIN
				    set @outSellTaxCnt = @sellTaxCnt
				END
			END 
			ELSE 
			BEGIN 
				set @retCode = @RET_ERR
			    set @retMsg = '이미 마감된 정산 내역이 있어 오더 일부 항목을 수정할 수 없습니다.'
			END
			
			SET @buyAllocId = @allocId
			
			IF @buyFinishCnt = 0
			BEGIN 
				IF @buyTaxCnt = 0
				BEGIN 
					-- 매입처 배차 등록/수정
					-- 매입처 배차 수수료 0원 (05.19 수정)
					EXEC UPDATE_ORDER_ALLOC @orderId, @allocId, @custId, @deptId, @loginId, @staffTel
										  , @buyCustId, @buyDeptId, @buyStaffId, @buyStaffTel, @buyCharge, 0
										  , @buyVehicId, @buyDriverId, @buyCarNum, @buyCarTonCode, @buyCarTypeCode
										  , @buyDriverName, @buyDriverTel, @regId, @buyCargoBox, NULL, @linkSelect, @payType, @spMsg  OUTPUT, @spId1 OUTPUT;
										 
					UPDATE T_ORDER 
					SET DRIVER_MEMO = @driverMemo
					WHERE 
						ORDER_ID = @orderId
						
	
					SELECT @buyAllocId = ALLOC_ID, @buyDriverId = DRIVER_ID, @buyVehicId = VEHIC_ID
					FROM T_ORDER_ALLOC
					WHERE ORDER_ID = @orderId AND SELL_CUST_ID = @custId AND SELL_DEPT_ID = @deptId;
		
					UPDATE T_CUST_VEHIC 
					SET CAR_SCTN_CODE = CASE WHEN ISNULL(@carSctnCode, '') = '' THEN CAR_SCTN_CODE ELSE @carSctnCode END
					  , CAR_MNG_CODE = @carMngCode
					  , CAR_MNG_MEMO = @carMngMemo
				  		, PAY_TYPE  =  @payType
					WHERE CUST_ID = @custId AND DEPT_ID = @deptId AND DRIVER_ID = @buyDriverId AND VEHIC_ID = @buyVehicId;
					
					--혼적오더 배차 차량이 혼적선호 Y가 아닐 때 Y로 변경
					IF @mixYn = 'Y'
					BEGIN
						UPDATE T_VEHIC_MST 
						SET CAR_TYPE_CODE = @buyCarTypeCode, CAR_TON_CODE = @buyCarTonCode, CARGO_BOX = @buyCargoBox, MIX_PREFER_YN = @mixYn
						WHERE VEHIC_ID = @buyVehicId AND DRIVER_ID = @buyDriverId
					END
					ELSE
					BEGIN 
						UPDATE T_VEHIC_MST 
						SET CAR_TYPE_CODE = @buyCarTypeCode, CAR_TON_CODE = @buyCarTonCode, CARGO_BOX = @buyCargoBox
						WHERE VEHIC_ID = @buyVehicId AND DRIVER_ID = @buyDriverId
					END
		
				END
				ELSE
				BEGIN
					BEGIN
				    	set @outBuyTaxCnt = @buyTaxCnt
					END
				END
			END
			ELSE 
			BEGIN 
				set @retCode = @RET_ERR
			    set @retMsg = '이미 마감된 정산 내역이 있어 오더 일부 항목을 수정할 수 없습니다.'
			END
			SELECT @sellOutAllocId = ALLOC_ID
			FROM T_ORDER_ALLOC
			WHERE ORDER_ID = @orderId AND SELL_CUST_ID = @sellCustId AND SELL_DEPT_ID = @sellDeptId;
			
			IF @buyFinishCnt = 0 AND @sellFinishCnt = 0
			BEGIN
				set @retCode = @RET_OK
			    set @retMsg = '오더가 수정되었습니다.'
			END
		END
	IF @mode = 'C'
		BEGIN
			SET @oldOrderId = @orderId
			
			SELECT @seq = NEXT VALUE FOR SEQ_ORDER;
			SET @orderId = 'O'+@timestamp  + RIGHT('00' + @seq, 3)
			-- 오더 복사시 상/하차시간 현재 시간으로 복사(2021-11-25)
			INSERT INTO T_ORDER (
				ORDER_ID,				REQ_CUST_ID,			REQ_DEPT_ID,
				REQ_STAFF_ID,			REQ_TEL,				REQ_ADDR,
				REQ_ADDR_DETAIL,		IN_OUT_SCTN,			TRUCK_TYPE_CODE,
				S_COM_NAME,				S_SIDO,					S_GUNGU,
				S_DONG,					S_ADDR,					S_ADDR_DETAIL,
				S_DATE,					S_STAFF,				S_TEL,
				S_MEMO,					E_COM_NAME,				E_SIDO,
				E_GUNGU,				E_DONG,					E_ADDR,
				E_ADDR_DETAIL,			E_DATE,					E_STAFF,
				E_TEL,					E_MEMO,					S_LAT,
				S_LON,					E_LAT,					E_LON,
				GOODS_NAME,				GOODS_WEIGHT,			WEIGHT_UNIT_CODE,
				GOODS_QTY,				QTY_UNIT_CODE,			S_WAY_CODE,
				E_WAY_CODE,				MIX_YN,					MIX_SIZE,
				RETURN_YN,				CAR_TON_CODE,			CAR_TYPE_CODE,
				CHARGE_TYPE,			DISTANCE,				[TIME],
				REQ_MEMO,				DRIVER_MEMO,			ITEM_CODE,
				REGID,					REGDATE,				CUST_ID,
				DEPT_ID,				MEMO,					UNIT_PRICE_TYPE,
				UNIT_CHARGE,			DANGER_GOODS_YN,		CHEMICALS_YN,
				FOREIGN_LICENSE_YN)
			VALUES (
				@orderId,				@reqCustId,				@reqDeptId,
				@reqStaffId,			@reqTel,				@reqAddr,
				@reqAddrDetail, 		@inOutSctn,				@truckTypeCode,
				@sComName,				@sSido,					@sGungu,
				@sDong,					@sAddr,					@sAddrDetail,
				GETDATE(),				@sStaff,				@sTel,
				@sMemo,					@eComName,				@eSido,
				@eGungu,				@eDong,					@eAddr,
				@eAddrDetail,			GETDATE(),				@eStaff,
				@eTel,					@eMemo,					ISNULL(@sLat,0),
				ISNULL(@sLon,0),		ISNULL(@eLat,0),		ISNULL(@eLon,0),
				@goodsName,				CONVERT(float,@goodsWeight) * 1000,	@weightUnitCode,
				@goodsQty,				@qtyUnitCode,			@sWayCode,
				@eWayCode,				ISNULL(@mixYn,'N'),		@mixSize,
				ISNULL(@returnYn,'N'),	@carTonCode,			@carTypeCode,
				@chargeType,			@distance,				@time,
				@reqMemo,				@driverMemo,			@itemCode,
				@loginId,				GETDATE(),				@custId,
				@deptId,				@memo,					@unitPriceType,
				@unitCharge,			ISNULL(@dangerGoodsYn,'N'),	ISNULL(@chemicalsYn,'N'),
				ISNULL(@foreignLicenseYn,'N'));
			-- 경유지 복사(20220209)
			INSERT INTO T_ORDER_STOP(
				   ORDER_ID, 			STOP_NO, 			E_COM_NAME, 
				   E_ADDR, 				E_ADDR_DETAIL, 		E_STAFF, 
				   E_TEL, 				FINISH_YN,			FINISH_DATE, 
				   GOODS_WEIGHT, 		E_LAT,				E_LON,
				   WEIGHT_UNIT_CODE, 	GOODS_QTY,			QTY_UNIT_CODE,
				   GOODS_NAME, 			USE_YN,				REGDATE,
				   REGID, 				STOP_SE)
			SELECT @orderId, 			STOP_NO, 			E_COM_NAME, 
				   E_ADDR, 				E_ADDR_DETAIL, 		E_STAFF, 
				   E_TEL, 				'N',				NULL, 
				   GOODS_WEIGHT, 		E_LAT,				E_LON,
				   WEIGHT_UNIT_CODE, 	GOODS_QTY,			QTY_UNIT_CODE,
				   GOODS_NAME, 			USE_YN,				GETDATE(),
				   @regId, 				STOP_SE 
			FROM T_ORDER_STOP 
			WHERE ORDER_ID = @oldOrderId AND USE_YN = 'Y';
		
			-- 매출처 배차 등록/수정
			EXEC UPDATE_ORDER_ALLOC @orderId, NULL, @reqCustId, @reqDeptId, @reqStaffId, @reqTel
			         			  , @custId, @deptId, @loginId, @staffTel, @sellCharge, @sellFee
			         			  , NULL, NULL, NULL, NULL, NULL
			         			  , NULL, NULL, @loginId, NULL, @sellWeight, NULL, NULL, @spId1  OUTPUT, @spMsg OUTPUT;
			
			         			 
			SELECT @sellOutAllocId = ALLOC_ID
			FROM T_ORDER_ALLOC
			WHERE ORDER_ID = @orderId AND SELL_CUST_ID = @sellCustId AND SELL_DEPT_ID = @sellDeptId;
			
			-- 추가운임 복사(20220209)
			INSERT INTO T_ORDER_ALLOC_ADD(
				   ORDER_ID,		ALLOC_ID, 				CALC_TYPE_CODE,
				   ADD_CHARGE,		MEMO,					REGDATE,
				   REGID)
			SELECT @orderId,		@sellOutAllocId,		CALC_TYPE_CODE,
				   ADD_CHARGE,		MEMO,					getdate(),
				   @regId
			FROM T_ORDER_ALLOC_ADD 
			WHERE ORDER_ID = @oldOrderId
			AND ALLOC_ID = @sellAllocId;

	    	set @retCode = @RET_OK
		    set @retMsg = '오더를 복사했습니다.'
		END
	set @retId = @orderId	
END	
GO
