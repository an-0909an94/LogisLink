package com.logislink.cmm;

public class LinkMessage {
	private String sender;
	private int status;
	private String message;
	private String detailMessage;
	private LinkMessageData data;
	
	public String getSender() {
		return sender;
	}
	public void setSender(String sender) {
		this.sender = sender;
	}
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}
	public String getMessage() {
		return message;
	}
	public void setMessage(String message) {
		this.message = message;
	}
	public String getDetailMessage() {
		return detailMessage;
	}
	public void setDetailMessage(String detailMessage) {
		this.detailMessage = detailMessage;
	}
	public LinkMessageData getData() {
		return data;
	}
	public void setData(LinkMessageData data) {
		this.data = data;
	}
}
