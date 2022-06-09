package com.logislink.basic.service;

import java.util.List;
import java.util.Map;

import com.logislink.basic.vo.CodeVO;

public interface CodeService {
	public List<CodeVO> getCodeGroupList(Map<String, Object> map);
	
	public List<CodeVO> getCodeList(Map<String, Object> map);
	
	public void insertCodeGroup(Map<String, Object> map);
	
	public void insertCode(Map<String, Object> map);
}
