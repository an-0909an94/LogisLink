package com.logislink.cmm.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.logislink.basic.vo.CodeVO;
import com.logislink.basic.vo.CompDeptVO;

import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

@Repository("mainDao")
public class MainDao extends EgovAbstractMapper{

	public HashMap<String, Object> checkBizNum(Map<String, Object> map) {
		HashMap<String, Object> data = selectOne("custDataNS.joinCheckBizNum", map);
		return data;
	}

	public HashMap<String, Object> checkUserId(Map<String, Object> map) {
		HashMap<String, Object> data = selectOne("userDataNS.joinCheckUserId", map);
		return data;
	}

	public List<CodeVO> getCmmCode(Map<String, Object> map) {
		return selectList("codeDataNS.selectCmmCode", map);
	}

	public void signUp(Map<String, Object> map) {
		update("userDataNS.signUp", map);		
	}

	public List<CompDeptVO> getCompDeptList(Map<String, Object> map) {
		List<CompDeptVO> compDeptList = selectList("compDataNS.selectCompDeptList", map);
		return compDeptList;
	}

	public void getUserData(Map<String, Object> map) {
		// TODO Auto-generated method stub
		update("userDataNS.getUserData", map);		
	}
}
