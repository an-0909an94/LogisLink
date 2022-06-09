package com.logislink.login.service;

import java.util.List;
import java.util.Map;

import com.logislink.login.vo.LoginMenuVO;
import com.logislink.login.vo.LoginVO;

public interface LoginService {

	public LoginVO getUser(Map<String, Object> map);
	
	public List<LoginMenuVO> getLoginMenu(Map<String, Object> map);
	
	public void updateLastLogin(Map<String, Object> map);
}
