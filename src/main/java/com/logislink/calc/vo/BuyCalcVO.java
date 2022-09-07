package com.logislink.calc.vo;

public class BuyCalcVO {
	public int number;
	public String orderId;
	public String finishYn;
	public String finishUserName;
	public String allocDate;
	public String eDate;
	
	public String driverCarrierName;
	public String buyCustName;
	public String buyManagerName;
	public String buyManagerTel;
	public String carSctnName;
	public String fastPayYn;
	
	// 인수증
	public String receiptYn;
	// 계산서
	public String taxinvYn;
	
	public String sAddr;
	public String eAddr;
	public String wayPoint;
	
	// 매입액(소계)
	public int payableAmt;
	// 내수운송료
	public int buyCharge;
	// 경유비
	public int buyWaypointCharge;
	// 대기료
	public int buyStayCharge;
	// 수작업비
	public int buyHandworkCharge;
	// 회차료
	public int buyRoundCharge;
	// 기타추가비
	public int buyOtheraddCharge;
	// 서비스수수료
	public int buyServiceFeeCharge;
	// 청구구분
	public String chargeTypeName;
	// 수수료
	public int allocFee;
	// 지급액
	public int withdrawallAmt;
	
	public String goodsName;
	public String unitPriceTypeName;
	public int unitPrice;
	public String sellWeight;
	public int goodsWeight;
	public String custName;
	public String bizName;
	public String appName;
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
	public String custId;
	public String deptId;
	public String reqCustId;
	public String reqDeptId;
	
	public String buyAllocId;
	public String buyChargeId;
	public String buyWaypointChargeId;
	public String buyStayChargeId;
	public String buyHandworkChargeId;
	public String buyRoundChargeId;
	public String buyOtheraddChargeId;
	public String buyServiceFeeChargeId;
	
	public String allocState;
	public String allocDateFull;
	public String sDateFull;
	public String eDateFull;
	public String taxinvId;
}
