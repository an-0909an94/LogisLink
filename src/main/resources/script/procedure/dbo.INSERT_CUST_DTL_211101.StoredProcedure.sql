USE [logislink]
GO
/****** Object:  StoredProcedure [dbo].[INSERT_CUST_DTL_211101]    Script Date: 2022-07-14 오후 6:16:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[INSERT_CUST_DTL_211101]
(
    @custSeq BIGINT
  , @custId NVARCHAR(20)
  , @deptId NVARCHAR(20)
  , @mngCustId NVARCHAR(20)
  , @mngDeptId NVARCHAR(20)
  , @sellBuySctn NVARCHAR(20)
  , @custName NVARCHAR(30)
  , @telNum NVARCHAR(13)
  , @mobile NVARCHAR(13)
  , @fax NVARCHAR(13)
  , @taxEmail NVARCHAR(50)
  , @itemCode NVARCHAR(10)
  , @manager NVARCHAR(30)
  , @custMemo NVARCHAR(1000)
  , @orderMemo NVARCHAR(1000)
  , @userName NVARCHAR(20)
  , @useYn NVARCHAR(1)
  , @regId NVARCHAR(20)
  , @editId NVARCHAR(20)
  , @custMngCode NVARCHAR(2)
  , @custMngMemo NVARCHAR(1000)
  , @retCode NVARCHAR(2) OUTPUT
  , @retMsg NVARCHAR(200) OUTPUT
)
AS
BEGIN
	
	DECLARE @RET_OK NVARCHAR(2) = '00'		-- 성공
	DECLARE @RET_ERR NVARCHAR(2) = '99'		-- Error
	DECLARE @timestamp	NVARCHAR(14) = ''
	DECLARE @CHG_SELL_BUY_SCTN NVARCHAR(20) = ''
	DECLARE @bizNum NVARCHAR(10);
	DECLARE @mngBizNum NVARCHAR(10);
	DECLARE @dupCnt INT
	
	IF @custSeq = ''
		BEGIN
			--SELECT @bizNum = BIZ_NUM FROM T_CUST_MST WHERE CUST_ID = @custId;
			--SELECT @mngBizNum = BIZ_NUM FROM T_CUST_MST WHERE CUST_ID = @mngCustId;
			-- 중복 등록 검증
			SELECT @dupCnt = COUNT(1)
			FROM T_CUST_DTL
			WHERE CUST_ID = @custId AND DEPT_ID = @deptId 
					AND MNG_CUST_ID = @mngCustId AND MNG_DEPT_ID = @mngDeptId AND SELL_BUY_SCTN = @sellBuySctn
					AND USE_YN = 'Y'
					
			IF @dupCnt > 0 
			BEGIN 
				set @retCode = @RET_ERR
			    set @retMsg = '이미 등록된 거래처입니다.'
			END 
			ELSE 
			BEGIN 				
				--IF @bizNum <> @mngBizNum
--					BEGIN
				IF @custId = @mngCustId AND @deptId = @mngDeptId
					BEGIN 
			            set @retCode = @RET_ERR
			            set @retMsg = '자기조직을 거래처로 등록할 수 없습니다.'
					END 
				ELSE 
					BEGIN
						INSERT INTO dbo.T_CUST_DTL 
							(
								CUST_ID, DEPT_ID, SELL_BUY_SCTN, CUST_NAME, TELNUM, 
								MOBILE, FAX, TAX_EMAIL, USE_YN, REGDATE, ITEM_CODE, STAFF_NAME,
								MANAGER, MNG_DEPT_ID, MNG_CUST_ID, CUST_MEMO, ORDER_MEMO, REGID,
								CUST_MNG_CODE, CUST_MNG_MEMO 
							)
			            VALUES
			            	(
			            		@custId, @deptId, @sellBuySctn, @custName, @telNum, 
			            		@mobile, @fax, @taxEmail, 'Y', GETDATE(), @itemCode, @userName,
			            		@manager, @mngDeptId, @mngCustId, @custMemo, @orderMemo, @regId,
			            		@custMngCode, @custMngMemo
			            	)
			            	
			            IF @sellBuysctn = '01'
				            BEGIN
					            set @CHG_SELL_BUY_SCTN = '02'
				            END
				        ELSE 
				        	BEGIN
					        	set @CHG_SELL_BUY_SCTN = '01'
				        	END
			            
				        SELECT * FROM dbo.T_CUST_DTL
				        WHERE CUST_ID = @mngCustId AND DEPT_ID = @mngDeptId AND SELL_BUY_SCTN = @CHG_SELL_BUY_SCTN AND
			            	MNG_DEPT_ID = @deptId AND MNG_CUST_ID = @custId
				        	
			            IF @@ROWCOUNT = 0
			            	BEGIN 
				             	INSERT INTO dbo.T_CUST_DTL 
									(
										CUST_ID, DEPT_ID, SELL_BUY_SCTN, USE_YN, REGDATE, 
										MNG_DEPT_ID, MNG_CUST_ID, REGID, CUST_NAME, CUST_MNG_CODE, 
										CUST_MNG_MEMO 
									)
					            VALUES
					            	(
					            		@mngCustId, @mngDeptId, @CHG_SELL_BUY_SCTN, 'Y', GETDATE(),
					            		@deptId, @custId, @regId, (SELECT BIZ_NAME FROM T_CUST_MST WHERE CUST_ID = @mngCustId), @custMngCode,
					            		@custMngMemo
					            	)
			            	END
			                    
			            set @retCode = @RET_OK
			            set @retMsg = '거래처 정보가 추가되었습니다.'
						
					END
				--ELSE 
--					BEGIN 	  
--			            set @retCode = @RET_ERR
--			            set @retMsg = '자기조직의 사업자 번호로 등록할 수 없습니다.'
--					END
			END 
		
		END
	ELSE
		BEGIN
			UPDATE dbo.T_CUST_DTL
		    SET 
		        CUST_NAME = @custName,
		        TELNUM = @telNum,
		        MOBILE = @mobile,
		        FAX = @fax,
		   TAX_EMAIL = @taxEmail,
		        ITEM_CODE = @itemCode,
		        MANAGER = @manager,
		        MNG_DEPT_ID = @mngDeptId,
		        MNG_CUST_ID = @mngCustId,
		        CUST_MEMO = @custMemo,
		        ORDER_MEMO = @orderMemo,
		        STAFF_NAME = @userName,
		        EDITDATE = GETDATE(),
		        USE_YN = @useYn,
				DISUSE_DATE = CASE @useYn WHEN 'N' THEN GETDATE() WHEN 'Y' THEN NULL END,
		        EDITID = @editId,
		        CUST_MNG_CODE = @custMngCode,
		        CUST_MNG_MEMO = @custMngMemo
		    WHERE CUST_SEQ = @custSeq
		    
		    set @retCode = @RET_OK
		    set @retMsg = '거래처 정보가 수정되었습니다.'
		END
END
GO
