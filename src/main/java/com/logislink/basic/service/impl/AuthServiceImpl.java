package com.logislink.basic.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.logislink.basic.dao.AuthDao;
import com.logislink.basic.service.AuthService;
import com.logislink.basic.vo.AuthVO;


@Service("authService")
public class AuthServiceImpl implements AuthService {
	
	@Resource(name="authDao")
	private AuthDao authDao;

	@Override
	public List<AuthVO> selectUserList(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return authDao.selectUserList(map);
	}

	@Override
	public List<AuthVO> selectAuthList(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return authDao.selectAuthList(map);
	}

	@Override
	public void insert(Map<String, Object> map) {
		// TODO Auto-generated method stub
		authDao.insert(map);
	}

	@Override
	public void delete(Map<String, Object> map) {
		// TODO Auto-generated method stub
		authDao.delete(map);
	}

	@Override
	public void insertAuth(Map<String, Object> map) {
		// TODO Auto-generated method stub
		authDao.insertAuth(map);
	}
	
	@Override
	public List<AuthVO> selectAllAuthList(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return authDao.selectAllAuthList(map);
	}

	@Override
	public List<AuthVO> selectUserAuthList(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return authDao.selectUserAuthList(map);
	}

	@Override
	public HashMap<String, Object> checkAuthSeq(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return authDao.checkAuthSeq(map);
	}
}
