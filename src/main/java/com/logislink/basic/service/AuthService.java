package com.logislink.basic.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.logislink.basic.vo.AuthVO;


public interface AuthService {

	public List<AuthVO> selectUserList(Map<String, Object> map);
	
	public List<AuthVO> selectAuthList(Map<String, Object> map);
	
	public void insert(Map<String, Object> map);
	
	public void delete(Map<String, Object> map);

	public void insertAuth(Map<String, Object> map);
	
	public List<AuthVO> selectAllAuthList(Map<String, Object> map);
	
	public List<AuthVO> selectUserAuthList(Map<String, Object> map);

	public HashMap<String, Object> checkAuthSeq(Map<String, Object> map);
}
