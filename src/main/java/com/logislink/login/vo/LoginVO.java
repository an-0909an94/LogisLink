package com.logislink.login.vo;

public class LoginVO {

	private String custId;
	private String deptId;
	private String userId;
	private String bizName;
	private String deptName;
	private String userName;
	private int authSeq;
	private String grade;		// 직급
	private String masterYn;
	private String userMainPage;
	private String custTypeCode;
	private String mobile;
	private String email;
	private String userIp;
	
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
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getBizName() {
		return bizName;
	}
	public void setBizName(String bizName) {
		this.bizName = bizName;
	}
	public String getDeptName() {
		return deptName;
	}
	public void setDeptName(String deptName) {
		this.deptName = deptName;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public int getAuthSeq() {
		return authSeq;
	}
	public void setAuthSeq(int authSeq) {
		this.authSeq = authSeq;
	}
	public String getGrade() {
		return grade;
	}
	public void setGrade(String grade) {
		this.grade = grade;
	}
	public String getMasterYn() {
		return masterYn;
	}
	public void setMasterYn(String masterYn) {
		this.masterYn = masterYn;
	}	
	public String getUserMainPage() {
		return userMainPage;
	}
	public void setUserMainPage(String userMainPage) {
		this.userMainPage = userMainPage;
	}	
	public String getCustTypeCode() {
		return custTypeCode;
	}
	public void setCustTypeCode(String custTypeCode) {
		this.custTypeCode = custTypeCode;
	}	
	public String getMobile() {
		return mobile;
	}
	public void setMobile(String mobile) {
		this.mobile = mobile;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	@Override
	public String toString() {
		return "LoginVO [custId=" + custId + ", deptId=" + deptId + ", userId=" + userId + ", bizName=" + bizName
				+ ", deptName=" + deptName + ", userName=" + userName + ", authSeq=" + authSeq + ", grade=" + grade
				+ ", masterYn=" + masterYn + "]";
	}

	public String getUserIp() {
		return userIp;
	}

	public void setUserIp(String userIp) {
		this.userIp = userIp;
	}
}
