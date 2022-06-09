package com.logislink.notice.service;

import java.util.List;
import java.util.Map;

import com.logislink.notice.vo.TalkTemplateVO;
import com.logislink.notice.vo.TalkVO;

public interface TalkService {
	
	public List<TalkTemplateVO> getTalkTemplate(Map<String, Object> map);
	
	public void talkSendUser(Map<String, Object> map);

	public List<TalkVO> talkList(Map<String, Object> map); 

	public int getCnt(Map<String, Object> map);
}
