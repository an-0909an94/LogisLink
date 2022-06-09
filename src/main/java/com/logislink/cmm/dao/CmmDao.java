package com.logislink.cmm.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.logislink.basic.vo.CodeVO;
import com.logislink.cmm.vo.AreaVO;

import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

@Repository("cmmDao")
public class CmmDao extends EgovAbstractMapper{

	public List<CodeVO> selectCmmCode(Map<String, Object> map) {
		return selectList("codeDataNS.selectCmmCode", map);
	}

	public AreaVO selectAreaCode(Map<String, Object> map) throws Exception {
		return (AreaVO)selectOne("cmmDataNS.selectAreaCode", map);
	}
	
	public int selectOpiInfoCnt(Map<String, Object> map) throws Exception {
		String count = (String)selectOne("cmmDataNS.selectOpiInfoCnt", map);
		int cnt = Integer.valueOf(count);
		return cnt;
	}
	
	public void insertOpiInfo(Map<String, Object> map) throws Exception {
		insert("cmmDataNS.insertOpiInfo", map);
	}

	public void insertWeatherInfo(Map<String, String> map) {
		// TODO Auto-generated method stub
		insert("cmmDataNS.insertWeatherInfo", map);
	}

	public List<AreaVO> selectAreaCodeList(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return selectList("cmmDataNS.selectAreaCodeList", map);
	}
}
