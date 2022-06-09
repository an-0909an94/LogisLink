package com.logislink.calc.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.logislink.calc.vo.TranDtlVO;
import com.logislink.calc.vo.TranVO;

import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

@Repository("tranDao")
public class TranDao extends EgovAbstractMapper {
	public void regTranReceipt(Map<String, Object> map) {
		insert("tranDataNS.regTranReceipt", map);
	}
	
	public List<TranVO> selectTranList(Map<String, Object> map) {
		List<TranVO> list = selectList("tranDataNS.selectTranList", map);
		return list;
	}
	
	public int getCnt(Map<String, Object> map) {
		String cnt = selectOne("tranDataNS.selectCnt",map);
		return Integer.valueOf(cnt);
	}
	
	public List<TranDtlVO> selectTranDtlList(Map<String, Object> map) {
		List<TranDtlVO> list = selectList("tranDataNS.selectTranDtlList", map);
		
		return list;
	}
	
	public TranVO selectTranInfo(Map<String, Object> map) {
		TranVO tran = selectOne("tranDataNS.selectTranInfo", map);
		
		return tran;
	}
	
	public void deleteTranReceipt(Map<String, Object> map) {
		update("tranDataNS.deleteTranReceipt", map);
	}

	public void regTranReceiptForDriver(Map<String, Object> map) {
		// TODO Auto-generated method stub
		insert("tranDataNS.regTranReceiptForDriver", map);
	}
}
