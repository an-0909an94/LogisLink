package com.logislink.calc.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.logislink.calc.vo.CalcVO;
import com.logislink.calc.vo.PayVO;

import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

@Repository("payDao")
public class PayDao extends EgovAbstractMapper {
	
	public List<PayVO> getPayList(Map<String, Object> map) {
		List<PayVO> payList = selectList("payDataNS.selectPayList", map);
		return payList;
	}

	public List<CalcVO> getPayCalcList(Map<String, Object> map) {
		List<CalcVO> calcList = selectList("payDataNS.selectPayCalcList", map);
		return calcList;
	}

	public void payApproUpdate(Map<String, Object> map) {
		update("payDataNS.payApproUpdate", map);		
	}

	public void outreqUpdate(Map<String, Object> map) {
		update("payDataNS.outreqUpdate", map);		
	}

	public void outUpdate(Map<String, Object> map) {
		update("payDataNS.outUpdate", map);	
	}

	public void payReturn(Map<String, Object> map) {
		update("payDataNS.payReturn", map);	
		update("payDataNS.calcReturn", map);	
	}

	public void insertVacs(Map<String, Object> map) {
		insert("payDataNS.insertVacs", map);
	}

	public Map<String, Object> getVacsSendRlt(Map<String, Object> map) {
		return selectOne("payDataNS.selectVacsSendRlt", map);
	}

	public void bankChkDateupdate(Map<String, Object> map) {
		update("payDataNS.bankChkDateupdate", map);	
	}
	
	public int updateWithdrawalDueDate(Map<String, Object> map) {
		int result = update("payDataNS.updateWithdrawalDueDate", map);
		return result;
	}
}
