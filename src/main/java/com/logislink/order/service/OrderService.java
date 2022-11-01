package com.logislink.order.service;

import java.math.BigInteger;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.logislink.basic.vo.DrvLocVO;
import com.logislink.order.vo.OrderStopVO;
import com.logislink.order.vo.OrderVO;

public interface OrderService {
	
	public List<OrderVO> getOrderList(Map<String, Object> map);
	
	public Map<String,Object> getCnt(Map<String, Object> map);
	
	public List<OrderStopVO> getOrderStop(Map<String, Object> map);

	public OrderVO getOrderDetail(Map<String, Object> map);
	
	public List<DrvLocVO> getOrderLbs(Map<String, Object> map); 
	
	public void orderWrite(Map<String, Object> map);	
	
	public void insertOrderStop(Map<String, Object> map);
	
	public void updateOrderStopFinish(Map<String, Object> map);
	
	public void updateOrderState(Map<String, Object> map);
	
	public void updateOrderAlloc(Map<String, Object> map);
	
	public void updateAllocState(Map<String, Object> map);
	
	public int getAvgFare(Map<String, Object> map);
	
	public void linkWrite(Map<String, Object> map);
	
	public List<Map<String, Object>> getLinkList(Map<String, Object> map);
	
	public Map<String, Object> getAllocCharge(Map<String, Object> map);
	
	public BigInteger getCharge(Map<String, Object> map);

	public HashMap<String, Object> linkCarTypeChk(Map<String, Object> map);

	public HashMap<String, Object> linkCarTonChk(Map<String, Object> map);

	public HashMap<String, Object> linkDateChk(Map<String, Object> map);

	public void linkDriverChange(Map<String, Object> map);

	public void multOrderAllocAddInsert(Map<String, Object> map);

	public void linkCancelOrder(Map<String, Object> map);
	
	public void insertAllocAddToCalc(Map<String, Object> map);
	
	public void linkSettle(Map<String, Object> map);

	public List<Map<String, Object>> getDriverOrderHistoryList(Map<String, Object> map);

	public int getDriverOrderHistoryCnt(Map<String, Object> map);
	
	public int getLinkCnt(Map<String, Object> map);

	public void updateLinkDriver(Map<String, Object> map);

	public Map<String, Object> priceDetail(Map<String, Object> map);

	public List<OrderVO> getOrderSituation(Map<String, Object> map);

	public List<Map<String, Object>> getOrderHistory(Map<String, Object> map);

	public int getOrderHistoryCnt(Map<String, Object> map);

	public List<OrderVO> getFreightControlList(Map<String, Object> map);

	public void multOrderAllocUpdate(Map<String, Object> map);
	
	public int getFreightControlCnt(Map<String, Object> map);

	public Map<String, Object> getBasicFare(Map<String, Object> map);
}
