USE [logislink]
GO
/****** Object:  StoredProcedure [dbo].[APP_TAX_INVOICE_INSERT_20220331]    Script Date: 2022-07-14 오후 6:16:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[APP_TAX_INVOICE_INSERT_20220331]
(
	  @orderId			NVARCHAR(20)
	, @allocId			NVARCHAR(20)   
	, @billKind         NVARCHAR(1)
    , @docAttr          NVARCHAR(1)
    , @docClass         NVARCHAR(2)
    , @docType          NVARCHAR(2)
    , @pubType          NVARCHAR(1)
    , @pubForm          NVARCHAR(2)
    , @writeDate		NVARCHAR(8)
    , @supplierVehicId  NVARCHAR(20)
    , @supplierDriverId NVARCHAR(20)  
    , @brokerCustId		NVARCHAR(20)
    , @brokerDeptId		NVARCHAR(20)
    , @brokerBizNo		NVARCHAR(13)
    , @brokerBizType	NVARCHAR(40)
    , @brokerBizName	NVARCHAR(70)
    , @brokerBizClass	NVARCHAR(40)
    , @brokerBizSubNo	NVARCHAR(4)
    , @brokerCeo		NVARCHAR(30)
    , @brokerMemDept	NVARCHAR(40)
    , @brokerMemName	NVARCHAR(30)
    , @brokerMemEmail	NVARCHAR(40)
    , @brokerMemTel		NVARCHAR(20)
    , @brokerAddr		NVARCHAR(150)
    , @regId            NVARCHAR(20)
    , @retCode		    NVARCHAR(2)		OUTPUT
    , @retMsg		    NVARCHAR(200)	OUTPUT
    , @invId            NVARCHAR(20)    OUTPUT
)
AS
BEGIN
	
	DECLARE @RET_OK NVARCHAR(2) = '00'		-- 성공
	DECLARE @RET_ERR NVARCHAR(2) = '99'		-- Error
	DECLARE @timestamp	NVARCHAR(14) = ''
    DECLARE @taxsNum    NVARCHAR(24) = ''
    DECLARE @issueId    NVARCHAR(24) = ''
    DECLARE @issueDate  NVARCHAR(14) = ''
    DECLARE @regDate    DATETIME
	
	DECLARE @seq		INT
	
	DECLARE @supplierBizName  NVARCHAR(70)
    DECLARE @supplierBizNo    NVARCHAR(13)
    DECLARE @supplierBizSubNo NVARCHAR(4)
    DECLARE @supplierCeo      NVARCHAR(30)
    DECLARE @supplierAddr     NVARCHAR(150)
    DECLARE @supplierBizType  NVARCHAR(40)
    DECLARE @supplierBizClass NVARCHAR(40)
    DECLARE @supplierMemName  NVARCHAR(30)
    DECLARE @supplierMemTel   NVARCHAR(20)
    DECLARE @supplierMemEmail NVARCHAR(40)
    
    DECLARE @buyerCustId      NVARCHAR(20)
    DECLARE @buyerDeptId      NVARCHAR(20) 
    DECLARE @buyerMemName     NVARCHAR(30)
    DECLARE @buyerMemTel      NVARCHAR(20)
    DECLARE @buyerMemEmail    NVARCHAR(40)
    DECLARE @buyerBizName     NVARCHAR(70)
    DECLARE @buyerBizNo       NVARCHAR(13)
    DECLARE @buyerBizSubNo    NVARCHAR(4)
    DECLARE @buyerCeo         NVARCHAR(30)
    DECLARE @buyerAddr        NVARCHAR(150)
    DECLARE @buyerBizType     NVARCHAR(40)
    DECLARE @buyerBizClass    NVARCHAR(40)
    DECLARE @buyerBizNoType   NVARCHAR(2)
    
    DECLARE @supprice         NUMERIC
    DECLARE @tax              NUMERIC
    DECLARE @totPrice         NUMERIC
    DECLARE @remark           NVARCHAR(150)
    DECLARE @loadStatus       NVARCHAR(3)
    
    /* carNum bankCode bankAccount bankCnnm 변수 선언 2022-01-03 */
    DECLARE @carNum           NVARCHAR(10)
    DECLARE @bankCode         NVARCHAR(5)
    DECLARE @bankAccount      NVARCHAR(30)
    DECLARE @bankCnnm         NVARCHAR(20)
    DECLARE @eDate			  NVARCHAR(10)
    DECLARE @reqPayYn		  NVARCHAR(1)
    
    DECLARE @monitorSeq			INT
    
	DECLARE @newCalcId		NVARCHAR(20)
	DECLARE @calcAmt		INT
			
    SET @regDate = getDate()
    SET @timestamp = convert(varchar, @regDate, 112) + replace(convert(varchar, @regDate, 108), ':', '')
    SELECT @seq = NEXT VALUE FOR SEQ_TAX_INVOICE;
    SET @invId = 'I' + @timestamp + FORMAT(CONVERT(int, RIGHT(@seq, 3)), '000')
    SET @taxsNum = @writeDate + '41000008fux' + FORMAT(CONVERT(int, RIGHT(@seq, 5)), '00000') --real
    SET @issueDate = @timestamp
    SET @issueId = @taxsNum
    
    SELECT @buyerCustId = SELL_CUST_ID, @buyerDeptId = SELL_DEPT_ID, @buyerMemTel = SELL_STAFF_TEL, @buyerMemName = B.USER_NAME,
    	   @buyerMemEmail = B.EMAIL, @eDate = CONVERT(CHAR(10), C.E_DATE, 111), @reqPayYn = A.REQ_PAY_YN 
    FROM T_ORDER_ALLOC A 
    	 INNER JOIN
    	 T_USER B ON A.SELL_STAFF_ID = B.USER_ID
    	 INNER JOIN 
    	 T_ORDER C ON A.ORDER_ID = C.ORDER_ID 
    WHERE A.ORDER_ID = @orderId AND ALLOC_ID = @allocId AND DRIVER_ID = @supplierDriverId AND VEHIC_ID = @supplierVehicId
    
    IF @@ROWCOUNT = 0 
    BEGIN 	    
	    set @retCode = @RET_ERR;
	    set @retMsg = '잘못된 오더 정보입니다.';
    END
    ELSE 
    BEGIN 
		BEGIN TRY     
		    /* carNum bankCode bankAccount bankCnnm 변수 세팅 2022-01-03 */
		    SELECT 	@supplierBizName = ISNULL(A.BIZ_NAME, ''), @supplierBizNo = ISNULL(A.BIZ_NUM, ''), @supplierCeo = ISNULL(A.CEO, ''),  
		    		@supplierAddr = A.BIZ_ADDR + ' ' + A.BIZ_ADDR_DETAIL, @supplierBizType = A.BIZ_COND,
		    		@supplierBizClass = A.BIZ_KIND, @supplierMemName = B.DRIVER_NAME, @supplierMemTel = B.MOBILE, @supplierMemEmail = B.DRIVER_EMAIL, 
		    		@carNum = A.CAR_NUM, @bankCode = B.BANK_CODE, @bankAccount = B.BANK_ACCOUNT, @bankCnnm = B.BANK_CNNM
		    FROM 
		    	(
		    		SELECT BIZ_NAME, BIZ_NUM, CEO, BIZ_ADDR, BIZ_ADDR_DETAIL, BIZ_COND, BIZ_KIND, SUB_BIZ_NUM, DRIVER_ID, CAR_NUM
		    		FROM T_VEHIC_MST 
		    		WHERE VEHIC_ID = @supplierVehicId AND DRIVER_ID = @supplierDriverId
		    	) A
		    	 INNER JOIN 
		    	 T_DRIVER B ON A.DRIVER_ID = B.DRIVER_ID ;
		    	
		    
		    SELECT @buyerBizName = ISNULL(BIZ_NAME, ''), @buyerBizNo = ISNULL(BIZ_NUM, ''), @buyerBizSubNo = BIZ_NUM_SUB, @buyerCeo = ISNULL(CEO, ''),
	   				@buyerAddr = BIZ_ADDR + ' ' + BIZ_ADDR_DETAIL, @buyerBizType = BIZ_COND, @buyerBizClass = BIZ_KIND,
	   				@buyerBizNoType = BIZ_TYPE_CODE 
		    FROM T_CUST_MST 
		    WHERE CUST_ID = @buyerCustId
		     
		    IF @supplierBizName = '' OR  @supplierBizNo = '' OR @supplierCeo = '' OR @supplierAddr = ''
		    BEGIN 
				THROW 50001, '공급자의 사업자 정보가 누락되었습니다.', 1    
		    END
			
		    IF ISNULL(@buyerBizName, '') = '' OR ISNULL(@buyerBizNo, '') = '' OR ISNULL(@buyerCeo, '') = '' OR ISNULL(@buyerAddr, '') = ''
		    BEGIN
				THROW 50001, '공급받는자의 사업자 번호가 누락되었습니다.', 1
		    END
		    
		    SELECT @supprice = SUM(ISNULL(PAYABLE_AMT,0)) + SUM(ISNULL(WITHDRAWAL_AMT,0)) 
		    FROM T_CALC 
		    WHERE ALLOC_ID = @allocId AND SELL_BUY_SCTN = '02' 
		    	AND USE_YN = 'Y' AND VEHIC_ID = @supplierVehicId AND DRIVER_ID = @supplierDriverId
		    
		    -- 빠른지급 신청된 경우 서비스 수수료 확인(2022.01.05)
		    IF @reqPayYn = 'Y'
		    BEGIN
				IF NOT EXISTS (
					SELECT CALC_ID 
					FROM T_CALC 
					WHERE ORDER_ID = @orderId AND ALLOC_ID = @allocId AND CALC_TYPE_CODE = '0901' AND USE_YN = 'Y'
						AND ISNULL(PAYABLE_AMT, '0') != 0 AND PAYABLE_AMT != ''
				)
				BEGIN 					
					SELECT @seq = NEXT VALUE FOR SEQ_CALC;
					SET @newCalcId = 'C' + @timestamp + RIGHT('00' + @seq, 3);
					
					-- 서비스 수수료 계산
					SELECT @calcAmt = FLOOR(CONVERT(FLOAT, FEE) * @supprice / 100) 
					FROM T_CUST_FEE 
					WHERE CUST_ID = @buyerCustId AND S_DATE < GETDATE() AND ISNULL(E_DATE, GETDATE()) >= GETDATE();
					
					-- 정산 등록
					INSERT INTO T_CALC 
							   (CALC_ID, ALLOC_ID, ORDER_ID, CALC_TYPE_CODE, SELL_BUY_SCTN,
							    PAYABLE_AMT, CALC_STATE, FINISH_YN,	MNG_CUST_ID, MNG_DEPT_ID, 
							    REGDATE, REGID,	VEHIC_ID, DRIVER_ID, USE_YN)
					VALUES (@newCalcId, @allocId, @orderId, '0901', '02',
							@calcAmt * (-1), '00', 'N', @buyerCustId, @buyerDeptId, 
							GETDATE(), @supplierDriverId, @supplierVehicId, @supplierDriverId, 'Y');
						
					set @supprice = @supprice - @calcAmt
				END
				
			END 
		    
		    
		   
		    SET @tax = FLOOR(@supprice * 0.1) 	--소숫점 버림
		    SET @totPrice = @supprice + @tax
		    
		    	
		    /* 비고 요청 형식에 따라 수정 2022-01-03 */
		    INSERT INTO T_TAX_INVOICE (
		        INV_ID, BILL_KIND, DOC_ATTR, PUBTYPE, 
		        ISSUE_DATE, ISSUE_ID, DOC_CLASS, DOC_TYPE, 
		        REMARKS, 
		        REMARKS2, REMARKS3, WRITE_DATE, 
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
		        LOADSTATUS, SMS, REGDATE, REG_ID, MNG_DRIVER_ID, MNG_VEHIC_ID
		    ) VALUES (
		        @invId, CONVERT(numeric, @billKind), @docAttr, @pubType, 
		        @issueDate, @issueId, @docClass, @docType,
		        (SELECT CNAME FROM T_CODE WHERE GCODE = 'BANK_CD' AND CODE = @bankCode) + ' ' + @bankAccount + ' ' + @bankCnnm + ' ' + @carNum, 
		        NULL, NULL, @writeDate,
		        NULL, @pubForm, NULL, NULL,
		        NULL, @supplierBizNo, @supplierBizType, @supplierBizName,
		        @supplierBizClass, @supplierBizSubNo, @supplierCeo, NULL,
		        @supplierMemName, @supplierMemTel, @supplierMemEmail,
		        @supplierAddr, @supplierVehicId, @supplierDriverId,
		        @buyerCustId, @buyerDeptId, @buyerBizNo, @buyerBizType,
		        @buyerBizName, @buyerBizClass, @buyerBizSubNo, @buyerBizNoType,
		        @buyerCeo, NULL, @buyerMemName, @buyerMemTel,
		        @buyerMemEmail, @buyerAddr, @brokerCustId, @brokerDeptId,
		        @brokerBizNo, @brokerBizType, @brokerBizName, @brokerBizClass,
		        @brokerBizSubNo, @brokerCeo, @brokerMemDept, @brokerMemName,
		        @brokerMemEmail, @brokerMemTel, @brokerAddr,
		        0, 0, 0, 0, @supprice, @tax, @totPrice,
		        @loadStatus, NULL, @regDate, @regId, @supplierDriverId, @supplierVehicId
		    )
			
		    
		    /* 비고, 품목, 요청 형식에 따라 수정 2022-01-03 */
			INSERT INTO 
					T_TAX_ITEM 
					(
						  INV_ID
						, SEQ
						, ITEM_REMARKS
						, ITEM_SUPPRICE
						, ITEM_QTY    
						, ITEM_NAME   
						, ITEM_DATE    
						, ITEM_TAX     
						, ITEM_PRICE
						, ORDER_ID
						, ALLOC_ID
					)
			VALUES		
					(
							  @invId
							, 1
							, @eDate + ' (' +@orderId+ ')'
							, @supprice
							, 1
							, CASE WHEN @reqPayYn = 'Y' THEN '(빠른지급)운송료' ELSE '운송료' END
							, @writeDate
							, @tax
							, @supprice
							, @orderId
							, @allocId
					)		
				
			-- 세금계산서 발행 요청 상태로 변경
			UPDATE T_CALC SET TAXINV_YN = 'R'
		    WHERE ALLOC_ID = @allocId AND SELL_BUY_SCTN = '02' 
		    	AND USE_YN = 'Y' AND VEHIC_ID = @supplierVehicId AND DRIVER_ID = @supplierDriverId
	    	
		 
		    set @retCode = @RET_OK
		    set @retMsg = '세금계산서가 저장되었습니다.'
		END TRY
		BEGIN CATCH		
			IF CAST(ERROR_NUMBER() AS VARCHAR(10)) = '50001' 
			BEGIN 				
			    set @retCode = @RET_ERR
			    set @retMsg = ERROR_MESSAGE()
			END 
			ELSE
			BEGIN
			    set @retCode = @RET_ERR
			    set @retMsg = '오류가 발생했습니다. 관리자에게 문의하세요.'		
			END
		
		END CATCH
    END
    
END
GO
