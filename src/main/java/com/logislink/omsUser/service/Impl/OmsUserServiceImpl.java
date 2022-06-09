package com.logislink.omsUser.service.Impl;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.logislink.basic.vo.UserOptionVO;
import com.logislink.omsUser.dao.OmsUserDao;
import com.logislink.omsUser.service.OmsUserService;

@Service("omsUserService")
public class OmsUserServiceImpl implements OmsUserService {
	@Resource(name="omsUserDao")
	private OmsUserDao omsUserDao;

	@Override
	public UserOptionVO getUserOption(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return omsUserDao.getUserOption(map);
	}

	@Override
	public void insertUserOption(Map<String, Object> map) {
		// TODO Auto-generated method stub
		omsUserDao.insertUserOption(map);
	}
}
