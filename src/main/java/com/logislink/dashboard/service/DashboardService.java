package com.logislink.dashboard.service;

import com.logislink.dashboard.vo.MmtopRankVO;
import com.logislink.dashboard.vo.ResultRankVO;
import com.logislink.dashboard.vo.MyResultVO;
import com.logislink.dashboard.vo.ResultVehicleVO;
import com.logislink.dashboard.vo.TodayCustResultVO;
import java.util.List;
import java.util.Map;

public interface DashboardService {

    //최근 실적
    public ResultRankVO getResultRank(Map<String, Object>map);

    //나의 실적
    public List<MyResultVO> getMyResult(Map<String, Object>map);

    // 배차 손익 추이
    public List<ResultVehicleVO> getResultVehicle(Map<String, Object> map);

    // Today's High Lights
    public List<TodayCustResultVO> getTodayCustResult(Map<String, Object>map);

    // 전월 TOP 거래처 현황
    public List<MmtopRankVO> getMmtopRank(Map<String, Object>map);

    // Header 개인 내역
    public String getHeader(Map<String, Object>map);
}
