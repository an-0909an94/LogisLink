package com.logislink.basic.vo;

public class CustAddrVO {
	private int number;
	private int addrSeq;
	private String custId;
	private String deptId;
	private String deptName;
	private String addrName;
	private String addr;
	private String addrDetail;
	private String lat;
	private String lon;
	private String staffName;
	private String staffTel;
	private String orderMemo;
	private String regDate;
	private String regId;
	private String useYn;
	private String sido;
	private String gungu;
	private String dong;
	private String mode;
	
	public CustAddrVO() {
		super();
	}
	
	public CustAddrVO(String custId, String deptId, String addrName, String addr, String addrDetail, String lat,
			String lon, String staffName, String staffTel, String orderMemo, String regId, 
			String sido, String gungu, String dong, String mode) {
		super();
		this.custId = custId;
		this.deptId = deptId;
		this.addrName = addrName;
		this.addr = addr;
		this.addrDetail = addrDetail;
		this.lat = lat;
		this.lon = lon;
		this.staffName = staffName;
		this.staffTel = staffTel;
		this.orderMemo = orderMemo;
		this.regId = regId;
		this.sido = sido;
		this.gungu = gungu;
		this.dong = dong;
		this.mode = mode;
	}


	public int getNumber() {
		return number;
	}
	public void setNumber(int number) {
		this.number = number;
	}
	public int getAddrSeq() {
		return addrSeq;
	}
	public void setAddrSeq(int addrSeq) {
		this.addrSeq = addrSeq;
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
	
	public String getDeptName() {
		return deptName;
	}

	public void setDeptName(String deptName) {
		this.deptName = deptName;
	}

	public String getAddrName() {
		return addrName;
	}
	public void setAddrName(String addrName) {
		this.addrName = addrName;
	}
	public String getAddr() {
		return addr;
	}
	public void setAddr(String addr) {
		this.addr = addr;
	}
	public String getAddrDetail() {
		return addrDetail;
	}
	public void setAddrDetail(String addrDetail) {
		this.addrDetail = addrDetail;
	}
	public String getLat() {
		return lat;
	}
	public void setLat(String lat) {
		this.lat = lat;
	}
	public String getLon() {
		return lon;
	}
	public void setLon(String lon) {
		this.lon = lon;
	}
	public String getStaffName() {
		return staffName;
	}
	public void setStaffName(String staffName) {
		this.staffName = staffName;
	}
	public String getStaffTel() {
		return staffTel;
	}
	public void setStaffTel(String staffTel) {
		this.staffTel = staffTel;
	}
	public String getOrderMemo() {
		return orderMemo;
	}
	public void setOrderMemo(String orderMemo) {
		this.orderMemo = orderMemo;
	}
	public String getRegDate() {
		return regDate;
	}
	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}
	public String getRegId() {
		return regId;
	}
	public void setRegId(String regId) {
		this.regId = regId;
	}
	public String getUseYn() {
		return useYn;
	}
	public void setUseYn(String useYn) {
		this.useYn = useYn;
	}
	public String getSido() {
		return sido;
	}
	public void setSido(String sido) {
		this.sido = sido;
	}
	public String getGungu() {
		return gungu;
	}
	public void setGungu(String gungu) {
		this.gungu = gungu;
	}
	public String getDong() {
		return dong;
	}
	public void setDong(String dong) {
		this.dong = dong;
	}

	public String getMode() {
		return mode;
	}

	public void setMode(String mode) {
		this.mode = mode;
	}
}
