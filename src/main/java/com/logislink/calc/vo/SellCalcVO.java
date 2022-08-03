package com.logislink.calc.vo;

public class SellCalcVO {
	public int number;
	public String orderId;
	public String finishYn;
	public String finishUserName;
	public String allocDate;
	public String eDate;
	public String custName;
	public String bizName;
	public String sAddr;
	public String eAddr;
	// 2착지
	public String wayPoint;
	// 매출액(소계)
	public int unpaidAmt;
	// 내수운송료
	public int sellCharge;
	// 경유비
	public int sellWaypointCharge;
	// 대기료
	public int sellStayCharge;
	// 수작업비
	public int sellHandworkCharge;
	// 회차료
	public int sellRoundCharge;
	// 기타추가비
	public int sellOtheraddCharge;
	public String goodsName;
	public String unitPriceTypeName;
	public int unitPrice;
	public String sellWeight;
	public int goodsWeight;
	public String chargeTypeName;
	public int allocFee;
	// 입금액
	public int depositAmt;
	public String tranReceiptYn;
	public String tranReceiptUserName;
	public String sellTaxinvYn;
	public String sellTaxinvUserName;
	public String postsendYn;
	public String postsendUserName;
	// 매입액(소계)
	public int payableAmt;
	// 차량구분
	public String carSctnName;
	// 차량번호(운송사)
	public String buyCustName;
	// 차주명(담당자)
	public String buyCustManager;
	// 차주연락처(담당자연락처)
	public String buyCustMobile;
	// 빠른지급
	public String reqPayYn;
	// 인수증
	public String receiptYn;
	// 계산서
	public String taxinvYn;
	public String appName;
	public String driverCarrierName;
	public String finishMemo;
	public String refContent1;
	public String refContent2;
	public String reportBizNum;
	public String reportBizName;
	public String mngDeptName;
	public String mngUserName;
	public String deleteYn;
	public String deleteUserName;
	
	/* 숨김항목 */
	public String mngCustId;
	public String mngDeptId;
	public String sellAllocId;
	public String buyAllocId;
	public String custId;
	public String bizId;
	public String sellChargeId;
	public String sellWaypointChargeId;
	public String sellStayChargeId;
	public String sellHandworkChargeId;
	public String sellRoundChargeId;
	public String sellOtheraddChargeId;
	public String buyChargeId;
	public String buyWaypointChargeId;
	public String buyStayChargeId;
	public String buyHandworkChargeId;
	public String buyRoundChargeId;
	public String buyOtheraddChargeId;
	public String buyAllocfeeChargeId;
}
