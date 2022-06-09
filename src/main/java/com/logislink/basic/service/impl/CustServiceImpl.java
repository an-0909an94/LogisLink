package com.logislink.basic.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.logislink.basic.dao.CustDao;
import com.logislink.basic.service.CustService;
import com.logislink.basic.vo.CustAddrVO;
import com.logislink.basic.vo.CustVO;

@Service("custService")
public class CustServiceImpl implements CustService {
	@Resource(name="custDao")
	private CustDao custDao;
	
	@Override
	public List<CustVO> getCustList(Map<String, Object> map) {
		return custDao.selectCustList(map);
	}

	@Override
	public int getCnt(Map<String, Object> map) {
		return custDao.getCnt(map);
	}

	@Override
	public List<Map<String, Object>> getSearchCust(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return custDao.getSearchCust(map);
	}

	@Override
	public int getSearchCustCnt(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return custDao.getSearchCustCnt(map);
	}

	
	@Override
	public List<CustAddrVO> getCustAddrList(Map<String, Object> map) {
		return custDao.selectCustAddrList(map);
	}

	@Override
	public int getAddrCnt(Map<String, Object> map) {
		return custDao.getAddrCnt(map);
	}
	
	@Override
	public HashMap<String, Object> checkBizNum(Map<String, Object> map) {
		return custDao.checkBizNum(map);
	}
	
	@Override
	public List<CustVO> getCustInfo(Map<String, Object> map) {
		return custDao.getCustInfo(map);
	}

	@Override
	public List<Map<String, Object>> getCustFrtCost(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return custDao.getCustFrtCost(map);
	}
	
	@Override
	public void insertCustDtl(Map<String, Object> map) {
		custDao.insertCustDtl(map);
	}
	
	@Override
	public HashMap<String, String> checkDeptId(Map<String, Object> map) {
		return custDao.checkDeptId(map);
	}
	
	@Override
	public void insertCustAddr(Map<String, Object> map) {
		custDao.insertCustAddr(map);
	}

	@Override
	public void insertCustFrtCost(Map<String, Object> map) {
		// TODO Auto-generated method stub
		custDao.insertCustFrtCost(map);
	}

	@Override
	public void deleteCustFrtCost(Map<String, Object> map) {
		// TODO Auto-generated method stub
		custDao.deleteCustFrtCost(map);
	}

	@Override
	public HashMap<String, String> checkAddr(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return custDao.checkAddr(map);
	}

	@Override
	public void deleteCustAddr(Map<String, Object> map) {
		// TODO Auto-generated method stub
		custDao.deleteCustAddr(map);
	}

	@Override
	public void insertCustAddrBundle(Map<String, Object> map) {
		// TODO Auto-generated method stub
		custDao.insertCustAddrBundle(map);
	}

	@Override
	public CustVO getBizInfo(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return custDao.getBizInfo(map);
	}

	@Override
	public List<CustVO> searchBizinfoList(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return custDao.searchBizinfoList(map);
	}

	@Override
	public int searchBizinfoCnt(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return custDao.searchBizinfoCnt(map);
	}

}
