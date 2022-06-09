package com.logislink.calc.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.logislink.calc.vo.TaxVO;

import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

@Repository("taxDao")
public class TaxDao extends EgovAbstractMapper{
	
	public List<TaxVO> selectTaxInvoice(Map<String, Object> map) {
		return selectList("taxDataNS.selectTaxInvoice", map);
	}
	
	public int selectTaxInvoiceCnt(Map<String, Object> map) {
		String cnt = selectOne("taxDataNS.selectTaxInvoiceCnt",map);
		return Integer.valueOf(cnt);
	}
	
	public TaxVO getTaxBizInfo(Map<String, Object> map) {
		TaxVO tax = selectOne("taxDataNS.getTaxBizInfo", map);
		
		return tax;
	}
	
	public void insertTaxInvoice(Map<String, Object> map) {
		insert("taxDataNS.insertTaxInvoice", map);
	}
	
	public void insertTaxInvoiceDetail(Map<String, Object> map) {
		insert("taxDataNS.insertTaxInvoiceDetail", map);
		update("taxDataNS.updateCalcTaxinvYn", map);
	}
	
	public void insertTaxInvoiceMonitor(Map<String, Object> map) {
		insert("taxDataNS.insertTaxInvoiceMonitor", map);
	}

	public void updateLoadStatus(Map<String, Object> map) {
		// TODO Auto-generated method stub
		update("taxDataNS.updateLoadStatus", map);
	}
	
	public Map<String, Object> selectTaxSendXml(Map<String, Object> map) {
		return selectOne("taxDataNS.selectTaxSendXml", map);
	}

	public void taxStatus(Map<String, Object> map) {
		// TODO Auto-generated method stub
		update("taxDataNS.taxInvoiceStatus", map);
		update("taxDataNS.taxMonitorStatus", map);
	}

	public void texResend(Map<String, Object> map) {
		// TODO Auto-generated method stub
		update("taxDataNS.taxInvoiceResend", map);
		update("taxDataNS.taxMonitorResend", map);
	}

	public List<Map<String, Object>> viewTaxItem(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return selectList("taxDataNS.viewTaxItem",map);
	}

	public void insertCalcTaxInvoice(Map<String, Object> map) {
		// TODO Auto-generated method stub
		insert("taxDataNS.insertCalcTaxInvoice", map);
	}
	
	public void insertReceiptTaxInvoice(Map<String, Object> map) {
		// TODO Auto-generated method stub
		insert("taxDataNS.insertReceiptTaxInvoice", map);
	}
	
	public void insertTaxModify(Map<String, Object> map) {
		insert("taxDataNS.insertTaxModify", map);
	}

	public void updateTaxInvoiceDetail(Map<String, Object> map) {
		// TODO Auto-generated method stub
		update("taxDataNS.updateTaxInvoiceDetail", map);
	}

	public void deleteTaxInvoiceDetail(Map<String, Object> map) {
		// TODO Auto-generated method stub
		update("taxDataNS.deleteTaxInvoiceDetail", map);
	}

	public void insertReceiptTaxInvoiceForDriver(Map<String, Object> map) {
		// TODO Auto-generated method stub
		insert("taxDataNS.insertReceiptTaxInvoiceForDriver", map);
	}
}
