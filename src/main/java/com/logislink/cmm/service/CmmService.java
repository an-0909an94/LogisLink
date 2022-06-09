package com.logislink.cmm.service;

import java.util.List;
import java.util.Map;

import com.logislink.basic.vo.CodeVO;
import com.logislink.cmm.vo.AreaVO;

public interface CmmService {

	public List<CodeVO> getCmmCode(Map<String, Object> map);

	public AreaVO getAreaCode(Map<String, Object> map) throws Exception;
	
	public int getOpiInfoCnt(Map<String, Object> map) throws Exception;
	
	public void insertOpiInfo(Map<String, Object> map) throws Exception;

	public void insertWeatherInfo(Map<String, String> map);

	public List<AreaVO> getAreaCodeList(Map<String, Object> map);
	
}
