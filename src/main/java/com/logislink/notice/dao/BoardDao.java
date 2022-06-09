package com.logislink.notice.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.logislink.notice.vo.BoardFileVO;
import com.logislink.notice.vo.BoardVO;

import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

@Repository("boardDao")
public class BoardDao extends EgovAbstractMapper{
	public List<BoardVO> selectBoardList(Map<String, Object> map){
		List<BoardVO> boardList = selectList("boardDataNS.selectBoardList", map);
		
		return boardList;
	}
	
	public int getCnt(Map<String, Object> map) {
		String cnt = selectOne("boardDataNS.selectBoardCnt",map);
		return Integer.valueOf(cnt);
	}
	
	public void boardWrite(Map<String, Object> map) {
		update("boardDataNS.boardWrite", map);		
	}

	public void boardReadCount(Map<String, Object> map) {
		update("boardDataNS.boardReadCount", map);	
	} 
	
	public BoardVO getBoardDetail(Map<String, Object> map) {
		BoardVO board = selectOne("boardDataNS.selectBoardDetail", map);

		return board;
	}

	public List<BoardFileVO> getFiles(Map<String, Object> map) {
		List<BoardFileVO> fileList = selectList("boardDataNS.selectBoardFiles", map);
		
		return fileList;
	}

	public void insertFiles(Map<String, Object> map) {
		update("boardDataNS.insertFiles", map);
	}
	
	public BoardFileVO getFile(Map<String, Object> map) {
		return selectOne("boardDataNS.selectFileDownload", map);
	}

	public void deleteFiles(Map<String, Object> map) {
		// TODO Auto-generated method stub
		delete("boardDataNS.deleteFiles", map);
	}

	public BoardVO lastBoardSeq(Map<String, Object> map) {
		// TODO Auto-generated method stub
		BoardVO board = selectOne("boardDataNS.lastBoardSeq", map);
		
		return board;
	}

	public void deleteBoard(Map<String, Object> map) {
		// TODO Auto-generated method stub
		update("boardDataNS.deleteBoard", map);
	}
}
