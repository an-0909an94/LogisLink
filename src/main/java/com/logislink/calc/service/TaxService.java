package com.logislink.calc.service;

import java.util.List;
import java.util.Map;

import com.logislink.calc.vo.TaxVO;

public interface TaxService {
	
	public List<TaxVO> getTaxInvoice(Map<String, Object> map);
	
	public int getTaxInvoiceCnt(Map<String, Object> map);
	
	public TaxVO getTaxBizInfo(Map<String, Object> map);
	
	public void insertTaxInvoice(Map<String, Object> map);
	
	public void insertTaxInvoiceDetail(Map<String, Object> map);
	
	public void insertTaxInvoiceMonitor(Map<String, Object> map);

	public void updateLoadStatus(Map<String, Object> map);

	public Map<String, Object> getTaxSendXml(Map<String, Object> map);

	public void taxStatus(Map<String, Object> map);

	public void taxResend(Map<String, Object> map);

	public List<Map<String, Object>> viewTaxItem(Map<String, Object> map);

	public void insertCalcTaxInvoice(Map<String, Object> map);
	
	public void insertReceiptTaxInvoice(Map<String, Object> map);
	
	public void insertTaxModify(Map<String, Object> map);

	public void updateTaxInvoiceDetail(Map<String, Object> map);

	public void deleteTaxInvoiceDetail(Map<String, Object> map);

	public void insertReceiptTaxInvoiceForDriver(Map<String, Object> map);
}
