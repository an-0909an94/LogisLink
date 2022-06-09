package com.logislink.basic.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.logislink.basic.vo.CustAddrVO;
import com.logislink.basic.vo.CustVO;

public interface CustService {
	
	public List<CustVO> getCustList(Map<String, Object> map);

	public int getCnt(Map<String, Object> map);
	
	public List<Map<String, Object>> getSearchCust(Map<String, Object> map);
	
	public int getSearchCustCnt(Map<String, Object> map);
	
	public List<CustAddrVO> getCustAddrList(Map<String, Object> map);
	
	public int getAddrCnt(Map<String, Object> map);
	
	public HashMap<String, Object> checkBizNum(Map<String, Object> map);
	
	public List<CustVO> getCustInfo(Map<String, Object> map);
	
	public List<Map<String, Object>> getCustFrtCost(Map<String, Object> map);
	
	public void insertCustDtl(Map<String, Object> map);
	
	public HashMap<String, String> checkDeptId(Map<String, Object> map);
	
	public void insertCustAddr(Map<String, Object> map);
	
	public void insertCustFrtCost(Map<String, Object> map);
	
	public void deleteCustFrtCost(Map<String, Object> map);
	
	public HashMap<String, String> checkAddr(Map<String, Object> map);

	public void deleteCustAddr(Map<String, Object> map);

	public void insertCustAddrBundle(Map<String, Object> map);

	public CustVO getBizInfo(Map<String, Object> map);

	public List<CustVO> searchBizinfoList(Map<String, Object> map);

	public int searchBizinfoCnt(Map<String, Object> map);
}
