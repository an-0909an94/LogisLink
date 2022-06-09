package com.logislink.calc.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.logislink.calc.vo.CalcVO;
import com.logislink.calc.vo.OrderCalcVO;
import com.logislink.cmm.vo.FileVO;

public interface CalcService {
	public List<CalcVO> getCalcList(Map<String, Object> map);
	
	public int getCnt(Map<String, Object> map);
	
	public Map<String, Object> getSummary(Map<String, Object> map);

	public List<OrderCalcVO> getPurchaseDeadline(Map<String, Object> map);
	
	public List<OrderCalcVO> getSellPurchaseDeadline(Map<String, Object> map);
	
	public Map<String, Object> getPurchaseDeadlineSummary(Map<String, Object> map);
	
	public void updateAllocCharge(Map<String, Object> map);
	
	public void custFinishCalc(Map<String, Object> map);
	
	public void multiFinishCalc(Map<String, Object> map);
	
	public void newCalcCharge(Map<String, Object> map);

	public void multiDeleteCalc(Map<String, Object> map);
	
	public void updateChangeReq(Map<String, Object> map);
	
	public List<Map<String, Object>> getCustByBiz(Map<String, Object> map);
	
	public List<Map<String, Object>> getDeptByCust(Map<String, Object> map);

	public void multiDeleteAllocAdd(Map<String, Object> map);

	public HashMap<String, String> calcCheck(Map<String, Object> map);
	
	public void multPaperReceipt(Map<String, Object> map);

	public void multPaperTax(Map<String, Object> map);

	public void detailCalcUpdate(Map<String, Object> map);

	public Map<String, Object> viewTax(Map<String, Object> map);

	public List<FileVO> viewReceipt(Map<String, Object> map);

	public HashMap<String, Object> allocIdChk(Map<String, Object> map);

	public List<Map<String, Object>> viewTaxDetail(Map<String, Object> map); 

	public Map<String, Object> getDriverCommission(Map<String, Object> map); 
	
	public List<Map<String, Object>> getOrderAllocAdd(Map<String, Object> map);

	public List<CalcVO> serchCustDeptInfo(Map<String, Object> map);
}
