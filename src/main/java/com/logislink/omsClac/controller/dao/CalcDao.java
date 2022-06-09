package com.logislink.omsClac.controller.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.logislink.calc.vo.CalcVO;

import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

@Repository("omsCalcDao")
public class CalcDao extends EgovAbstractMapper{

	public List<CalcVO> getCalcList(Map<String, Object> map) {
		List<CalcVO> calc = selectList("calcDataNS.omsSelectCalcList", map);
		
		return calc;
	}

	public int getCnt(Map<String, Object> map) {
		String cnt = selectOne("calcDataNS.omsSelectCnt",map);
		return Integer.valueOf(cnt);
	}
	
	public void custFinishCalc(Map<String, Object> map) {
		update("calcDataNS.custFinishCalc", map);
	}
	
	public void multiFinishCalc(Map<String, Object> map) {
		update("calcDataNS.multiFinishCalc", map);
	}
	
	public void newCalcCharge(Map<String, Object> map) {
		insert("calcDataNS.newCalcCharge", map);
	}

	public void multiDeleteCalc(Map<String, Object> map) {
		// TODO Auto-generated method stub
		update("calcDataNS.multiDeleteCalc", map);
	}

}
