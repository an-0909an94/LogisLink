package com.logislink.omsIndicators.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.logislink.omsIndicators.dao.OmsIndicatorsDao;
import com.logislink.omsIndicators.service.OmsIndicatorService;

@Service("omsIndicatorService")
public class OmsIndicatorServiceImpl implements OmsIndicatorService {

	@Resource(name="omsIndicatorDao")
	private OmsIndicatorsDao omsIndicatorDao;
	
	@Override
	public List<Map<String, Object>> getKpiDaily(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return omsIndicatorDao.selectKpiDaily(map);
	}

	@Override
	public List<Map<String, Object>> getKpiMonthly(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return omsIndicatorDao.selectKpiMonthly(map);
	}

	@Override
	public List<Map<String, Object>> getChargeDaily(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return omsIndicatorDao.selectChargeDaily(map);
	}

	@Override
	public List<Map<String, Object>> getChargeMonthly(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return omsIndicatorDao.selectChargeMonthly(map);
	}

}
