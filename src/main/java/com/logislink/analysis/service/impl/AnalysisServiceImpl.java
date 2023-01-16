package com.logislink.analysis.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.logislink.analysis.dao.AnalysisDao;
import com.logislink.analysis.service.AnalysisService;

@Service("analysisService")
public class AnalysisServiceImpl implements AnalysisService {

	@Resource(name="analysisDao")
	private AnalysisDao analysisDao;
	
	@Override
	public List<Map<String, Object>> selectFreightAnalysisEArea(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return analysisDao.selectFreightAnalysisEArea(map);
	}

	@Override
	public List<Map<String, Object>> selectFreightAnalysisStat(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return analysisDao.selectFreightAnalysisStat(map);
	}

	@Override
	public List<Map<String, Object>> selectFreightAnalysisMode(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return analysisDao.selectFreightAnalysisMode(map);
	}

	@Override
	public List<Map<String, Object>> selectFreightAnalysisModeAll(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return analysisDao.selectFreightAnalysisModeAll(map);
	}

	@Override
	public List<Map<String, Object>> selectFreightAnalysisAvg(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return analysisDao.selectFreightAnalysisAvg(map);
	}

	@Override
	public List<Map<String, Object>> selectFreightAnalysisAvgAll(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return analysisDao.selectFreightAnalysisAvgAll(map);
	}

	@Override
	public List<Map<String, Object>> selectFreightAnalysisMin(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return analysisDao.selectFreightAnalysisMin(map);
	}

	@Override
	public List<Map<String, Object>> selectFreightAnalysisMax(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return analysisDao.selectFreightAnalysisMax(map);
	}

	@Override
	public List<Map<String, Object>> selectTransportDB(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return analysisDao.selectTransportDB(map);
	}

}
