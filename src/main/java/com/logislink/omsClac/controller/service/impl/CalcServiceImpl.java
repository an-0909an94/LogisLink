package com.logislink.omsClac.controller.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.logislink.calc.vo.CalcVO;
import com.logislink.omsClac.controller.dao.CalcDao;
import com.logislink.omsClac.controller.service.CalcService;

@Service("omsCalcService")
public class CalcServiceImpl implements CalcService {
	@Resource(name="omsCalcDao")
	private CalcDao omsCalcDao;
	
	
	@Override
	public List<CalcVO> getCalcList(Map<String, Object> map) {
		return omsCalcDao.getCalcList(map);
	}

	@Override
	public int getCnt(Map<String, Object> map) {
		return omsCalcDao.getCnt(map);
	}

	@Override
	public void custFinishCalc(Map<String, Object> map) {
		omsCalcDao.custFinishCalc(map);
	}
	
	@Override
	public void multiFinishCalc(Map<String, Object> map) {
		omsCalcDao.multiFinishCalc(map);
	}
	
	@Override
	public void newCalcCharge(Map<String, Object> map) {
		omsCalcDao.newCalcCharge(map);
	}

	@Override
	public void multiDeleteCalc(Map<String, Object> map) {
		omsCalcDao.multiDeleteCalc(map);
	}

}
