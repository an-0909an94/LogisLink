package com.logislink.omsClac.controller.service;

import java.util.List;
import java.util.Map;

import com.logislink.calc.vo.CalcVO;

public interface CalcService {
	public List<CalcVO> getCalcList(Map<String, Object> map);
	
	public int getCnt(Map<String, Object> map);
	
	public void custFinishCalc(Map<String, Object> map);
	
	public void multiFinishCalc(Map<String, Object> map);
	
	public void multiDeleteCalc(Map<String, Object> map);
	
	public void newCalcCharge(Map<String, Object> map);
}
