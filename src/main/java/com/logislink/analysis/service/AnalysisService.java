package com.logislink.analysis.service;

import java.util.List;
import java.util.Map;

public interface AnalysisService {
	
	public List<Map<String, Object>> selectFreightAnalysisEArea(Map<String, Object> map);
	
	public List<Map<String, Object>> selectFreightAnalysisStat(Map<String, Object> map);
	
	public List<Map<String, Object>> selectFreightAnalysisMode(Map<String, Object> map);
	
	public List<Map<String, Object>> selectFreightAnalysisModeAll(Map<String, Object> map);
	
	public List<Map<String, Object>> selectFreightAnalysisAvg(Map<String, Object> map);
	
	public List<Map<String, Object>> selectFreightAnalysisAvgAll(Map<String, Object> map);
	
	public List<Map<String, Object>> selectFreightAnalysisMin(Map<String, Object> map);
	
	public List<Map<String, Object>> selectFreightAnalysisMax(Map<String, Object> map);
}
