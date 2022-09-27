package com.logislink.calc.service;

import java.util.List;
import java.util.Map;

import com.logislink.calc.vo.SellCalcVO;

public interface SellCalcService {
	public List<SellCalcVO> getSellCalcList(Map<String, Object> map);
	
	public Map<String, Object> getSellCalcListCnt(Map<String, Object> map);
	
	public Map<String, Object> selectTaxBizInfo(Map<String, Object> map);
	
	public Map<String, Object> selectSupplierTaxBizInfo(Map<String, Object> map);
	
	public Map<String, Object> selectBuyerTaxBizInfo(Map<String, Object> map);
	
	public Map<String, Object> selectSupplierTaxDriverInfo(Map<String, Object> map);
	
	public int updatePostSendYn(Map<String, Object> map);
	
	public int updateDeleteYn(Map<String, Object> map);
	
	public void updateSellChangeReq(Map<String, Object> map);
	
	public void upsertCalcCharge(Map<String, Object> map);
	
	public int updateAllocCharge(Map<String, Object> map);
	
	public void updateSellCalcFinish(Map<String, Object> map);
	
	public void updateSellCalcPayFinish(Map<String, Object> map);
}
