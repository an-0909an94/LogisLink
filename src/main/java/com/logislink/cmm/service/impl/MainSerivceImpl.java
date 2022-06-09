package com.logislink.cmm.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.logislink.basic.vo.CodeVO;
import com.logislink.basic.vo.CompDeptVO;
import com.logislink.cmm.dao.MainDao;
import com.logislink.cmm.service.MainSerivce;

@Service("mainService")
public class MainSerivceImpl implements MainSerivce {

	@Resource(name="mainDao")
	private MainDao mainDao;

	@Override
	public HashMap<String, Object> checkBizNum(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return mainDao.checkBizNum(map);
	}

	@Override
	public HashMap<String, Object> checkUserId(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return mainDao.checkUserId(map);
	}

	@Override
	public void signUp(Map<String, Object> map) {
		mainDao.signUp(map);
	}

	@Override
	public List<CodeVO> getCmmCode(Map<String, Object> map) {
		return mainDao.getCmmCode(map);
	}

	@Override
	public List<CompDeptVO> getCompDeptList(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return mainDao.getCompDeptList(map);
	}

	@Override
	public void getUserData(Map<String, Object> map) {
		// TODO Auto-generated method stub
		mainDao.getUserData(map);
	}
}
