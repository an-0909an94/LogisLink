package com.logislink.calc.vo;

import java.util.List;

public class TaxVO {
	private String invId;
	private int billKind;
	private String taxsNum;
	private String docAttr;
	private String pubType;
	private String issueDate;
	private String issueId;
	private String docClass;
	private String docType;
	private String remarks;
	private String remarks2;
	private String remarks3;
	private String writeDate;
	private String amendment;
	private String pubform;
	private String oriIssueId;
    private int number;
	
	// 공급자
	private String supplierCustId;
	private String supplierDeptId;
	private String supplierBizNo;
	private String supplierBizName;
	private String supplierBizType;
	private String supplierBizClass;
	private String supplierBizSubNo;
	private String supplierCeo;
	private String supplierMemDept;
	private String supplierMemName;
	private String supplierMemTel;
	private String supplierMemEmail;
	private String supplierAddr;
	private String supplierVehicId;
	private String supplierDriverId;
	
	// 공급받는자
	private String buyerCustId;
	private String buyerDeptId;
	private String buyerBizNo;
	private String buyerBizName;
	private String buyerBizType;
	private String buyerBizClass;
	private String buyerBizSubNo;
	private String buyerBizNoType;
	private String buyerCeo;
	private String buyerMemDept;
	private String buyerMemName;
	private String buyerMemTel;
	private String buyerMemEmail;
	private String buyerAddr;
	
	// 위수탁
	private String brokerCustId;
	private String brokerDeptId;
	private String brokerBizNo;
	private String brokerBizType;
	private String brokerBizName;
	private String brokerBizClass;
	private String brokerBizSubNo;
	private String brokerCeo;
	private String brokerMemDept;
	private String brokerMemName;
	private String brokerMememail;
	private String brokerMemTel;
	private String brokerAddr;
	
	private String cash;
	private String cheque;
	private String bill;
	private String outstand;
	private String supprice;
	private String tax;
	private String totPrice;
	
	private int loadStatus;
	private String sms;
	private String regDate;
	private String regId;
	
	private String mngCustId;
	private String mngDeptId;
	private String mngCustName;
	
	private String mngVehicId;
	private String mngCarNum;

	private String result; 			//스마트빌전송상태
	private String dtiStatus;		//스마트빌상태
	private String ntsSendStatus;	//국세청전송상태
	private String ntsSendDate;		//국세청전송일자
	private String resultDtl;		//전송상태상세
	
	private List<TaxItemVO> taxItems; 
	
	public String getInvId() {
		return invId;
	}
	public void setInvId(String invId) {
		this.invId = invId;
	}
	public int getBillKind() {
		return billKind;
	}
	public void setBillKind(int billKind) {
		this.billKind = billKind;
	}
	public String getTaxsNum() {
		return taxsNum;
	}
	public void setTaxsNum(String taxsNum) {
		this.taxsNum = taxsNum;
	}
	public String getDocAttr() {
		return docAttr;
	}
	public void setDocAttr(String docAttr) {
		this.docAttr = docAttr;
	}
	public String getPubType() {
		return pubType;
	}
	public void setPubType(String pubType) {
		this.pubType = pubType;
	}
	public String getIssueDate() {
		return issueDate;
	}
	public void setIssueDate(String issueDate) {
		this.issueDate = issueDate;
	}
	public String getIssueId() {
		return issueId;
	}
	public void setIssueId(String issueId) {
		this.issueId = issueId;
	}
	public String getDocClass() {
		return docClass;
	}
	public void setDocClass(String docClass) {
		this.docClass = docClass;
	}
	public String getDocType() {
		return docType;
	}
	public void setDocType(String docType) {
		this.docType = docType;
	}
	public String getRemarks() {
		return remarks;
	}
	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}
	public String getRemarks2() {
		return remarks2;
	}
	public void setRemarks2(String remarks2) {
		this.remarks2 = remarks2;
	}
	public String getRemarks3() {
		return remarks3;
	}
	public void setRemarks3(String remarks3) {
		this.remarks3 = remarks3;
	}
	public String getWriteDate() {
		return writeDate;
	}
	public void setWriteDate(String writeDate) {
		this.writeDate = writeDate;
	}
	public String getAmendment() {
		return amendment;
	}
	public void setAmendment(String amendment) {
		this.amendment = amendment;
	}
	public String getPubform() {
		return pubform;
	}
	public void setPubform(String pubform) {
		this.pubform = pubform;
	}
	public String getOriIssueId() {
		return oriIssueId;
	}
	public void setOriIssueId(String oriIssueId) {
		this.oriIssueId = oriIssueId;
	}
	public String getSupplierCustId() {
		return supplierCustId;
	}
	public void setSupplierCustId(String supplierCustId) {
		this.supplierCustId = supplierCustId;
	}
	public String getSupplierDeptId() {
		return supplierDeptId;
	}
	public void setSupplierDeptId(String supplierDeptId) {
		this.supplierDeptId = supplierDeptId;
	}
	public String getSupplierBizNo() {
		return supplierBizNo;
	}
	public void setSupplierBizNo(String supplierBizNo) {
		this.supplierBizNo = supplierBizNo;
	}
	public String getSupplierBizName() {
		return supplierBizName;
	}
	public void setSupplierBizName(String supplierBizName) {
		this.supplierBizName = supplierBizName;
	}
	public String getSupplierBizClass() {
		return supplierBizClass;
	}
	public void setSupplierBizClass(String supplierBizClass) {
		this.supplierBizClass = supplierBizClass;
	}
	public String getSupplierBizSubNo() {
		return supplierBizSubNo;
	}
	public void setSupplierBizSubNo(String supplierBizSubNo) {
		this.supplierBizSubNo = supplierBizSubNo;
	}
	public String getSupplierCeo() {
		return supplierCeo;
	}
	public void setSupplierCeo(String supplierCeo) {
		this.supplierCeo = supplierCeo;
	}
	public String getSupplierMemDept() {
		return supplierMemDept;
	}
	public void setSupplierMemDept(String supplierMemDept) {
		this.supplierMemDept = supplierMemDept;
	}
	public String getSupplierMemName() {
		return supplierMemName;
	}
	public void setSupplierMemName(String supplierMemName) {
		this.supplierMemName = supplierMemName;
	}
	public String getSupplierMemTel() {
		return supplierMemTel;
	}
	public void setSupplierMemTel(String supplierMemTel) {
		this.supplierMemTel = supplierMemTel;
	}
	public String getSupplierMemEmail() {
		return supplierMemEmail;
	}
	public void setSupplierMemEmail(String supplierMemEmail) {
		this.supplierMemEmail = supplierMemEmail;
	}
	public String getSupplierAddr() {
		return supplierAddr;
	}
	public void setSupplierAddr(String supplierAddr) {
		this.supplierAddr = supplierAddr;
	}
	public String getSupplierVehicId() {
		return supplierVehicId;
	}
	public void setSupplierVehicId(String supplierVehicId) {
		this.supplierVehicId = supplierVehicId;
	}
	public String getSupplierDriverId() {
		return supplierDriverId;
	}
	public void setSupplierDriverId(String supplierDriverId) {
		this.supplierDriverId = supplierDriverId;
	}
	public String getBuyerCustId() {
		return buyerCustId;
	}
	public void setBuyerCustId(String buyerCustId) {
		this.buyerCustId = buyerCustId;
	}
	public String getBuyerDeptId() {
		return buyerDeptId;
	}
	public void setBuyerDeptId(String buyerDeptId) {
		this.buyerDeptId = buyerDeptId;
	}
	public String getBuyerBizNo() {
		return buyerBizNo;
	}
	public void setBuyerBizNo(String buyerBizNo) {
		this.buyerBizNo = buyerBizNo;
	}
	public String getBuyerBizName() {
		return buyerBizName;
	}
	public void setBuyerBizName(String buyerBizName) {
		this.buyerBizName = buyerBizName;
	}
	public String getBuyerBizType() {
		return buyerBizType;
	}
	public void setBuyerBizType(String buyerBizType) {
		this.buyerBizType = buyerBizType;
	}
	public String getBuyerBizClass() {
		return buyerBizClass;
	}
	public void setBuyerBizClass(String buyerBizClass) {
		this.buyerBizClass = buyerBizClass;
	}
	public String getBuyerBizSubNo() {
		return buyerBizSubNo;
	}
	public void setBuyerBizSubNo(String buyerBizSubNo) {
		this.buyerBizSubNo = buyerBizSubNo;
	}
	public String getBuyerBizNoType() {
		return buyerBizNoType;
	}
	public void setBuyerBizNoType(String buyerBizNoType) {
		this.buyerBizNoType = buyerBizNoType;
	}
	public String getBuyerCeo() {
		return buyerCeo;
	}
	public void setBuyerCeo(String buyerCeo) {
		this.buyerCeo = buyerCeo;
	}
	public String getBuyerMemDept() {
		return buyerMemDept;
	}
	public void setBuyerMemDept(String buyerMemDept) {
		this.buyerMemDept = buyerMemDept;
	}
	public String getBuyerMemName() {
		return buyerMemName;
	}
	public void setBuyerMemName(String buyerMemName) {
		this.buyerMemName = buyerMemName;
	}
	public String getBuyerMemTel() {
		return buyerMemTel;
	}
	public void setBuyerMemTel(String buyerMemTel) {
		this.buyerMemTel = buyerMemTel;
	}
	public String getBuyerMemEmail() {
		return buyerMemEmail;
	}
	public void setBuyerMemEmail(String buyerMemEmail) {
		this.buyerMemEmail = buyerMemEmail;
	}
	public String getBuyerAddr() {
		return buyerAddr;
	}
	public void setBuyerAddr(String buyerAddr) {
		this.buyerAddr = buyerAddr;
	}
	public String getBrokerCustId() {
		return brokerCustId;
	}
	public void setBrokerCustId(String brokerCustId) {
		this.brokerCustId = brokerCustId;
	}
	public String getBrokerDeptId() {
		return brokerDeptId;
	}
	public void setBrokerDeptId(String brokerDeptId) {
		this.brokerDeptId = brokerDeptId;
	}
	public String getBrokerBizNo() {
		return brokerBizNo;
	}
	public void setBrokerBizNo(String brokerBizNo) {
		this.brokerBizNo = brokerBizNo;
	}
	public String getBrokerBizType() {
		return brokerBizType;
	}
	public void setBrokerBizType(String brokerBizType) {
		this.brokerBizType = brokerBizType;
	}
	public String getBrokerBizName() {
		return brokerBizName;
	}
	public void setBrokerBizName(String brokerBizName) {
		this.brokerBizName = brokerBizName;
	}
	public String getBrokerBizClass() {
		return brokerBizClass;
	}
	public void setBrokerBizClass(String brokerBizClass) {
		this.brokerBizClass = brokerBizClass;
	}
	public String getBrokerBizSubNo() {
		return brokerBizSubNo;
	}
	public void setBrokerBizSubNo(String brokerBizSubNo) {
		this.brokerBizSubNo = brokerBizSubNo;
	}
	public String getBrokerCeo() {
		return brokerCeo;
	}
	public void setBrokerCeo(String brokerCeo) {
		this.brokerCeo = brokerCeo;
	}
	public String getBrokerMemDept() {
		return brokerMemDept;
	}
	public void setBrokerMemDept(String brokerMemDept) {
		this.brokerMemDept = brokerMemDept;
	}
	public String getBrokerMemName() {
		return brokerMemName;
	}
	public void setBrokerMemName(String brokerMemName) {
		this.brokerMemName = brokerMemName;
	}
	public String getBrokerMememail() {
		return brokerMememail;
	}
	public void setBrokerMememail(String brokerMememail) {
		this.brokerMememail = brokerMememail;
	}
	public String getBrokerMemTel() {
		return brokerMemTel;
	}
	public void setBrokerMemTel(String brokerMemTel) {
		this.brokerMemTel = brokerMemTel;
	}
	public String getBrokerAddr() {
		return brokerAddr;
	}
	public void setBrokerAddr(String brokerAddr) {
		this.brokerAddr = brokerAddr;
	}
	public String getCash() {
		return cash;
	}
	public void setCash(String cash) {
		this.cash = cash;
	}
	public String getCheque() {
		return cheque;
	}
	public void setCheque(String cheque) {
		this.cheque = cheque;
	}
	public String getBill() {
		return bill;
	}
	public void setBill(String bill) {
		this.bill = bill;
	}
	public String getOutstand() {
		return outstand;
	}
	public void setOutstand(String outstand) {
		this.outstand = outstand;
	}
	public String getSupprice() {
		return supprice;
	}
	public void setSupprice(String supprice) {
		this.supprice = supprice;
	}
	public String getTax() {
		return tax;
	}
	public void setTax(String tax) {
		this.tax = tax;
	}
	public String getTotPrice() {
		return totPrice;
	}
	public void setTotPrice(String totPrice) {
		this.totPrice = totPrice;
	}
	public int getLoadStatus() {
		return loadStatus;
	}
	public void setLoadStatus(int loadStatus) {
		this.loadStatus = loadStatus;
	}
	public String getSms() {
		return sms;
	}
	public void setSms(String sms) {
		this.sms = sms;
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
	public List<TaxItemVO> getTaxItems() {
		return taxItems;
	}
	public void setTaxItems(List<TaxItemVO> taxItems) {
		this.taxItems = taxItems;
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
	public String getMngCustName() {
		return mngCustName;
	}
	public void setMngCustName(String mngCustName) {
		this.mngCustName = mngCustName;
	}
	public String getMngVehicId() {
		return mngVehicId;
	}
	public void setMngVehicId(String mngVehicId) {
		this.mngVehicId = mngVehicId;
	}
	public String getMngCarNum() {
		return mngCarNum;
	}
	public void setMngCarNum(String mngCarNum) {
		this.mngCarNum = mngCarNum;
	}	
	public String getResult() {
		return result;
	}
	public void setResult(String result) {
		this.result = result;
	}
	public String getDtiStatus() {
		return dtiStatus;
	}
	public void setDtiStatus(String dtiStatus) {
		this.dtiStatus = dtiStatus;
	}
	public String getNtsSendStatus() {
		return ntsSendStatus;
	}
	public void setNtsSendStatus(String ntsSendStatus) {
		this.ntsSendStatus = ntsSendStatus;
	}
	public String getNtsSendDate() {
		return ntsSendDate;
	}
	public void setNtsSendDate(String ntsSendDate) {
		this.ntsSendDate = ntsSendDate;
	}
	public String getResultDtl() {
		return resultDtl;
	}
	public void setResultDtl(String resultDtl) {
		this.resultDtl = resultDtl;
	}
	public int getNumber() {
		return number;
	}
	public void setNumber(int number) {
		this.number = number;
	}
	public String getSupplierBizType() {
		return supplierBizType;
	}
	public void setSupplierBizType(String supplierBizType) {
		this.supplierBizType = supplierBizType;
	}	
}
