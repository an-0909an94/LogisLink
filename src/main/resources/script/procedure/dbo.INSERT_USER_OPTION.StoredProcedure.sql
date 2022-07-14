USE [logislink]
GO
/****** Object:  StoredProcedure [dbo].[INSERT_USER_OPTION]    Script Date: 2022-07-14 오후 6:16:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[INSERT_USER_OPTION]
(
	@userId 		NVARCHAR(20)
  , @buyCustId		NVARCHAR(20)
  , @buyDeptId		NVARCHAR(20)
  , @reqCustId		NVARCHAR(20)
  , @reqDeptId		NVARCHAR(20)
  , @reqStaffId		NVARCHAR(20)
  , @reqAddr		NVARCHAR(50)
  , @reqAddrDetail	NVARCHAR(50)
  , @reqTel			NVARCHAR(13)
  , @reqMemo		NVARCHAR(1000)
  , @sSido			NVARCHAR(10)
  , @sGungu			NVARCHAR(20)
  , @sDong			NVARCHAR(20)
  , @sLat			DECIMAL(16,13)
  , @sLon			DECIMAL(16,12)
  , @sComName		NVARCHAR(50)
  , @sStaff			NVARCHAR(20)
  , @sAddr			NVARCHAR(50)
  , @sAddrDetail	NVARCHAR(50)
  , @sTel			NVARCHAR(13)
  , @sMemo			NVARCHAR(1000)  
  , @carTypeCode	NVARCHAR(20)
  , @carTonCode		NVARCHAR(20)
  , @goodsName		NVARCHAR(100)
  , @goodsWeight	NVARCHAR(10)
  , @inOutSctn		NVARCHAR(2)
  , @truckTypeCode	NVARCHAR(2)
  , @itemCode		NVARCHAR(10)
  , @sWayCode		NVARCHAR(20)
  , @eWayCode		NVARCHAR(20)
  , @unitPriceType	NVARCHAR(2)
  , @unitCharge		INT
  , @sellCharge		INT
  , @buyCharge		INT
  , @driverMemo		NVARCHAR(1000)
  , @retCode 		INT OUTPUT
  , @retMsg 		NVARCHAR(200) OUTPUT
)
AS 
BEGIN
	
	DECLARE @RET_OK NVARCHAR(2) = '00'		-- 성공
	DECLARE @RET_ERR NVARCHAR(2) = '99'		-- Error
	
	SELECT USER_ID
	FROM T_USER_OPTION
	WHERE USER_ID = @userId
	
	IF @@ROWCOUNT=0
		BEGIN 
			INSERT INTO T_USER_OPTION 
				(
					USER_ID								, REQ_CUST_ID							, REQ_DEPT_ID 
				  , S_COM_NAME  						, S_SIDO 								, S_GUNGU 
				  , S_DONG 								, S_ADDR 								, S_ADDR_DETAIL 
				  , S_STAFF 							, S_TEL 								, S_MEMO 
				  , S_LAT 								, S_LON 								, GOODS_NAME 
				  , GOODS_WEIGHT						, S_WAY_CODE 							, E_WAY_CODE 
				  , CAR_TON_CODE						, CAR_TYPE_CODE 						, IN_OUT_SCTN 
				  , TRUCK_TYPE_CODE						, REQ_MEMO 								, DRIVER_MEMO 
				  , ITEM_CODE 							, UNIT_PRICE_TYPE 						, UNIT_CHARGE 
				  , REGDATE 							, REGID 								, REQ_STAFF_ID 
				  , REQ_TEL 							, REQ_ADDR 								, REQ_ADDR_DETAIL 
				  , SELL_CHARGE 						, BUY_CHARGE 							, BUY_CUST_ID 
				  , BUY_DEPT_ID 						, BUY_STAFF_ID 
				)
			VALUES
				(
					@userId								, @reqCustId							, @reqDeptId
				  , @sComName							, @sSido								, @sGungu
				  , @sDong								, @sAddr								, @sAddrDetail
				  , @sStaff								, @sTel									, @sMemo
				  , ISNULL(@sLat,0)						, ISNULL(@sLon,0) 						, @goodsName  
				  , @goodsWeight						, @sWayCode 							, @eWayCode 
				  , @carTonCode							, @carTypeCode 							, @inOutSctn 
				  , @truckTypeCode  					, @reqMemo 								, @driverMemo 
				  , @itemCode 							, @unitPriceType 						, @unitCharge 
				  , GETDATE() 							, @userId 								, @reqStaffId 
				  , @reqTel 							, @reqAddr 								, @reqAddrDetail
				  , @sellCharge 						, @buyCharge 							, @buyCustId 
				  , @buyDeptId 							, @userId 
				)
		    
			set @retCode = @RET_OK
		    set @retMsg = '초기값 설정을 완료했습니다.'
		END
	ELSE
		BEGIN 
			UPDATE T_USER_OPTION 
			SET 
				USER_ID 		= @userId
			  , REQ_CUST_ID 	= @reqCustId
			  , REQ_DEPT_ID 	= @reqDeptId
			  , S_COM_NAME 		= @sComName
			  , S_SIDO 			= @sSido
			  , S_GUNGU 		= @sGungu
			  , S_DONG 			= @sDong
			  , S_ADDR 			= @sAddr
			  , S_ADDR_DETAIL 	= @sAddrDetail
			  , S_STAFF 		= @sStaff
			  , S_TEL 			= @sTel
			  , S_MEMO 			= @sMemo
			  , S_LAT 			= ISNULL(@sLat,0)
			  , S_LON 			= ISNULL(@sLon,0)
			  , GOODS_NAME 		= @goodsName
			  , GOODS_WEIGHT 	= @goodsWeight
			  , S_WAY_CODE 		= @sWayCode
			  , E_WAY_CODE 		= @eWayCode
			  , CAR_TON_CODE 	= @carTonCode
			  , CAR_TYPE_CODE 	= @carTypeCode
			  , IN_OUT_SCTN 	= @inOutSctn
			  , TRUCK_TYPE_CODE = @truckTypeCode
			  , REQ_MEMO 		= @reqMemo
			  , DRIVER_MEMO 	= @driverMemo
			  , ITEM_CODE 		= @itemCode
			  , UNIT_PRICE_TYPE = @unitPriceType
			  , UNIT_CHARGE 	= @unitCharge
			  , EDITDATE 		= GETDATE()
			  , EDITID 			= @userId
			  , REQ_STAFF_ID 	= @reqStaffId
			  , REQ_TEL 		= @reqTel
			  , REQ_ADDR 		= @reqAddr
			  , REQ_ADDR_DETAIL = @reqAddrDetail
			  , SELL_CHARGE 	= @sellCharge
			  , BUY_CHARGE 		= @buyCharge
			  , BUY_CUST_ID 	= @buyCustId
			  , BUY_DEPT_ID 	= @buyDeptId
			  , BUY_STAFF_ID	= @userId
			WHERE USER_ID = @userId
			AND BUY_CUST_ID = @buyCustId
			AND BUY_DEPT_ID = @buyDeptId
		    
			set @retCode = @RET_OK
		    set @retMsg = '초기값 수정을 완료했습니다.'
		END
END
GO
