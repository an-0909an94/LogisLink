package com.logislink.notice.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.logislink.notice.dao.TalkDao;
import com.logislink.notice.service.TalkService;
import com.logislink.notice.vo.TalkTemplateVO;
import com.logislink.notice.vo.TalkVO;

@Service("talkService")
public class TalkServiceImpl implements TalkService {	
	@Resource(name="talkDao")
	private TalkDao talkDao;

	@Override
	public List<TalkTemplateVO> getTalkTemplate(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return talkDao.selectTalkTemplate(map);
	}
	@Override
	public void talkSendUser(Map<String, Object> map) {
		// TODO Auto-generated method stub
		talkDao.talkSendUser(map);
	}

	@Override
	public List<TalkVO> talkList(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return talkDao.talkList(map);
	}

	@Override
	public int getCnt(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return talkDao.getCnt(map);
	}

}
