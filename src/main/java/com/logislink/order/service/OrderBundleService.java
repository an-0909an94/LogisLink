package com.logislink.order.service;

import java.util.Collection;
import java.util.List;
import java.util.Map;

public interface OrderBundleService {

	public List<Map<String, Object>> getCustId(Map<String, Object> map);
	
	public List<Map<String, Object>> getVehicId(Map<String, Object> map);
	
	// 22.07.09 이건욱 T1 > J5, J6 배차관리 기능개선 (거래처명 조회)
	public List<Map<String, Object>> getCustName(Map<String, Object> map);
	
	// 22.07.09 이건욱 T1 > J5, J6 배차관리 기능개선 (부서명 조회)
	public List<Map<String, Object>> getDeptName(Map<String, Object> map);
	
	// 22.07.09 이건욱 T1 > J5, J6 배차관리 기능개선 (코드 명으로 코드 아이디 조회)
	public List<Map<String, Object>> getCodeId(Map<String, Object> map);
	
	// 22.7.12 이건욱 T1 > J6 배차일괄등록 편의성 개선 (차량번호로 차량조회)
	public List<Map<String, Object>> getVehicInfo(Map<String, String> map);

	public void insertOrderBundle(Map<String, Object> map);

	public void insertCalc(Map<String, Object> map);
}
