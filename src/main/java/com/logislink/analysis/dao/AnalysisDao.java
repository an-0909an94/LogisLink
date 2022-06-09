package com.logislink.analysis.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

@Repository("analysisDao")
public class AnalysisDao extends EgovAbstractMapper {

	public List<Map<String, Object>> selectFreightAnalysisEArea(Map<String, Object> map) {
		return selectList("analysisDataNS.selectFreightAnalysisEArea", map);
	}
	
	public List<Map<String, Object>> selectFreightAnalysisStat(Map<String, Object> map) {
		return selectList("analysisDataNS.selectFreightAnalysisStat", map);
	}
	
	public List<Map<String, Object>> selectFreightAnalysisMode(Map<String, Object> map) {
		return selectList("analysisDataNS.selectFreightAnalysisMode", map);
	}

	public List<Map<String, Object>> selectFreightAnalysisModeAll(Map<String, Object> map) {
		return selectList("analysisDataNS.selectFreightAnalysisModeAll", map);
	}
	
	public List<Map<String, Object>> selectFreightAnalysisAvg(Map<String, Object> map) {
		return selectList("analysisDataNS.selectFreightAnalysisAvg", map);
	}
	
	public List<Map<String, Object>> selectFreightAnalysisAvgAll(Map<String, Object> map) {
		return selectList("analysisDataNS.selectFreightAnalysisAvgAll", map);
	}
	
	public List<Map<String, Object>> selectFreightAnalysisMin(Map<String, Object> map) {
		return selectList("analysisDataNS.selectFreightAnalysisMin", map);
	}
	
	public List<Map<String, Object>> selectFreightAnalysisMax(Map<String, Object> map) {
		return selectList("analysisDataNS.selectFreightAnalysisMax", map);
	}
}
