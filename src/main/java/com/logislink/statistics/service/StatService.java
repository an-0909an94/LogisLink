package com.logislink.statistics.service;

import java.util.List;
import java.util.Map;

import com.logislink.statistics.vo.StatVO;

public interface StatService {
	
	List<StatVO> getStatDispatch(Map<String, Object> map);
	
	List<StatVO> getStatDispatchGrid(Map<String, Object> map);
	
	int getStatDispatchGridCount(Map<String, Object> map);
	
	List<StatVO> getStatAllocation(Map<String, Object> map);
	
	List<StatVO> getStatAllocationGrid(Map<String, Object> map);
	
	int getStatAllocationGridCount(Map<String, Object> map);
	
	List<StatVO> getStatUrgent(Map<String, Object> map);
	
	List<StatVO> getStatUrgentGrid(Map<String, Object> map);
	
	int getStatUrgentGridCount(Map<String, Object> map);
	
	List<StatVO> getStatEnter(Map<String, Object> map);
	
	List<StatVO> getStatEnterGrid(Map<String, Object> map);
	
	int getStatEnterGridCount(Map<String, Object> map);
	
	List<StatVO> getStatArrival(Map<String, Object> map);
	
	List<StatVO> getStatArrivalGrid(Map<String, Object> map);
	
	int getStatArrivalGridCount(Map<String, Object> map);
	
	List<StatVO> getStatLoad(Map<String, Object> map);
	
	List<StatVO> getStatLoadGrid(Map<String, Object> map);
	
	int getStatLoadGridCount(Map<String, Object> map);
	
	List<StatVO> getStatCharge(Map<String, Object> map);
	
	List<StatVO> getStatChargeGrid(Map<String, Object> map);
	
	int getStatChargeGridCount(Map<String, Object> map);
	
	List<StatVO> getStatTonCharge(Map<String, Object> map);
	
	List<StatVO> getStatTonChargeGrid(Map<String, Object> map);
	
	int getStatTonChargeGridCount(Map<String, Object> map);
}
