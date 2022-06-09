package com.logislink.calc.vo;

public class OrderCalcVO {

	   private int number;
	   private String orderId;            //오더 ID
	   private String reqCustName;
	   private String sAddr;            //상차지주소
	   private String sDate;            //상차일 (YYYY-MM-DD HH:mm:ss)
	   private String sDateDay;            //상차일 (YYYY-MM-DD HH:mm:ss)
	   private String eAddr;            //하차지 주소
	   private String eDate;            //하차일 (YYYY-MM-DD HH:mm:ss)
	   private String eDateDay;            //하차일 (YYYY-MM-DD HH:mm:ss)
	   private String returnYn;         //왕복여부
	   private int stopCount;            //경유지 
	   private String stopName;			// 대표 경유지
	   private String goodsName;
	   private String mngDeptName;
	   
	   /* 매출 정보  */
	   private String sellAllocId;            //매출 배차 ID
	   private String sellCustId;         //매출 거래처 ID 
	   private String sellDeptId;         //매출 부서 ID
	   private int sellCharge;            //매출운송비
	   private String sellWeight;	   //청구중량
	   private String sellWayPointMemo;		//경유비 메모
	   private String sellWayPointCharge;	//경유비 금액
	   private String sellStayMemo;			//대기료 메모
	   private String sellStayCharge;		//대기료 금액
	   private String sellHandWorkMemo;		//수작업비 메모
	   private String sellHandWorkCharge;	//수작업비 금액
	   private String sellRoundMemo;		//회차료 메모
	   private String sellRoundCharge;		//회차료 금액
	   private String sellOtherAddMemo;		//기타추가비 메모
	   private String sellOtherAddCharge;	//기타추가비 금액
	   private String unitPriceType;		//단가구분
	   private int unitCharge;				//단가금액
	   private String sellFinishDate;		
	   private String chargeType;
	   
	   /* 매입 정보 */
	   private String allocId;            //매입 배차 ID
	   private String buyCustId;         //매입 거래처 ID (물량 받는곳)
	   private String buyDeptId;         //매입 부서 ID
	   private String buyCustName;         
	   private String buyDeptName;
	   private String buyStaff;         //매입거래처담당자
	   private String buyStaffId;         //매입거래처담당자 ID
	   private String buyStaffTel;
	   private int buyCharge;            //매입운송비
	   private int buyFee;               //매입수수료
	   private String allocDate;         //배차일 (매입 정보 지정일)
	   private String wayPointMemo;		//경유비 메모
	   private String wayPointCharge;	//경유비 금액
	   private String stayMemo;			//대기료 메모
	   private String stayCharge;		//대기료 금액
	   private String handWorkMemo;		//수작업비 메모
	   private String handWorkCharge;	//수작업비 금액
	   private String roundMemo;		//회차료 메모
	   private String roundCharge;		//회차료 금액
	   private String otherAddMemo;		//기타추가비 메모
	   private String otherAddCharge;	//기타추가비 금액
	   private String buyFinishDate;
	   	   
	   /* 배차 기사 정보*/
	   private String driverState;      //기사 배차 상태         
	   private String vehicId;          //차량 id
	   private String driverId;         //기사 id
	   private String carNum;           //차량번호
	   private String driverName;       //기사명
	   private String driverTel;      	//기사연락처
	   private String driverStateName;
	   private String carSctnCode;
	   private String carSctnName;
	   private String buyCarTonCode;	//톤수
	   private String buyCarTypeCode;	//차종
	   private String carTonName;
	   private String carTypeName;
	   private String carPayType;		//기사빠른지급여부
	   private String allocStateName;
	   private String driverBizName;	//계산서 발행지
	   
	   private String staffName;	//배차원

	   private int sellAmt;
	   private int buyAmt;
	   private String reqPayDate;
	   private String receiptYn;
	   private String receiptDate;
	   private String taxinvYn;
	   private String taxinvDate;
	   private String invId;
	   private int withdrawalAmt;
	   
	   private String appName;		//어플명
	   private String finishMemo;	//마감 시 메모
	   private String refContent1;	//참고 내용 1
	   private String refContent2;	//참고 내용 2
	   private String reportBizNum;	//신고용 사업자번호
	   private String reportBizName;	//신고용 사업자명
	   private String finishUserName;
	   private String carrierName;
	   private String payReturnMemo;
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
	public String getReqCustName() {
		return reqCustName;
	}
	public void setReqCustName(String reqCustName) {
		this.reqCustName = reqCustName;
	}
	public String getsAddr() {
		return sAddr;
	}
	public void setsAddr(String sAddr) {
		this.sAddr = sAddr;
	}
	public String getsDate() {
		return sDate;
	}
	public void setsDate(String sDate) {
		this.sDate = sDate;
	}
	public String getsDateDay() {
		return sDateDay;
	}
	public void setsDateDay(String sDateDay) {
		this.sDateDay = sDateDay;
	}
	public String geteAddr() {
		return eAddr;
	}
	public void seteAddr(String eAddr) {
		this.eAddr = eAddr;
	}
	public String geteDate() {
		return eDate;
	}
	public void seteDate(String eDate) {
		this.eDate = eDate;
	}
	public String geteDateDay() {
		return eDateDay;
	}
	public void seteDateDay(String eDateDay) {
		this.eDateDay = eDateDay;
	}
	public String getReturnYn() {
		return returnYn;
	}
	public void setReturnYn(String returnYn) {
		this.returnYn = returnYn;
	}
	public int getStopCount() {
		return stopCount;
	}
	public void setStopCount(int stopCount) {
		this.stopCount = stopCount;
	}
	public String getStopName() {
		return stopName;
	}
	public void setStopName(String stopName) {
		this.stopName = stopName;
	}
	public String getGoodsName() {
		return goodsName;
	}
	public void setGoodsName(String goodsName) {
		this.goodsName = goodsName;
	}
	public String getMngDeptName() {
		return mngDeptName;
	}
	public void setMngDeptName(String mngDeptName) {
		this.mngDeptName = mngDeptName;
	}
	public String getSellAllocId() {
		return sellAllocId;
	}
	public void setSellAllocId(String sellAllocId) {
		this.sellAllocId = sellAllocId;
	}
	public String getSellCustId() {
		return sellCustId;
	}
	public void setSellCustId(String sellCustId) {
		this.sellCustId = sellCustId;
	}
	public String getSellDeptId() {
		return sellDeptId;
	}
	public void setSellDeptId(String sellDeptId) {
		this.sellDeptId = sellDeptId;
	}
	public int getSellCharge() {
		return sellCharge;
	}
	public void setSellCharge(int sellCharge) {
		this.sellCharge = sellCharge;
	}
	public String getSellWeight() {
		return sellWeight;
	}
	public void setSellWeight(String sellWeight) {
		this.sellWeight = sellWeight;
	}
	public String getSellWayPointMemo() {
		return sellWayPointMemo;
	}
	public void setSellWayPointMemo(String sellWayPointMemo) {
		this.sellWayPointMemo = sellWayPointMemo;
	}
	public String getSellWayPointCharge() {
		return sellWayPointCharge;
	}
	public void setSellWayPointCharge(String sellWayPointCharge) {
		this.sellWayPointCharge = sellWayPointCharge;
	}
	public String getSellStayMemo() {
		return sellStayMemo;
	}
	public void setSellStayMemo(String sellStayMemo) {
		this.sellStayMemo = sellStayMemo;
	}
	public String getSellStayCharge() {
		return sellStayCharge;
	}
	public void setSellStayCharge(String sellStayCharge) {
		this.sellStayCharge = sellStayCharge;
	}
	public String getSellHandWorkMemo() {
		return sellHandWorkMemo;
	}
	public void setSellHandWorkMemo(String sellHandWorkMemo) {
		this.sellHandWorkMemo = sellHandWorkMemo;
	}
	public String getSellHandWorkCharge() {
		return sellHandWorkCharge;
	}
	public void setSellHandWorkCharge(String sellHandWorkCharge) {
		this.sellHandWorkCharge = sellHandWorkCharge;
	}
	public String getSellRoundMemo() {
		return sellRoundMemo;
	}
	public void setSellRoundMemo(String sellRoundMemo) {
		this.sellRoundMemo = sellRoundMemo;
	}
	public String getSellRoundCharge() {
		return sellRoundCharge;
	}
	public void setSellRoundCharge(String sellRoundCharge) {
		this.sellRoundCharge = sellRoundCharge;
	}
	public String getSellOtherAddMemo() {
		return sellOtherAddMemo;
	}
	public void setSellOtherAddMemo(String sellOtherAddMemo) {
		this.sellOtherAddMemo = sellOtherAddMemo;
	}
	public String getSellOtherAddCharge() {
		return sellOtherAddCharge;
	}
	public void setSellOtherAddCharge(String sellOtherAddCharge) {
		this.sellOtherAddCharge = sellOtherAddCharge;
	}
	public String getUnitPriceType() {
		return unitPriceType;
	}
	public void setUnitPriceType(String unitPriceType) {
		this.unitPriceType = unitPriceType;
	}
	public int getUnitCharge() {
		return unitCharge;
	}
	public void setUnitCharge(int unitCharge) {
		this.unitCharge = unitCharge;
	}
	public String getSellFinishDate() {
		return sellFinishDate;
	}
	public void setSellFinishDate(String sellFinishDate) {
		this.sellFinishDate = sellFinishDate;
	}
	public String getChargeType() {
		return chargeType;
	}
	public void setChargeType(String chargeType) {
		this.chargeType = chargeType;
	}
	public String getAllocId() {
		return allocId;
	}
	public void setAllocId(String allocId) {
		this.allocId = allocId;
	}
	public String getBuyCustId() {
		return buyCustId;
	}
	public void setBuyCustId(String buyCustId) {
		this.buyCustId = buyCustId;
	}
	public String getBuyDeptId() {
		return buyDeptId;
	}
	public void setBuyDeptId(String buyDeptId) {
		this.buyDeptId = buyDeptId;
	}
	public String getBuyCustName() {
		return buyCustName;
	}
	public void setBuyCustName(String buyCustName) {
		this.buyCustName = buyCustName;
	}
	public String getBuyDeptName() {
		return buyDeptName;
	}
	public void setBuyDeptName(String buyDeptName) {
		this.buyDeptName = buyDeptName;
	}
	public String getBuyStaff() {
		return buyStaff;
	}
	public void setBuyStaff(String buyStaff) {
		this.buyStaff = buyStaff;
	}
	public String getBuyStaffId() {
		return buyStaffId;
	}
	public void setBuyStaffId(String buyStaffId) {
		this.buyStaffId = buyStaffId;
	}
	public String getBuyStaffTel() {
		return buyStaffTel;
	}
	public void setBuyStaffTel(String buyStaffTel) {
		this.buyStaffTel = buyStaffTel;
	}
	public int getBuyCharge() {
		return buyCharge;
	}
	public void setBuyCharge(int buyCharge) {
		this.buyCharge = buyCharge;
	}
	public int getBuyFee() {
		return buyFee;
	}
	public void setBuyFee(int buyFee) {
		this.buyFee = buyFee;
	}
	public String getAllocDate() {
		return allocDate;
	}
	public void setAllocDate(String allocDate) {
		this.allocDate = allocDate;
	}
	public String getWayPointMemo() {
		return wayPointMemo;
	}
	public void setWayPointMemo(String wayPointMemo) {
		this.wayPointMemo = wayPointMemo;
	}
	public String getWayPointCharge() {
		return wayPointCharge;
	}
	public void setWayPointCharge(String wayPointCharge) {
		this.wayPointCharge = wayPointCharge;
	}
	public String getStayMemo() {
		return stayMemo;
	}
	public void setStayMemo(String stayMemo) {
		this.stayMemo = stayMemo;
	}
	public String getStayCharge() {
		return stayCharge;
	}
	public void setStayCharge(String stayCharge) {
		this.stayCharge = stayCharge;
	}
	public String getHandWorkMemo() {
		return handWorkMemo;
	}
	public void setHandWorkMemo(String handWorkMemo) {
		this.handWorkMemo = handWorkMemo;
	}
	public String getHandWorkCharge() {
		return handWorkCharge;
	}
	public void setHandWorkCharge(String handWorkCharge) {
		this.handWorkCharge = handWorkCharge;
	}
	public String getRoundMemo() {
		return roundMemo;
	}
	public void setRoundMemo(String roundMemo) {
		this.roundMemo = roundMemo;
	}
	public String getRoundCharge() {
		return roundCharge;
	}
	public void setRoundCharge(String roundCharge) {
		this.roundCharge = roundCharge;
	}
	public String getOtherAddMemo() {
		return otherAddMemo;
	}
	public void setOtherAddMemo(String otherAddMemo) {
		this.otherAddMemo = otherAddMemo;
	}
	public String getOtherAddCharge() {
		return otherAddCharge;
	}
	public void setOtherAddCharge(String otherAddCharge) {
		this.otherAddCharge = otherAddCharge;
	}
	public String getBuyFinishDate() {
		return buyFinishDate;
	}
	public void setBuyFinishDate(String buyFinishDate) {
		this.buyFinishDate = buyFinishDate;
	}
	public String getDriverState() {
		return driverState;
	}
	public void setDriverState(String driverState) {
		this.driverState = driverState;
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
	public String getCarNum() {
		return carNum;
	}
	public void setCarNum(String carNum) {
		this.carNum = carNum;
	}
	public String getDriverName() {
		return driverName;
	}
	public void setDriverName(String driverName) {
		this.driverName = driverName;
	}
	public String getDriverTel() {
		return driverTel;
	}
	public void setDriverTel(String driverTel) {
		this.driverTel = driverTel;
	}
	public String getDriverStateName() {
		return driverStateName;
	}
	public void setDriverStateName(String driverStateName) {
		this.driverStateName = driverStateName;
	}
	public String getCarSctnCode() {
		return carSctnCode;
	}
	public void setCarSctnCode(String carSctnCode) {
		this.carSctnCode = carSctnCode;
	}
	public String getCarSctnName() {
		return carSctnName;
	}
	public void setCarSctnName(String carSctnName) {
		this.carSctnName = carSctnName;
	}
	public String getBuyCarTonCode() {
		return buyCarTonCode;
	}
	public void setBuyCarTonCode(String buyCarTonCode) {
		this.buyCarTonCode = buyCarTonCode;
	}
	public String getBuyCarTypeCode() {
		return buyCarTypeCode;
	}
	public void setBuyCarTypeCode(String buyCarTypeCode) {
		this.buyCarTypeCode = buyCarTypeCode;
	}
	public String getCarTonName() {
		return carTonName;
	}
	public void setCarTonName(String carTonName) {
		this.carTonName = carTonName;
	}
	public String getCarTypeName() {
		return carTypeName;
	}
	public void setCarTypeName(String carTypeName) {
		this.carTypeName = carTypeName;
	}
	public String getCarPayType() {
		return carPayType;
	}
	public void setCarPayType(String carPayType) {
		this.carPayType = carPayType;
	}
	public String getAllocStateName() {
		return allocStateName;
	}
	public void setAllocStateName(String allocStateName) {
		this.allocStateName = allocStateName;
	}
	public String getDriverBizName() {
		return driverBizName;
	}
	public void setDriverBizName(String driverBizName) {
		this.driverBizName = driverBizName;
	}
	public String getStaffName() {
		return staffName;
	}
	public void setStaffName(String staffName) {
		this.staffName = staffName;
	}
	public int getSellAmt() {
		return sellAmt;
	}
	public void setSellAmt(int sellAmt) {
		this.sellAmt = sellAmt;
	}
	public int getBuyAmt() {
		return buyAmt;
	}
	public void setBuyAmt(int buyAmt) {
		this.buyAmt = buyAmt;
	}
	public String getReqPayDate() {
		return reqPayDate;
	}
	public void setReqPayDate(String reqPayDate) {
		this.reqPayDate = reqPayDate;
	}
	public String getReceiptYn() {
		return receiptYn;
	}
	public void setReceiptYn(String receiptYn) {
		this.receiptYn = receiptYn;
	}
	public String getReceiptDate() {
		return receiptDate;
	}
	public void setReceiptDate(String receiptDate) {
		this.receiptDate = receiptDate;
	}
	public String getTaxinvYn() {
		return taxinvYn;
	}
	public void setTaxinvYn(String taxinvYn) {
		this.taxinvYn = taxinvYn;
	}
	public String getTaxinvDate() {
		return taxinvDate;
	}
	public void setTaxinvDate(String taxinvDate) {
		this.taxinvDate = taxinvDate;
	}
	public String getInvId() {
		return invId;
	}
	public void setInvId(String invId) {
		this.invId = invId;
	}
	public int getWithdrawalAmt() {
		return withdrawalAmt;
	}
	public void setWithdrawalAmt(int withdrawalAmt) {
		this.withdrawalAmt = withdrawalAmt;
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
	public String getFinishUserName() {
		return finishUserName;
	}
	public void setFinishUserName(String finishUserName) {
		this.finishUserName = finishUserName;
	}
	public String getCarrierName() {
		return carrierName;
	}
	public void setCarrierName(String carrierName) {
		this.carrierName = carrierName;
	}
	public String getPayReturnMemo() {
		return payReturnMemo;
	}
	public void setPayReturnMemo(String payReturnMemo) {
		this.payReturnMemo = payReturnMemo;
	}  
}
