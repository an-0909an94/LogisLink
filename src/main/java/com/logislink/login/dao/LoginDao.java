package com.logislink.login.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.logislink.login.vo.LoginMenuVO;
import com.logislink.login.vo.LoginVO;

import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

@Repository("loginDao")
public class LoginDao extends EgovAbstractMapper {

	public LoginVO selectUserList(Map<String, Object> map) {
		
		LoginVO login = selectOne("loginDataNS.selectUserLogin", map);
		
		return login;
	} 
	
	public List<LoginMenuVO> selectLoginMenuList(Map<String, Object> map) {
		
		List<LoginMenuVO> menuList = selectList("loginDataNS.selectLoginMenu", map);
		
		return menuList;
	}
	
	public void updateLastLogin(Map<String, Object> map) {
		update("loginDataNS.updateLoginDate", map);
	}

	public void insertLoginTalk(Map<String, Object> map) {
		insert("loginDataNS.insertLoginTalk", map);
	}
}
