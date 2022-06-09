package com.logislink.notice.dao;


import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.logislink.notice.vo.TalkTemplateVO;
import com.logislink.notice.vo.TalkVO;

import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

@Repository("talkDao")
public class TalkDao extends EgovAbstractMapper{

	public List<TalkTemplateVO> selectTalkTemplate(Map<String, Object> map) {
		return selectList("talkDataNS.selecctTalkTemplate", map);
	}
		
	public void talkSendUser(Map<String, Object> map) {
		// TODO Auto-generated method stub
		insert("talkDataNS.talkSendUser",map);
	}

	public List<TalkVO> talkList(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return selectList("talkDataNS.selectTalkList", map);
	}

	public int getCnt(Map<String, Object> map) {
		String cnt = selectOne("talkDataNS.selectTalkCnt",map);
		return Integer.valueOf(cnt);
	}
	
}
