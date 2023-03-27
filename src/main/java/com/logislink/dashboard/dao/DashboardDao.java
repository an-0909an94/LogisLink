package com.logislink.dashboard.dao;

import com.logislink.dashboard.vo.MmtopRankVO;
import com.logislink.dashboard.vo.ResultRankVO;
import com.logislink.dashboard.vo.MyResultVO;
import com.logislink.dashboard.vo.ResultVehicleVO;
import com.logislink.dashboard.vo.TodayCustResultVO;
import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

import java.util.ArrayList;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository("dashboardDao")
public class DashboardDao extends EgovAbstractMapper {

    // 최근 실적 랭킹
    public List<ResultRankVO> getResultRank(Map<String, Object> map){
        List<ResultRankVO> rank = selectList("dashboardDataNS.selectResultRank",map);
        return rank;
    }

    // 나의 실적
    public List<MyResultVO> getMyResult(Map<String, Object> map){
        List<MyResultVO> myResult = selectList("dashboardDataNS.selectMyResult",map);
        return myResult;
    }

    // 배차 손익 추이
    public List<ResultVehicleVO> getResultVehicle(Map<String, Object>map){
        List<ResultVehicleVO> ResultVehic = selectList("dashboardDataNS.selectResultVehicle",map);
        return ResultVehic;
    }

    // Today's High Lights
    public List<TodayCustResultVO> getTodayCustResult(Map<String, Object>map){
        List<TodayCustResultVO> todayCustResult = selectList("dashboardDataNS.selectTodayCustResult",map);
        return todayCustResult;
    }

    // 전월 TOP 거래처 현황
    public List<MmtopRankVO> getMmtopRank(Map<String, Object>map){
        List<MmtopRankVO> mmtopRank = selectList("dashboardDataNS.selectMmtopRank",map);
        return mmtopRank;
    }

    // Header 개인 내역
    public String getHeader(Map<String, Object>map){
        String headerPrivate = selectOne("");
        return headerPrivate;
    }
}
