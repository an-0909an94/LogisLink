package com.logislink.basic.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.logislink.basic.vo.CompDeptVO;
import com.logislink.basic.vo.CompVO;

import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

@Repository("compDao")
public class CompDao extends EgovAbstractMapper{

	public CompVO selectCompInfo(Map<String, Object> map) {
		CompVO comp = selectOne("compDataNS.selectCompInfo", map);
		
		return comp;
	}
	
	public List<CompDeptVO> selectCompDeptList(Map<String, Object> map) {
		List<CompDeptVO> compDeptList = selectList("compDataNS.selectCompDeptList", map);
		
		return compDeptList;
	}
	
	public List<CompVO> selectMasterCompList(Map<String, Object> map) {
		List<CompVO> masterCompList = selectList("compDataNS.selectMasterCompList", map);
		
		return masterCompList;
	}
	
	public int getCnt(Map<String, Object> map) {
		String cnt = selectOne("compDataNS.selectMasterCompCnt",map);
		return Integer.valueOf(cnt);
	}
	
	public void update(Map<String, Object> map) {
		update("compDataNS.updateComp", map);		
	} 
	
	public void insertCompDept(Map<String, Object> map) {
		update("compDataNS.insertCompDept", map);		
	}

	public void updateCompDept(Map<String, Object> map) {
		// TODO Auto-generated method stub
		update("compDataNS.compDeptUpdate", map);
	} 
	
	public void updateCompApi(Map<String, Object> map) {
		update("compDataNS.updateCompApi", map);
	}
}
