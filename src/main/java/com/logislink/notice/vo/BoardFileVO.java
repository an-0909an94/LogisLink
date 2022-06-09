package com.logislink.notice.vo;

public class BoardFileVO {
	private int files;
	private int fileSeq; 
	private int boardSeq;
	private String fileTypeCode;
	private String fileName;
	private String filePath;
	private long fileSize;
	private String mimeType;
	private String regdate;
	private String regid;
	private String fileRealName;
	private int fNo;
	
	
	public int getFiles() {
		return files;
	}
	public void setFiles(int files) {
		this.files = files;
	}
	public int getFileSeq() {
		return fileSeq;
	}
	public int getBoardSeq() {
		return boardSeq;
	}
	public String getFileTypeCode() {
		return fileTypeCode;
	}
	public String getFileName() {
		return fileName;
	}
	public String getFilePath() {
		return filePath;
	}
	public long getFileSize() {
		return fileSize;
	}
	public String getMimeType() {
		return mimeType;
	}
	public String getRegdate() {
		return regdate;
	}
	public String getRegid() {
		return regid;
	}
	public String getFileRealName() {
		return fileRealName;
	}
	public int getfNo() {
		return fNo;
	}
	public void setFileSeq(int fileSeq) {
		this.fileSeq = fileSeq;
	}
	public void setBoardSeq(int boardSeq) {
		this.boardSeq = boardSeq;
	}
	public void setFileTypeCode(String fileTypeCode) {
		this.fileTypeCode = fileTypeCode;
	}
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	public void setFilePath(String filePath) {
		this.filePath = filePath;
	}
	public void setFileSize(long fileSize) {
		this.fileSize = fileSize;
	}
	public void setMimeType(String mimeType) {
		this.mimeType = mimeType;
	}
	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}
	public void setRegid(String regid) {
		this.regid = regid;
	}
	public void setFileRealName(String fileRealName) {
		this.fileRealName = fileRealName;
	}
	public void setfNo(int fNo) {
		this.fNo = fNo;
	}
}
