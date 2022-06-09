package com.logislink.basic.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.logislink.basic.dao.CodeDao;
import com.logislink.basic.service.CodeService;
import com.logislink.basic.vo.CodeVO;

@Service("codeService")
public class CodeServiceImpl implements CodeService {
	@Resource(name="codeDao")
	private CodeDao codeDao;

		@Override
	public List<CodeVO> getCodeGroupList(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return codeDao.getCodeGroupList(map);
	}

	@Override
	public List<CodeVO> getCodeList(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return codeDao.getCodeList(map);
	}
	
	@Override
	public void insertCodeGroup(Map<String, Object> map) {
		codeDao.insertCodeGroup(map);
	}
	
	@Override
	public void insertCode(Map<String, Object> map) {
		codeDao.insertCode(map);
	}
}
