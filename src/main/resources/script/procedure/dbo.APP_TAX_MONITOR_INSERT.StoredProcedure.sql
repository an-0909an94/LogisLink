USE [logislink]
GO
/****** Object:  StoredProcedure [dbo].[APP_TAX_MONITOR_INSERT]    Script Date: 2022-07-14 오후 6:16:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[APP_TAX_MONITOR_INSERT]
(
	  @invId			NVARCHAR(20)
    , @vehicId  		NVARCHAR(20)
    , @driverId 		NVARCHAR(20)
    , @retCode		    NVARCHAR(2)		OUTPUT
    , @retMsg		    NVARCHAR(200)	OUTPUT
)
AS 
BEGIN
	
	DECLARE @RET_OK NVARCHAR(2) = '00'		-- 성공
	DECLARE @RET_ERR NVARCHAR(2) = '99'		-- Error
    DECLARE @monitorSeq			INT
    DECLARE @mesgId		NVARCHAR(36)
    
    DECLARE @orderId	NVARCHAR(20)
    DECLARE @allocId	NVARCHAR(20)
    
				
	SELECT @monitorSeq = NEXT VALUE FOR SEQ_TAX_INVOICE
	SELECT @mesgId = 'LOGISLINK_' + convert(varchar, getdate(), 112) + replace(convert(varchar, getdate(), 108), ':', '') + FORMAT(CONVERT(int, RIGHT(@monitorSeq, 4)), '0000')
	
	
	INSERT INTO T_TAX_MONITOR 
				(
					INV_ID			, MESG_ID		, SIGNAL		, SUPPLIER_CUST_ID	, SUPPLIER_BIZ_NO 
				  ,	BUYER_CUST_ID	, BUYER_BIZ_NO	, CONVER_ID		, MODULE			, RESULT		
				  , STATUS			, REGDATE		, PUB_DATE
				)
	SELECT			
					INV_ID		  	, @mesgId		, 'ARISSUE'		, SUPPLIER_DRIVER_ID, SUPPLIER_BIZ_NO 
				  , BUYER_CUST_ID 	, BUYER_BIZ_NO 	
				  , SUPPLIER_BIZ_NO + BUYER_BIZ_NO + convert(varchar, getdate(), 112) + FORMAT(CONVERT(int, RIGHT(@monitorSeq, 4)), '0000') + '006'
				  , 'L'			  	, 'N'
				  , NULL			, getdate()  	, NULL
	FROM
				T_TAX_INVOICE 
	WHERE 	
				INV_ID = @invId AND SUPPLIER_DRIVER_ID = @driverId AND SUPPLIER_VEHIC_ID = @vehicId
		
	--세금계산서 발행상태 변경			
	UPDATE T_TAX_INVOICE SET LOADSTATUS = '1'
	WHERE INV_ID = @invId 
	
	
	-- 세금계산서 발행 요청 후, 기사에게 알림톡 전송
	SELECT @orderId = ORDER_ID, @allocId = ALLOC_ID 
	FROM T_TAX_ITEM
	WHERE INV_ID = @invId
	
	EXEC INSERT_SMS_SEND 'TAXOK', @orderId, @allocId, '', '', '00000000000000';
		
	
	IF @@ROWCOUNT = 0
	BEGIN 
	    set @retCode = @RET_ERR
	    set @retMsg = '유효하지 않은 계산서입니다.'
	END
	ELSE 
	BEGIN 
	    set @retCode = @RET_OK
	    set @retMsg = '세금계산서 발행 요청하였습니다.'
	END
			
END
GO
