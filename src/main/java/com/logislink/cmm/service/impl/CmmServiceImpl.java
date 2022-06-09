package com.logislink.cmm.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.logislink.cmm.dao.CmmDao;
import com.logislink.cmm.service.CmmService;
import com.logislink.cmm.vo.AreaVO;
import com.logislink.basic.vo.CodeVO;

@Service("cmmService")
public class CmmServiceImpl implements CmmService {

	@Resource(name="cmmDao")
	private CmmDao cmmDao;
	
	@Override
	public List<CodeVO> getCmmCode(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return cmmDao.selectCmmCode(map);
	}

	@Override
	public AreaVO getAreaCode(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		return cmmDao.selectAreaCode(map);
	}

	@Override
	public int getOpiInfoCnt(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		return cmmDao.selectOpiInfoCnt(map);
	}

	@Override
	public void insertOpiInfo(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		cmmDao.insertOpiInfo(map);
	}

	@Override
	public void insertWeatherInfo(Map<String, String> map) {
		// TODO Auto-generated method stub
		cmmDao.insertWeatherInfo(map);
	}

	@Override
	public List<AreaVO> getAreaCodeList(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return cmmDao.selectAreaCodeList(map);
	}

}
