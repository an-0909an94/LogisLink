USE [logislink]
GO
/****** Object:  StoredProcedure [dbo].[APP_ORDER_LINK_INSERT_20211012]    Script Date: 2022-07-14 오후 6:16:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[APP_ORDER_LINK_INSERT_20211012]
(
	@linkType		NVARCHAR(10)
  , @linkStatus		NVARCHAR(10)
  , @fare		    NVARCHAR(10)
  , @fee		    NVARCHAR(10)
  , @orderId        NVARCHAR(20)
  , @allocId		NVARCHAR(20)
  , @command        NVARCHAR(100)
  , @payDate		NVARCHAR(10)
  , @chargeTypeCode	NVARCHAR(2)
  , @cargoDsc		NVARCHAR(100)
  , @regId			NVARCHAR(20)
  , @custId			NVARCHAR(20)
  , @deptId			NVARCHAR(20)
  , @retCode		NVARCHAR(2)		OUTPUT
  , @retMsg			NVARCHAR(200)	OUTPUT
)
AS
BEGIN
	
	DECLARE @RET_OK NVARCHAR(2) = '00'		-- 성공
	DECLARE @RET_ERR NVARCHAR(2) = '99'		-- Error
	DECLARE @timestamp	NVARCHAR(14) = ''
	
	DECLARE @seq		INT
    DECLARE @cur_link_status NVARCHAR(10) = ''
    DECLARE @cur_ord_status NVARCHAR(10) = ''
    DECLARE @carTonCode NVARCHAR(10) = ''
    DECLARE @carTypeCode NVARCHAR(10) = ''
    
    DECLARE @linkCount INT
    DECLARE @preCommand NVARCHAR(20)
    
    IF ISNULL(@allocId, '') = ''
		BEGIN
			
			SET @timestamp = convert(varchar, getDate(), 112) + replace(convert(varchar, getDate(), 108), ':', '')
			SELECT @seq = NEXT VALUE FOR SEQ_ORDER_ALLOC;
			SET @allocId = 'A' + @timestamp + RIGHT('00' + @seq, 3)
			
			MERGE INTO 	T_ORDER_ALLOC AS A 
			USING
				(
					SELECT 
							@allocId		ALLOC_ID
						  , @orderId		ORDER_ID 
						  , @custId			SELL_CUST_ID 
						  , @deptId			SELL_DEPT_ID
						  , CONVERT(INT, @fare)			ALLOC_CHARGE 
						  , CONVERT(INT, @fee)			ALLOC_FEE 
						  , @linkStatus		ALLOC_STATE 
						  , @regId			REGID 
				) D
			ON A.ORDER_ID = D.ORDER_ID AND A.SELL_CUST_ID = D.SELL_CUST_ID AND A.SELL_DEPT_ID = D.SELL_DEPT_ID
			WHEN MATCHED THEN 
				UPDATE SET A.ALLOC_CHARGE = D.ALLOC_CHARGE
						 , A.ALLOC_FEE = D.ALLOC_FEE
						 , A.ALLOC_STATE = D.ALLOC_STATE 
						 , A.EDITID = D.REGID
						 , A.EDITDATE = GETDATE()
			WHEN NOT MATCHED THEN 
				INSERT (
							ALLOC_ID		, ORDER_ID			, SELL_CUST_ID		, SELL_DEPT_ID	, ALLOC_CHARGE	
						  , ALLOC_FEE		, ALLOC_STATE		, REGID			
						  , REGDATE			
						  , SELL_STAFF_ID 	, SELL_STAFF_TEL 
						)
				VALUES (
							D.ALLOC_ID		, D.ORDER_ID		, D.SELL_CUST_ID	, D.SELL_DEPT_ID , D.ALLOC_CHARGE
						  , D.ALLOC_FEE		, D.ALLOC_STATE		, D.REGID		
						  , GETDATE()
						  , D.REGID			, (SELECT MOBILE FROM T_USER WHERE USER_ID = D.REGID)
						);		
		END
/*	ELSE
		BEGIN
			
			UPDATE T_ORDER_ALLOC
			SET	ALLOC_CHARGE = CONVERT(INT, @fare)
			  , ALLOC_FEE = CONVERT(INT, @fee)
			  , ALLOC_STATE = @linkStatus
			  , EDITDATE  = GETDATE()
			  , EDITID = @regId
			  , LINK_YN = 'Y'
			  , LINK_CODE = @linkType
			WHERE ORDER_ID = @orderId AND ALLOC_ID = @allocId
		END*/
		
	SELECT @cur_ord_status = ORDSTATUS, @cur_link_status = LINK_STATUS, @preCommand = COMMAND 
	FROM T_LINK
	WHERE ALLOC_ID = @allocId AND LINK_TYPE = @linkType
	SET @linkCount = @@ROWCOUNT 
	
	-- 접수 실패한 내역에 대해 재접수인 경우, 기존 이력은 지우고 다시 INSERT 한다.
	IF @preCommand = 'ADDORDER' AND @cur_link_status = '25' AND @preCommand = @command
	BEGIN 
		DELETE FROM T_LINK 
		WHERE ALLOC_ID = @allocId AND LINK_TYPE = @linkType
		
		SET @linkCount = 0
	END
	
    IF @linkCount = 0
    	BEGIN 
            IF @command = 'ADDORDER'
                BEGIN    
                    INSERT INTO T_LINK (
                        ALLOC_ID, ORDER_ID, LINK_TYPE, LINK_STATUS, COMMAND,
                        STARTWIDE, STARTSGG, STARTDONG, 
                        STARTDETAIL, ENDWIDE, ENDSGG, 
                        ENDDONG, ENDDETAIL, MULTICARGOGUB, 
                        SHUTTLECARGOINFO, CARGOTON, TRUCKTYPE, 
                        FRGTON, STARTPLANDT, ENDPLANDT, 
                        STARTLOAD, ENDLOAD, CARGODSC, 
                        FAREPAYTYPE, FARE, FEE, ENDAREAPHONE, FIRSTTYPE,
                        FIRSTSHIPPERNM, FIRSTSHIPPERINFO, FIRSTSHIPPERBIZNO, PAYPLANYMD,
                        ORDSTATUS, CJNAME, CJPHONE, 
                        CJCARNUM, CJCARGOTON, CJTRUCKTYPE, REG_DATE, REG_ID)
					(SELECT
                      OA.ALLOC_ID ALLOC_ID, O.ORDER_ID ORDER_ID, @linkType LINK_TYPE, @linkStatus LINK_STATUS, @command,
                        O.S_SIDO STARTWIDE, O.S_GUNGU STARTSGG, O.S_DONG STARTDONG, 
                        O.S_SIDO + ' ' + O.S_GUNGU + ' ' + O.S_DONG STARTDETAIL, O.E_SIDO ENDWIDE, O.E_GUNGU ENDSGG, 
                        O.E_DONG ENDDONG, O.E_SIDO + ' ' + O.E_GUNGU + ' ' + O.E_DONG ENDDETAIL, (CASE O.MIX_YN WHEN 'Y' THEN '혼적' ELSE '' END) MULTICARGOGUB, 
     (CASE O.RETURN_YN WHEN 'Y' THEN '왕복' ELSE '' END) SHUTTLECARGOINFO, (SELECT CODE FROM T_CODE WHERE CODE = O.CAR_TON_CODE AND GCODE = 'CAR_TON_CD') CARGOTON, (SELECT CODE FROM T_CODE WHERE CODE = O.CAR_TYPE_CODE AND GCODE = 'CAR_TYPE_CD') TRUCKTYPE, 
                        CONVERT(FLOAT,O.GOODS_WEIGHT)/1000 FRGTON, CONVERT(NVARCHAR(20), O.S_DATE, 120) STARTPLANDT, CONVERT(NVARCHAR(20), O.E_DATE, 120) ENDPLANDT,  
                        (SELECT CODE FROM T_CODE WHERE CODE = O.S_WAY_CODE AND GCODE = 'WAY_TYPE_CD') STARTLOAD, (SELECT CODE FROM T_CODE WHERE CODE = O.E_WAY_CODE AND GCODE = 'WAY_TYPE_CD') ENDLOAD, @cargoDsc CARGODSC, 
                        @chargeTypeCode FAREPAYTYPE, @fare FARE, @fee FEE, O.E_TEL ENDAREAPHONE, (SELECT (CASE CUST_TYPE_CODE WHEN '04' THEN '01' ELSE '02' END) FIRSTTYPE FROM T_CUST_MST WHERE CUST_ID = OA.SELL_CUST_ID) FIRSTTYPE,
                        (SELECT BIZ_NAME FROM T_CUST_MST WHERE CUST_ID = OA.SELL_CUST_ID) FIRSTSHIPPERNM, OA.SELL_STAFF_TEL FIRSTSHIPPERINFO, (SELECT BIZ_NUM FROM T_CUST_MST WHERE CUST_ID = OA.SELL_CUST_ID) FIRSTSHIPPERBIZNO, REPLACE(@payDate, '-', ''),
                        '00', OA.DRIVER_NAME CJNAME, OA.DRIVER_TEL CJPHONE, 
                        OA.CAR_NUM CJCARNUM, (SELECT CODE FROM T_CODE WHERE CODE = O.CAR_TON_CODE AND GCODE = 'CAR_TON_CD') CJCARGOTON, (SELECT CODE FROM T_CODE WHERE CODE = O.CAR_TYPE_CODE AND GCODE = 'CAR_TON_CD') CJTRUCKTYPE, getdate(), @regId
                    FROM
                        T_ORDER O, T_ORDER_ALLOC OA
                    WHERE
                        O.ORDER_ID = OA.ORDER_ID AND
                        ALLOC_ID = @allocId)
                            
                    INSERT INTO T_LINK_API (
                        ALLOC_ID, LINK_TYPE, LINK_STATUS, COMMAND,
                        STARTWIDE, STARTSGG, STARTDONG, 
                        STARTDETAIL, ENDWIDE, ENDSGG, 
                        ENDDONG, ENDDETAIL, MULTICARGOGUB, 
                        SHUTTLECARGOINFO, CARGOTON, TRUCKTYPE, 
                        FRGTON, STARTPLANDT, ENDPLANDT, 
                        STARTLOAD, ENDLOAD, CARGODSC, 
                        FAREPAYTYPE, FARE, FEE, ENDAREAPHONE, FIRSTTYPE,
                        FIRSTSHIPPERNM, FIRSTSHIPPERINFO, FIRSTSHIPPERBIZNO, TAXBILLTYPE, PAYPLANYMD, ORDER_ID)
                    (SELECT
                        OA.ALLOC_ID ALLOC_ID, @linkType LINK_TYPE, @linkStatus LINK_STATUS, @command COMMAND,
                        O.S_SIDO STARTWIDE, O.S_GUNGU STARTSGG, O.S_DONG STARTDONG, 
                       O.S_SIDO + ' ' + O.S_GUNGU + ' ' + O.S_DONG STARTDETAIL, O.E_SIDO ENDWIDE, O.E_GUNGU ENDSGG, 
                        O.E_DONG ENDDONG, O.E_SIDO + ' ' + O.E_GUNGU + ' ' + O.E_DONG ENDDETAIL, (CASE O.MIX_YN WHEN 'Y' THEN '혼적' ELSE '' END) MULTICARGOGUB, 
                        (CASE O.RETURN_YN WHEN 'Y' THEN '왕복' ELSE '' END) SHUTTLECARGOINFO, (SELECT CODE FROM T_CODE WHERE CODE = O.CAR_TON_CODE AND GCODE = 'CAR_TON_CD') CARGOTON, (SELECT CODE FROM T_CODE WHERE CODE = O.CAR_TYPE_CODE AND GCODE = 'CAR_TYPE_CD') TRUCKTYPE, 
                        CONVERT(FLOAT,O.GOODS_WEIGHT)/1000 FRGTON, CONVERT(NVARCHAR(20), O.S_DATE, 120) STARTPLANDT, CONVERT(NVARCHAR(20), O.E_DATE, 120) ENDPLANDT,  
                        (SELECT CODE FROM T_CODE WHERE CODE = O.S_WAY_CODE AND GCODE = 'WAY_TYPE_CD') STARTLOAD, (SELECT CODE FROM T_CODE WHERE CODE = O.E_WAY_CODE AND GCODE = 'WAY_TYPE_CD') ENDLOAD, @cargoDsc CARGODSC, 
                        @chargeTypeCode FAREPAYTYPE, @fare FARE, @fee FEE, O.E_TEL ENDAREAPHONE, (SELECT (CASE CUST_TYPE_CODE WHEN '04' THEN '01' ELSE '02' END) FIRSTTYPE FROM T_CUST_MST WHERE CUST_ID = OA.SELL_CUST_ID) FIRSTTYPE,
                        (SELECT BIZ_NAME FROM T_CUST_MST WHERE CUST_ID = OA.SELL_CUST_ID) FIRSTSHIPPERNM, OA.SELL_STAFF_TEL FIRSTSHIPPERINFO, (SELECT BIZ_NUM FROM T_CUST_MST WHERE CUST_ID = OA.SELL_CUST_ID) FIRSTSHIPPERBIZNO, 'Y', REPLACE(@payDate, '-', ''), O.ORDER_ID
                    FROM
     T_ORDER O, T_ORDER_ALLOC OA
                    WHERE
                        O.ORDER_ID = OA.ORDER_ID AND
                        ALLOC_ID = @allocId)

                    set @retCode = @RET_OK
		            set @retMsg = '정보망이 접수되었습니다.'
                END
            ELSE
                BEGIN	                
					SELECT 0           
                    set @retCode = @RET_ERR
		            set @retMsg = '존재하지 않는 오더입니다. 관리자에게 문의해주세요.'
                END
    	END
    ELSE
    	BEGIN
--            IF @cur_link_status != 0
--                BEGIN
--                    set @retCode = @RET_ERR
--		            set @retMsg = '이미 배차된 오더는 수정할 수 없습니다.'
--                END
--            ELSE
--                BEGIN
                    IF @command = 'ADDORDER'
                        BEGIN
                            set @command = 'MODORDER'
                            
				            IF @cur_link_status = '배차' OR  @cur_link_status = '취소'
			                BEGIN
			                    set @retCode = @RET_ERR
					            set @retMsg = '접수 상태의 오더만 수정할 수 있습니다.'
			                END
							ELSE 
							BEGIN
	                            UPDATE T_LINK
	                            SET LINK_STATUS = '11',
			                        STARTWIDE	= O.S_SIDO,
			                        STARTSGG	= O.S_GUNGU,
			                        STARTDONG	= O.S_DONG, 
			                        STARTDETAIL	= O.S_SIDO + ' ' + O.S_GUNGU + ' ' + O.S_DONG, 
			                        ENDWIDE		= O.E_SIDO, 
			                        ENDSGG		= O.E_GUNGU, 
			                        ENDDONG		= O.E_DONG, 
			                        ENDDETAIL	= O.E_SIDO + ' ' + O.E_GUNGU + ' ' + O.E_DONG, 
			                        MULTICARGOGUB = (CASE O.MIX_YN WHEN 'Y' THEN '혼적' ELSE '' END), 
			                        SHUTTLECARGOINFO = (CASE O.RETURN_YN WHEN 'Y' THEN '왕복' ELSE '' END), 
			                        CARGOTON 	= (SELECT CODE FROM T_CODE WHERE CODE = O.CAR_TON_CODE AND GCODE = 'CAR_TON_CD'), 
			                        TRUCKTYPE	= (SELECT CODE FROM T_CODE WHERE CODE = O.CAR_TYPE_CODE AND GCODE = 'CAR_TYPE_CD'), 
			                        FRGTON		= CONVERT(FLOAT,O.GOODS_WEIGHT)/1000, 
			                        STARTPLANDT = CONVERT(NVARCHAR(20), O.S_DATE, 120), 
			                        ENDPLANDT	= CONVERT(NVARCHAR(20), O.E_DATE, 120), 
			                        STARTLOAD	= (SELECT CODE FROM T_CODE WHERE CODE = O.S_WAY_CODE AND GCODE = 'WAY_TYPE_CD'), 
			                        ENDLOAD		= (SELECT CODE FROM T_CODE WHERE CODE = O.E_WAY_CODE AND GCODE = 'WAY_TYPE_CD'), 
			                        CARGODSC	= @cargoDsc, 
			                        FAREPAYTYPE = @chargeTypeCode, 
			                        FARE		= @fare, 
			                        FEE			= @fee, 
			                        COMMAND		= @command,
			                        ENDAREAPHONE= O.E_TEL, 
			                        FIRSTTYPE	= (SELECT (CASE CUST_TYPE_CODE WHEN '04' THEN '01' ELSE '02' END) FIRSTTYPE FROM T_CUST_MST WHERE CUST_ID = OA.SELL_CUST_ID),
			                        FIRSTSHIPPERNM = (SELECT BIZ_NAME FROM T_CUST_MST WHERE CUST_ID = OA.SELL_CUST_ID), 
			                        FIRSTSHIPPERINFO = OA.SELL_STAFF_TEL, 
			                        FIRSTSHIPPERBIZNO = (SELECT BIZ_NUM FROM T_CUST_MST WHERE CUST_ID = OA.SELL_CUST_ID), 
			                        PAYPLANYMD	= REPLACE(@payDate, '-', '')		                       
			                    FROM  
			                        T_LINK T_LINK, T_ORDER O, T_ORDER_ALLOC OA
			       WHERE
			                        O.ORDER_ID = OA.ORDER_ID AND T_LINK.ALLOC_ID = OA.ALLOC_ID AND OA.ALLOC_ID = @allocId AND T_LINK.LINK_TYPE = @linkType
	
	
	                            INSERT INTO T_LINK_API (
	                                ALLOC_ID, LINK_TYPE, LINK_STATUS, COMMAND,
	                                STARTWIDE, STARTSGG, STARTDONG, 
	                                STARTDETAIL, ENDWIDE, ENDSGG, 
	                                ENDDONG, ENDDETAIL, MULTICARGOGUB, 
	                                SHUTTLECARGOINFO, CARGOTON, TRUCKTYPE, 
	                                FRGTON, STARTPLANDT, ENDPLANDT, 
	                                STARTLOAD, ENDLOAD, CARGODSC, 
	                                FAREPAYTYPE, FARE, FEE, ENDAREAPHONE, FIRSTTYPE,
	                            FIRSTSHIPPERNM, FIRSTSHIPPERINFO, FIRSTSHIPPERBIZNO, TAXBILLTYPE, PAYPLANYMD, ORDER_ID)
	                            (SELECT
	                                OA.ALLOC_ID ALLOC_ID, @linkType LINK_TYPE, @linkStatus LINK_STATUS, @command COMMAND,
	                                O.S_SIDO STARTWIDE, O.S_GUNGU STARTSGG, O.S_DONG STARTDONG, 
	                                O.S_SIDO + ' ' + O.S_GUNGU + ' ' + O.S_DONG STARTDETAIL, O.E_SIDO ENDWIDE, O.E_GUNGU ENDSGG, 
	                                O.E_DONG ENDDONG, O.E_SIDO + ' ' + O.E_GUNGU + ' ' + O.E_DONG ENDDETAIL, (CASE O.MIX_YN WHEN 'Y' THEN '혼적' ELSE '' END) MULTICARGOGUB, 
	                                (CASE O.RETURN_YN WHEN 'Y' THEN '왕복' ELSE '' END) SHUTTLECARGOINFO, (SELECT CODE FROM T_CODE WHERE CODE = O.CAR_TON_CODE AND GCODE = 'CAR_TON_CD') CARGOTON, (SELECT CODE FROM T_CODE WHERE CODE = O.CAR_TYPE_CODE AND GCODE = 'CAR_TYPE_CD') TRUCKTYPE, 
	                                CONVERT(FLOAT,O.GOODS_WEIGHT)/1000 FRGTON, CONVERT(NVARCHAR(20), O.S_DATE, 120) STARTPLANDT, CONVERT(NVARCHAR(20), O.E_DATE, 120) ENDPLANDT,  
	                                (SELECT CODE FROM T_CODE WHERE CODE = O.S_WAY_CODE AND GCODE = 'WAY_TYPE_CD') STARTLOAD, (SELECT CODE FROM T_CODE WHERE CODE = O.E_WAY_CODE AND GCODE = 'WAY_TYPE_CD') ENDLOAD, O.ITEM_CODE CARGODSC, 
	                                @chargeTypeCode FAREPAYTYPE, @fare FARE, @fee FEE, O.E_TEL ENDAREAPHONE, (SELECT (CASE CUST_TYPE_CODE WHEN '04' THEN '01' ELSE '02' END) FIRSTTYPE FROM T_CUST_MST WHERE CUST_ID = OA.SELL_CUST_ID) FIRSTTYPE,
	                                (SELECT BIZ_NAME FROM T_CUST_MST WHERE CUST_ID = OA.SELL_CUST_ID) FIRSTSHIPPERNM, OA.SELL_STAFF_TEL FIRSTSHIPPERINFO, (SELECT BIZ_NUM FROM T_CUST_MST WHERE CUST_ID = OA.SELL_CUST_ID) FIRSTSHIPPERBIZNO, 'Y', REPLACE(@payDate, '-', ''), O.ORDER_ID
	                            FROM
	                                T_ORDER O, T_ORDER_ALLOC OA
	                            WHERE
	                                O.ORDER_ID = OA.ORDER_ID AND
	                                ALLOC_ID = @allocId)
	
	                            set @retCode = @RET_OK
			                    set @retMsg = '수정된 내용이 접수되었습니다.'
			            	END        
                        END
                    ELSE
                   		BEGIN
	                        
	                        UPDATE T_LINK 
                            SET LINK_STATUS = '11', COMMAND = @command			-- api 접수 상태로 업데이트 해야 스케줄러에서 재전송함
                            WHERE ALLOC_ID = @allocId AND LINK_TYPE = @linkType
                            
                            INSERT INTO T_LINK_API (ALLOC_ID, LINK_TYPE, LINK_STATUS, ORDER_ID, COMMAND)
                            VALUES (@allocId, @linkType, @linkStatus, @orderId, @command)

                            IF @command = 'CANCELORDER'
                                BEGIN  
	                                SELECT 0
             		set @retCode = @RET_OK
                                    set @retMsg = '오더 취소가 접수되었습니다.'
                                END
                            ELSE IF @command = 'CANCELALLOC'
           						BEGIN
	                      SELECT 0
                            		set @retCode = @RET_OK
                                 set @retMsg = '배차 취소가 접수되었습니다.'
                                END
                            ELSE 
                            	BEGIN 
	                                SELECT 0
                            		set @retCode = @RET_OK
                                    set @retMsg = '오더가 재접수되었습니다.'
	                            END 
                        END
                        
               --END
    	END
END
GO
