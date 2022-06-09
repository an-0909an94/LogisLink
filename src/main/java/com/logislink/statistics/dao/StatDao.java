package com.logislink.statistics.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.logislink.statistics.vo.StatVO;

import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

@Repository("statDao")
public class StatDao extends EgovAbstractMapper {
	
	public List<StatVO> getStatDispatch(Map<String, Object> map){
		return selectList("statDataNS.getStatDispatch", map);
	}
	
	public List<StatVO> getStatDispatchGrid(Map<String, Object> map) {
		return selectList("statDataNS.getStatDispatchGrid", map);
	}
	
	public int getStatDispatchGridCount(Map<String, Object> map) {
		String cnt = selectOne("statDataNS.getStatDispatchGridCount",map);
		return Integer.valueOf(cnt);
	}
	
	public List<StatVO> getStatAllocation(Map<String, Object> map) {
		return selectList("statDataNS.getStatAllocation", map);
	}
	
	public List<StatVO> getStatAllocationGrid(Map<String, Object> map) {
		return selectList("statDataNS.getStatAllocationGrid", map);
	}
	
	public int getStatAllocationGridCount(Map<String, Object> map) {
		String cnt = selectOne("statDataNS.getStatAllocationGridCount", map);
		return Integer.valueOf(cnt);
	}
	
	public List<StatVO> getStatUrgent(Map<String, Object> map) {
		return selectList("statDataNS.getStatUrgent", map);
	}
	
	public List<StatVO> getStatUrgentGrid(Map<String, Object> map) {
		return selectList("statDataNS.getStatUrgentGrid", map);
	}
	
	public int getStatUrgentGridCount(Map<String, Object> map) {
		String cnt = selectOne("statDataNS.getStatUrgentGridCount", map);
		return Integer.valueOf(cnt);
	}
	
	public List<StatVO> getStatEnter(Map<String, Object> map) {
		return selectList("statDataNS.getStatEnter", map);
	}
	
	public List<StatVO> getStatEnterGrid(Map<String, Object> map) {
		return selectList("statDataNS.getStatEnterGrid", map);
	}
	
	public int getStatEnterGridCount(Map<String, Object> map) {
		String cnt = selectOne("statDataNS.getStatEnterGridCount", map);
		return Integer.valueOf(cnt);
	}
	
	public List<StatVO> getStatArrival(Map<String, Object> map) {
		return selectList("statDataNS.getStatArrival", map);
	}
	
	public List<StatVO> getStatArrivalGrid(Map<String, Object> map) {
		return selectList("statDataNS.getStatArrivalGrid", map);
	}
	
	public int getStatArrivalGridCount(Map<String, Object> map) {
		String cnt = selectOne("statDataNS.getStatArrivalGridCount", map);
		return Integer.valueOf(cnt);
	}
	
	public List<StatVO> getStatLoad(Map<String, Object> map) {
		return selectList("statDataNS.getStatLoad", map);
	}
	
	public List<StatVO> getStatLoadGrid(Map<String, Object> map) {
		return selectList("statDataNS.getStatLoadGrid", map);
	}
	
	public int getStatLoadGridCount(Map<String, Object> map) {
		String cnt = selectOne("statDataNS.getStatLoadGridCount", map);
		return Integer.valueOf(cnt);
	}
	
	public List<StatVO> getStatCharge(Map<String, Object> map) {
		return selectList("statDataNS.getStatCharge", map);
	}
	
	public List<StatVO> getStatChargeGrid(Map<String, Object> map) {
		return selectList("statDataNS.getStatChargeGrid", map);
	}
	
	public int getStatChargeGridCount(Map<String, Object> map) {
		String cnt = selectOne("statDataNS.getStatChargeGridCount", map);
		return Integer.valueOf(cnt);
	}
	
	public List<StatVO> getStatTonCharge(Map<String, Object> map) {
		return selectList("statDataNS.getStatTonCharge", map);
	}
	
	public List<StatVO> getStatTonChargeGrid(Map<String, Object> map) {
		return selectList("statDataNS.getStatTonChargeGrid", map);
	}
	
	public int getStatTonChargeGridCount(Map<String, Object> map) {
		String cnt = selectOne("statDataNS.getStatTonChargeGridCount", map);
		return Integer.valueOf(cnt);
	}
}
