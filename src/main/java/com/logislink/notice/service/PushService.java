package com.logislink.notice.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.logislink.notice.vo.PushVO;

public interface PushService {
	
	public List<PushVO> getPushList(Map<String, Object> map);
	
	public int getCnt(Map<String, Object> map);
	
	public int insertPushMsg(Map<String, Object> map);
	
	public void insertPushSendList(Map<String, Object> map);
	
	public List<Map<String, String>> searchPushUserList(Map<String, Object> map);
}
