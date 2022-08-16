package com.logislink.calc.vo;

public class SellCalcVO {
	private int number;
	private String orderId;
	private String finishYn;
	private String finishUserName;
	private String allocDate;
	private String eDate;
	private String custName;
	private String bizName;
	private String sAddr;
	private String eAddr;
	// 2착지
	private String wayPoint;
	// 매출액(소계)
	private int unpaidAmt;
	// 내수운송료
	private int sellCharge;
	// 경유비
	private int sellWaypointCharge;
	// 대기료
	private int sellStayCharge;
	// 수작업비
	private int sellHandworkCharge;
	// 회차료
	private int sellRoundCharge;
	// 기타추가비
	private int sellOtheraddCharge;
	private String goodsName;
	private String unitPriceTypeName;
	private int unitPrice;
	private String sellWeight;
	private int goodsWeight;
	private String chargeTypeName;
	private int allocFee;
	// 입금액
	private int depositAmt;
	private String tranReceiptYn;
	private String tranReceiptUserName;
	private String sellTaxinvYn;
	private String sellTaxinvUserName;
	private String postsendYn;
	private String postsendUserName;
	private String finishMemo;
	private String refContent1;
	private String refContent2;
	private String mngDeptName;
	private String mngUserName;
	private String deleteYn;
	private String deleteUserName;
	
	/* 숨김항목 */
	private String mngCustId;
	private String mngDeptId;
	private String sellAllocId;
	private String custId;
	private String deptId;
	private String bizId;
	private String sellChargeId;
	private String sellWaypointChargeId;
	private String sellStayChargeId;
	private String sellHandworkChargeId;
	private String sellRoundChargeId;
	private String sellOtheraddChargeId;
	private String chargeTypeCode;
	private String carNum;
	private String vehicId;
	private String driverId;
	private String allocDateFull;
	private String sDateFull;
	private String eDateFull;
	
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
	public int getUnpaidAmt() {
		return unpaidAmt;
	}
	public void setUnpaidAmt(int unpaidAmt) {
		this.unpaidAmt = unpaidAmt;
	}
	public int getSellCharge() {
		return sellCharge;
	}
	public void setSellCharge(int sellCharge) {
		this.sellCharge = sellCharge;
	}
	public int getSellWaypointCharge() {
		return sellWaypointCharge;
	}
	public void setSellWaypointCharge(int sellWaypointCharge) {
		this.sellWaypointCharge = sellWaypointCharge;
	}
	public int getSellStayCharge() {
		return sellStayCharge;
	}
	public void setSellStayCharge(int sellStayCharge) {
		this.sellStayCharge = sellStayCharge;
	}
	public int getSellHandworkCharge() {
		return sellHandworkCharge;
	}
	public void setSellHandworkCharge(int sellHandworkCharge) {
		this.sellHandworkCharge = sellHandworkCharge;
	}
	public int getSellRoundCharge() {
		return sellRoundCharge;
	}
	public void setSellRoundCharge(int sellRoundCharge) {
		this.sellRoundCharge = sellRoundCharge;
	}
	public int getSellOtheraddCharge() {
		return sellOtheraddCharge;
	}
	public void setSellOtheraddCharge(int sellOtheraddCharge) {
		this.sellOtheraddCharge = sellOtheraddCharge;
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
	public int getDepositAmt() {
		return depositAmt;
	}
	public void setDepositAmt(int depositAmt) {
		this.depositAmt = depositAmt;
	}
	public String getTranReceiptYn() {
		return tranReceiptYn;
	}
	public void setTranReceiptYn(String tranReceiptYn) {
		this.tranReceiptYn = tranReceiptYn;
	}
	public String getTranReceiptUserName() {
		return tranReceiptUserName;
	}
	public void setTranReceiptUserName(String tranReceiptUserName) {
		this.tranReceiptUserName = tranReceiptUserName;
	}
	public String getSellTaxinvYn() {
		return sellTaxinvYn;
	}
	public void setSellTaxinvYn(String sellTaxinvYn) {
		this.sellTaxinvYn = sellTaxinvYn;
	}
	public String getSellTaxinvUserName() {
		return sellTaxinvUserName;
	}
	public void setSellTaxinvUserName(String sellTaxinvUserName) {
		this.sellTaxinvUserName = sellTaxinvUserName;
	}
	public String getPostsendYn() {
		return postsendYn;
	}
	public void setPostsendYn(String postsendYn) {
		this.postsendYn = postsendYn;
	}
	public String getPostsendUserName() {
		return postsendUserName;
	}
	public void setPostsendUserName(String postsendUserName) {
		this.postsendUserName = postsendUserName;
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
	public String getSellAllocId() {
		return sellAllocId;
	}
	public void setSellAllocId(String sellAllocId) {
		this.sellAllocId = sellAllocId;
	}
	public String getCustId() {
		return custId;
	}
	public void setCustId(String custId) {
		this.custId = custId;
	}
	public String getBizId() {
		return bizId;
	}
	public void setBizId(String bizId) {
		this.bizId = bizId;
	}
	public String getSellChargeId() {
		return sellChargeId;
	}
	public void setSellChargeId(String sellChargeId) {
		this.sellChargeId = sellChargeId;
	}
	public String getSellWaypointChargeId() {
		return sellWaypointChargeId;
	}
	public void setSellWaypointChargeId(String sellWaypointChargeId) {
		this.sellWaypointChargeId = sellWaypointChargeId;
	}
	public String getSellStayChargeId() {
		return sellStayChargeId;
	}
	public void setSellStayChargeId(String sellStayChargeId) {
		this.sellStayChargeId = sellStayChargeId;
	}
	public String getSellHandworkChargeId() {
		return sellHandworkChargeId;
	}
	public void setSellHandworkChargeId(String sellHandworkChargeId) {
		this.sellHandworkChargeId = sellHandworkChargeId;
	}
	public String getSellRoundChargeId() {
		return sellRoundChargeId;
	}
	public void setSellRoundChargeId(String sellRoundChargeId) {
		this.sellRoundChargeId = sellRoundChargeId;
	}
	public String getSellOtheraddChargeId() {
		return sellOtheraddChargeId;
	}
	public void setSellOtheraddChargeId(String sellOtheraddChargeId) {
		this.sellOtheraddChargeId = sellOtheraddChargeId;
	}
	public String getChargeTypeCode() {
		return chargeTypeCode;
	}
	public void setChargeTypeCode(String chargeTypeCode) {
		this.chargeTypeCode = chargeTypeCode;
	}
	public String getCarNum() {
		return carNum;
	}
	public void setCarNum(String carNum) {
		this.carNum = carNum;
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
	public String getDeptId() {
		return deptId;
	}
	public void setDeptId(String deptId) {
		this.deptId = deptId;
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
}
