package com.logislink.cmm.dao;

import java.util.List;
import java.util.Map;

import com.logislink.basic.vo.AddrVO;
import org.springframework.stereotype.Repository;

import com.logislink.basic.vo.CodeVO;
import com.logislink.cmm.vo.AreaVO;

import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

@Repository("cmmDao")
public class CmmDao extends EgovAbstractMapper{

	public List<CodeVO> selectCmmCode(Map<String, Object> map) {
		return selectList("codeDataNS.selectCmmCode", map);
	}

	public AreaVO selectAreaCode(Map<String, Object> map) throws Exception {
		return (AreaVO)selectOne("cmmDataNS.selectAreaCode", map);
	}
	
	public int selectOpiInfoCnt(Map<String, Object> map) throws Exception {
		String count = (String)selectOne("cmmDataNS.selectOpiInfoCnt", map);
		int cnt = Integer.valueOf(count);
		return cnt;
	}
	
	public void insertOpiInfo(Map<String, Object> map) throws Exception {
		insert("cmmDataNS.insertOpiInfo", map);
	}

	public void insertWeatherInfo(Map<String, String> map) {
		// TODO Auto-generated method stub
		insert("cmmDataNS.insertWeatherInfo", map);
	}

	public List<AreaVO> selectAreaCodeList(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return selectList("cmmDataNS.selectAreaCodeList", map);
	}
	
	// 22.07.15 이건욱 그리드 개인화 설정
	public List<Map<String, Object>> selectPrivateColInfo(Map<String, Object> map) {
		List<Map<String, Object>> list = selectList("cmmDataNS.selectPrivateColInfo", map);
		return list;
	}
	
	public void savePrivateColList(Map<String, Object> map) throws Exception {
		update("cmmDataNS.savePrivateColList", map);
	}
	
	public List<Map<String, Object>> selectPrivateTblInfo(Map<String, Object> map) {
		List<Map<String, Object>> list = selectList("cmmDataNS.selectPrivateTblInfo", map);
		return list;
	}
	
	public List<Map<String, Object>> selectPrivateTblCnt(Map<String, Object> map) {
		List<Map<String, Object>> list = selectList("cmmDataNS.selectPrivateTblCnt", map);
		return list;
	}
	
	public void savePrivateColRemove(Map<String, Object> map) throws Exception {
		delete("cmmDataNS.savePrivateColRemove", map);
	}
	
	public void savePrivateColReset(Map<String, Object> map) throws Exception {
		insert("cmmDataNS.savePrivateColReset", map);
	}
	
	public void savePrivateTblCnt(Map<String, Object> map) throws Exception {
		insert("cmmDataNS.savePrivateTblCnt", map);
	}
	// 22.07.15 이건욱 그리드 개인화 설정 -> End

	public List<AddrVO> getJibunAddr(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return selectList("cmmDataNS.selectJibunList", map);
	}

	public int getAddrCnt(Map<String, Object> map) {
		String cnt = selectOne("cmmDataNS.selectAddrCnt",map);
		return Integer.valueOf(cnt);
	}
}
