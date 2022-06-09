package com.logislink.cmm.vo;

public class FileVO {

	private int fileSeq;
	private int serviceSeq;
	private String codeFile;
	private String mid;
	private int midSeq;
	private int fNo;
	private String fNameOrg;
	private String fName;
	private String fPath;
	private long fSize;
	private String fType;
	private String code;
	private String codeName;
	private int asort;
	private int regSeq;
	
	public int getFileSeq() {
		return fileSeq;
	}
	public void setFileSeq(int fileSeq) {
		this.fileSeq = fileSeq;
	}
	public int getServiceSeq() {
		return serviceSeq;
	}
	public void setServiceSeq(int serviceSeq) {
		this.serviceSeq = serviceSeq;
	}
	public String getCodeFile() {
		return codeFile;
	}
	public void setCodeFile(String codeFile) {
		this.codeFile = codeFile;
	}
	public String getMid() {
		return mid;
	}
	public void setMid(String mid) {
		this.mid = mid;
	}
	public int getMidSeq() {
		return midSeq;
	}
	public void setMidSeq(int midSeq) {
		this.midSeq = midSeq;
	}
	public int getfNo() {
		return fNo;
	}
	public void setfNo(int fNo) {
		this.fNo = fNo;
	}
	public String getfNameOrg() {
		return fNameOrg;
	}
	public void setfNameOrg(String fNameOrg) {
		this.fNameOrg = fNameOrg;
	}
	public String getfName() {
		return fName;
	}
	public void setfName(String fName) {
		this.fName = fName;
	}
	public String getfPath() {
		return fPath;
	}
	public void setfPath(String fPath) {
		this.fPath = fPath;
	}
	public long getfSize() {
		return fSize;
	}
	public void setfSize(long fSize) {
		this.fSize = fSize;
	}
	public String getfType() {
		return fType;
	}
	public void setfType(String fType) {
		this.fType = fType;
	}
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
	public String getCodeName() {
		return codeName;
	}
	public void setCodeName(String codeName) {
		this.codeName = codeName;
	}
	public int getAsort() {
		return asort;
	}
	public void setAsort(int asort) {
		this.asort = asort;
	}
	public int getRegSeq() {
		return regSeq;
	}
	public void setRegSeq(int regSeq) {
		this.regSeq = regSeq;
	}
	@Override
	public String toString() {
		return "FileVO [fileSeq=" + fileSeq + ", serviceSeq=" + serviceSeq + ", codeFile=" + codeFile + ", mid=" + mid
				+ ", midSeq=" + midSeq + ", fNo=" + fNo + ", fNameOrg=" + fNameOrg + ", fName=" + fName + ", fPath="
				+ fPath + ", fSize=" + fSize + ", fType=" + fType + ", code=" + code + ", codeName=" + codeName
				+ ", asort=" + asort + ", regSeq=" + regSeq + "]";
	}
	
}
