package com.logislink.basic.service;

import java.util.List;
import java.util.Map;

import com.logislink.basic.vo.CompDeptVO;
import com.logislink.basic.vo.CompVO;

public interface CompService {
	public CompVO getComp(Map<String, Object> map);
	
	public List<CompDeptVO> getCompDeptList(Map<String, Object> map);
	
	public List<CompVO> getMasterCompList(Map<String, Object> map);
	
	public int getCnt(Map<String, Object> map);
	
	public void updateComp(Map<String, Object> map);
	
	public void insertCompDept(Map<String, Object> map);

	public void updateCompDept(Map<String, Object> map);
	
	public void updateCompApi(Map<String, Object> map); 
}
