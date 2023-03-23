package com.logislink.dashboard.service.Impl;

import com.logislink.dashboard.dao.DashboardDao;
import com.logislink.dashboard.service.DashboardService;
import com.logislink.dashboard.vo.DashboardVO;
import com.logislink.dashboard.vo.MmtopRankVO;
import com.logislink.dashboard.vo.ResultRankVO;
import com.logislink.dashboard.vo.MyResultVO;
import com.logislink.dashboard.vo.ResultVehicleVO;
import com.logislink.dashboard.vo.TodayCustResultVO;
import java.util.List;
import java.util.Map;
import javax.annotation.Resource;
import org.springframework.stereotype.Service;

@Service ("dashboardService")
public class DashboardImpl implements DashboardService {

    @Resource(name = "dashboardDao")
    private DashboardDao dashboardDao;

    @Override
    public List<ResultRankVO> getResultRank(Map<String, Object> map) {
        return dashboardDao.getResultRank(map);
    }

    @Override
    public List<MyResultVO> getMyResult(Map<String, Object> map) {
        return dashboardDao.getMyResult(map);
    }

    @Override
    public List<ResultVehicleVO> getResultVehicle(Map<String, Object> map) {
        return dashboardDao.getResultVehicle(map);
    }

    @Override
    public List<TodayCustResultVO> getTodayCustResult(Map<String, Object> map) {
        return dashboardDao.getTodayCustResult(map);
    }

    @Override
    public List<MmtopRankVO> getMmtopRank(Map<String, Object> map) {
        return dashboardDao.getMmtopRank(map);
    }

    @Override
    public String getHeader(Map<String, Object> map) {
        return dashboardDao.getHeader(map);
    }

    @Override
    public List<DashboardVO> getDashboard(Map<String, Object> map) {
        return dashboardDao.getDashboard(map);
    }
}
