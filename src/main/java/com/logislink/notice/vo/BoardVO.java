package com.logislink.notice.vo;

import java.util.List;

public class BoardVO {
	private int number;
	private int boardSeq; 
	private String custId;
	private String readCnt;
	private String userName;
	private String title;
	private String content;
	private String popSdate;
	private String popEdate;
	private String boardTarget;
	private String popYn;
	private int fileCnt;
	private String regdate;
	private String regid;
	private String editdate;
	private String editid;
	private String useYn;
	private List<BoardFileVO> fileList;
	
	public int getNumber() {
		return number;
	}
	public void setNumber(int number) {
		this.number = number;
	}
	public int getBoardSeq() {
		return boardSeq;
	}
	public void setBoardSeq(int boardSeq) {
		this.boardSeq = boardSeq;
	}
	public String getCustId() {
		return custId;
	}
	public void setCustId(String custId) {
		this.custId = custId;
	}
	public String getReadCnt() {
		return readCnt;
	}
	public void setReadCnt(String readCnt) {
		this.readCnt = readCnt;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getPopSdate() {
		return popSdate;
	}
	public void setPopSdate(String popSdate) {
		this.popSdate = popSdate;
	}
	public String getPopEdate() {
		return popEdate;
	}
	public void setPopEdate(String popEdate) {
		this.popEdate = popEdate;
	}
	public String getBoardTarget() {
		return boardTarget;
	}
	public void setBoardTarget(String boardTarget) {
		this.boardTarget = boardTarget;
	}
	public String getPopYn() {
		return popYn;
	}
	public void setPopYn(String popYn) {
		this.popYn = popYn;
	}
	public int getFileCnt() {
		return fileCnt;
	}
	public void setFileCnt(int fileCnt) {
		this.fileCnt = fileCnt;
	}
	public String getRegdate() {
		return regdate;
	}
	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}
	public String getRegid() {
		return regid;
	}
	public void setRegid(String regid) {
		this.regid = regid;
	}
	public String getEditdate() {
		return editdate;
	}
	public void setEditdate(String editdate) {
		this.editdate = editdate;
	}
	public String getEditid() {
		return editid;
	}
	public void setEditid(String editid) {
		this.editid = editid;
	}
	public String getUseYn() {
		return useYn;
	}
	public void setUseYn(String useYn) {
		this.useYn = useYn;
	}
	public List<BoardFileVO> getFileList() {
		return fileList;
	}
	public void setFileList(List<BoardFileVO> fileList) {
		this.fileList = fileList;
	}
	
}
