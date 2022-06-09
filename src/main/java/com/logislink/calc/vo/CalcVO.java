package com.logislink.calc.vo;

public class CalcVO {
	private int number;
	private String calcId;
	private String allocId;
	private String orderId;
	private String allocDate;
	private String calcTypeCode;
	private String calcTypeName;
	private String custName;
	private String carrierName;
	private String carNum;
	private String sellBuySctn;
	private String sellBuySctnName;
	private int unpaidAmt;
	private int payableAmt;
	private int depositAmt;
	private int withdrawalAmt;
	private int prePayment;
	private int allocFee;
	private String calcState;
	private String finishYn;
	private String memo;
	private String calcDate;
	private String taxinvYn;
	private String mngCustId;
	private String mngDeptId;
	private String mngDeptName;
	private String custId;
	private String deptId;
	private String regDate;
	private String regId;
	private String vehicId;
	private String driverId;
	private String useYn;
	private String sComName;
	private String eComName;
	private String goodsName;
	private String goodsWeight;
	private String sellWeight;
	private String taxinvDate;
	private String tranYn;
	private String tranDate;
	private String eDateDay;
	private String eDate;
	private String stopCount;
	private String stopComName;
	private String driverName;
	private String driverTel;
	private String unitPriceType;
	private String userName;
	private String finishMemo;
	private String finishUserName;
	private String reportBizNum;
	private String reportBizName;
	private String appName;
	private String refContent1;
	private String refContent2;
	private String finishUserId;
	private String reqBizName;
	private String driverBizName;
	private String invId;
	private String payReturnMemo;
	private String carSctnName;
	private String chargeType;
	
	private String receiptYn;			//인수증 여부 N, Y, P
	private String receiptPath;			//인수증 경로 
	private String receiptDate;			//인수증접수일
	private String paperReceiptDate;	//종이인수증접수일
	
	private String payType;
	private String reqPayYn;			//기사 빠른지급 신청
	private String reqPayDate;
	
	public int getNumber() {
		return number;
	}
	public String getCalcId() {
		return calcId;
	}
	public String getAllocId() {
		return allocId;
	}
	public String getOrderId() {
		return orderId;
	}
	public String getAllocDate() {
		return allocDate;
	}
	public String getCalcTypeCode() {
		return calcTypeCode;
	}
	public String getCalcTypeName() {
		return calcTypeName;
	}
	public String getCustName() {
		return custName;
	}
	public String getCarrierName() {
		return carrierName;
	}
	public String getCarNum() {
		return carNum;
	}
	public String getSellBuySctn() {
		return sellBuySctn;
	}
	public String getSellBuySctnName() {
		return sellBuySctnName;
	}
	public int getUnpaidAmt() {
		return unpaidAmt;
	}
	public int getPayableAmt() {
		return payableAmt;
	}
	public int getDepositAmt() {
		return depositAmt;
	}
	public int getWithdrawalAmt() {
		return withdrawalAmt;
	}
	public int getPrePayment() {
		return prePayment;
	}
	public String getCalcState() {
		return calcState;
	}
	public String getFinishYn() {
		return finishYn;
	}
	public String getMemo() {
		return memo;
	}
	public String getCalcDate() {
		return calcDate;
	}
	public String getTaxinvYn() {
		return taxinvYn;
	}
	public String getMngCustId() {
		return mngCustId;
	}
	public String getMngDeptId() {
		return mngDeptId;
	}
	public String getMngDeptName() {
		return mngDeptName;
	}
	public String getCustId() {
		return custId;
	}
	public String getDeptId() {
		return deptId;
	}
	public String getRegDate() {
		return regDate;
	}
	public String getRegId() {
		return regId;
	}
	public String getVehicId() {
		return vehicId;
	}
	public String getDriverId() {
		return driverId;
	}
	public String getUseYn() {
		return useYn;
	}
	public String getsComName() {
		return sComName;
	}
	public String geteComName() {
		return eComName;
	}
	public String getGoodsName() {
		return goodsName;
	}
	public String getGoodsWeight() {
		return goodsWeight;
	}
	public String getSellWeight() {
		return sellWeight;
	}
	public String getTaxinvDate() {
		return taxinvDate;
	}
	public String getTranYn() {
		return tranYn;
	}
	public String getTranDate() {
		return tranDate;
	}
	public String geteDateDay() {
		return eDateDay;
	}
	public String getStopCount() {
		return stopCount;
	}
	public String getStopComName() {
		return stopComName;
	}
	public String getDriverName() {
		return driverName;
	}
	public String getDriverTel() {
		return driverTel;
	}
	public String getUnitPriceType() {
		return unitPriceType;
	}
	public String getUserName() {
		return userName;
	}
	public String getFinishMemo() {
		return finishMemo;
	}
	public String getFinishUserName() {
		return finishUserName;
	}
	public String getReportBizNum() {
		return reportBizNum;
	}
	public String getReportBizName() {
		return reportBizName;
	}
	public String getAppName() {
		return appName;
	}
	public String getRefContent1() {
		return refContent1;
	}
	public String getRefContent2() {
		return refContent2;
	}
	public String getFinishUserId() {
		return finishUserId;
	}
	public String getReqBizName() {
		return reqBizName;
	}
	public String getDriverBizName() {
		return driverBizName;
	}
	public String getInvId() {
		return invId;
	}
	public String getReceiptYn() {
		return receiptYn;
	}
	public String getReceiptPath() {
		return receiptPath;
	}
	public String getReceiptDate() {
		return receiptDate;
	}
	public String getPaperReceiptDate() {
		return paperReceiptDate;
	}
	public String getPayType() {
		return payType;
	}
	public String getReqPayYn() {
		return reqPayYn;
	}
	public String getReqPayDate() {
		return reqPayDate;
	}
	public void setNumber(int number) {
		this.number = number;
	}
	public void setCalcId(String calcId) {
		this.calcId = calcId;
	}
	public void setAllocId(String allocId) {
		this.allocId = allocId;
	}
	public void setOrderId(String orderId) {
		this.orderId = orderId;
	}
	public void setAllocDate(String allocDate) {
		this.allocDate = allocDate;
	}
	public void setCalcTypeCode(String calcTypeCode) {
		this.calcTypeCode = calcTypeCode;
	}
	public void setCalcTypeName(String calcTypeName) {
		this.calcTypeName = calcTypeName;
	}
	public void setCustName(String custName) {
		this.custName = custName;
	}
	public void setCarrierName(String carrierName) {
		this.carrierName = carrierName;
	}
	public void setCarNum(String carNum) {
		this.carNum = carNum;
	}
	public void setSellBuySctn(String sellBuySctn) {
		this.sellBuySctn = sellBuySctn;
	}
	public void setSellBuySctnName(String sellBuySctnName) {
		this.sellBuySctnName = sellBuySctnName;
	}
	public void setUnpaidAmt(int unpaidAmt) {
		this.unpaidAmt = unpaidAmt;
	}
	public void setPayableAmt(int payableAmt) {
		this.payableAmt = payableAmt;
	}
	public void setDepositAmt(int depositAmt) {
		this.depositAmt = depositAmt;
	}
	public void setWithdrawalAmt(int withdrawalAmt) {
		this.withdrawalAmt = withdrawalAmt;
	}
	public void setPrePayment(int prePayment) {
		this.prePayment = prePayment;
	}
	public void setCalcState(String calcState) {
		this.calcState = calcState;
	}
	public void setFinishYn(String finishYn) {
		this.finishYn = finishYn;
	}
	public void setMemo(String memo) {
		this.memo = memo;
	}
	public void setCalcDate(String calcDate) {
		this.calcDate = calcDate;
	}
	public void setTaxinvYn(String taxinvYn) {
		this.taxinvYn = taxinvYn;
	}
	public void setMngCustId(String mngCustId) {
		this.mngCustId = mngCustId;
	}
	public void setMngDeptId(String mngDeptId) {
		this.mngDeptId = mngDeptId;
	}
	public void setMngDeptName(String mngDeptName) {
		this.mngDeptName = mngDeptName;
	}
	public void setCustId(String custId) {
		this.custId = custId;
	}
	public void setDeptId(String deptId) {
		this.deptId = deptId;
	}
	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}
	public void setRegId(String regId) {
		this.regId = regId;
	}
	public void setVehicId(String vehicId) {
		this.vehicId = vehicId;
	}
	public void setDriverId(String driverId) {
		this.driverId = driverId;
	}
	public void setUseYn(String useYn) {
		this.useYn = useYn;
	}
	public void setsComName(String sComName) {
		this.sComName = sComName;
	}
	public void seteComName(String eComName) {
		this.eComName = eComName;
	}
	public void setGoodsName(String goodsName) {
		this.goodsName = goodsName;
	}
	public void setGoodsWeight(String goodsWeight) {
		this.goodsWeight = goodsWeight;
	}
	public void setSellWeight(String sellWeight) {
		this.sellWeight = sellWeight;
	}
	public void setTaxinvDate(String taxinvDate) {
		this.taxinvDate = taxinvDate;
	}
	public void setTranYn(String tranYn) {
		this.tranYn = tranYn;
	}
	public void setTranDate(String tranDate) {
		this.tranDate = tranDate;
	}
	public void seteDateDay(String eDateDay) {
		this.eDateDay = eDateDay;
	}
	public void setStopCount(String stopCount) {
		this.stopCount = stopCount;
	}
	public void setStopComName(String stopComName) {
		this.stopComName = stopComName;
	}
	public void setDriverName(String driverName) {
		this.driverName = driverName;
	}
	public void setDriverTel(String driverTel) {
		this.driverTel = driverTel;
	}
	public void setUnitPriceType(String unitPriceType) {
		this.unitPriceType = unitPriceType;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public void setFinishMemo(String finishMemo) {
		this.finishMemo = finishMemo;
	}
	public void setFinishUserName(String finishUserName) {
		this.finishUserName = finishUserName;
	}
	public void setReportBizNum(String reportBizNum) {
		this.reportBizNum = reportBizNum;
	}
	public void setReportBizName(String reportBizName) {
		this.reportBizName = reportBizName;
	}
	public void setAppName(String appName) {
		this.appName = appName;
	}
	public void setRefContent1(String refContent1) {
		this.refContent1 = refContent1;
	}
	public void setRefContent2(String refContent2) {
		this.refContent2 = refContent2;
	}
	public void setFinishUserId(String finishUserId) {
		this.finishUserId = finishUserId;
	}
	public void setReqBizName(String reqBizName) {
		this.reqBizName = reqBizName;
	}
	public void setDriverBizName(String driverBizName) {
		this.driverBizName = driverBizName;
	}
	public void setInvId(String invId) {
		this.invId = invId;
	}
	public void setReceiptYn(String receiptYn) {
		this.receiptYn = receiptYn;
	}
	public void setReceiptPath(String receiptPath) {
		this.receiptPath = receiptPath;
	}
	public void setReceiptDate(String receiptDate) {
		this.receiptDate = receiptDate;
	}
	public void setPaperReceiptDate(String paperReceiptDate) {
		this.paperReceiptDate = paperReceiptDate;
	}
	public void setPayType(String payType) {
		this.payType = payType;
	}
	public void setReqPayYn(String reqPayYn) {
		this.reqPayYn = reqPayYn;
	}
	public void setReqPayDate(String reqPayDate) {
		this.reqPayDate = reqPayDate;
	}
	public String getPayReturnMemo() {
		return payReturnMemo;
	}
	public void setPayReturnMemo(String payReturnMemo) {
		this.payReturnMemo = payReturnMemo;
	}
	public String getCarSctnName() {
		return carSctnName;
	}
	public void setCarSctnName(String carSctnName) {
		this.carSctnName = carSctnName;
	}
	public String geteDate() {
		return eDate;
	}
	public void seteDate(String eDate) {
		this.eDate = eDate;
	}
	public String getChargeType() {
		return chargeType;
	}
	public void setChargeType(String chargeType) {
		this.chargeType = chargeType;
	}
	public int getAllocFee() {
		return allocFee;
	}
	public void setAllocFee(int allocFee) {
		this.allocFee = allocFee;
	}
	
}
