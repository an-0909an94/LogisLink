package com.logislink.notice.vo;

public class TalkVO {
	private int rNum;
	private int seq;
	private String inTime;		//등록일 YYYY-MM-DD
	private String callPhone;	//수신번호
	private String result;		//전송결과
	private String msg;			//메시지
	private String sentTime;	//전송시간
	private String callName;	//회원이름
	private String reqName;		//등록자
	
	public int getrNum() {
		return rNum;
	}
	public int getSeq() {
		return seq;
	}
	public String getInTime() {
		return inTime;
	}
	public String getCallPhone() {
		return callPhone;
	}
	public String getResult() {
		return result;
	}
	public String getMsg() {
		return msg;
	}
	public String getSentTime() {
		return sentTime;
	}
	public String getCallName() {
		return callName;
	}
	public String getReqName() {
		return reqName;
	}
	public void setrNum(int rNum) {
		this.rNum = rNum;
	}
	public void setSeq(int seq) {
		this.seq = seq;
	}
	public void setInTime(String inTime) {
		this.inTime = inTime;
	}
	public void setCallPhone(String callPhone) {
		this.callPhone = callPhone;
	}
	public void setResult(String result) {
		this.result = result;
	}
	public void setMsg(String msg) {
		this.msg = msg;
	}
	public void setSentTime(String sentTime) {
		this.sentTime = sentTime;
	}
	public void setCallName(String callName) {
		this.callName = callName;
	}
	public void setReqName(String reqName) {
		this.reqName = reqName;
	}
}
