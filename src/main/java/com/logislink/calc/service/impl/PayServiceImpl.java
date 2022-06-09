package com.logislink.calc.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.logislink.calc.dao.PayDao;
import com.logislink.calc.service.PayService;
import com.logislink.calc.vo.CalcVO;
import com.logislink.calc.vo.PayVO;

@Service("payService")
public class PayServiceImpl implements PayService {

	@Resource(name="payDao")
	private PayDao payDao;
	
	@Override
	public List<PayVO> getPayList(Map<String, Object> map) {
		return payDao.getPayList(map);
	}

	@Override
	public List<CalcVO> getPayCalcList(Map<String, Object> map) {
		return payDao.getPayCalcList(map);
	}

	@Override
	public void payApproUpdate(Map<String, Object> map) {
		payDao.payApproUpdate(map);
	}

	@Override
	public void outreqUpdate(Map<String, Object> map) {
		payDao.outreqUpdate(map);
	}

	@Override
	public void outUpdate(Map<String, Object> map) {
		payDao.outUpdate(map);
	}

	@Override
	public void payReturn(Map<String, Object> map) {
		payDao.payReturn(map);
	}

	@Override
	public void insertVacs(Map<String, Object> map) {
		payDao.insertVacs(map);
	}

	@Override
	public Map<String, Object> getVacsSendRlt(Map<String, Object> map) {
		return payDao.getVacsSendRlt(map);
	}

	@Override
	public void bankChkDateupdate(Map<String, Object> map) {
		payDao.bankChkDateupdate(map);
	}

}
