package com.logislink.omsOrder.service;

import java.util.List;
import java.util.Map;

import com.logislink.omsOrder.vo.OmsOrderVO;

public interface OmsOrderService {
	
	public List<OmsOrderVO> getOmsOrderList(Map<String, Object> map);
	
	public int getCnt(Map<String, Object> map);
	
	public List<Map<String, Object>> getCustId(Map<String, Object> map);

	public void insertOrderBundle(Map<String, Object> map);

	public List<OmsOrderVO> getOmsOrderLocationList(Map<String, Object> map); 

	public int getOmsOrderLocationCnt(Map<String, Object> map);

	public Map<String, Object> getOmsOrderSummary(Map<String, Object> map);

	public void orderWrite(Map<String, Object> map); 
}
