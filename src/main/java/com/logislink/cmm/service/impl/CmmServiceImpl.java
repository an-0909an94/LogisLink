package com.logislink.cmm.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import com.logislink.basic.vo.AddrVO;
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
	
	// 22.07.15 이건욱 그리드 개인화 설정
	@Override
	public List<Map<String, Object>> getPrivateColInfo(Map<String, Object> map) {
		return cmmDao.selectPrivateColInfo(map);
	}
	
	@Override
	public void savePrivateColList(Map<String, Object> map) throws Exception {
		cmmDao.savePrivateColList(map);
	}
	
	@Override
	public List<Map<String, Object>> getPrivateTblInfo(Map<String, Object> map) {
		return cmmDao.selectPrivateTblInfo(map);
	}
	
	@Override
	public List<Map<String, Object>> getPrivateTblCnt(Map<String, Object> map) {
		return cmmDao.selectPrivateTblCnt(map);
	}
	
	@Override
	public void savePrivateColReset(Map<String, Object> map) throws Exception {
		cmmDao.savePrivateColRemove(map);
		cmmDao.savePrivateColReset(map);
	}
	
	@Override
	public void savePrivateTblCnt(Map<String, Object> map) throws Exception {
		cmmDao.savePrivateTblCnt(map);
	}
	// 22.07.15 이건욱 그리드 개인화 설정 -> End

	@Override
	public List<AddrVO> getJibunAddr(Map<String, Object> map) throws Exception {
		return cmmDao.getJibunAddr(map);
	}

	@Override
	public int getAddrCnt(Map<String, Object> map) {
		return cmmDao.getAddrCnt(map);
	}
	
	@Override
	public String insertVacsSendAccountCheck(Map<String, Object> map) {
		return cmmDao.insertVacsSendAccountCheck(map);
	}
	
	@Override
	public Map<String, Object> selectVacsSendAccountCheck(Map<String, Object> map) {
		return cmmDao.selectVacsSendAccountCheck(map);
	}
	
	@Override
	public int updateDriverAccountCheck(Map<String, Object> map) {
		return cmmDao.updateDriverAccountCheck(map);
	}
}
