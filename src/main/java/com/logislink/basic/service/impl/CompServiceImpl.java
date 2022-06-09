package com.logislink.basic.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.logislink.basic.dao.CompDao;
import com.logislink.basic.service.CompService;
import com.logislink.basic.vo.CompDeptVO;
import com.logislink.basic.vo.CompVO;

@Service("compService")
public class CompServiceImpl implements CompService {
	@Resource(name="compDao")
	private CompDao compDao;

	@Override
	public CompVO getComp(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return compDao.selectCompInfo(map);
	}

	@Override
	public List<CompDeptVO> getCompDeptList(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return compDao.selectCompDeptList(map);
	}
	
	@Override
	public List<CompVO> getMasterCompList(Map<String, Object> map) {
		return compDao.selectMasterCompList(map);
	}

	@Override
	public int getCnt(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return compDao.getCnt(map);
	}
	
	@Override
	public void updateComp(Map<String, Object> map) {
		// TODO Auto-generated method stub
		compDao.update(map);
	}
	
	@Override
	public void insertCompDept(Map<String, Object> map) {
		// TODO Auto-generated method stub
		compDao.insertCompDept(map);
	}

	@Override
	public void updateCompDept(Map<String, Object> map) {
		// TODO Auto-generated method stub
		compDao.updateCompDept(map);
	}

	@Override
	public void updateCompApi(Map<String, Object> map) {
		// TODO Auto-generated method stub
		compDao.updateCompApi(map);
	}
}
