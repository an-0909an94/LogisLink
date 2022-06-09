package com.logislink.basic.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.logislink.basic.vo.AuthVO;

import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

@Repository("authDao")
public class AuthDao extends EgovAbstractMapper{
	

	public List<AuthVO> selectUserList(Map<String, Object> map){
		return selectList("authDataNS.selectUserList", map);
	}
	
	public List<AuthVO> selectAuthList(Map<String, Object> map){
		return selectList("authDataNS.selectAuthList", map);
	}
	
	public void insert(Map<String, Object> map) {
		update("authDataNS.insertUserAuth", map);
	}

	public void delete(Map<String, Object> map) {
		delete("authDataNS.deleteAuth", map);
		delete("authDataNS.deleteAuthMenu", map);
	}

	public void insertAuth(Map<String, Object> map) {
		update("authDataNS.insertAuth", map);
		
	}
	
	public List<AuthVO> selectAllAuthList(Map<String, Object> map) {
		List<AuthVO> authList = selectList("authDataNS.selectAllAuthList", map);
		
		return authList;
	}
	
	public List<AuthVO> selectUserAuthList(Map<String, Object> map) {
		List<AuthVO> authList = selectList("authDataNS.selectUserAuthList", map);
		
		return authList;
	}

	public HashMap<String, Object> checkAuthSeq(Map<String, Object> map) {
		HashMap<String, Object> ret = selectOne("authDataNS.checkAuthSeq", map);
		return ret;
	} 
}
