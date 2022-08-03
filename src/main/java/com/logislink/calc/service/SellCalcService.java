package com.logislink.calc.service;

import java.util.List;
import java.util.Map;

import com.logislink.calc.vo.SellCalcVO;

public interface SellCalcService {
	public List<SellCalcVO> getSellCalcList(Map<String, Object> map);
	
	public int getSellCalcListCnt(Map<String, Object> map);
	
	public int updatePostSendYn(Map<String, Object> map);
	
	public int updateDeleteYn(Map<String, Object> map);
	
	public void updateSellChangeReq(Map<String, Object> map);
	
	public void upsertCalcCharge(Map<String, Object> map);
}
