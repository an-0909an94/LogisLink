package com.logislink.calc.service;

import java.util.List;
import java.util.Map;

import com.logislink.calc.vo.CalcVO;
import com.logislink.calc.vo.PayVO;

public interface PayService {

	public List<PayVO> getPayList(Map<String, Object> map);
	
	public List<CalcVO> getPayCalcList(Map<String, Object> map);

	public void payApproUpdate(Map<String, Object> map);

	public void outreqUpdate(Map<String, Object> map);

	public void outUpdate(Map<String, Object> map);

	public void payReturn(Map<String, Object> map);

	public void insertVacs(Map<String, Object> map);

	public Map<String, Object> getVacsSendRlt(Map<String, Object> map);

	public void bankChkDateupdate(Map<String, Object> map);
}
