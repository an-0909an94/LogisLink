package com.logislink.basic.vo;

public class DrvLocVO {

	private String driverId;	
	private String allocId;
	private String carNum;
	private double lat;
	private double lon;
	private String regdate;
	
	public String getDriverId() {
		return driverId;
	}
	public void setDriverId(String driverId) {
		this.driverId = driverId;
	}
	
	public String getAllocId() {
		return allocId;
	}
	public void setAllocId(String allocId) {
		this.allocId = allocId;
	}
	public double getLat() {
		return lat;
	}
	public void setLat(double lat) {
		this.lat = lat;
	}
	public double getLon() {
		return lon;
	}
	public void setLon(double lon) {
		this.lon = lon;
	}
	public String getRegdate() {
		return regdate;
	}
	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}
	
	
}
