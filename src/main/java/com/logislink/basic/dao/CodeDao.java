package com.logislink.basic.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.logislink.basic.vo.CodeVO;

import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

@Repository("codeDao")
public class CodeDao extends EgovAbstractMapper{

	public List<CodeVO> getCodeGroupList(Map<String, Object> map) {
		List<CodeVO> codeGroupList = selectList("codeDataNS.getCodeGroupList", map);
		
		return codeGroupList;
	}
	
	public List<CodeVO> getCodeList(Map<String, Object> map) {
		List<CodeVO> codeList = selectList("codeDataNS.getCodeList", map);
		
		return codeList;
	}
	
	public void insertCodeGroup(Map<String, Object> map) {
		update("codeDataNS.insertCodeGroup", map);		
	} 
	
	public void insertCode(Map<String, Object> map) {
		update("codeDataNS.insertCode", map);
	}
}
