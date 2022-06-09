package com.logislink.basic.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.logislink.basic.vo.UserOptionVO;
import com.logislink.basic.vo.UserVO;

import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

@Repository("userDao")
public class UserDao extends EgovAbstractMapper{
	
	public List<UserVO> selectUserList(Map<String, Object> map) {
		List<UserVO> userList = selectList("userDataNS.selectUserList", map);
		
		return userList;
	} 
	
	public int getCnt(Map<String, Object> map) {
		String cnt = selectOne("userDataNS.selectUserCnt",map);
		return Integer.valueOf(cnt);
	}
	
	public HashMap<String, String> checkUserId(Map<String, Object> map) {
		HashMap<String, String> chk = selectOne("userDataNS.checkUserId", map);
		
		return chk;
	}
	
	public void insertUser(Map<String, Object> map) {
		update("userDataNS.insertUser", map);		
	} 
	
	public List<UserVO> selectUserNameList(Map<String, Object> map) {
		List<UserVO> userNameList = selectList("userDataNS.userNameList", map);
		
		return userNameList;
	} 
	
	public UserVO getUserInfo(Map<String, Object> map) {
		UserVO userInfo = selectOne("userDataNS.getUserInfo", map);
		
		return userInfo;
	}
	
	public List<Map<String, Object>> getSendPushUserList(Map<String, Object> map) {
		return selectList("userDataNS.selectSendPushUserList", map);
	}

	
	public List<Map<String, Object>> getSendTalkUserList(Map<String, Object> map) {
		return selectList("userDataNS.selectSendTalkUserList", map);
	}
	
	public void updateUserMainPage(Map<String, Object> map) {
		update("userDataNS.updateUserMainPage", map);
	}

	public void insertUserOption(Map<String, Object> map) {
		// TODO Auto-generated method stub
		insert("userDataNS.insertUserOption", map);
	}

	public UserOptionVO getUserOption(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return selectOne("userDataNS.getUserOption", map);
	}
}
