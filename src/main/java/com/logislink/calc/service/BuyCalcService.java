package com.logislink.calc.service;

import java.util.List;
import java.util.Map;

import com.logislink.calc.vo.BuyCalcVO;

public interface BuyCalcService {
	public List<BuyCalcVO> getBuyCalcList(Map<String, Object> map);
	
	public Map<String, Object> getBuyCalcListCnt(Map<String, Object> map);
	
	public Map<String, Object> selectTaxinv(Map<String, Object> map);
	
	public List<Map<String, Object>> selectTaxinvDetailList(Map<String, Object> map);
	
	public int updateReceiptSub(Map<String, Object> map);
	
	public int updateTaxinvSub(Map<String, Object> map);
	
	public int updateDeleteYn(Map<String, Object> map);
	
	public void upsertCalcCharge(Map<String, Object> map);
	
	public void updateBuyCalcFinish(Map<String, Object> map);
}
