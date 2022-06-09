package com.logislink.basic.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.logislink.basic.dao.UserDao;
import com.logislink.basic.service.UserService;
import com.logislink.basic.vo.UserOptionVO;
import com.logislink.basic.vo.UserVO;

@Service("userService")
public class UserServiceImpl implements UserService {
	@Resource(name="userDao")
	private UserDao userDao;
	
	@Override
	public List<UserVO> getUserList(Map<String, Object> map) {
		return userDao.selectUserList(map);
	}
	
	@Override
	public int getCnt(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return userDao.getCnt(map);
	}
	
	@Override
	public HashMap<String, String> checkUserId(Map<String, Object> map) {
		return userDao.checkUserId(map);
	}
	
	@Override
	public void insertUser(Map<String, Object> map) {
		// TODO Auto-generated method stub
		userDao.insertUser(map);
	}

	@Override
	public List<UserVO> getUserNameList(Map<String, Object> map) {
		return userDao.selectUserNameList(map);
	}
	
	@Override
	public UserVO getUserInfo(Map<String, Object> map) {
		return userDao.getUserInfo(map);
	}
	
	@Override
	public List<Map<String, Object>> getSendPushUserList(Map<String, Object> map) {
		return userDao.getSendPushUserList(map);
	}

	@Override
	public List<Map<String, Object>> getSendTalkUserList(Map<String, Object> map) {
		return userDao.getSendTalkUserList(map);
	}

	@Override
	public void updateUserMainPage(Map<String, Object> map) {
		// TODO Auto-generated method stub
		userDao.updateUserMainPage(map);
	}

	@Override
	public void insertUserOption(Map<String, Object> map) {
		// TODO Auto-generated method stub
		userDao.insertUserOption(map);
	}

	@Override
	public UserOptionVO getUserOption(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return userDao.getUserOption(map);
	}
}
