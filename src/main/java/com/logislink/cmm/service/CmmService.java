package com.logislink.cmm.service;

import java.util.List;
import java.util.Map;

import com.logislink.basic.vo.AddrVO;
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

	public List<AddrVO> getJibunAddr(Map<String, Object> map) throws Exception;

	public int getAddrCnt(Map<String, Object> map) throws Exception;
	
	// 예금주 확인용 DB에 데이터 삽입
	public String insertVacsSendAccountCheck(Map<String, Object> map);
	
	// 예금주 확인 결과 조회
	public Map<String, Object> selectVacsSendAccountCheck(Map<String, Object> map);
	
	// 기사 계좌확인 결과 업데이트
	public int updateDriverAccountCheck(Map<String, Object> map);
}
