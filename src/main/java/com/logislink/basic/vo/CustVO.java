package com.logislink.basic.vo;

import java.util.List;

public class CustVO {
	private int number;
	private int custSeq;
	private String custId;
	private String deptId;
	private String mngCustId;
	private String mngDeptId;
	private String mngDeptName;
	private String custTypeCode;
	private String custTypeName;
	private String sellBuySctn;
	private String sellBuySctnName;
	private String custName;
	private String deptName;
	private String fax;
	private String mobile;
	private String ceo;
	private String bizNum;
	private String bizCond;
	private String bizKind;
	private String mainProduct;
	private List<UserVO> userList;
	private List<CompDeptVO> deptList;
	
	private String bizName;
	private String bizNumSub;
	private String bizTypeCode;
	private String bizTypeName;
	private String bizPost;
	private String bizAddr;
	private String bizAddrDetail;
	private String regDate;
	private String custMemo;
	private String orderMemo;
	private String taxEmail;
	private String taxStaffName;
	private String taxTelNum;
	private String useYn;
	private String itemCode;
	private String manager;
	private String managerName;
	private String custMngCode;
	private String custMngName;
	private String custMngMemo;
	private String payType;
	private String payMemo;
	private String driverCommission;
	private String postalAddr;
	private String postalAddrDetail;
	private String postalPost;
	
	private String userId;
  	private String passwd;
  	private String userName;
  	private String grade;
  	private String telNum;
  	private String email;
  	private String talkYn;  	
  	private String disuseDate;
	
  	private String bankCode;
  	private String bankName;
  	private String bankCnnm;
  	private String bankAccount;
  	
	public int getNumber() {
		return number;
	}
	public void setNumber(int number) {
		this.number = number;
	}
	public int getCustSeq() {
		return custSeq;
	}
	public void setCustSeq(int custSeq) {
		this.custSeq = custSeq;
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
	public String getMngCustId() {
		return mngCustId;
	}
	public void setMngCustId(String mngCustId) {
		this.mngCustId = mngCustId;
	}
	public String getMngDeptId() {
		return mngDeptId;
	}
	public void setMngDeptId(String mngDeptId) {
		this.mngDeptId = mngDeptId;
	}
	public String getMngDeptName() {
		return mngDeptName;
	}
	public void setMngDeptName(String mngDeptName) {
		this.mngDeptName = mngDeptName;
	}
	public String getCustTypeCode() {
		return custTypeCode;
	}
	public void setCustTypeCode(String custTypeCode) {
		this.custTypeCode = custTypeCode;
	}
	public String getCustTypeName() {
		return custTypeName;
	}
	public void setCustTypeName(String custTypeName) {
		this.custTypeName = custTypeName;
	}
	public String getSellBuySctn() {
		return sellBuySctn;
	}
	public void setSellBuySctn(String sellBuySctn) {
		this.sellBuySctn = sellBuySctn;
	}
	public String getSellBuySctnName() {
		return sellBuySctnName;
	}
	public void setSellBuySctnName(String sellBuySctnName) {
		this.sellBuySctnName = sellBuySctnName;
	}
	public String getCustName() {
		return custName;
	}
	public void setCustName(String custName) {
		this.custName = custName;
	}
	public String getDeptName() {
		return deptName;
	}
	public void setDeptName(String deptName) {
		this.deptName = deptName;
	}
	public String getFax() {
		return fax;
	}
	public void setFax(String fax) {
		this.fax = fax;
	}
	public String getMobile() {
		return mobile;
	}
	public void setMobile(String mobile) {
		this.mobile = mobile;
	}
	public String getCeo() {
		return ceo;
	}
	public void setCeo(String ceo) {
		this.ceo = ceo;
	}
	public String getBizNum() {
		return bizNum;
	}
	public void setBizNum(String bizNum) {
		this.bizNum = bizNum;
	}
	public String getBizCond() {
		return bizCond;
	}
	public void setBizCond(String bizCond) {
		this.bizCond = bizCond;
	}
	public String getBizKind() {
		return bizKind;
	}
	public void setBizKind(String bizKind) {
		this.bizKind = bizKind;
	}
	public List<UserVO> getUserList() {
		return userList;
	}
	public void setUserList(List<UserVO> userList) {
		this.userList = userList;
	}
	public List<CompDeptVO> getDeptList() {
		return deptList;
	}
	public void setDeptList(List<CompDeptVO> deptList) {
		this.deptList = deptList;
	}
	public String getBizName() {
		return bizName;
	}
	public void setBizName(String bizName) {
		this.bizName = bizName;
	}
	public String getBizNumSub() {
		return bizNumSub;
	}
	public void setBizNumSub(String bizNumSub) {
		this.bizNumSub = bizNumSub;
	}
	public String getBizTypeCode() {
		return bizTypeCode;
	}
	public void setBizTypeCode(String bizTypeCode) {
		this.bizTypeCode = bizTypeCode;
	}
	public String getBizPost() {
		return bizPost;
	}
	public void setBizPost(String bizPost) {
		this.bizPost = bizPost;
	}
	public String getBizAddr() {
		return bizAddr;
	}
	public void setBizAddr(String bizAddr) {
		this.bizAddr = bizAddr;
	}
	public String getBizAddrDetail() {
		return bizAddrDetail;
	}
	public void setBizAddrDetail(String bizAddrDetail) {
		this.bizAddrDetail = bizAddrDetail;
	}
	public String getRegDate() {
		return regDate;
	}
	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}
	public String getCustMemo() {
		return custMemo;
	}
	public void setCustMemo(String custMemo) {
		this.custMemo = custMemo;
	}
	public String getOrderMemo() {
		return orderMemo;
	}
	public void setOrderMemo(String orderMemo) {
		this.orderMemo = orderMemo;
	}
	public String getTaxEmail() {
		return taxEmail;
	}
	public void setTaxEmail(String taxEmail) {
		this.taxEmail = taxEmail;
	}
	public String getUseYn() {
		return useYn;
	}
	public void setUseYn(String useYn) {
		this.useYn = useYn;
	}
	public String getItemCode() {
		return itemCode;
	}
	public void setItemCode(String itemCode) {
		this.itemCode = itemCode;
	}
	public String getManager() {
		return manager;
	}
	public void setManager(String manager) {
		this.manager = manager;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getPasswd() {
		return passwd;
	}
	public void setPasswd(String passwd) {
		this.passwd = passwd;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getGrade() {
		return grade;
	}
	public void setGrade(String grade) {
		this.grade = grade;
	}
	public String getTelNum() {
		return telNum;
	}
	public void setTelNum(String telNum) {
		this.telNum = telNum;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getTalkYn() {
		return talkYn;
	}
	public void setTalkYn(String talkYn) {
		this.talkYn = talkYn;
	}
	public String getDisuseDate() {
		return disuseDate;
	}
	public void setDisuseDate(String disuseDate) {
		this.disuseDate = disuseDate;
	}
	public String getBizTypeName() {
		return bizTypeName;
	}
	public void setBizTypeName(String bizTypeName) {
		this.bizTypeName = bizTypeName;
	}
	public String getBankCode() {
		return bankCode;
	}
	public String getBankCnnm() {
		return bankCnnm;
	}
	public String getBankAccount() {
		return bankAccount;
	}
	public void setBankCode(String bankCode) {
		this.bankCode = bankCode;
	}
	public void setBankCnnm(String bankCnnm) {
		this.bankCnnm = bankCnnm;
	}
	public void setBankAccount(String bankAccount) {
		this.bankAccount = bankAccount;
	}
	public String getCustMngCode() {
		return custMngCode;
	}
	public String getCustMngMemo() {
		return custMngMemo;
	}
	public void setCustMngCode(String custMngCode) {
		this.custMngCode = custMngCode;
	}
	public void setCustMngMemo(String custMngMemo) {
		this.custMngMemo = custMngMemo;
	}
	public String getPayType() {
		return payType;
	}
	public String getPayMemo() {
		return payMemo;
	}
	public void setPayType(String payType) {
		this.payType = payType;
	}
	public void setPayMemo(String payMemo) {
		this.payMemo = payMemo;
	}
	public String getManagerName() {
		return managerName;
	}
	public void setManagerName(String managerName) {
		this.managerName = managerName;
	}
	public String getBankName() {
		return bankName;
	}
	public void setBankName(String bankName) {
		this.bankName = bankName;
	}
	public String getCustMngName() {
		return custMngName;
	}
	public void setCustMngName(String custMngName) {
		this.custMngName = custMngName;
	}
	public String getDriverCommission() {
		return driverCommission;
	}
	public void setDriverCommission(String driverCommission) {
		this.driverCommission = driverCommission;
	}
	public String getMainProduct() {
		return mainProduct;
	}
	public void setMainProduct(String mainProduct) {
		this.mainProduct = mainProduct;
	}
	public String getTaxStaffName() {
		return taxStaffName;
	}
	public String getTaxTelNum() {
		return taxTelNum;
	}
	public void setTaxStaffName(String taxStaffName) {
		this.taxStaffName = taxStaffName;
	}
	public void setTaxTelNum(String taxTelNum) {
		this.taxTelNum = taxTelNum;
	}
	public String getPostalAddr() {
		return postalAddr;
	}
	public String getPostalAddrDetail() {
		return postalAddrDetail;
	}
	public String getPostalPost() {
		return postalPost;
	}
	public void setPostalAddr(String postalAddr) {
		this.postalAddr = postalAddr;
	}
	public void setPostalAddrDetail(String postalAddrDetail) {
		this.postalAddrDetail = postalAddrDetail;
	}
	public void setPostalPost(String postalPost) {
		this.postalPost = postalPost;
	}
}
