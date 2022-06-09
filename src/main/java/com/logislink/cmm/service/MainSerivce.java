package com.logislink.cmm.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.logislink.basic.vo.CodeVO;
import com.logislink.basic.vo.CompDeptVO;

public interface MainSerivce {

	public HashMap<String, Object> checkBizNum(Map<String, Object> map);

	public HashMap<String, Object> checkUserId(Map<String, Object> map);
	
	public void signUp(Map<String, Object> map);

	public List<CodeVO> getCmmCode(Map<String, Object> map);

	public List<CompDeptVO> getCompDeptList(Map<String, Object> map);

	public void getUserData(Map<String, Object> map);
}
