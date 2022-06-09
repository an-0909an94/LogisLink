package com.logislink.basic.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.logislink.basic.vo.ManualVO;

import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

@Repository("manualDao")
public class ManualDao extends EgovAbstractMapper{

	public List<ManualVO> getManualGroupList(Map<String, Object> map) {
		List<ManualVO> manualGroupList = selectList("menualDataNS.getManualGroupList", map);
		
		return manualGroupList;
	}

	public List<ManualVO> getManualList(Map<String, Object> map) {
		List<ManualVO> manualList = selectList("menualDataNS.getManualList", map);
		
		return manualList;
	}

	public void insertManualGroup(Map<String, Object> map) {
		// TODO Auto-generated method stub
		update("menualDataNS.insertManualGroup", map);		
	}

	public void insertManual(Map<String, Object> map) {
		// TODO Auto-generated method stub
		update("menualDataNS.insertManual", map);		
	}

	public void insertManualFile(Map<String, Object> map) {
		// TODO Auto-generated method stub
		update("menualDataNS.insertManualFile", map);
	}

}
