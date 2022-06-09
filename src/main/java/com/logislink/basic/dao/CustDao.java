package com.logislink.basic.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.logislink.basic.vo.CustAddrVO;
import com.logislink.basic.vo.CustVO;

import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

@Repository("custDao")
public class CustDao extends EgovAbstractMapper{
	
	public List<CustVO> selectCustList(Map<String, Object> map) {
		List<CustVO> custList = selectList("custDataNS.selectCustList", map);
		
		return custList;
	} 
	 
	public int getCnt(Map<String, Object> map) {
		String cnt = selectOne("custDataNS.selectCnt",map);
		return Integer.valueOf(cnt);
	}
	
	public List<Map<String, Object>> getSearchCust(Map<String, Object> map) {
		List<Map<String, Object>> list = selectList("custDataNS.selectSearchCust",map);
		
		return list;
	}
	
	public int getSearchCustCnt(Map<String, Object> map) {
		String cnt = selectOne("custDataNS.selectSearchCustCnt",map);
		return Integer.valueOf(cnt);
	}
	
	public List<CustAddrVO> selectCustAddrList(Map<String, Object> map) {
		List<CustAddrVO> custAddrList = selectList("custDataNS.selectCustAddrList", map);
		
		return custAddrList;
	}
	 
	public int getAddrCnt(Map<String, Object> map) {
		String cnt = selectOne("custDataNS.selectAddrCnt",map);
		return Integer.valueOf(cnt);
	}
	
	public HashMap<String, Object> checkBizNum(Map<String, Object> map) {
		HashMap<String, Object> ret = selectOne("custDataNS.checkBizNum", map);
		
		return ret;
	}
	
	public List<CustVO> getCustInfo(Map<String, Object> map) {
		List<CustVO> cust = selectList("custDataNS.getCustInfo", map);
		
		return cust;
	}
	
	public List<Map<String, Object>> getCustFrtCost(Map<String, Object> map) {
		List<Map<String, Object>> list = selectList("custDataNS.selectCustFrtCost", map);
		
		return list;
	}
	
	public void insertCustDtl(Map<String, Object> map) {
		update("custDataNS.insertCustDtl", map);
	}
	
	public HashMap<String, String> checkDeptId(Map<String, Object> map) {
		HashMap<String, String> chk = selectOne("custDataNS.checkDeptId", map);
		
		return chk;
	}
	
	public void insertCustAddr(Map<String, Object> map) {
		update("custDataNS.insertCustAddr", map);
	}
	
	public void insertCustFrtCost(Map<String, Object> map) {
		insert("custDataNS.insertCustFrtCost", map);
	} 
	
	public void deleteCustFrtCost(Map<String, Object> map) {
		delete("custDataNS.deleteCustFrtCost", map);
	}
	public HashMap<String, String> checkAddr(Map<String, Object> map) {
		HashMap<String, String> chk = selectOne("custDataNS.checkAddr", map);
		
		return chk;
	}

	public void deleteCustAddr(Map<String, Object> map) {
		// TODO Auto-generated method stub
		delete("custDataNS.deleteCustAddr", map);
	}

	public void insertCustAddrBundle(Map<String, Object> map) {
		// TODO Auto-generated method stub
		insert("custDataNS.insertCustAddrBundle", map);
	}

	public CustVO getBizInfo(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return selectOne("custDataNS.selectBizInfo", map);
	}

	public List<CustVO> searchBizinfoList(Map<String, Object> map) {
		// TODO Auto-generated method stub
		List<CustVO> searchBizinfoList = selectList("custDataNS.searchBizinfoList", map);
		
		return searchBizinfoList;
	}

	public int searchBizinfoCnt(Map<String, Object> map) {
		// TODO Auto-generated method stub
		String cnt = selectOne("custDataNS.searchBizinfoCnt",map);
		return Integer.valueOf(cnt);
	}
}
