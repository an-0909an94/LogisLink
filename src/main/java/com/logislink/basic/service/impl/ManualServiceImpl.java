package com.logislink.basic.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.logislink.basic.dao.ManualDao;
import com.logislink.basic.service.ManualService;
import com.logislink.basic.vo.ManualVO;

@Service("manualService")
public class ManualServiceImpl implements ManualService {
	@Resource(name="manualDao")
	private ManualDao manualDao;

	@Override
	public List<ManualVO> getManualGroupList(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return manualDao.getManualGroupList(map);
	}

	@Override
	public List<ManualVO> getManualList(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return manualDao.getManualList(map);
	}

	@Override
	public void insertManualGroup(Map<String, Object> map) {
		// TODO Auto-generated method stub
		manualDao.insertManualGroup(map);
	}

	@Override
	public void insertManual(Map<String, Object> map) {
		// TODO Auto-generated method stub
		manualDao.insertManual(map);
	}

	@Override
	public void insertManualFile(Map<String, Object> map) {
		// TODO Auto-generated method stub
		manualDao.insertManualFile(map);
	}

}
