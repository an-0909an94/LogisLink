package com.logislink.calc.service;

import java.util.List;
import java.util.Map;

import com.logislink.calc.vo.FpisVO;

public interface FpisService {
	public List<FpisVO> getFpisList(Map<String, Object> map);
	
	public int getFpisCnt(Map<String, Object> map);
}
