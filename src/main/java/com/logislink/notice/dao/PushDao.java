package com.logislink.notice.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.logislink.notice.vo.PushVO;

import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

@Repository("pushDao")
public class PushDao extends EgovAbstractMapper{
	
	public List<PushVO> selectPushList(Map<String, Object> map) {
		List<PushVO> pushList = selectList("pushDataNS.selectPushList", map);
		
		return pushList;
	} 
	
	public int getCnt(Map<String, Object> map) {
		String cnt = selectOne("pushDataNS.selectPushCnt",map);
		return Integer.valueOf(cnt);
	}
	
	public int insertPushMsg(Map<String, Object> map) {
		return insert("pushDataNS.insertPushMsg", map);
	}
	
	public void insertPushSendList(Map<String, Object> map) {
		insert("pushDataNS.insertPushSendList", map);
	}
	
	public List<Map<String, String>> searchPushUserList(Map<String, Object> map) {
		return selectList("pushDataNS.searchPushUserList", map);
	}
}
