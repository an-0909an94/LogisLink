USE [logislink]
GO
/****** Object:  StoredProcedure [dbo].[INSERT_TAX_INVOICE]    Script Date: 2022-07-14 오후 6:16:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[INSERT_TAX_INVOICE]
(
	  @billKind         NVARCHAR(1)
    , @docAttr          NVARCHAR(1)
    , @docClass         NVARCHAR(2)
    , @docType          NVARCHAR(2)
    , @pubType          NVARCHAR(1)
    , @pubForm          NVARCHAR(2)
    , @supplierCustId   NVARCHAR(20)
    , @supplierDeptId   NVARCHAR(20)
    , @supplierVehicId  NVARCHAR(20)
    , @supplierDriverId NVARCHAR(20)
    , @supplierBizName  NVARCHAR(70)
    , @supplierBizNo    NVARCHAR(13)
    , @supplierBizSubNo NVARCHAR(4)
    , @supplierCeo      NVARCHAR(30)
    , @supplierAddr     NVARCHAR(150)
    , @supplierBizType  NVARCHAR(40)
    , @supplierBizClass NVARCHAR(40)
    , @supplierMemName  NVARCHAR(30)
    , @supplierMemTel   NVARCHAR(20)
    , @supplierMemEmail NVARCHAR(40)
    , @buyerCustId      NVARCHAR(20)
    , @buyerDeptId      NVARCHAR(20)
    , @buyerBizName     NVARCHAR(70)
    , @buyerBizNo       NVARCHAR(13)
    , @buyerBizSubNo    NVARCHAR(4)
    , @buyerCeo         NVARCHAR(30)
    , @buyerAddr        NVARCHAR(150)
    , @buyerBizType     NVARCHAR(40)
    , @buyerBizClass    NVARCHAR(40)
    , @buyerBizNoType   NVARCHAR(2)
    , @buyerMemName     NVARCHAR(30)
    , @buyerMemTel      NVARCHAR(20)
    , @buyerMemEmail    NVARCHAR(40)
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
    , @writeDate        NVARCHAR(8)
    , @supprice         NVARCHAR(18)
    , @tax              NVARCHAR(18)
    , @totPrice         NVARCHAR(18)
    , @remark           NVARCHAR(150)
    , @loadStatus       NVARCHAR(3)
    , @mngCustId		NVARCHAR(20)
    , @mngDeptId		NVARCHAR(20)
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
			
    SET @regDate = getDate()
    SET @timestamp = convert(varchar, @regDate, 112) + replace(convert(varchar, @regDate, 108), ':', '')
    SELECT @seq = NEXT VALUE FOR SEQ_TAX_INVOICE;
    SET @invId = 'I' + @timestamp + FORMAT(CONVERT(int, RIGHT(@seq, 3)), '000')
    --SET @taxsNum = @writeDate + '41000008uwh' + FORMAT(CONVERT(int, RIGHT(@seq, 5)), '00000') --dev
    SET @taxsNum = @writeDate + '41000008fux' + FORMAT(CONVERT(int, RIGHT(@seq, 5)), '00000') --real
    SET @issueDate = @timestamp
    SET @issueId = @taxsNum
    
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
        LOADSTATUS, SMS, REGDATE, REG_ID, MNG_CUST_ID, MNG_DEPT_ID
    ) VALUES (
        @invId, CONVERT(numeric, @billKind), @docAttr, @pubType, 
        @issueDate, @issueId, @docClass, @docType,
        @remark, NULL, NULL, @writeDate,
        NULL, @pubForm, NULL, @supplierCustId,
        @supplierDeptId, @supplierBizNo, @supplierBizType, @supplierBizName,
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
        0, 0, 0, 0, CONVERT(numeric, @supprice), CONVERT(numeric, @tax), CONVERT(numeric, @totPrice),
        @loadStatus, NULL, @regDate, @regId, @mngCustId, @mngDeptId
    );


    set @retCode = @RET_OK
    set @retMsg = '세금계산서가 발행되었습니다.'
END
GO
