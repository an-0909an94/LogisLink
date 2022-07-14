package com.logislink.order.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

@Repository("orderBundleDao")
public class OrderBundleDao extends EgovAbstractMapper {

	public List<Map<String, Object>> selectCustId(Map<String, Object> map) {
		return selectList("orderBundleDataNS.selectCustId", map);
	}
	
	public List<Map<String, Object>> selectVehicId(Map<String, Object> map) {
		return selectList("orderBundleDataNS.selectVehicId", map);
	}
	
	// 22.07.09 이건욱 T1 > J5, J6 배차관리 기능개선 (거래처명 조회)
	public List<Map<String, Object>> selectCustName(Map<String, Object> map) {
		return selectList("orderBundleDataNS.selectCustName", map);
	}
	
	// 22.07.09 이건욱 T1 > J5, J6 배차관리 기능개선 (부서명 조회)
	public List<Map<String, Object>> selectDeptName(Map<String, Object> map) {
		return selectList("orderBundleDataNS.selectDeptName", map);
	}
	
	// 22.07.09 이건욱 T1 > J5, J6 배차관리 기능개선 (코드 명으로 코드 아이디 조회)
	public List<Map<String, Object>> selectCodeId(Map<String, Object> map) {
		return selectList("orderBundleDataNS.selectCodeId", map);
	}
	
	// 22.7.12 이건욱 T1 > J6 배차일괄등록 편의성 개선 (차량번호로 차량조회)
	public List<Map<String, Object>> selectVehicInfo(Map<String, String> map) {
		return selectList("orderBundleDataNS.selectVehicInfo", map);
	}
	
	public void insertOrderBundle(Map<String, Object> map) {
		insert("orderBundleDataNS.insertOrder", map);
		insert("orderBundleDataNS.insertOrderAlloc", map);
		insert("orderBundleDataNS.insertOrderBuyAlloc", map);
	}
	
	public void insertCalc(Map<String, Object> map) {
		insert("orderBundleDataNS.insertCalc", map);
	}
}