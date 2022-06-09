package com.logislink.monitor.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.logislink.monitor.dao.MonitorDao;
import com.logislink.monitor.service.MonitorService;

@Service("monitorService")
public class MonitorServiceImpl implements MonitorService {

	@Resource(name="monitorDao")
	private MonitorDao monitorDao;

	@Override
	public List<Map<String, Object>> selectOrderMonitorUserId(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return monitorDao.selectOrderMonitorUserId(map);
	}

	@Override
	public List<Map<String, Object>> selectOrderMonitorMonthly(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return monitorDao.selectOrderMonitorMonthly(map);
	}


	@Override
	public List<Map<String, Object>> selectOrderMonitorMonthlySum(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return monitorDao.selectOrderMonitorMonthlySum(map);
	}

	@Override
	public List<Map<String, Object>> selectProfitCustId(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return monitorDao.selectProfitCustId(map);
	}

	@Override
	public List<Map<String, Object>> selectProfitCustMonth(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return monitorDao.selectProfitCustMonth(map);
	}

	@Override
	public List<Map<String, Object>> selectProfitCustYear(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return monitorDao.selectProfitCustYear(map);
	}

	@Override
	public List<Map<String, Object>> selectOrderMonitorYear(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return monitorDao.selectOrderMonitorYear(map);
	}

	@Override
	public List<Map<String, Object>> selectOrderMonitorYearSum(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return monitorDao.selectOrderMonitorYearSum(map);
	}

	@Override
	public List<Map<String, Object>> selectProfitDeptId(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return monitorDao.selectProfitDeptId(map);
	}

	@Override
	public List<Map<String, Object>> selectProfitDeptMonth(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return monitorDao.selectProfitDeptMonth(map);
	}

	@Override
	public List<Map<String, Object>> selectProfitDeptMonthlySum(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return monitorDao.selectProfitDeptMonthlySum(map);
	}

	@Override
	public List<Map<String, Object>> selectProfitDeptYear(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return monitorDao.selectProfitDeptYear(map);
	}

	@Override
	public List<Map<String, Object>> selectProfitDeptYearSum(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return monitorDao.selectProfitDeptYearSum(map);
	}

}
