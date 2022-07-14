USE [logislink]
GO
/****** Object:  StoredProcedure [dbo].[OMS_INSERT_USER_OPTION]    Script Date: 2022-07-14 오후 6:16:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[OMS_INSERT_USER_OPTION]
(
	@userId 		NVARCHAR(20)
  , @userCustId		NVARCHAR(20)
  , @userDeptId		NVARCHAR(20)
  , @buyCustId		NVARCHAR(20)
  , @buyDeptId		NVARCHAR(20)
  , @buyStaffId		NVARCHAR(20)
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
	AND REQ_CUST_ID = @userCustId
	AND REQ_DEPT_ID = @userDeptId;
	
	IF @@ROWCOUNT=0
		BEGIN 
			INSERT INTO T_USER_OPTION 
				(
					USER_ID								, REQ_CUST_ID							, REQ_DEPT_ID 
				  , BUY_CUST_ID							, BUY_DEPT_ID							, BUY_STAFF_ID
				  , REQ_MEMO							, S_SIDO 								, S_GUNGU 
				  , S_DONG 								, S_LAT 								, S_LON 
				  , S_COM_NAME 							, S_STAFF 								, S_ADDR 
				  , S_ADDR_DETAIL 						, S_TEL 								, S_MEMO 
				  , CAR_TYPE_CODE 						, CAR_TON_CODE 							, GOODS_NAME 
				  , GOODS_WEIGHT 						, IN_OUT_SCTN 							, TRUCK_TYPE_CODE 
				  , ITEM_CODE 							, S_WAY_CODE 							, E_WAY_CODE 
				  , BUY_CHARGE 							, DRIVER_MEMO
				)
			VALUES
				(
					@userId								, @userCustId							, @userDeptId
				  , @buyCustId							, @buyDeptId							, @buyStaffId
				  , @reqMemo							, @sSido								, @sGungu
				  , @sDong								, ISNULL(@sLat,0)						, ISNULL(@sLon,0)
				  , @sComName							, @sStaff								, @sAddr
				  , @sAddrDetail						, @sTel									, @sMemo
				  , @carTypeCode						, @carTonCode							, @goodsName
				  , @goodsWeight						, @inOutSctn 							, @truckTypeCode
				  , @itemCode							, @sWayCode								, @eWayCode
				  , @buyCharge							, @driverMemo
				)
		    
			set @retCode = @RET_OK
		    set @retMsg = '초기값 설정을 완료했습니다.'
		END
	ELSE
		BEGIN 
			UPDATE T_USER_OPTION 
			SET 
				USER_ID 			= @userId
			  , REQ_CUST_ID 		= @userCustId
			  , REQ_DEPT_ID 		= @userDeptId
			  , BUY_CUST_ID  		= @buyCustId
			  , BUY_DEPT_ID  		= @buyDeptId
			  , BUY_STAFF_ID 		= @buyStaffId
			  , REQ_MEMO  			= @reqMemo
			  , S_SIDO  			= @sSido
			  , S_GUNGU  			= @sGungu
			  , S_DONG  			= @sDong
			  , S_LAT 				= ISNULL(@sLat,0)
			  , S_LON 				= ISNULL(@sLon,0)
			  , S_COM_NAME  		= @sComName
			  , S_STAFF  			= @sStaff
			  , S_ADDR  			= @sAddr
			  , S_ADDR_DETAIL  		= @sAddrDetail
			  , S_TEL  				= @sTel
			  , S_MEMO  			= @sMemo
			  , CAR_TYPE_CODE  		= @carTypeCode
			  , CAR_TON_CODE  		= @carTonCode
			  , GOODS_NAME  		= @goodsName
			  , GOODS_WEIGHT  		= @goodsWeight
			  , IN_OUT_SCTN  		= @inOutSctn
			  , TRUCK_TYPE_CODE  	= @truckTypeCode
			  , ITEM_CODE  			= @itemCode
			  , S_WAY_CODE  		= @sWayCode
			  , E_WAY_CODE  		= @eWayCode
			  , BUY_CHARGE  		= @buyCharge
			  , DRIVER_MEMO 		= @driverMemo
			WHERE USER_ID = @userId
			AND REQ_CUST_ID = @userCustId
			AND REQ_DEPT_ID = @userDeptId
		    
			set @retCode = @RET_OK
		    set @retMsg = '초기값 수정을 완료했습니다.'
		END
END
GO
