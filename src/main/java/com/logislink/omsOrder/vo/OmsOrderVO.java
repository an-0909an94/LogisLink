package com.logislink.omsOrder.vo;

public class OmsOrderVO {
	   private String orderId;          //오더 ID
	   private String reqCustId;
	   private String reqDeptId;
	   private String sComName;         //상차지명
	   private String reqAddr;          //화주주소
	   private String reqAddrDetail;    //화주상세주소
	   private String sAddr;            //상차지주소
	   private String sSido;            //상차지시도
	   private String sGungu;            //상차지군구
	   private String sDong;            //상차지동
	   private double sLat;         
	   private double sLon;
	   private String sDateDay;             //상차일 (YYYY-MM-DD)
	   private String sDateTime;            //상차일 (HH:mm:ss)
	   private String eComName;         //하차지명
	   private String eAddr;            //하차지 주소
	   private String eSido;            //상차지시도
	   private String eGungu;            //상차지군구
	   private String eDong;            //상차지동
	   private double eLat;         
	   private double eLon;
	   private String eDateDay;             //상차일 (YYYY-MM-DD)
	   private String eDateTime;            //상차일 (HH:mm:ss)
	   private String carTypeName;
	   private String carTonName;
	   private String chargeTypeName;   //운임구분코드(인수증.선착불)
	   private String orderStateName;
	   private int buyCharge;           //매입운송비
	   private String driverId;
	   private String vehicId;
	   private String carNum;           //차량번호
	   private String driverName;       //기사명
	   private String driverTel;      	//기사연락처
	   private String regdate;          //오더 등록일
	   private String buyCustName;         
	   private String buyDeptName;
	   private String mngDeptName;
	   private String returnName; 
	   private String mixName;
	   private String eStaff;
	   private String sStaff;
	   private String reqMemo;
	   private String sMemo;
	   private String eMemo;
	   private String sAddrDetail;
	   private String eAddrDetail;
	   private String sTel;
	   private String eTel;
	   private String mixYn;
	   private String returnYn;
	   private String inOutSctn;
	   private String truckTypeCode;
	   private String carTonCode;         
	   private String carTypeCode;
	   private String goodsName;
	   private String itemCode; 
	   private String sWayCode; 
	   private String eWayCode;
	   private String mixSize;
	   private String goodsWeight;
	   private String weightUnitCode;
	   private String goodsQty;
	   private String qtyUnitCode;
	   private String driverMemo;
	   private String buyStaff;        
	   private String buyStaffId;
	   private int stopCount;            //경유지 
	   private String stopName;			// 대표 경유지
	   private String buyDeptId;
	   private String buyCustId;
	   private String mngDeptId;
	   private String mngCustId;
	   private String allocId;
	   private float distance;   
	   private int time;
	   private String dangerGoodsYn;
	   private String chemicalsYn;
	   private String foreignLicenseYn;
	   
	   
	   /* 차량 상태 정보*/
	   private String startDate;
	   private String finishDate;
	   private String enterDate;
	   
	public String getOrderId() {
		return orderId;
	}
	public String getReqCustId() {
		return reqCustId;
	}
	public String getReqDeptId() {
		return reqDeptId;
	}
	public String getsComName() {
		return sComName;
	}
	public String getReqAddr() {
		return reqAddr;
	}
	public String getReqAddrDetail() {
		return reqAddrDetail;
	}
	public String getsAddr() {
		return sAddr;
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
	public double getsLat() {
		return sLat;
	}
	public double getsLon() {
		return sLon;
	}
	public String getsDateDay() {
		return sDateDay;
	}
	public String getsDateTime() {
		return sDateTime;
	}
	public String geteComName() {
		return eComName;
	}
	public String geteAddr() {
		return eAddr;
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
	public double geteLat() {
		return eLat;
	}
	public double geteLon() {
		return eLon;
	}
	public String geteDateDay() {
		return eDateDay;
	}
	public String geteDateTime() {
		return eDateTime;
	}
	public String getCarTypeName() {
		return carTypeName;
	}
	public String getCarTonName() {
		return carTonName;
	}
	public String getChargeTypeName() {
		return chargeTypeName;
	}
	public String getOrderStateName() {
		return orderStateName;
	}
	public int getBuyCharge() {
		return buyCharge;
	}
	public String getDriverId() {
		return driverId;
	}
	public String getVehicId() {
		return vehicId;
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
	public String getRegdate() {
		return regdate;
	}
	public String getBuyCustName() {
		return buyCustName;
	}
	public String getBuyDeptName() {
		return buyDeptName;
	}
	public String getReturnName() {
		return returnName;
	}
	public String getMixName() {
		return mixName;
	}
	public String geteStaff() {
		return eStaff;
	}
	public String getsStaff() {
		return sStaff;
	}
	public String getReqMemo() {
		return reqMemo;
	}
	public String getsMemo() {
		return sMemo;
	}
	public String geteMemo() {
		return eMemo;
	}
	public String getsAddrDetail() {
		return sAddrDetail;
	}
	public String geteAddrDetail() {
		return eAddrDetail;
	}
	public String getsTel() {
		return sTel;
	}
	public String geteTel() {
		return eTel;
	}
	public String getMixYn() {
		return mixYn;
	}
	public String getReturnYn() {
		return returnYn;
	}
	public String getInOutSctn() {
		return inOutSctn;
	}
	public String getTruckTypeCode() {
		return truckTypeCode;
	}
	public String getCarTonCode() {
		return carTonCode;
	}
	public String getCarTypeCode() {
		return carTypeCode;
	}
	public String getGoodsName() {
		return goodsName;
	}
	public String getItemCode() {
		return itemCode;
	}
	public String getsWayCode() {
		return sWayCode;
	}
	public String geteWayCode() {
		return eWayCode;
	}
	public String getMixSize() {
		return mixSize;
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
	public String getDriverMemo() {
		return driverMemo;
	}
	public String getBuyStaff() {
		return buyStaff;
	}
	public String getBuyStaffId() {
		return buyStaffId;
	}
	public int getStopCount() {
		return stopCount;
	}
	public String getStopName() {
		return stopName;
	}
	public String getBuyDeptId() {
		return buyDeptId;
	}
	public String getBuyCustId() {
		return buyCustId;
	}
	public float getDistance() {
		return distance;
	}
	public int getTime() {
		return time;
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
	public void setOrderId(String orderId) {
		this.orderId = orderId;
	}
	public void setReqCustId(String reqCustId) {
		this.reqCustId = reqCustId;
	}
	public void setReqDeptId(String reqDeptId) {
		this.reqDeptId = reqDeptId;
	}
	public void setsComName(String sComName) {
		this.sComName = sComName;
	}
	public void setReqAddr(String reqAddr) {
		this.reqAddr = reqAddr;
	}
	public void setReqAddrDetail(String reqAddrDetail) {
		this.reqAddrDetail = reqAddrDetail;
	}
	public void setsAddr(String sAddr) {
		this.sAddr = sAddr;
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
	public void setsLat(double sLat) {
		this.sLat = sLat;
	}
	public void setsLon(double sLon) {
		this.sLon = sLon;
	}
	public void setsDateDay(String sDateDay) {
		this.sDateDay = sDateDay;
	}
	public void setsDateTime(String sDateTime) {
		this.sDateTime = sDateTime;
	}
	public void seteComName(String eComName) {
		this.eComName = eComName;
	}
	public void seteAddr(String eAddr) {
		this.eAddr = eAddr;
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
	public void seteLat(double eLat) {
		this.eLat = eLat;
	}
	public void seteLon(double eLon) {
		this.eLon = eLon;
	}
	public void seteDateDay(String eDateDay) {
		this.eDateDay = eDateDay;
	}
	public void seteDateTime(String eDateTime) {
		this.eDateTime = eDateTime;
	}
	public void setCarTypeName(String carTypeName) {
		this.carTypeName = carTypeName;
	}
	public void setCarTonName(String carTonName) {
		this.carTonName = carTonName;
	}
	public void setChargeTypeName(String chargeTypeName) {
		this.chargeTypeName = chargeTypeName;
	}
	public void setOrderStateName(String orderStateName) {
		this.orderStateName = orderStateName;
	}
	public void setBuyCharge(int buyCharge) {
		this.buyCharge = buyCharge;
	}
	public void setDriverId(String driverId) {
		this.driverId = driverId;
	}
	public void setVehicId(String vehicId) {
		this.vehicId = vehicId;
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
	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}
	public void setBuyCustName(String buyCustName) {
		this.buyCustName = buyCustName;
	}
	public void setBuyDeptName(String buyDeptName) {
		this.buyDeptName = buyDeptName;
	}
	public void setReturnName(String returnName) {
		this.returnName = returnName;
	}
	public void setMixName(String mixName) {
		this.mixName = mixName;
	}
	public void seteStaff(String eStaff) {
		this.eStaff = eStaff;
	}
	public void setsStaff(String sStaff) {
		this.sStaff = sStaff;
	}
	public void setReqMemo(String reqMemo) {
		this.reqMemo = reqMemo;
	}
	public void setsMemo(String sMemo) {
		this.sMemo = sMemo;
	}
	public void seteMemo(String eMemo) {
		this.eMemo = eMemo;
	}
	public void setsAddrDetail(String sAddrDetail) {
		this.sAddrDetail = sAddrDetail;
	}
	public void seteAddrDetail(String eAddrDetail) {
		this.eAddrDetail = eAddrDetail;
	}
	public void setsTel(String sTel) {
		this.sTel = sTel;
	}
	public void seteTel(String eTel) {
		this.eTel = eTel;
	}
	public void setMixYn(String mixYn) {
		this.mixYn = mixYn;
	}
	public void setReturnYn(String returnYn) {
		this.returnYn = returnYn;
	}
	public void setInOutSctn(String inOutSctn) {
		this.inOutSctn = inOutSctn;
	}
	public void setTruckTypeCode(String truckTypeCode) {
		this.truckTypeCode = truckTypeCode;
	}
	public void setCarTonCode(String carTonCode) {
		this.carTonCode = carTonCode;
	}
	public void setCarTypeCode(String carTypeCode) {
		this.carTypeCode = carTypeCode;
	}
	public void setGoodsName(String goodsName) {
		this.goodsName = goodsName;
	}
	public void setItemCode(String itemCode) {
		this.itemCode = itemCode;
	}
	public void setsWayCode(String sWayCode) {
		this.sWayCode = sWayCode;
	}
	public void seteWayCode(String eWayCode) {
		this.eWayCode = eWayCode;
	}
	public void setMixSize(String mixSize) {
		this.mixSize = mixSize;
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
	public void setDriverMemo(String driverMemo) {
		this.driverMemo = driverMemo;
	}
	public void setBuyStaff(String buyStaff) {
		this.buyStaff = buyStaff;
	}
	public void setBuyStaffId(String buyStaffId) {
		this.buyStaffId = buyStaffId;
	}
	public void setStopCount(int stopCount) {
		this.stopCount = stopCount;
	}
	public void setStopName(String stopName) {
		this.stopName = stopName;
	}
	public void setBuyDeptId(String buyDeptId) {
		this.buyDeptId = buyDeptId;
	}
	public void setBuyCustId(String buyCustId) {
		this.buyCustId = buyCustId;
	}
	public void setDistance(float distance) {
		this.distance = distance;
	}
	public void setTime(int time) {
		this.time = time;
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
	public String getAllocId() {
		return allocId;
	}
	public void setAllocId(String allocId) {
		this.allocId = allocId;
	}
	public String getMngDeptName() {
		return mngDeptName;
	}
	public void setMngDeptName(String mngDeptName) {
		this.mngDeptName = mngDeptName;
	}
	public String getMngDeptId() {
		return mngDeptId;
	}
	public String getMngCustId() {
		return mngCustId;
	}
	public void setMngDeptId(String mngDeptId) {
		this.mngDeptId = mngDeptId;
	}
	public void setMngCustId(String mngCustId) {
		this.mngCustId = mngCustId;
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
	public void setDangerGoodsYn(String dangerGoodsYn) {
		this.dangerGoodsYn = dangerGoodsYn;
	}
	public void setChemicalsYn(String chemicalsYn) {
		this.chemicalsYn = chemicalsYn;
	}
	public void setForeignLicenseYn(String foreignLicenseYn) {
		this.foreignLicenseYn = foreignLicenseYn;
	}
}
