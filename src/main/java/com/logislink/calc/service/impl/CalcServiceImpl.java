package com.logislink.calc.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.logislink.calc.dao.CalcDao;
import com.logislink.calc.service.CalcService;
import com.logislink.calc.vo.CalcVO;
import com.logislink.calc.vo.OrderCalcVO;
import com.logislink.cmm.vo.FileVO;

@Service("calcService")
public class CalcServiceImpl implements CalcService {
	@Resource(name="calcDao")
	private CalcDao calcDao;

	@Override
	public List<CalcVO> getCalcList(Map<String, Object> map) {
		return calcDao.getCalcList(map);
	}
	
	@Override
	public int getCnt(Map<String, Object> map) {
		return calcDao.getCnt(map);
	}
	
	@Override
	public Map<String, Object> getSummary(Map<String, Object> map) {
		return calcDao.getSummary(map);
	}

	@Override
	public List<OrderCalcVO> getPurchaseDeadline(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return calcDao.selectPurchaseDeadline(map);
	} 

	@Override
	public Map<String, Object> getPurchaseDeadlineSummary(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return calcDao.selectPurchaseDeadlineSummary(map);
	}


	@Override
	public List<OrderCalcVO> getSellPurchaseDeadline(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return calcDao.selectSellPurchaseDeadline(map);
	} 
	
	@Override
	public void updateAllocCharge(Map<String, Object> map) {
		calcDao.updateAllocCharge(map);
	}
	
	@Override
	public void custFinishCalc(Map<String, Object> map) {
		calcDao.custFinishCalc(map);
	}
	
	@Override
	public void multiFinishCalc(Map<String, Object> map) {
		calcDao.multiFinishCalc(map);
	}
	
	@Override
	public void newCalcCharge(Map<String, Object> map) {
		calcDao.newCalcCharge(map);
	}

	@Override
	public void multiDeleteCalc(Map<String, Object> map) {
		calcDao.multiDeleteCalc(map);
	}

	@Override
	public void updateChangeReq(Map<String, Object> map) {
		calcDao.updateChangeReq(map);
	}

	@Override
	public List<Map<String, Object>> getCustByBiz(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return calcDao.selectCustByBiz(map);
	}

	@Override
	public List<Map<String, Object>> getDeptByCust(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return calcDao.selectDeptByCust(map);
	}

	@Override
	public void multiDeleteAllocAdd(Map<String, Object> map) {
		// TODO Auto-generated method stub
		calcDao.multiDeleteAllocAdd(map);
	}

	@Override
	public HashMap<String, String> calcCheck(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return calcDao.calcCheck(map);
	}

	@Override
	public void multPaperReceipt(Map<String, Object> map) {
		calcDao.multPaperReceipt(map);
	}

	@Override
	public void multPaperTax(Map<String, Object> map) {
		// TODO Auto-generated method stub
		calcDao.multPaperTax(map);
	}

	@Override
	public void detailCalcUpdate(Map<String, Object> map) {
		// TODO Auto-generated method stub
		calcDao.detailCalcUpdate(map);
	}

	@Override
	public Map<String, Object> viewTax(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return calcDao.viewTax(map);
	}

	@Override
	public List<FileVO> viewReceipt(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return calcDao.viewReceipt(map);
	}

	@Override
	public HashMap<String, Object> allocIdChk(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return calcDao.allocIdChk(map);
	}

	@Override
	public List<Map<String, Object>> viewTaxDetail(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return calcDao.viewTaxDetail(map);
	}

	@Override
	public Map<String, Object> getDriverCommission(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return calcDao.getDriverCommission(map);
	}

	@Override
	public List<Map<String, Object>> getOrderAllocAdd(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return calcDao.selectOrderAllocAdd(map);
	}

	@Override
	public List<CalcVO> serchCustDeptInfo(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return calcDao.serchCustDeptInfo(map);
	}

}
