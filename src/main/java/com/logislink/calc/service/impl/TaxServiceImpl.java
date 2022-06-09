package com.logislink.calc.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.logislink.calc.dao.TaxDao;
import com.logislink.calc.service.TaxService;
import com.logislink.calc.vo.TaxVO;

@Service("taxService")
public class TaxServiceImpl implements TaxService {
	@Resource(name="taxDao")
	private TaxDao taxDao;

	@Override
	public List<TaxVO> getTaxInvoice(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return taxDao.selectTaxInvoice(map);
	}

	@Override
	public int getTaxInvoiceCnt(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return taxDao.selectTaxInvoiceCnt(map);
	}
	
	@Override
	public TaxVO getTaxBizInfo(Map<String, Object> map) {
		return taxDao.getTaxBizInfo(map);
	}
	
	@Override
	public void insertTaxInvoice(Map<String, Object> map) {
		taxDao.insertTaxInvoice(map);
	}
	
	@Override
	public void insertTaxInvoiceDetail(Map<String, Object> map) {
		taxDao.insertTaxInvoiceDetail(map);
	}
	
	@Override
	public void insertTaxInvoiceMonitor(Map<String, Object> map) {
		taxDao.insertTaxInvoiceMonitor(map);
	}

	@Override
	public void updateLoadStatus(Map<String, Object> map) {
		// TODO Auto-generated method stub
		taxDao.updateLoadStatus(map);
	}

	@Override
	public Map<String, Object> getTaxSendXml(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return taxDao.selectTaxSendXml(map);
	}

	@Override
	public void taxStatus(Map<String, Object> map) {
		// TODO Auto-generated method stub
		taxDao.taxStatus(map);
	}

	@Override
	public void taxResend(Map<String, Object> map) {
		// TODO Auto-generated method stub
		taxDao.texResend(map);
	}

	@Override
	public List<Map<String, Object>> viewTaxItem(Map<String, Object> map) {
		return taxDao.viewTaxItem(map);
	}

	@Override
	public void insertCalcTaxInvoice(Map<String, Object> map) {
		// TODO Auto-generated method stub
		taxDao.insertCalcTaxInvoice(map);
	}

	@Override
	public void insertReceiptTaxInvoice(Map<String, Object> map) {
		// TODO Auto-generated method stub
		taxDao.insertReceiptTaxInvoice(map);
	}

	@Override
	public void insertTaxModify(Map<String, Object> map) {
		// TODO Auto-generated method stub
		taxDao.insertTaxModify(map);
	}

	@Override
	public void updateTaxInvoiceDetail(Map<String, Object> map) {
		// TODO Auto-generated method stub
		taxDao.updateTaxInvoiceDetail(map);
	}

	@Override
	public void deleteTaxInvoiceDetail(Map<String, Object> map) {
		// TODO Auto-generated method stub
		taxDao.deleteTaxInvoiceDetail(map);
	}

	@Override
	public void insertReceiptTaxInvoiceForDriver(Map<String, Object> map) {
		// TODO Auto-generated method stub
		taxDao.insertReceiptTaxInvoiceForDriver(map);
	}
}