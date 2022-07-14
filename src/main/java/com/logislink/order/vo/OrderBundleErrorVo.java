package com.logislink.order.vo;

/**
 * 22.07.09 이건욱 T1 > J5, J6 배차관리 기능개선
 * @author user
 *
 */
public class OrderBundleErrorVo {
	private int rowNum;
	private String colName;
	private Object colValue;
	private String message;
	
	public int getRowNum() {
		return rowNum;
	}
	public void setRowNum(int rowNum) {
		this.rowNum = rowNum;
	}
	public String getColName() {
		return colName;
	}
	public void setColName(String colName) {
		this.colName = colName;
	}
	public Object getColValue() {
		return colValue;
	}
	public void setColValue(Object colValue) {
		this.colValue = colValue;
	}
	public String getMessage() {
		return message;
	}
	public void setMessage(String message) {
		this.message = message;
	}
}
