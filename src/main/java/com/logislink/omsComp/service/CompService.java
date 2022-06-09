package com.logislink.omsComp.service;

import java.util.List;
import java.util.Map;

import com.logislink.basic.vo.UserVO;

public interface CompService {
	
	public List<UserVO> getUserList(Map<String, Object> map);

	public int getCnt(Map<String, Object> map);
}
