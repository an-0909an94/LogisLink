package com.logislink.omsIndicators.service;

import java.util.List;
import java.util.Map;

public interface OmsIndicatorService {
	public List<Map<String, Object>> getKpiDaily(Map<String, Object> map);
	public List<Map<String, Object>> getKpiMonthly(Map<String, Object> map);
	public List<Map<String, Object>> getChargeDaily(Map<String, Object> map);
	public List<Map<String, Object>> getChargeMonthly(Map<String, Object> map);
}
