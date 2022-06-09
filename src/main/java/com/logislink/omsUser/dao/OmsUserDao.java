package com.logislink.omsUser.dao;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.logislink.basic.vo.UserOptionVO;

import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

@Repository("omsUserDao")
public class OmsUserDao extends EgovAbstractMapper{

	public UserOptionVO getUserOption(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return selectOne("userDataNS.omsGetUserOption", map);
	}

	public void insertUserOption(Map<String, Object> map) {
		// TODO Auto-generated method stub
		insert("userDataNS.omsInsertUserOption", map);
	}

}
