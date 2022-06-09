package com.logislink.omsComp.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.logislink.basic.vo.UserVO;
import com.logislink.omsComp.dao.CompDao;
import com.logislink.omsComp.service.CompService;

@Service("omsCompService")
public class CompServiceImpl implements CompService {
	@Resource(name="omsCompDao")
	private CompDao compDao;

	@Override
	public List<UserVO> getUserList(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return compDao.selectUserList(map);
	}

	@Override
	public int getCnt(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return compDao.getCnt(map);
	}

}
