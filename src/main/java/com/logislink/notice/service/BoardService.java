package com.logislink.notice.service;

import com.logislink.notice.vo.BoardFileVO;
import com.logislink.notice.vo.BoardVO;

import java.util.List;
import java.util.Map;

public interface BoardService {
	public List<BoardVO> getBoardList(Map<String, Object> map);
	
	public int getCnt(Map<String, Object> map);
	
	public void boardWrite(Map<String, Object> map);
	
	public void boardReadCount(Map<String, Object> map);
	
	public BoardVO getBoardDetail(Map<String, Object> map);
	
	public List<BoardFileVO> getFiles(Map<String, Object> map);
	
	public void insertFiles(Map<String, Object> map);
	
	public BoardFileVO getFile(Map<String, Object> map);
	
	public void deleteFiles(Map<String, Object> map);

	public BoardVO lastBoardSeq(Map<String, Object> map);

	public void deleteBoard(Map<String, Object> map);
}
