package com.logislink.notice.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.logislink.notice.dao.PushDao;
import com.logislink.notice.service.PushService;
import com.logislink.notice.vo.PushVO;

@Service("pushService")
public class PushServiceImpl implements PushService {
	@Resource(name="pushDao")
	private PushDao pushDao;
	
	@Override
	public List<PushVO> getPushList(Map<String, Object> map) {
		return pushDao.selectPushList(map);
	}
	
	@Override
	public int getCnt(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return pushDao.getCnt(map);
	}
	
	@Override
	public int insertPushMsg(Map<String, Object> map) {
		return pushDao.insertPushMsg(map);
	}
	
	@Override
	public void insertPushSendList(Map<String, Object> map) {
		pushDao.insertPushSendList(map);
	}
	
	@Override
	public List<Map<String, String>> searchPushUserList(Map<String, Object> map) {
		return pushDao.searchPushUserList(map);
	}
}
