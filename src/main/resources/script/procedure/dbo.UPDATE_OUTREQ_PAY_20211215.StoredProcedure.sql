USE [logislink]
GO
/****** Object:  StoredProcedure [dbo].[UPDATE_OUTREQ_PAY_20211215]    Script Date: 2022-07-14 오후 6:16:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UPDATE_OUTREQ_PAY_20211215]
(
	@outKind		NVARCHAR(1)
  , @paySeqList		NVARCHAR(2000)
  , @regId			NVARCHAR(20)
  , @retCode		NVARCHAR(2)		OUTPUT
  , @retMsg			NVARCHAR(200)	OUTPUT
)
AS
BEGIN
	DECLARE @RET_OK		NVARCHAR(2) = '00'
	DECLARE @RET_ERR	NVARCHAR(2) = '99'
	
	DECLARE @data NVARCHAR(MAX), @delimiter NVARCHAR(5)
	
	DECLARE @paySeq 	BIGINT
	DECLARE @buyAmt 	INT
	DECLARE @custId 	NVARCHAR(20)
	DECLARE @deptId 	NVARCHAR(20)
	DECLARE @driverId 	NVARCHAR(20)
	DECLARE @vehicId 	NVARCHAR(20)
	DECLARE @mngCustId  NVARCHAR(20)
	DECLARE @mngDeptId  NVARCHAR(20)
	DECLARE @spId1		NVARCHAR(6)
	DECLARE @spId2		NVARCHAR(2)
	DECLARE @spMsg		NVARCHAR(200)
	SELECT @data = @paySeqList,@delimiter = ','
	
	DECLARE cur CURSOR FOR
	SELECT PAY_SEQ, BUY_AMT, CUST_ID, DEPT_ID, DRIVER_ID, VEHIC_ID, MNG_CUST_ID, MNG_DEPT_ID 
	FROM T_CALC_PAY 
	WHERE PAY_SEQ IN (SELECT VALUE FROM STRING_SPLIT(@data, ','))
	
	OPEN cur
	
	FETCH NEXT FROM CUR INTO @paySeq, @buyAmt, @custId, @deptId, @driverId, @vehicId, @mngCustId, @mngDeptId
	
	WHILE(@@FETCH_STATUS = 0) 
	BEGIN 
		UPDATE 
			T_CALC_PAY
		SET 
			OUTREQ_DATE = GETDATE(),
			OUTREQ_ID = @regId,
			OUT_KIND = @outKind 
		WHERE PAY_SEQ = @paySeq
		
		IF @outKind = 'F'
		BEGIN 
			EXEC dbo.INSERT_VACS_SEND 'FM', @buyAmt, @custId, @deptId, @driverId, @vehicId, '2000', @mngCustId, @mngDeptId, @paySeq, @regId, @spId1 OUTPUT, @spId2 OUTPUT, @spMsg OUTPUT;
		END
		
		set @retCode = @RET_OK
		set @retMsg = '출금요청 처리가 완료되었습니다.'
		
		FETCH NEXT FROM cur INTO @paySeq, @buyAmt, @custId, @deptId, @driverId, @vehicId, @mngCustId, @mngDeptId
	END 
	CLOSE cur 
	DEALLOCATE cur
END
GO
