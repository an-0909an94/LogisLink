package com.logislink.calc.vo;

import java.util.List;

public class TranVO {
	private int number;
	private String receiptId;
	private String toCustId;
	private String toDeptId;
	private String frCustId;
	private String frDeptId;
	private String frBizNum;
	private String frBizNumSub;
	private String frBizName;
	private String frCeo;
	private String frTelNum;
	private String frBizCond;
	private String frBizKind;
	private String frAddr;
	private String frAddrDetail;
	private String toBizNum;
	private String toBizNumSub;
	private String toBizName;
	private String toCeo;
	private String toTelNum;
	private String toBizCond;
	private String toBizKind;
	private String toAddr;
	private String toAddrDetail;
	private String charge;
	private String vat;
	private String amt;
	private String amtKrw;
	private int totalCnt;
	private String tranSDate;
	private String tranEDate;
	private String regDate;
	private String regId;
	private String useYn;
	private String bankName;
	private String bankCnnm;
	private String bankAccount;
	private List<TranDtlVO> tranDtlList;
	
	public int getNumber() {
		return number;
	}
	public void setNumber(int number) {
		this.number = number;
	}
	public String getReceiptId() {
		return receiptId;
	}
	public void setReceiptId(String receiptId) {
		this.receiptId = receiptId;
	}
	public String getToCustId() {
		return toCustId;
	}
	public void setToCustId(String toCustId) {
		this.toCustId = toCustId;
	}
	public String getToDeptId() {
		return toDeptId;
	}
	public void setToDeptId(String toDeptId) {
		this.toDeptId = toDeptId;
	}
	public String getFrCustId() {
		return frCustId;
	}
	public void setFrCustId(String frCustId) {
		this.frCustId = frCustId;
	}
	public String getFrDeptId() {
		return frDeptId;
	}
	public void setFrDeptId(String frDeptId) {
		this.frDeptId = frDeptId;
	}
	public String getFrBizNum() {
		return frBizNum;
	}
	public void setFtBizNum(String frBizNum) {
		this.frBizNum = frBizNum;
	}
	public String getFrBizNumSub() {
		return frBizNumSub;
	}
	public void setFrBizNumSub(String frBizNumSub) {
		this.frBizNumSub = frBizNumSub;
	}
	public String getFrBizName() {
		return frBizName;
	}
	public void setFrBizName(String frBizName) {
		this.frBizName = frBizName;
	}
	public String getFrCeo() {
		return frCeo;
	}
	public void setFrCeo(String frCeo) {
		this.frCeo = frCeo;
	}
	public String getFrTelNum() {
		return frTelNum;
	}
	public void setFrTelNum(String frTelNum) {
		this.frTelNum = frTelNum;
	}
	public String getFrBizCond() {
		return frBizCond;
	}
	public void setFrBizCond(String frBizCond) {
		this.frBizCond = frBizCond;
	}
	public String getFrBizKind() {
		return frBizKind;
	}
	public void setFrBizKind(String frBizKind) {
		this.frBizKind = frBizKind;
	}
	public String getFrAddr() {
		return frAddr;
	}
	public void setFrAddr(String frAddr) {
		this.frAddr = frAddr;
	}
	public String getFrAddrDetail() {
		return frAddrDetail;
	}
	public void setFrAddrDetail(String frAddrDetail) {
		this.frAddrDetail = frAddrDetail;
	}
	public String getToBizNum() {
		return toBizNum;
	}
	public void setToBizNum(String toBizNum) {
		this.toBizNum = toBizNum;
	}
	public String getToBizNumSub() {
		return toBizNumSub;
	}
	public void setToBizNumSub(String toBizNumSub) {
		this.toBizNumSub = toBizNumSub;
	}
	public String getToBizName() {
		return toBizName;
	}
	public void setToBizName(String toBizName) {
		this.toBizName = toBizName;
	}
	public String getToCeo() {
		return toCeo;
	}
	public void setToCeo(String toCeo) {
		this.toCeo = toCeo;
	}
	public String getToTelNum() {
		return toTelNum;
	}
	public void setToTelNum(String toTelNum) {
		this.toTelNum = toTelNum;
	}
	public String getToBizCond() {
		return toBizCond;
	}
	public void setToBizCond(String toBizCond) {
		this.toBizCond = toBizCond;
	}
	public String getToBizKind() {
		return toBizKind;
	}
	public void setToBizKind(String toBizKind) {
		this.toBizKind = toBizKind;
	}
	public String getToAddr() {
		return toAddr;
	}
	public void setToAddr(String toAddr) {
		this.toAddr = toAddr;
	}
	public String getToAddrDetail() {
		return toAddrDetail;
	}
	public void setToAddrDetail(String toAddrDetail) {
		this.toAddrDetail = toAddrDetail;
	}
	public String getCharge() {
		return charge;
	}
	public void setCharge(String charge) {
		this.charge = charge;
	}
	public String getVat() {
		return vat;
	}
	public void setVat(String vat) {
		this.vat = vat;
	}
	public String getAmt() {
		return amt;
	}
	public void setAmt(String amt) {
		this.amt = amt;
	}
	public String getTranSDate() {
		return tranSDate;
	}
	public void setTranSDate(String tranSDate) {
		this.tranSDate = tranSDate;
	}
	public String getTranEDate() {
		return tranEDate;
	}
	public void setTranEDate(String tranEDate) {
		this.tranEDate = tranEDate;
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
	public List<TranDtlVO> getTranDtlList() {
		return tranDtlList;
	}
	public void setTranDtlList(List<TranDtlVO> tranDtlList) {
		this.tranDtlList = tranDtlList;
	}
	public String getBankName() {
		return bankName;
	}
	public void setBankName(String bankName) {
		this.bankName = bankName;
	}
	public String getBankCnnm() {
		return bankCnnm;
	}
	public void setBankCnnm(String bankCnnm) {
		this.bankCnnm = bankCnnm;
	}
	public String getBankAccount() {
		return bankAccount;
	}
	public void setBankAccount(String bankAccount) {
		this.bankAccount = bankAccount;
	}
	public void setFrBizNum(String frBizNum) {
		this.frBizNum = frBizNum;
	}
	public int getTotalCnt() {
		return totalCnt;
	}
	public void setTotalCnt(int totalCnt) {
		this.totalCnt = totalCnt;
	}
	public String getAmtKrw() {
		return amtKrw;
	}
	public void setAmtKrw(String amtKrw) {
		this.amtKrw = amtKrw;
	}
}
