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
	
	public void insertOrderBundle(Map<String, Object> map) {
		insert("orderBundleDataNS.insertOrder", map);
		insert("orderBundleDataNS.insertOrderAlloc", map);
		insert("orderBundleDataNS.insertOrderBuyAlloc", map);
	}
	
	public void insertCalc(Map<String, Object> map) {
		insert("orderBundleDataNS.insertCalc", map);
	}
}