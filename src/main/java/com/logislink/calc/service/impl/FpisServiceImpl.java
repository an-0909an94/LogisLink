package com.logislink.calc.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.logislink.calc.dao.FpisDao;
import com.logislink.calc.service.FpisService;
import com.logislink.calc.vo.FpisVO;

@Service("fpisService")
public class FpisServiceImpl implements FpisService {

	@Resource(name="fpisDao")
	private FpisDao fpisDao;
	
	@Override
	public List<FpisVO> getFpisList(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return fpisDao.selectFpisList(map);
	}

	@Override
	public int getFpisCnt(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return fpisDao.selectFpisCnt(map);
	}

}
