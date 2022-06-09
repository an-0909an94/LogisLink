package com.logislink.calc.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.logislink.calc.vo.CalcVO;
import com.logislink.calc.vo.OrderCalcVO;
import com.logislink.cmm.vo.FileVO;

import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

@Repository("calcDao")
public class CalcDao extends EgovAbstractMapper{

	public List<CalcVO> getCalcList(Map<String, Object> map) {
		List<CalcVO> calc = selectList("calcDataNS.selectCalcList", map);
		
		return calc;
	}
	
	public int getCnt(Map<String, Object> map) {
		String cnt = selectOne("calcDataNS.selectCnt",map);
		return Integer.valueOf(cnt);
	}
	
	public Map<String, Object> getSummary(Map<String, Object> map) {
		return selectOne("calcDataNS.selectCalcSummary", map);
	}
	
	public List<OrderCalcVO> selectPurchaseDeadline (Map<String, Object> map) {
		return selectList("calcDataNS.selectPurchaseDeadline", map);
	}
	
	public Map<String, Object> selectPurchaseDeadlineSummary(Map<String, Object> map) {
		return selectOne("calcDataNS.selectPurchaseDeadlineSummary", map);
	}

	public List<OrderCalcVO> selectSellPurchaseDeadline (Map<String, Object> map) {
		return selectList("calcDataNS.selectSellPurchaseDeadline", map);
	}
	
	public void updateAllocCharge(Map<String, Object> map) {
		update("calcDataNS.updateAllocCharge", map);
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
		update("calcDataNS.multiDeleteCalc", map);
	}

	public void updateChangeReq(Map<String, Object> map) {
		update("calcDataNS.updateChangeReq", map);		
	}
	
	public List<Map<String, Object>> selectCustByBiz(Map<String, Object> map) {
		return selectList("calcDataNS.selectCustByBiz", map);
	}

	public List<Map<String, Object>> selectDeptByCust(Map<String, Object> map) {
		return selectList("calcDataNS.selectDeptByCust", map);
	}

	public void multiDeleteAllocAdd(Map<String, Object> map) {
		// TODO Auto-generated method stub
		delete("calcDataNS.multiDeleteAllocAdd", map);
	}

	public HashMap<String, String> calcCheck(Map<String, Object> map) {
		HashMap<String, String> chk = selectOne("calcDataNS.calcCheck", map);
		return chk;
	}

	public void multPaperReceipt(Map<String, Object> map) {
		// TODO Auto-generated method stub
		update("calcDataNS.multPaperReceipt", map);		
	}

	public void multPaperTax(Map<String, Object> map) {
		// TODO Auto-generated method stub
		update("calcDataNS.multPaperTax", map);		
	}

	public void detailCalcUpdate(Map<String, Object> map) {
		// TODO Auto-generated method stub
		update("calcDataNS.detailCalcUpdate", map);
	}

	public Map<String, Object> viewTax(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return selectOne("calcDataNS.viewTax",map);
	}

	public List<FileVO> viewReceipt(Map<String, Object> map) {
		List<FileVO> file = selectList("calcDataNS.viewReceipt", map);
		
		return file;
	}

	public HashMap<String, Object> allocIdChk(Map<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> ret = selectOne("calcDataNS.allocIdChk", map);
		return ret;
	}

	public List<Map<String, Object>> viewTaxDetail(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return selectList("calcDataNS.viewTaxDetail",map);
	}

	public Map<String, Object> getDriverCommission(Map<String, Object> map) {
		// TODO Auto-generated method stub 
		return selectOne("calcDataNS.driverCommission",map);
	}
	
	public List<Map<String, Object>> selectOrderAllocAdd(Map<String, Object> map) {
		return selectList("calcDataNS.selectOrderAllocAdd", map);
	}

	public List<CalcVO> serchCustDeptInfo(Map<String, Object> map) {
		List<CalcVO> list = selectList("calcDataNS.serchCustDeptInfo", map);
		return list;
	}
}
