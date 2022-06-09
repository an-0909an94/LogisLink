package com.logislink.notice.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.logislink.notice.dao.BoardDao;
import com.logislink.notice.service.BoardService;
import com.logislink.notice.vo.BoardFileVO;
import com.logislink.notice.vo.BoardVO;

@Service("boardService")
public class BoardServiceImpl implements BoardService {

	@Resource(name="boardDao")
	private BoardDao boardDao;
	
	@Override
	public List<BoardVO> getBoardList(Map<String, Object> map) {
		return boardDao.selectBoardList(map);
	}

	@Override
	public int getCnt(Map<String, Object> map) {
		return boardDao.getCnt(map);
	}

	@Override
	public void boardWrite(Map<String, Object> map) {
		boardDao.boardWrite(map);
	}
	
	@Override
	public void boardReadCount(Map<String, Object> map) {
		boardDao.boardReadCount(map);
	}


	@Override
	public BoardVO getBoardDetail(Map<String, Object> map) {
		return boardDao.getBoardDetail(map);
	}

	@Override
	public List<BoardFileVO> getFiles(Map<String, Object> map) {
		return boardDao.getFiles(map);
	}

	@Override
	public void insertFiles(Map<String, Object> map) {
		boardDao.insertFiles(map);
	}

	@Override
	public BoardFileVO getFile(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return boardDao.getFile(map);
	}

	@Override
	public void deleteFiles(Map<String, Object> map) {
		// TODO Auto-generated method stub
		boardDao.deleteFiles(map);
	}

	@Override
	public BoardVO lastBoardSeq(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return boardDao.lastBoardSeq(map);
	}

	@Override
	public void deleteBoard(Map<String, Object> map) {
		// TODO Auto-generated method stub
		boardDao.deleteBoard(map);
	}

}
