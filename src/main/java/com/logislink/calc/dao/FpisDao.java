package com.logislink.calc.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.logislink.calc.vo.FpisVO;

import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

@Repository("fpisDao")
public class FpisDao extends EgovAbstractMapper{

	public List<FpisVO> selectFpisList(Map<String, Object> map) {
		return selectList("fpisDataNS.selectFpis", map);
	}
	
	public int selectFpisCnt(Map<String, Object> map) {
		String cnt = selectOne("fpisDataNS.selectFpisCnt", map);
		return Integer.valueOf(cnt);
	}
}
