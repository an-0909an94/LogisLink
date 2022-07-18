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
	
	// 22.07.15 이건욱 그리드 개인화 설정
	public List<Map<String, Object>> getPrivateColInfo(Map<String, Object> map);
	
	public void savePrivateColList(Map<String, Object> map) throws Exception;
	
	public List<Map<String, Object>> getPrivateTblInfo(Map<String, Object> map);
	
	public List<Map<String, Object>> getPrivateTblCnt(Map<String, Object> map);
	
	public void savePrivateColReset(Map<String, Object> map) throws Exception;
	
	public void savePrivateTblCnt(Map<String, Object> map) throws Exception;
	// 22.07.15 이건욱 그리드 개인화 설정 -> End
}
