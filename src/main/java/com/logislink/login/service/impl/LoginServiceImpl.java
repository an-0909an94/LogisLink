package com.logislink.login.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.logislink.login.dao.LoginDao;
import com.logislink.login.service.LoginService;
import com.logislink.login.vo.LoginMenuVO;
import com.logislink.login.vo.LoginVO;

@Service("loginService")
public class LoginServiceImpl implements LoginService {

	@Resource(name="loginDao")
	private LoginDao loginDao;
	
	@Override
	public LoginVO getUser(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return loginDao.selectUserList(map);
	}

	@Override
	public List<LoginMenuVO> getLoginMenu(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return loginDao.selectLoginMenuList(map);
	}

	@Override
	public void updateLastLogin(Map<String, Object> map) {
		// TODO Auto-generated method stub
		loginDao.updateLastLogin(map);
	}

	@Override
	public void insertLoginTalk(Map<String, Object> map) {
		// TODO Auto-generated method stub
		loginDao.insertLoginTalk(map);
	}

}
