USE [logislink]
GO
/****** Object:  StoredProcedure [dbo].[UPDATE_MULT_ORDER_ALLOC]    Script Date: 2022-07-14 오후 6:16:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UPDATE_MULT_ORDER_ALLOC]
(
	@orderId		NVARCHAR(20)
  , @allocId		NVARCHAR(20)
  , @sellCharge		INT
  , @buyCharge		INT
  , @sellWeight		NVARCHAR(100)
  , @buyCustId		NVARCHAR(20)
  , @buyDeptId		NVARCHAR(20)
  , @loginId		NVARCHAR(20)
  , @newAllocId		NVARCHAR(20)	OUTPUT
  , @outTaxCnt		INT				OUTPUT
  , @retCode		NVARCHAR(2)		OUTPUT
  , @retMsg			NVARCHAR(200)	OUTPUT
)
AS
BEGIN
	DECLARE @RET_OK				NVARCHAR(2) = '00'
	DECLARE @RET_ERR			NVARCHAR(2) = '99'
	DECLARE @seq				INT
	DECLARE @timestamp			NVARCHAR(14) = ''
	DECLARE @allocCharge 		INT 
	DECLARE @finishCnt			INT
	DECLARE @taxCnt				INT
	
	SELECT @finishCnt = COUNT(1)
	FROM T_CALC 
	WHERE ORDER_ID = @orderId AND USE_YN = 'Y' AND FINISH_YN = 'Y'
	IF @finishCnt = 0
		BEGIN 
			SELECT @taxCnt = COUNT(1)
			FROM T_CALC 
			WHERE ORDER_ID = @orderId 
			AND ALLOC_ID = @allocId
			AND USE_YN = 'Y'
			AND TAXINV_YN != 'N'
			
			IF ISNULL(@sellCharge, '') <> ''
				BEGIN 
					SET @allocCharge = @sellCharge
				END
			ELSE 
				BEGIN 
					SET @allocCharge = @buyCharge
				END
			
			IF ISNULL(@sellWeight, '') <> ''
				BEGIN 
				   UPDATE 
						T_ORDER_ALLOC
					SET 
						SELL_WEIGHT = @sellWeight,
						EDITID = @loginId,
						EDITDATE = GETDATE()
					WHERE ORDER_ID = @orderId
					AND ALLOC_ID = @allocId
				END	
				
			IF ISNULL(@allocId, '') <> ''
				BEGIN
					IF @taxCnt = 0
						BEGIN
							UPDATE 
								T_ORDER_ALLOC
							SET 
								ALLOC_CHARGE = @allocCharge
							WHERE ORDER_ID = @orderId
							AND ALLOC_ID = @allocId
							-- 매입 정산 정보 업데이트
							UPDATE T_CALC SET PAYABLE_AMT = @allocCharge 
							WHERE ALLOC_ID = @allocId AND CALC_TYPE_CODE = '0002' AND SELL_BUY_SCTN = '02';
							
							-- 매출 정산 정보 업데이트
							UPDATE T_CALC SET UNPAID_AMT = @allocCharge 
							WHERE ALLOC_ID = @allocId AND CALC_TYPE_CODE = '0002' AND SELL_BUY_SCTN = '01';		
						END
					ELSE
						BEGIN
							SET @retCode = @RET_ERR
					    	SET @retMsg = '세금계산서가 발행된 오더는 수정할 수 없습니다.'
					    	SET @outTaxCnt = @taxCnt
						END
				END
		    ELSE
		    	BEGIN 
			    	SET @timestamp = convert(varchar, getDate(), 112) + replace(convert(varchar, getDate(), 108), ':', '')
					SELECT @seq = NEXT VALUE FOR SEQ_ORDER_ALLOC;
					SET @allocId = 'A' + @timestamp + RIGHT('00' + @seq, 3)
			    	
					INSERT INTO T_ORDER_ALLOC (
						ORDER_ID 		, ALLOC_ID 			, ALLOC_CHARGE
					  ,	SELL_CUST_ID	, SELL_DEPT_ID 		, ALLOC_STATE 
					  , REGID			, REGDATE 
					)
					VALUES (
						@orderId 		, @allocId 			, @allocCharge
					  ,	@buyCustId		, @buyDeptId		, '00'		
					  , @loginId 		, GETDATE()
					)
		    	END
		    	
		    	IF (@@ERROR <> 0)
					BEGIN 
						SET @retCode = @RET_ERR
				    	SET @retMsg = '등록 실패했습니다.'
					END
			    ELSE		
			    	BEGIN 
				    	SET @retCode = @RET_OK
				    	SET @newAllocId = @allocId
			    	END
		END
	ELSE
		BEGIN 
			set @retCode = @RET_ERR
		    set @retMsg = '이미 마감된 정산 내역이 있어 오더를 수정할 수 없습니다.'
		END
END 
GO
