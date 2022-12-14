package com.logislink.order.vo;

public class OrderVO {
	   private String orderId;            //오더 ID
	   private String reqCustId;         //화주 거래처 ID
	   private String reqCustName;
	   private String reqDeptId;         //화주 부서 ID
	   private String reqStaff;         //화주 담당자
	   private String reqStaffId;         //화주 담당 ID
	   private String reqTel;            //화주 연락처
	   private String reqAddr;            //화주 주소
	   private String reqAddrDetail;      //화주 상세주소
	   private String reqStaffName;			// 화주담당자(거래처기준)
	   private String reqStaffTel;			// 화주담당자연락처(거래처기준)
	   private String reqBizNum;		
	   private String reqBizName;
	   private String ReqCeo;
	   private String reqBizAddr;
	   private String reqTaxEmail;
	   private String reqTaxStaffName;
	   private String reqTaxTelNum;
	   private String custId;            //화주 지정 운송,주선사 ID
	   private String deptId;            //화주 지정 운송,주선사 부서 Id
	   private String inOutSctn;         //수출입구분(내수, 수출입)
	   private String inOutSctnName;
	   private String truckTypeCode;      //운송유형
	   private String truckTypeName;
	   private String sComName;         //상차지명
	   private String sSido;            //상차지시도
	   private String sGungu;            //상차지군구
	   private String sDong;            //상차지동
	   private String sAddr;            //상차지주소
	   private String sAddrDetail;         //상차지상세주소
	   private String sDate;            //상차일 (YYYY-MM-DD HH:mm:ss)
	   private String sStaff;            //상차지담당자
	   private String sTel;            //상차지 연락처
	   private String sMemo;            //상차지메모
	   private String eComName;         //하차지명
	   private String eSido;            //하차지시도
	   private String eGungu;            //하차지군구
	   private String eDong;            //하차지 동
	   private String eAddr;            //하차지 주소
	   private String eAddrDetail;         //하차지 상세주소
	   private String eDate;            //하차일 (YYYY-MM-DD HH:mm:ss)
	   private String eStaff;            //하차지 담당자
	   private String eTel;            //하차지 연락처
	   private String eMemo;            //하차지 메모
	   private double sLat;         
	   private double sLon;
	   private double eLat;
	   private double eLon;
	   private String goodsName;         //화물정보
	   private String goodsWeight;         //화물중량
	   private String weightUnitCode;      //중량단위코드
	   private String goodsQty;         //화물수량
	   private String qtyUnitCode;         //수량단위코드
	   private String sWayCode;         //상차방법
	   private String eWayCode;         //하차방법
	   private String mixYn;            //혼적여부
	   private String mixSize;            //혼적크기
	   private String returnYn;         //왕복여부
	   private String carTonCode;         
	   private String carTypeCode;
	   private String chargeType;         //운임구분코드(인수증.선착불)
	   private String allocKind;		//차량(D)/운송사(C)코드 
	   private String driverKind;		//차량데이터 유무 Y/N 
	   private String distance;   
	   private int time;
	   private String reqMemo;            //화주 요청사항 (주선사/운송사 확인)
	   private String driverMemo;         //기사 확인사항
	   private String itemCode;         //운송품목코드
	   private String regid;            //등록 id
	   private String regdate;            //오더 등록일
	   private String regname;			//등록직원이름
	   private int stopCount;            //경유지 
	   private String stopName;			// 대표 경유지
	   private int number;
	   private String sDateDay;
	   private String sDateTime;
	   private String eDateDay;
	   private String eDateTime;
	   private String orderState;
	   private String orderStateName;
	   private String memo;
	   private String staffId;			//담당자 아이디
	   private String payType;
	   private String orderCarTonName;
	   
	   private String deptName;
	   
	   /* 매출 정보  */
	   private String sellAllocId;            //매출 배차 ID
	   private String sellCustId;         //매출 거래처 ID 
	   private String sellDeptId;         //매출 부서 ID
	   private String sellStaff;         //매출거래처 담당자
	   private String sellStaffId;         //매출거래처 담당자 ID
	   private String sellStaffTel;
	   private String sellCustName;       
	   private String sellDeptName;
	   private int sellCharge;            //매출운송비
	   private int sellFee;            //매출수수료
	   private String sellWeight;	   //청구중량
	   private String sellLinkYn;
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
	   private String custMngCode;			//거래처등급코드
	   private String custMngName;			//거래처등급코드
	   private String custMngMemo;			//거래처등급사유
	   private String custMngCodeName;		//거래처등급이름
	   private String custPayType;			//거래처빠른지급여부
	   private String sellFinishDate;		
	   
	   /* 매입 정보 */
	   private String allocId;            //매입 배차 ID
	   private String allocState;         //배차상태
	   private String allocStateName;
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
	   private String buyDriverId;
	   private String buyVehicId;
	   private String buyDriverName;
	   private String buyDriverTel;
	   private String buyCarNum;
	   private String buyLinkYn;
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
	   private String driverAllocId;	//기사 배차 ID
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
	   private String buyCargoBox;	    //적재함길이
	   private String carMngCode; 		//기사등급코드
	   private String carMngName; 		//기사등급코드
	   private String carMngMemo;		//기사등급사유
	   private String dangerGoodsYn;
	   private String chemicalsYn;
	   private String foreignLicenseYn;
	   private String forkliftYn;
	   private String carTonName;
	   private String carTypeName;
	   private String carPayType;		//기사빠른지급여부
	   
	   /* 차량 상태 정보*/
	   private String startDate;
	   private String finishDate;
	   private String enterDate;
	   
	   private String linkName;		//정보망 연계
	   private String linkType;		//정보망 연계
	   private String linkSettleYn;	//정보망 확정여부
	   
	   private String staffName;	//배차원

	   private int sellAmt;
	   private int buyAmt;
	   private String reqPayDate;
	   private String receiptYn;
	   private String receiptDate;
	   private String taxinvYn;
	   private String taxinvDate;
	   private String invId;
	   //알림톡 사용여부 추가
	   private String talkYn;
	   private int finishCnt;
	   private int taxCnt;

	   private String salesFinish;
	   private String salesTaxinv;
	   private String purchaseFinish;
	   private String purchaseTaxinv;

	   private String modId;
	   private String modDate;
	   
	public String getOrderId() {
		return orderId;
	}
	public String getReqCustId() {
		return reqCustId;
	}
	public String getReqDeptId() {
		return reqDeptId;
	}
	public String getReqStaff() {
		return reqStaff;
	}
	public String getReqTel() {
		return reqTel;
	}
	public String getReqAddr() {
		return reqAddr;
	}
	public String getReqAddrDetail() {
		return reqAddrDetail;
	}	
	public String getReqStaffName() {
		return reqStaffName;
	}
	public void setReqStaffName(String reqStaffName) {
		this.reqStaffName = reqStaffName;
	}	
	public String getReqStaffTel() {
		return reqStaffTel;
	}
	public void setReqStaffTel(String reqStaffTel) {
		this.reqStaffTel = reqStaffTel;
	}
	public String getCustId() {
		return custId;
	}
	public String getDeptId() {
		return deptId;
	}
	public String getInOutSctn() {
		return inOutSctn;
	}
	public String getInOutSctnName() {
		return inOutSctnName;
	}
	public String getTruckTypeCode() {
		return truckTypeCode;
	}
	public String getTruckTypeName() {
		return truckTypeName;
	}
	public String getsComName() {
		return sComName;
	}
	public String getsSido() {
		return sSido;
	}
	public String getsGungu() {
		return sGungu;
	}
	public String getsDong() {
		return sDong;
	}
	public String getsAddr() {
		return sAddr;
	}
	public String getsAddrDetail() {
		return sAddrDetail;
	}
	public String getsDate() {
		return sDate;
	}
	public String getsStaff() {
		return sStaff;
	}
	public String getsTel() {
		return sTel;
	}
	public String getsMemo() {
		return sMemo;
	}
	public String geteComName() {
		return eComName;
	}
	public String geteSido() {
		return eSido;
	}
	public String geteGungu() {
		return eGungu;
	}
	public String geteDong() {
		return eDong;
	}
	public String geteAddr() {
		return eAddr;
	}
	public String geteAddrDetail() {
		return eAddrDetail;
	}
	public String geteDate() {
		return eDate;
	}
	public String geteStaff() {
		return eStaff;
	}
	public String geteTel() {
		return eTel;
	}
	public String geteMemo() {
		return eMemo;
	}
	public double getsLat() {
		return sLat;
	}
	public double getsLon() {
		return sLon;
	}
	public double geteLat() {
		return eLat;
	}
	public double geteLon() {
		return eLon;
	}
	public String getGoodsName() {
		return goodsName;
	}
	public String getGoodsWeight() {
		return goodsWeight;
	}
	public String getWeightUnitCode() {
		return weightUnitCode;
	}
	public String getGoodsQty() {
		return goodsQty;
	}
	public String getQtyUnitCode() {
		return qtyUnitCode;
	}
	public String getsWayCode() {
		return sWayCode;
	}
	public String geteWayCode() {
		return eWayCode;
	}
	public String getMixYn() {
		return mixYn;
	}
	public String getMixSize() {
		return mixSize;
	}
	public String getReturnYn() {
		return returnYn;
	}
	public String getCarTonCode() {
		return carTonCode;
	}
	public String getCarTypeCode() {
		return carTypeCode;
	}
	public String getChargeType() {
		return chargeType;
	}
	public String getDistance() {
		return distance;
	}
	public int getTime() {
		return time;
	}
	public String getReqMemo() {
		return reqMemo;
	}
	public String getDriverMemo() {
		return driverMemo;
	}
	public String getItemCode() {
		return itemCode;
	}
	public String getRegid() {
		return regid;
	}
	public String getRegdate() {
		return regdate;
	}	
	public String getRegname() {
		return regname;
	}
	public void setRegname(String regname) {
		this.regname = regname;
	}
	public int getStopCount() {
		return stopCount;
	}
	public String getSellAllocId() {
		return sellAllocId;
	}
	public String getSellCustId() {
		return sellCustId;
	}
	public String getSellDeptId() {
		return sellDeptId;
	}
	public String getSellStaff() {
		return sellStaff;
	}
	public String getSellCustName() {
		return sellCustName;
	}
	public String getSellDeptName() {
		return sellDeptName;
	}
	public int getSellCharge() {
		return sellCharge;
	}
	public int getSellFee() {
		return sellFee;
	}
	public String getAllocId() {
		return allocId;
	}
	public String getAllocState() {
		return allocState;
	}
	public String getAllocStateName() {
		return allocStateName;
	}
	public String getBuyCustId() {
		return buyCustId;
	}
	public String getBuyDeptId() {
		return buyDeptId;
	}
	public String getBuyCustName() {
		return buyCustName;
	}
	public String getBuyDeptName() {
		return buyDeptName;
	}
	public String getBuyStaff() {
		return buyStaff;
	}
	public int getBuyCharge() {
		return buyCharge;
	}
	public int getBuyFee() {
		return buyFee;
	}
	public String getAllocDate() {
		return allocDate;
	}
	public String getDriverState() {
		return driverState;
	}
	public String getVehicId() {
		return vehicId;
	}
	public String getDriverId() {
		return driverId;
	}
	public String getCarNum() {
		return carNum;
	}
	public String getDriverName() {
		return driverName;
	}
	public String getDriverTel() {
		return driverTel;
	}
	public String getDriverStateName() {
		return driverStateName;
	}
	public void setOrderId(String orderId) {
		this.orderId = orderId;
	}
	public void setReqCustId(String reqCustId) {
		this.reqCustId = reqCustId;
	}
	public void setReqDeptId(String reqDeptId) {
		this.reqDeptId = reqDeptId;
	}
	public void setReqStaff(String reqStaff) {
		this.reqStaff = reqStaff;
	}
	public void setReqTel(String reqTel) {
		this.reqTel = reqTel;
	}
	public void setReqAddr(String reqAddr) {
		this.reqAddr = reqAddr;
	}
	public void setReqAddrDetail(String reqAddrDetail) {
		this.reqAddrDetail = reqAddrDetail;
	}
	public void setCustId(String custId) {
		this.custId = custId;
	}
	public void setDeptId(String deptId) {
		this.deptId = deptId;
	}
	public void setInOutSctn(String inOutSctn) {
		this.inOutSctn = inOutSctn;
	}
	public void setInOutSctnName(String inOutSctnName) {
		this.inOutSctnName = inOutSctnName;
	}
	public void setTruckTypeCode(String truckTypeCode) {
		this.truckTypeCode = truckTypeCode;
	}
	public void setTruckTypeName(String truckTypeName) {
		this.truckTypeName = truckTypeName;
	}
	public void setsComName(String sComName) {
		this.sComName = sComName;
	}
	public void setsSido(String sSido) {
		this.sSido = sSido;
	}
	public void setsGungu(String sGungu) {
		this.sGungu = sGungu;
	}
	public void setsDong(String sDong) {
		this.sDong = sDong;
	}
	public void setsAddr(String sAddr) {
		this.sAddr = sAddr;
	}
	public void setsAddrDetail(String sAddrDetail) {
		this.sAddrDetail = sAddrDetail;
	}
	public void setsDate(String sDate) {
		this.sDate = sDate;
	}
	public void setsStaff(String sStaff) {
		this.sStaff = sStaff;
	}
	public void setsTel(String sTel) {
		this.sTel = sTel;
	}
	public void setsMemo(String sMemo) {
		this.sMemo = sMemo;
	}
	public void seteComName(String eComName) {
		this.eComName = eComName;
	}
	public void seteSido(String eSido) {
		this.eSido = eSido;
	}
	public void seteGungu(String eGungu) {
		this.eGungu = eGungu;
	}
	public void seteDong(String eDong) {
		this.eDong = eDong;
	}
	public void seteAddr(String eAddr) {
		this.eAddr = eAddr;
	}
	public void seteAddrDetail(String eAddrDetail) {
		this.eAddrDetail = eAddrDetail;
	}
	public void seteDate(String eDate) {
		this.eDate = eDate;
	}
	public void seteStaff(String eStaff) {
		this.eStaff = eStaff;
	}
	public void seteTel(String eTel) {
		this.eTel = eTel;
	}
	public void seteMemo(String eMemo) {
		this.eMemo = eMemo;
	}
	public void setsLat(double sLat) {
		this.sLat = sLat;
	}
	public void setsLon(double sLon) {
		this.sLon = sLon;
	}
	public void seteLat(double eLat) {
		this.eLat = eLat;
	}
	public void seteLon(double eLon) {
		this.eLon = eLon;
	}
	public void setGoodsName(String goodsName) {
		this.goodsName = goodsName;
	}
	public void setGoodsWeight(String goodsWeight) {
		this.goodsWeight = goodsWeight;
	}
	public void setWeightUnitCode(String weightUnitCode) {
		this.weightUnitCode = weightUnitCode;
	}
	public void setGoodsQty(String goodsQty) {
		this.goodsQty = goodsQty;
	}
	public void setQtyUnitCode(String qtyUnitCode) {
		this.qtyUnitCode = qtyUnitCode;
	}
	public void setsWayCode(String sWayCode) {
		this.sWayCode = sWayCode;
	}
	public void seteWayCode(String eWayCode) {
		this.eWayCode = eWayCode;
	}
	public void setMixYn(String mixYn) {
		this.mixYn = mixYn;
	}
	public void setMixSize(String mixSize) {
		this.mixSize = mixSize;
	}
	public void setReturnYn(String returnYn) {
		this.returnYn = returnYn;
	}
	public void setCarTonCode(String carTonCode) {
		this.carTonCode = carTonCode;
	}
	public void setCarTypeCode(String carTypeCode) {
		this.carTypeCode = carTypeCode;
	}
	public void setChargeType(String chargeType) {
		this.chargeType = chargeType;
	}
	public void setDistance(String distance) {
		this.distance = distance;
	}
	public void setTime(int time) {
		this.time = time;
	}
	public void setReqMemo(String reqMemo) {
		this.reqMemo = reqMemo;
	}
	public void setDriverMemo(String driverMemo) {
		this.driverMemo = driverMemo;
	}
	public void setItemCode(String itemCode) {
		this.itemCode = itemCode;
	}
	public void setRegid(String regid) {
		this.regid = regid;
	}
	public void setRegdate(String regdate) {
		this.regdate = regdate;
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
	public void setSellAllocId(String sellAllocId) {
		this.sellAllocId = sellAllocId;
	}
	public void setSellCustId(String sellCustId) {
		this.sellCustId = sellCustId;
	}
	public void setSellDeptId(String sellDeptId) {
		this.sellDeptId = sellDeptId;
	}
	public void setSellStaff(String sellStaff) {
		this.sellStaff = sellStaff;
	}
	public void setSellCustName(String sellCustName) {
		this.sellCustName = sellCustName;
	}
	public void setSellDeptName(String sellDeptName) {
		this.sellDeptName = sellDeptName;
	}
	public void setSellCharge(int sellCharge) {
		this.sellCharge = sellCharge;
	}
	public void setSellFee(int sellFee) {
		this.sellFee = sellFee;
	}
	public void setAllocId(String allocId) {
		this.allocId = allocId;
	}
	public void setAllocState(String allocState) {
		this.allocState = allocState;
	}
	public void setAllocStateName(String allocStateName) {
		this.allocStateName = allocStateName;
	}
	public void setBuyCustId(String buyCustId) {
		this.buyCustId = buyCustId;
	}
	public void setBuyDeptId(String buyDeptId) {
		this.buyDeptId = buyDeptId;
	}
	public void setBuyCustName(String buyCustName) {
		this.buyCustName = buyCustName;
	}
	public void setBuyDeptName(String buyDeptName) {
		this.buyDeptName = buyDeptName;
	}
	public void setBuyStaff(String buyStaff) {
		this.buyStaff = buyStaff;
	}
	public void setBuyCharge(int buyCharge) {
		this.buyCharge = buyCharge;
	}
	public void setBuyFee(int buyFee) {
		this.buyFee = buyFee;
	}
	public void setAllocDate(String allocDate) {
		this.allocDate = allocDate;
	}	
	public String getDriverAllocId() {
		return driverAllocId;
	}
	public void setDriverAllocId(String driverAllocId) {
		this.driverAllocId = driverAllocId;
	}
	public void setDriverState(String driverState) {
		this.driverState = driverState;
	}
	public void setVehicId(String vehicId) {
		this.vehicId = vehicId;
	}
	public void setDriverId(String driverId) {
		this.driverId = driverId;
	}
	public void setCarNum(String carNum) {
		this.carNum = carNum;
	}
	public void setDriverName(String driverName) {
		this.driverName = driverName;
	}
	public void setDriverTel(String driverTel) {
		this.driverTel = driverTel;
	}
	public void setDriverStateName(String driverStateName) {
		this.driverStateName = driverStateName;
	}
	public int getNumber() {
		return number;
	}
	public String getsDateDay() {
		return sDateDay;
	}
	public String getsDateTime() {
		return sDateTime;
	}
	public String geteDateDay() {
		return eDateDay;
	}
	public String geteDateTime() {
		return eDateTime;
	}
	
	public void setNumber(int number) {
		this.number = number;
	}
	public void setsDateDay(String sDateDay) {
		this.sDateDay = sDateDay;
	}
	public void setsDateTime(String sDateTime) {
		this.sDateTime = sDateTime;
	}
	public void seteDateDay(String eDateDay) {
		this.eDateDay = eDateDay;
	}
	public void seteDateTime(String eDateTime) {
		this.eDateTime = eDateTime;
	}
	public String getReqStaffId() {
		return reqStaffId;
	}
	public String getSellStaffId() {
		return sellStaffId;
	}
	public String getBuyStaffId() {
		return buyStaffId;
	}
	public void setReqStaffId(String reqStaffId) {
		this.reqStaffId = reqStaffId;
	}
	public void setSellStaffId(String sellStaffId) {
		this.sellStaffId = sellStaffId;
	}
	public void setBuyStaffId(String buyStaffId) {
		this.buyStaffId = buyStaffId;
	}
	public String getBuyDriverId() {
		return buyDriverId;
	}
	public String getBuyVehicId() {
		return buyVehicId;
	}
	public String getBuyDriverName() {
		return buyDriverName;
	}
	public String getBuyDriverTel() {
		return buyDriverTel;
	}
	public String getBuyCarNum() {
		return buyCarNum;
	}
	public void setBuyDriverId(String buyDriverId) {
		this.buyDriverId = buyDriverId;
	}
	public void setBuyVehicId(String buyVehicId) {
		this.buyVehicId = buyVehicId;
	}
	public void setBuyDriverName(String buyDriverName) {
		this.buyDriverName = buyDriverName;
	}
	public void setBuyDriverTel(String buyDriverTel) {
		this.buyDriverTel = buyDriverTel;
	}
	public void setBuyCarNum(String buyCarNum) {
		this.buyCarNum = buyCarNum;
	}
	public String getAllocKind() {
		return allocKind;
	}
	public void setAllocKind(String allocKind) {
		this.allocKind = allocKind;
	}
	public String getDriverKind() {
		return driverKind;
	}
	public void setDriverKind(String driverKind) {
		this.driverKind = driverKind;
	}
	public String getStartDate() {
		return startDate;
	}
	public String getFinishDate() {
		return finishDate;
	}
	public String getEnterDate() {
		return enterDate;
	}
	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}
	public void setFinishDate(String finishDate) {
		this.finishDate = finishDate;
	}
	public void setEnterDate(String enterDate) {
		this.enterDate = enterDate;
	}	
	public String getOrderState() {
		return orderState;
	}
	public void setOrderState(String orderState) {
		this.orderState = orderState;
	}
	public String getOrderStateName() {
		return orderStateName;
	}
	public void setOrderStateName(String orderStateName) {
		this.orderStateName = orderStateName;
	}	
	public String getMemo() {
		return memo;
	}
	public void setMemo(String memo) {
		this.memo = memo;
	}
	public String getSellLinkYn() {
		return sellLinkYn;
	}
	public void setSellLinkYn(String sellLinkYn) {
		this.sellLinkYn = sellLinkYn;
	}
	public String getBuyLinkYn() {
		return buyLinkYn;
	}
	public void setBuyLinkYn(String buyLinkYn) {
		this.buyLinkYn = buyLinkYn;
	}
	public String getSellStaffTel() {
		return sellStaffTel;
	}
	public void setSellStaffTel(String sellStaffTel) {
		this.sellStaffTel = sellStaffTel;
	}
	public String getBuyStaffTel() {
		return buyStaffTel;
	}
	public void setBuyStaffTel(String buyStaffTel) {
		this.buyStaffTel = buyStaffTel;
	}
	public String getCarSctnCode() {
		return carSctnCode;
	}
	public void setCarSctnCode(String carSctnCode) {
		this.carSctnCode = carSctnCode;
	}
	public String getDeptName() {
		return deptName;
	}
	public void setDeptName(String deptName) {
		this.deptName = deptName;
	}
	public String getWayPointMemo() {
		return wayPointMemo;
	}
	public String getWayPointCharge() {
		return wayPointCharge;
	}
	public String getStayMemo() {
		return stayMemo;
	}
	public String getStayCharge() {
		return stayCharge;
	}
	public String getHandWorkMemo() {
		return handWorkMemo;
	}
	public String getHandWorkCharge() {
		return handWorkCharge;
	}
	public String getRoundMemo() {
		return roundMemo;
	}
	public String getRoundCharge() {
		return roundCharge;
	}
	public String getOtherAddMemo() {
		return otherAddMemo;
	}
	public String getOtherAddCharge() {
		return otherAddCharge;
	}
	public void setWayPointMemo(String wayPointMemo) {
		this.wayPointMemo = wayPointMemo;
	}
	public void setWayPointCharge(String wayPointCharge) {
		this.wayPointCharge = wayPointCharge;
	}
	public void setStayMemo(String stayMemo) {
		this.stayMemo = stayMemo;
	}
	public void setStayCharge(String stayCharge) {
		this.stayCharge = stayCharge;
	}
	public void setHandWorkMemo(String handWorkMemo) {
		this.handWorkMemo = handWorkMemo;
	}
	public void setHandWorkCharge(String handWorkCharge) {
		this.handWorkCharge = handWorkCharge;
	}
	public void setRoundMemo(String roundMemo) {
		this.roundMemo = roundMemo;
	}
	public void setRoundCharge(String roundCharge) {
		this.roundCharge = roundCharge;
	}
	public void setOtherAddMemo(String otherAddMemo) {
		this.otherAddMemo = otherAddMemo;
	}
	public void setOtherAddCharge(String otherAddCharge) {
		this.otherAddCharge = otherAddCharge;
	}
	public String getBuyCarTonCode() {
		return buyCarTonCode;
	}
	public String getBuyCarTypeCode() {
		return buyCarTypeCode;
	}
	public void setBuyCarTonCode(String buyCarTonCode) {
		this.buyCarTonCode = buyCarTonCode;
	}
	public void setBuyCarTypeCode(String buyCarTypeCode) {
		this.buyCarTypeCode = buyCarTypeCode;
	}
	public String getBuyCargoBox() {
		return buyCargoBox;
	}
	public void setBuyCargoBox(String buyCargoBox) {
		this.buyCargoBox = buyCargoBox;
	}
	public String getLinkName() {
		return linkName;
	}
	public void setLinkName(String linkName) {
		this.linkName = linkName;
	}
	public String getLinkType() {
		return linkType;
	}
	public void setLinkType(String linkType) {
		this.linkType = linkType;
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
	public String getSellWayPointCharge() {
		return sellWayPointCharge;
	}
	public String getSellStayMemo() {
		return sellStayMemo;
	}
	public String getSellStayCharge() {
		return sellStayCharge;
	}
	public String getSellHandWorkMemo() {
		return sellHandWorkMemo;
	}
	public String getSellHandWorkCharge() {
		return sellHandWorkCharge;
	}
	public String getSellRoundMemo() {
		return sellRoundMemo;
	}
	public String getSellRoundCharge() {
		return sellRoundCharge;
	}
	public String getSellOtherAddMemo() {
		return sellOtherAddMemo;
	}
	public String getSellOtherAddCharge() {
		return sellOtherAddCharge;
	}
	public void setSellWayPointMemo(String sellWayPointMemo) {
		this.sellWayPointMemo = sellWayPointMemo;
	}
	public void setSellWayPointCharge(String sellWayPointCharge) {
		this.sellWayPointCharge = sellWayPointCharge;
	}
	public void setSellStayMemo(String sellStayMemo) {
		this.sellStayMemo = sellStayMemo;
	}
	public void setSellStayCharge(String sellStayCharge) {
		this.sellStayCharge = sellStayCharge;
	}
	public void setSellHandWorkMemo(String sellHandWorkMemo) {
		this.sellHandWorkMemo = sellHandWorkMemo;
	}
	public void setSellHandWorkCharge(String sellHandWorkCharge) {
		this.sellHandWorkCharge = sellHandWorkCharge;
	}
	public void setSellRoundMemo(String sellRoundMemo) {
		this.sellRoundMemo = sellRoundMemo;
	}
	public void setSellRoundCharge(String sellRoundCharge) {
		this.sellRoundCharge = sellRoundCharge;
	}
	public void setSellOtherAddMemo(String sellOtherAddMemo) {
		this.sellOtherAddMemo = sellOtherAddMemo;
	}
	public void setSellOtherAddCharge(String sellOtherAddCharge) {
		this.sellOtherAddCharge = sellOtherAddCharge;
	}
	public String getStaffId() {
		return staffId;
	}
	public void setStaffId(String staffId) {
		this.staffId = staffId;
	}
	public String getUnitPriceType() {
		return unitPriceType;
	}
	public int getUnitCharge() {
		return unitCharge;
	}
	public void setUnitPriceType(String unitPriceType) {
		this.unitPriceType = unitPriceType;
	}
	public void setUnitCharge(int unitCharge) {
		this.unitCharge = unitCharge;
	}
	public String getCarMngCode() {
		return carMngCode;
	}
	public void setCarMngCode(String carMngCode) {
		this.carMngCode = carMngCode;
	}	
	public String getCarMngName() {
		return carMngName;
	}
	public void setCarMngName(String carMngName) {
		this.carMngName = carMngName;
	}
	public String getCarMngMemo() {
		return carMngMemo;
	}
	public void setCarMngMemo(String carMngMemo) {
		this.carMngMemo = carMngMemo;
	}
	public String getLinkSettleYn() {
		return linkSettleYn;
	}
	public void setLinkSettleYn(String linkSettleYn) {
		this.linkSettleYn = linkSettleYn;
	}
	public String getCustMngCode() {
		return custMngCode;
	}	
	public String getCustMngName() {
		return custMngName;
	}
	public void setCustMngName(String custMngName) {
		this.custMngName = custMngName;
	}
	public String getCustMngMemo() {
		return custMngMemo;
	}
	public String getCustMngCodeName() {
		return custMngCodeName;
	}
	public void setCustMngCode(String custMngCode) {
		this.custMngCode = custMngCode;
	}
	public void setCustMngMemo(String custMngMemo) {
		this.custMngMemo = custMngMemo;
	}
	public void setCustMngCodeName(String custMngCodeName) {
		this.custMngCodeName = custMngCodeName;
	}
	public String getDangerGoodsYn() {
		return dangerGoodsYn;
	}
	public String getChemicalsYn() {
		return chemicalsYn;
	}
	public String getForeignLicenseYn() {
		return foreignLicenseYn;
	}
	public String getForkliftYn() {
		return forkliftYn;
	}
	public void setDangerGoodsYn(String dangerGoodsYn) {
		this.dangerGoodsYn = dangerGoodsYn;
	}
	public void setChemicalsYn(String chemicalsYn) {
		this.chemicalsYn = chemicalsYn;
	}
	public void setForeignLicenseYn(String foreignLicenseYn) {
		this.foreignLicenseYn = foreignLicenseYn;
	}
	public void setForkliftYn(String forkliftYn) {
		this.forkliftYn = forkliftYn;
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
	public String getCarSctnName() {
		return carSctnName;
	}
	public void setCarSctnName(String carSctnName) {
		this.carSctnName = carSctnName;
	}
	public String getCustPayType() {
		return custPayType;
	}
	public String getCarPayType() {
		return carPayType;
	}
	public void setCustPayType(String custPayType) {
		this.custPayType = custPayType;
	}
	public void setCarPayType(String carPayType) {
		this.carPayType = carPayType;
	}
	public String getPayType() {
		return payType;
	}
	public void setPayType(String payType) {
		this.payType = payType;
	}	
	public String getOrderCarTonName() {
		return orderCarTonName;
	}
	public void setOrderCarTonName(String orderCarTonName) {
		this.orderCarTonName = orderCarTonName;
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
	public String getSellFinishDate() {
		return sellFinishDate;
	}
	public String getBuyFinishDate() {
		return buyFinishDate;
	}
	public void setSellFinishDate(String sellFinishDate) {
		this.sellFinishDate = sellFinishDate;
	}
	public void setBuyFinishDate(String buyFinishDate) {
		this.buyFinishDate = buyFinishDate;
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
	public String getReceiptDate() {
		return receiptDate;
	}
	public void setReceiptDate(String receiptDate) {
		this.receiptDate = receiptDate;
	}
	public String getInvId() {
		return invId;
	}
	public void setInvId(String invId) {
		this.invId = invId;
	}
	public String getReqCustName() {
		return reqCustName;
	}
	public void setReqCustName(String reqCustName) {
		this.reqCustName = reqCustName;
	}
	public String getReqBizNum() {
		return reqBizNum;
	}
	public String getReqBizName() {
		return reqBizName;
	}
	public String getReqCeo() {
		return ReqCeo;
	}
	public String getReqBizAddr() {
		return reqBizAddr;
	}
	public String getReqTaxEmail() {
		return reqTaxEmail;
	}
	public String getReqTaxStaffName() {
		return reqTaxStaffName;
	}
	public String getReqTaxTelNum() {
		return reqTaxTelNum;
	}
	public void setReqBizNum(String reqBizNum) {
		this.reqBizNum = reqBizNum;
	}
	public void setReqBizName(String reqBizName) {
		this.reqBizName = reqBizName;
	}
	public void setReqCeo(String reqCeo) {
		ReqCeo = reqCeo;
	}
	public void setReqBizAddr(String reqBizAddr) {
		this.reqBizAddr = reqBizAddr;
	}
	public void setReqTaxEmail(String reqTaxEmail) {
		this.reqTaxEmail = reqTaxEmail;
	}
	public void setReqTaxStaffName(String reqTaxStaffName) {
		this.reqTaxStaffName = reqTaxStaffName;
	}
	public void setReqTaxTelNum(String reqTaxTelNum) {
		this.reqTaxTelNum = reqTaxTelNum;
	}

	public String getTalkYn() {	return talkYn;	}

	public void setTalkYn(String talkYn) {	this.talkYn = talkYn;	}

	public int getFinishCnt() {
		return finishCnt;
	}

	public void setFinishCnt(int finishCnt) {
		this.finishCnt = finishCnt;
	}

	public int getTaxCnt() {
		return taxCnt;
	}

	public void setTaxCnt(int taxCnt) {
		this.taxCnt = taxCnt;
	}

	public String getSalesFinish() {
		return salesFinish;
	}

	public void setSalesFinish(String salesFinish) {
		this.salesFinish = salesFinish;
	}

	public String getSalesTaxinv() {
		return salesTaxinv;
	}

	public void setSalesTaxinv(String salesTaxinv) {
		this.salesTaxinv = salesTaxinv;
	}

	public String getPurchaseFinish() {
		return purchaseFinish;
	}

	public void setPurchaseFinish(String purchaseFinish) {
		this.purchaseFinish = purchaseFinish;
	}

	public String getPurchaseTaxinv() {
		return purchaseTaxinv;
	}

	public void setPurchaseTaxinv(String purchaseTaxinv) {
		this.purchaseTaxinv = purchaseTaxinv;
	}

	public String getModId() {
		return modId;
	}

	public void setModId(String modId) {
		this.modId = modId;
	}

	public String getModDate() {
		return modDate;
	}

	public void setModDate(String modDate) {
		this.modDate = modDate;
	}
}
