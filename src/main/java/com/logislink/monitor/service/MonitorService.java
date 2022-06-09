package com.logislink.monitor.service;

import java.util.List;
import java.util.Map;

public interface MonitorService {
	
	public List<Map<String, Object>> selectOrderMonitorUserId(Map<String, Object> map);
	
	public List<Map<String, Object>> selectOrderMonitorMonthly(Map<String, Object> map);
	
	public List<Map<String, Object>> selectOrderMonitorMonthlySum(Map<String, Object> map);
	
	public List<Map<String, Object>> selectProfitCustId(Map<String, Object> map);
	
	public List<Map<String, Object>> selectProfitCustMonth(Map<String, Object> map);
	
	public List<Map<String, Object>> selectProfitCustYear(Map<String, Object> map);
	
	public List<Map<String, Object>> selectOrderMonitorYear(Map<String, Object> map);
	
	public List<Map<String, Object>> selectOrderMonitorYearSum(Map<String, Object> map);
	
	public List<Map<String, Object>> selectProfitDeptId(Map<String, Object> map);
	
	public List<Map<String, Object>> selectProfitDeptMonth(Map<String, Object> map);
	
	public List<Map<String, Object>> selectProfitDeptMonthlySum(Map<String, Object> map);
	
	public List<Map<String, Object>> selectProfitDeptYear(Map<String, Object> map);
	
	public List<Map<String, Object>> selectProfitDeptYearSum(Map<String, Object> map);

}
