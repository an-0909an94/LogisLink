package com.logislink.omsComp.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.logislink.basic.vo.UserVO;

import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

@Repository("omsCompDao")
public class CompDao extends EgovAbstractMapper{

	public List<UserVO> selectUserList(Map<String, Object> map) {
		// TODO Auto-generated method stub
		List<UserVO> userList = selectList("userDataNS.omsSelectUserList", map);
		return userList;
	}

	public int getCnt(Map<String, Object> map) {
		// TODO Auto-generated method stub
		String cnt = selectOne("userDataNS.omsSelectUserCnt",map);
		return Integer.valueOf(cnt);
	}

}
