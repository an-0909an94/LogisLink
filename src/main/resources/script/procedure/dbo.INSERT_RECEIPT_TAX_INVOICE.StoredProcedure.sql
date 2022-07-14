USE [logislink]
GO
/****** Object:  StoredProcedure [dbo].[INSERT_RECEIPT_TAX_INVOICE]    Script Date: 2022-07-14 오후 6:16:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[INSERT_RECEIPT_TAX_INVOICE]
(
    @loginCustId		NVARCHAR(20)
  , @loginDeptId		NVARCHAR(20)
  , @receiptId			NVARCHAR(20)
  , @docType          	NVARCHAR(2)
  , @pubForm          	NVARCHAR(2)
  , @billKind         	NVARCHAR(1)
  , @supplierMemName  	NVARCHAR(30)
  , @supplierMemTel   	NVARCHAR(20)
  , @supplierMemEmail 	NVARCHAR(40)
  , @buyerMemName   	NVARCHAR(30)
  , @buyerMemTel    	NVARCHAR(20)
  , @buyerMemEmail 		NVARCHAR(40)
  , @brokerCustId		NVARCHAR(20)
  , @brokerDeptId		NVARCHAR(20)
  , @brokerBizNo		NVARCHAR(13)
  , @brokerBizType		NVARCHAR(40)
  , @brokerBizName		NVARCHAR(70)
  , @brokerBizClass		NVARCHAR(40)
  , @brokerBizSubNo		NVARCHAR(4)
  , @brokerCeo			NVARCHAR(30)
  , @brokerMemDept		NVARCHAR(40)
  , @brokerMemName		NVARCHAR(30)
  , @brokerMemEmail		NVARCHAR(40)
  , @brokerMemTel		NVARCHAR(20)
  , @brokerAddr			NVARCHAR(150)
  , @writeDate      	NVARCHAR(20)
  , @remark         	NVARCHAR(150)
  , @itemTotalType		NVARCHAR(1)				-- 0: 단건, 1: 다중
  , @regId				NVARCHAR(20)
  , @retCode			NVARCHAR(2)		OUTPUT
  , @retMsg				NVARCHAR(200)	OUTPUT
)
AS
BEGIN
	
	DECLARE @RET_OK 	NVARCHAR(2) = '00'		-- 성공
	DECLARE @RET_ERR 	NVARCHAR(2) = '99'		-- Error
	DECLARE @invId		NVARCHAR(20)
	DECLARE @timestamp	NVARCHAR(14) = ''
    DECLARE @taxsNum    NVARCHAR(24) = ''
    DECLARE @issueId    NVARCHAR(24) = ''
    DECLARE @issueDate  NVARCHAR(14) = ''
    DECLARE @regDate    NVARCHAR(8) = CONVERT(VARCHAR, GETDATE(), 112)
    
	DECLARE @seq		INT
	
	SET @timestamp = convert(varchar, @regDate, 112) + replace(convert(varchar, @regDate, 108), ':', '')
    SELECT @seq = NEXT VALUE FOR SEQ_TAX_INVOICE;
    SET @invId = 'I' + @timestamp + FORMAT(CONVERT(int, RIGHT(@seq, 3)), '000')
    SET @taxsNum = @regDate + '41000008fux' + FORMAT(CONVERT(int, RIGHT(@seq, 5)), '00000') --real
    SET @issueDate = @timestamp
    SET @issueId = @taxsNum
    
    IF ISNULL(@writeDate,'') = ''
    BEGIN 
	    SELECT TOP(1) @writeDate = CONVERT(VARCHAR, S_DATE,112)
		FROM T_TRAN_RECEIPT_DTL A 
		INNER JOIN 
		T_ORDER B ON A.ORDER_ID = B.ORDER_ID 
		WHERE RECEIPT_ID = @receiptId
		ORDER BY REPLACE(CONVERT(VARCHAR, S_DATE, 111),'/','') DESC
    END
    
	INSERT INTO T_TAX_INVOICE (
	        INV_ID, BILL_KIND, DOC_ATTR, PUBTYPE, 
	        ISSUE_DATE, ISSUE_ID, DOC_CLASS, DOC_TYPE, 
	        REMARKS, REMARKS2, REMARKS3, WRITE_DATE, 
	        AMENDMENT, PUBFORM, ORI_ISSUE_ID, SUPPLIER_CUST_ID, 
	        SUPPLIER_DEPT_ID, SUPPLIER_BIZ_NO, SUPPLIER_BIZ_TYPE, SUPPLIER_BIZ_NAME, 
	        SUPPLIER_BIZ_CLASS, SUPPLIER_BIZ_SUBNO, SUPPLIER_CEO, SUPPLIER_MEM_DEPT, 
	        SUPPLIER_MEM_NAME, SUPPLIER_MEM_TEL, SUPPLIER_MEM_EMAIL, 
	        SUPPLIER_ADDR, SUPPLIER_VEHIC_ID, SUPPLIER_DRIVER_ID, 
	        BUYER_CUST_ID, BUYER_DEPT_ID, BUYER_BIZ_NO, BUYER_BIZ_TYPE, 
	        BUYER_BIZ_NAME, BUYER_BIZ_CLASS, BUYER_BIZ_SUBNO, BUYER_BIZ_NO_TYPE, 
	        BUYER_CEO, BUYER_MEM_DEPT, BUYER_MEM_NAME, BUYER_MEM_TEL, 
	        BUYER_MEM_EMAIL, BUYER_ADDR, BROKER_CUST_ID, BROKER_DEPT_ID, 
	        BROKER_BIZ_NO, BROKER_BIZ_TYPE, BROKER_BIZ_NAME, BROKER_BIZ_CLASS, 
			BROKER_BIZ_SUBNO, BROKER_CEO, BROKER_MEM_DEPT, BROKER_MEM_NAME, 
	        BROKER_MEM_EMAIL, BROKER_MEM_TEL, BROKER_ADDR, 
	        CASH, CHEQUE, BILL, OUTSTAND, SUPPRICE, TAX, TOT_PRICE, 
	        LOADSTATUS, SMS, REGDATE, REG_ID, MNG_CUST_ID, MNG_DEPT_ID, RECEIPT_ID)
	SELECT 
			@invId, CONVERT(numeric, @billKind), 'N', 'S',
	        @issueDate, @issueId, '01', @docType,
	        @remark, NULL, NULL, @writeDate,
	        NULL, @pubForm, NULL, FR_CUST_ID,
	        FR_DEPT_ID, FR_BIZ_NUM, FR_BIZ_COND, FR_BIZ_NAME,
	        FR_BIZ_KIND, FR_BIZ_NUM_SUB, FR_CEO, NULL,
	        @supplierMemName, @supplierMemTel, @supplierMemEmail,
	        FR_ADDR, FR_VEHIC_ID, FR_DRIVER_ID,
	        TO_CUST_ID, TO_DEPT_ID, TO_BIZ_NUM,  TO_BIZ_COND,
	        TO_BIZ_NAME, TO_BIZ_KIND, TO_BIZ_NUM_SUB, '01',
	        TO_CEO, NULL, @buyerMemName, @buyerMemTel,
	        @buyerMemEmail, TO_ADDR, @brokerCustId, @brokerDeptId,
	        @brokerBizNo, @brokerBizType, @brokerBizName, @brokerBizClass,
	        @brokerBizSubNo, @brokerCeo, @brokerMemDept, @brokerMemName,
	        @brokerMemEmail, @brokerMemTel, @brokerAddr,
	        0, 0, 0, 0, CONVERT(numeric, CHARGE), CONVERT(numeric, VAT), CONVERT(numeric, AMT),
	        '0' , NULL, GETDATE(), @regId, @loginCustId, @loginDeptId, @receiptId
	FROM T_TRAN_RECEIPT 
	WHERE RECEIPT_ID = @receiptId;
	   
	
	IF @itemTotalType = '1'
	BEGIN 
		
		INSERT INTO 
						T_TAX_ITEM 
						(
							  INV_ID
							, SEQ
							, ITEM_REMARKS
							, ITEM_SUPPRICE
							, ITEM_QTY     
							, ITEM_TYPE    
							, ITEM_NAME   
							, ITEM_DATE    
							, ITEM_TAX     
							, ITEM_PRICE
							, ORDER_ID
							, ALLOC_ID
						)
		SELECT
				@invId
			  , (ROW_NUMBER() OVER(ORDER BY RECEIPT_SEQ ASC)) SEQ
			  , CONVERT(CHAR(10), B.E_DATE, 111) + ' (' + A.ORDER_ID + ')'
			  , A.ALLOC_CHARGE
			  , 1
			  , 0
			  ,'운송료(' + B.S_SIDO + ' ' + B.S_GUNGU + '→' + B.E_SIDO + ' ' + B.E_GUNGU + ')'
			  , @writeDate
			  , A.ALLOC_VAT
			  , A.ALLOC_AMT
			  , A.ORDER_ID 
			  , A.ALLOC_ID
		FROM 
				T_TRAN_RECEIPT_DTL A 
				INNER JOIN
				T_ORDER B ON A.ORDER_ID = B.ORDER_ID
		WHERE 
				RECEIPT_ID = @receiptId
				
	    set @retCode = @RET_OK
	    set @retMsg = '세금계산서가 발행되었습니다.'
	END
	ELSE 
	BEGIN 
		INSERT INTO 
						T_TAX_ITEM 
						(
							  INV_ID
							, SEQ
							, ITEM_REMARKS
							, ITEM_SUPPRICE
							, ITEM_QTY     
							, ITEM_TYPE    
							, ITEM_NAME   
							, ITEM_DATE    
							, ITEM_TAX     
							, ITEM_PRICE
							, ORDER_ID
							, ALLOC_ID
						)
		SELECT
				@invId
			  , 1
			  , CONVERT(CHAR(10), C.E_DATE, 111) + ' (' + B.ORDER_ID + ')'
			  , SUM(A.ALLOC_CHARGE)
			  , COUNT(1)
			  , 0
			  , '운송료(' + C.S_SIDO + ' ' + C.S_GUNGU + '→' + C.E_SIDO + ' ' + C.E_GUNGU + ' 외 ' + CONVERT(VARCHAR(8), (COUNT(1) - 1)) + '건)'
			  , @writeDate
			  , SUM(A.ALLOC_VAT)
			  , SUM(A.ALLOC_AMT)
			  , B.ORDER_ID 
			  , B.ALLOC_ID
		
		FROM T_TRAN_RECEIPT_DTL A
			 INNER JOIN
			(SELECT TOP 1 RECEIPT_ID, ORDER_ID, ALLOC_ID 
			 FROM T_TRAN_RECEIPT_DTL 
			 WHERE RECEIPT_ID = @receiptId
			 ORDER BY RECEIPT_SEQ DESC ) B ON A.RECEIPT_ID = B.RECEIPT_ID
			 INNER JOIN
			 T_ORDER C ON B.ORDER_ID = C.ORDER_ID
		GROUP BY B.ORDER_ID, B.ALLOC_ID, C.E_DATE, C.S_SIDO, C.S_GUNGU, C.E_SIDO, C.E_GUNGU
				
	    set @retCode = @RET_OK
	    set @retMsg = '세금계산서가 발행되었습니다.'
	END
END
GO
