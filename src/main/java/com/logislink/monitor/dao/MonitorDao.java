package com.logislink.monitor.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

@Repository("monitorDao")
public class MonitorDao extends EgovAbstractMapper{

	public List<Map<String, Object>> selectOrderMonitorUserId (Map<String, Object> map) {
		return selectList("monitorDataNS.selectOrderMonitorByUserId", map);
	}
	
	public List<Map<String, Object>> selectOrderMonitorMonthly(Map<String, Object> map ) {
		return selectList("monitorDataNS.selectOrderMonitorMonthly", map);
	}
	
	public List<Map<String, Object>> selectOrderMonitorMonthlySum(Map<String, Object> map ) {
		return selectList("monitorDataNS.selectOrderMonitorMonthlySum", map);
	}
	
	public List<Map<String, Object>> selectProfitCustId(Map<String, Object> map) {
		return selectList("monitorDataNS.selectProfitByCustId", map);
	}
	
	public List<Map<String, Object>> selectProfitCustMonth(Map<String, Object> map) {
		return selectList("monitorDataNS.selectProfitByCustMonth", map);
	}

	public List<Map<String, Object>> selectProfitCustYear(Map<String, Object> map) {
		return selectList("monitorDataNS.selectProfitByCustYear", map);
	}

	public List<Map<String, Object>> selectOrderMonitorYear(Map<String, Object> map) {
		return selectList("monitorDataNS.selectOrderMonitorYear", map);
	}

	public List<Map<String, Object>> selectOrderMonitorYearSum(Map<String, Object> map) {
		return selectList("monitorDataNS.selectOrderMonitorYearSum", map);
	}

	public List<Map<String, Object>> selectProfitDeptId(Map<String, Object> map) {
		return selectList("monitorDataNS.selectProfitDeptId", map);
	}

	public List<Map<String, Object>> selectProfitDeptMonth(Map<String, Object> map) {
		return selectList("monitorDataNS.selectProfitDeptMonth", map);
	}
	
	public List<Map<String, Object>> selectProfitDeptMonthlySum(Map<String, Object> map) {
		return selectList("monitorDataNS.selectProfitDeptMonthSum", map);
	}

	public List<Map<String, Object>> selectProfitDeptYear(Map<String, Object> map) {
		return selectList("monitorDataNS.selectProfitDeptYear", map);
	}

	public List<Map<String, Object>> selectProfitDeptYearSum(Map<String, Object> map) {
		return selectList("monitorDataNS.selectProfitDeptYearSum", map);
	}
	
}
