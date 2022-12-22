package com.logislink.basic.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.logislink.basic.vo.UserOptionVO;
import com.logislink.basic.vo.UserVO;

public interface UserService {
	
	public List<UserVO> getUserList(Map<String, Object> map);
	
	public int getCnt(Map<String, Object> map);
	
	public HashMap<String, String> checkUserId(Map<String, Object> map);
	
	public void insertUser(Map<String, Object> map);

	public List<UserVO> getUserNameList(Map<String, Object> map);
	
	public UserVO getUserInfo(Map<String, Object> map);
	
	public List<Map<String, Object>> getSendPushUserList(Map<String, Object> map);
	
	public List<Map<String, Object>> getSendTalkUserList(Map<String, Object> map);
	
	public void updateUserMainPage(Map<String, Object> map);

	public void insertUserOption(Map<String, Object> map);

	public UserOptionVO getUserOption(Map<String, Object> param);

	public void insertUserCargoAccount(Map<String, Object> map);

}
