package com.logislink.calc.vo;

public class BuyCalcVO {
	private int number;
	private String orderId;
	private String finishYn;
	private String finishUserName;
	private String allocDate;
	private String sDate;
	private String eDate;
	
	private String driverCarrierName;
	private String buyCustName;
	private String buyManagerName;
	private String buyManagerTel;
	private String carSctnName;
	private String fastPayYn;
	
	// 인수증
	private String receiptYn;
	// 계산서
	private String taxinvYn;
	
	private String sAddr;
	private String eAddr;
	private String wayPoint;
	
	// 매입액(소계)
	private int payableAmt;
	// 내수운송료
	private int buyCharge;
	// 경유비
	private int buyWaypointCharge;
	// 대기료
	private int buyStayCharge;
	// 수작업비
	private int buyHandworkCharge;
	// 회차료
	private int buyRoundCharge;
	// 기타추가비
	private int buyOtheraddCharge;
	// 서비스수수료
	private int buyServiceFeeCharge;
	// 청구구분
	private String chargeTypeName;
	// 수수료
	private int allocFee;
	// 지급액
	private int withdrawallAmt;
	
	private String goodsName;
	private String unitPriceTypeName;
	private int unitPrice;
	private String sellWeight;
	private int goodsWeight;
	private String custName;
	private String bizName;
	private String appName;
	private String finishMemo;
	private String refContent1;
	private String refContent2;
	private String reportBizNum;
	private String reportBizName;
	private String mngDeptName;
	private String mngUserName;
	private String deleteYn;
	private String deleteUserName;
	
	/* 숨김항목 */
	private String mngCustId;
	private String mngDeptId;
	private String custId;
	private String deptId;
	private String reqCustId;
	private String reqDeptId;
	private String vehicId;
	private String driverId;
	
	private String buyAllocId;
	private String buyChargeId;
	private String buyWaypointChargeId;
	private String buyStayChargeId;
	private String buyHandworkChargeId;
	private String buyRoundChargeId;
	private String buyOtheraddChargeId;
	private String buyServiceFeeChargeId;
	
	private String allocState;
	private String allocDateFull;
	private String sDateFull;
	private String eDateFull;
	private String taxinvId;
	
	private String calcTypeCode;

	public int getNumber() {
		return number;
	}

	public void setNumber(int number) {
		this.number = number;
	}

	public String getOrderId() {
		return orderId;
	}

	public void setOrderId(String orderId) {
		this.orderId = orderId;
	}

	public String getFinishYn() {
		return finishYn;
	}

	public void setFinishYn(String finishYn) {
		this.finishYn = finishYn;
	}

	public String getFinishUserName() {
		return finishUserName;
	}

	public void setFinishUserName(String finishUserName) {
		this.finishUserName = finishUserName;
	}

	public String getAllocDate() {
		return allocDate;
	}

	public void setAllocDate(String allocDate) {
		this.allocDate = allocDate;
	}

	public String geteDate() {
		return eDate;
	}

	public void seteDate(String eDate) {
		this.eDate = eDate;
	}

	public String getDriverCarrierName() {
		return driverCarrierName;
	}

	public void setDriverCarrierName(String driverCarrierName) {
		this.driverCarrierName = driverCarrierName;
	}

	public String getBuyCustName() {
		return buyCustName;
	}

	public void setBuyCustName(String buyCustName) {
		this.buyCustName = buyCustName;
	}

	public String getBuyManagerName() {
		return buyManagerName;
	}

	public void setBuyManagerName(String buyManagerName) {
		this.buyManagerName = buyManagerName;
	}

	public String getBuyManagerTel() {
		return buyManagerTel;
	}

	public void setBuyManagerTel(String buyManagerTel) {
		this.buyManagerTel = buyManagerTel;
	}

	public String getCarSctnName() {
		return carSctnName;
	}

	public void setCarSctnName(String carSctnName) {
		this.carSctnName = carSctnName;
	}

	public String getFastPayYn() {
		return fastPayYn;
	}

	public void setFastPayYn(String fastPayYn) {
		this.fastPayYn = fastPayYn;
	}

	public String getReceiptYn() {
		return receiptYn;
	}

	public void setReceiptYn(String receiptYn) {
		this.receiptYn = receiptYn;
	}

	public String getTaxinvYn() {
		return taxinvYn;
	}

	public void setTaxinvYn(String taxinvYn) {
		this.taxinvYn = taxinvYn;
	}

	public String getsAddr() {
		return sAddr;
	}

	public void setsAddr(String sAddr) {
		this.sAddr = sAddr;
	}

	public String geteAddr() {
		return eAddr;
	}

	public void seteAddr(String eAddr) {
		this.eAddr = eAddr;
	}

	public String getWayPoint() {
		return wayPoint;
	}

	public void setWayPoint(String wayPoint) {
		this.wayPoint = wayPoint;
	}

	public int getPayableAmt() {
		return payableAmt;
	}

	public void setPayableAmt(int payableAmt) {
		this.payableAmt = payableAmt;
	}

	public int getBuyCharge() {
		return buyCharge;
	}

	public void setBuyCharge(int buyCharge) {
		this.buyCharge = buyCharge;
	}

	public int getBuyWaypointCharge() {
		return buyWaypointCharge;
	}

	public void setBuyWaypointCharge(int buyWaypointCharge) {
		this.buyWaypointCharge = buyWaypointCharge;
	}

	public int getBuyStayCharge() {
		return buyStayCharge;
	}

	public void setBuyStayCharge(int buyStayCharge) {
		this.buyStayCharge = buyStayCharge;
	}

	public int getBuyHandworkCharge() {
		return buyHandworkCharge;
	}

	public void setBuyHandworkCharge(int buyHandworkCharge) {
		this.buyHandworkCharge = buyHandworkCharge;
	}

	public int getBuyRoundCharge() {
		return buyRoundCharge;
	}

	public void setBuyRoundCharge(int buyRoundCharge) {
		this.buyRoundCharge = buyRoundCharge;
	}

	public int getBuyOtheraddCharge() {
		return buyOtheraddCharge;
	}

	public void setBuyOtheraddCharge(int buyOtheraddCharge) {
		this.buyOtheraddCharge = buyOtheraddCharge;
	}

	public int getBuyServiceFeeCharge() {
		return buyServiceFeeCharge;
	}

	public void setBuyServiceFeeCharge(int buyServiceFeeCharge) {
		this.buyServiceFeeCharge = buyServiceFeeCharge;
	}

	public String getChargeTypeName() {
		return chargeTypeName;
	}

	public void setChargeTypeName(String chargeTypeName) {
		this.chargeTypeName = chargeTypeName;
	}

	public int getAllocFee() {
		return allocFee;
	}

	public void setAllocFee(int allocFee) {
		this.allocFee = allocFee;
	}

	public int getWithdrawallAmt() {
		return withdrawallAmt;
	}

	public void setWithdrawallAmt(int withdrawallAmt) {
		this.withdrawallAmt = withdrawallAmt;
	}

	public String getGoodsName() {
		return goodsName;
	}

	public void setGoodsName(String goodsName) {
		this.goodsName = goodsName;
	}

	public String getUnitPriceTypeName() {
		return unitPriceTypeName;
	}

	public void setUnitPriceTypeName(String unitPriceTypeName) {
		this.unitPriceTypeName = unitPriceTypeName;
	}

	public int getUnitPrice() {
		return unitPrice;
	}

	public void setUnitPrice(int unitPrice) {
		this.unitPrice = unitPrice;
	}

	public String getSellWeight() {
		return sellWeight;
	}

	public void setSellWeight(String sellWeight) {
		this.sellWeight = sellWeight;
	}

	public int getGoodsWeight() {
		return goodsWeight;
	}

	public void setGoodsWeight(int goodsWeight) {
		this.goodsWeight = goodsWeight;
	}

	public String getCustName() {
		return custName;
	}

	public void setCustName(String custName) {
		this.custName = custName;
	}

	public String getBizName() {
		return bizName;
	}

	public void setBizName(String bizName) {
		this.bizName = bizName;
	}

	public String getAppName() {
		return appName;
	}

	public void setAppName(String appName) {
		this.appName = appName;
	}

	public String getFinishMemo() {
		return finishMemo;
	}

	public void setFinishMemo(String finishMemo) {
		this.finishMemo = finishMemo;
	}

	public String getRefContent1() {
		return refContent1;
	}

	public void setRefContent1(String refContent1) {
		this.refContent1 = refContent1;
	}

	public String getRefContent2() {
		return refContent2;
	}

	public void setRefContent2(String refContent2) {
		this.refContent2 = refContent2;
	}

	public String getReportBizNum() {
		return reportBizNum;
	}

	public void setReportBizNum(String reportBizNum) {
		this.reportBizNum = reportBizNum;
	}

	public String getReportBizName() {
		return reportBizName;
	}

	public void setReportBizName(String reportBizName) {
		this.reportBizName = reportBizName;
	}

	public String getMngDeptName() {
		return mngDeptName;
	}

	public void setMngDeptName(String mngDeptName) {
		this.mngDeptName = mngDeptName;
	}

	public String getMngUserName() {
		return mngUserName;
	}

	public void setMngUserName(String mngUserName) {
		this.mngUserName = mngUserName;
	}

	public String getDeleteYn() {
		return deleteYn;
	}

	public void setDeleteYn(String deleteYn) {
		this.deleteYn = deleteYn;
	}

	public String getDeleteUserName() {
		return deleteUserName;
	}

	public void setDeleteUserName(String deleteUserName) {
		this.deleteUserName = deleteUserName;
	}

	public String getMngCustId() {
		return mngCustId;
	}

	public void setMngCustId(String mngCustId) {
		this.mngCustId = mngCustId;
	}

	public String getMngDeptId() {
		return mngDeptId;
	}

	public void setMngDeptId(String mngDeptId) {
		this.mngDeptId = mngDeptId;
	}

	public String getCustId() {
		return custId;
	}

	public void setCustId(String custId) {
		this.custId = custId;
	}

	public String getDeptId() {
		return deptId;
	}

	public void setDeptId(String deptId) {
		this.deptId = deptId;
	}

	public String getReqCustId() {
		return reqCustId;
	}

	public void setReqCustId(String reqCustId) {
		this.reqCustId = reqCustId;
	}

	public String getReqDeptId() {
		return reqDeptId;
	}

	public void setReqDeptId(String reqDeptId) {
		this.reqDeptId = reqDeptId;
	}

	public String getVehicId() {
		return vehicId;
	}

	public void setVehicId(String vehicId) {
		this.vehicId = vehicId;
	}

	public String getDriverId() {
		return driverId;
	}

	public void setDriverId(String driverId) {
		this.driverId = driverId;
	}

	public String getBuyAllocId() {
		return buyAllocId;
	}

	public void setBuyAllocId(String buyAllocId) {
		this.buyAllocId = buyAllocId;
	}

	public String getBuyChargeId() {
		return buyChargeId;
	}

	public void setBuyChargeId(String buyChargeId) {
		this.buyChargeId = buyChargeId;
	}

	public String getBuyWaypointChargeId() {
		return buyWaypointChargeId;
	}

	public void setBuyWaypointChargeId(String buyWaypointChargeId) {
		this.buyWaypointChargeId = buyWaypointChargeId;
	}

	public String getBuyStayChargeId() {
		return buyStayChargeId;
	}

	public void setBuyStayChargeId(String buyStayChargeId) {
		this.buyStayChargeId = buyStayChargeId;
	}

	public String getBuyHandworkChargeId() {
		return buyHandworkChargeId;
	}

	public void setBuyHandworkChargeId(String buyHandworkChargeId) {
		this.buyHandworkChargeId = buyHandworkChargeId;
	}

	public String getBuyRoundChargeId() {
		return buyRoundChargeId;
	}

	public void setBuyRoundChargeId(String buyRoundChargeId) {
		this.buyRoundChargeId = buyRoundChargeId;
	}

	public String getBuyOtheraddChargeId() {
		return buyOtheraddChargeId;
	}

	public void setBuyOtheraddChargeId(String buyOtheraddChargeId) {
		this.buyOtheraddChargeId = buyOtheraddChargeId;
	}

	public String getBuyServiceFeeChargeId() {
		return buyServiceFeeChargeId;
	}

	public void setBuyServiceFeeChargeId(String buyServiceFeeChargeId) {
		this.buyServiceFeeChargeId = buyServiceFeeChargeId;
	}

	public String getAllocState() {
		return allocState;
	}

	public void setAllocState(String allocState) {
		this.allocState = allocState;
	}

	public String getAllocDateFull() {
		return allocDateFull;
	}

	public void setAllocDateFull(String allocDateFull) {
		this.allocDateFull = allocDateFull;
	}

	public String getsDateFull() {
		return sDateFull;
	}

	public void setsDateFull(String sDateFull) {
		this.sDateFull = sDateFull;
	}

	public String geteDateFull() {
		return eDateFull;
	}

	public void seteDateFull(String eDateFull) {
		this.eDateFull = eDateFull;
	}

	public String getTaxinvId() {
		return taxinvId;
	}

	public void setTaxinvId(String taxinvId) {
		this.taxinvId = taxinvId;
	}

	public String getCalcTypeCode() {
		return calcTypeCode;
	}

	public void setCalcTypeCode(String calcTypeCode) {
		this.calcTypeCode = calcTypeCode;
	}

	public String getsDate() {
		return sDate;
	}

	public void setsDate(String sDate) {
		this.sDate = sDate;
	}
}
