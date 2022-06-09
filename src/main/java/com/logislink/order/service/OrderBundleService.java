package com.logislink.order.service;

import java.util.Collection;
import java.util.List;
import java.util.Map;

public interface OrderBundleService {

	public List<Map<String, Object>> getCustId(Map<String, Object> map);
	
	public List<Map<String, Object>> getVehicId(Map<String, Object> map);

	public void insertOrderBundle(Map<String, Object> map);

	public void insertCalc(Map<String, Object> map);
}
