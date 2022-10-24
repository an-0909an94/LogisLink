package com.logislink.calc.service;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.Map;

import com.logislink.calc.vo.TranDtlVO;
import com.logislink.calc.vo.TranVO;

public interface TranService {
	public void regTranReceipt(Map<String, Object> map);
	
	public List<TranVO> selectTranList(Map<String, Object> map);
	
	public int getCnt(Map<String, Object> map);
	
	public List<TranDtlVO> selectTranDtlList(Map<String, Object> map);
	
	public File generateInvoiceFor(Map<String, Object> map) throws IOException;
	
	public File generateInvoice(Map<String, Object> map) throws IOException;
	
	public TranVO selectTranInfo(Map<String, Object> map);
	
	public void deleteTranReceipt(Map<String, Object> map);

	public void regTranReceiptForDriver(Map<String, Object> map);
}