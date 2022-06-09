package com.logislink.omsIndicators.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

@Repository("omsIndicatorDao")
public class OmsIndicatorsDao extends EgovAbstractMapper {
	
	public List<Map<String, Object>> selectKpiDaily (Map<String, Object> map) {
		return selectList("indicatorDataNS.selectKpiDaily", map);
	}
	
	public List<Map<String, Object>> selectKpiMonthly (Map<String, Object> map) {
		return selectList("indicatorDataNS.selectKpiMonthly", map);
	}
	
	public List<Map<String, Object>> selectChargeDaily (Map<String, Object> map) {
		return selectList("indicatorDataNS.selectChargeDaily", map);
	}
	
	public List<Map<String, Object>> selectChargeMonthly (Map<String, Object> map) {
		return selectList("indicatorDataNS.selectChargeMonthly", map);
	}
}
