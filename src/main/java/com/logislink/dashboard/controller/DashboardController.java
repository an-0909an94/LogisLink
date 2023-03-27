package com.logislink.dashboard.controller;

import com.logislink.dashboard.service.DashboardService;
import com.logislink.dashboard.vo.MmtopRankVO;
import com.logislink.dashboard.vo.ResultRankVO;
import com.logislink.dashboard.vo.MyResultVO;
import com.logislink.dashboard.vo.ResultVehicleVO;
import com.logislink.dashboard.vo.TodayCustResultVO;
import com.logislink.login.vo.LoginVO;
import java.util.List;
import java.util.Map;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class DashboardController {

    @Resource(name="dashboardService")
    private DashboardService dashboardService;

    //최근실적 - Ranking
    @PostMapping(value = "/dashboard/resultrank.do")
    public String boardResultRank(HttpServletRequest request, Model model, ModelMap map, HttpSession session, @RequestParam Map<String, Object> param) throws Exception {

        LoginVO login = (LoginVO) session.getAttribute("userInfo");
        String custId = login.getCustId();

        param.put("custId", custId);
        //param.put("searchDate",param.get("yesterday"));
        //param.put("searchDate","2023-01-01");

        List<ResultRankVO> resultRank = dashboardService.getResultRank(param);

        map.put("result", Boolean.TRUE);
        map.put("data", resultRank);

        return "jsonView";
    }

    //나의 실적 - Performance
    @PostMapping(value = "/dashboard/myresult.do")
    public String boardMyResult(HttpServletRequest request, Model model, ModelMap map, HttpSession session, @RequestParam Map<String, Object> param) throws Exception {

        LoginVO login = (LoginVO) session.getAttribute("userInfo");

        String userId = login.getUserId();
        String custId = login.getCustId();

        param.put("userId", userId);
        param.put("custId", custId);

        List<MyResultVO> myResult = dashboardService.getMyResult(param);

        map.put("result", Boolean.TRUE);
        map.put("data", myResult);

        return "jsonView";
    }

    //Today's High Lights - HighLight
    @PostMapping(value = "/dashboard/todaycustresult.do")
    public String boardTodayCustResult(HttpServletRequest request, Model model, ModelMap map, HttpSession session, @RequestParam Map<String, Object> param) throws Exception {

        LoginVO login = (LoginVO) session.getAttribute("userInfo");
        String custId = login.getCustId();

        param.put("custId", custId);

        List<TodayCustResultVO> todayCustResult = dashboardService.getTodayCustResult(param);

        map.put("result", Boolean.TRUE);
        map.put("data", todayCustResult);

        return "jsonView";
    }

    //배차 손익추이 - ProfitLoss
    @PostMapping(value = "/dashboard/resultvehicle.do")
    public String boardResultVehicle(HttpServletRequest request, Model model, ModelMap map, HttpSession session, @RequestParam Map<String, Object> param) throws Exception {

        LoginVO login = (LoginVO) session.getAttribute("userInfo");
        String custId = login.getCustId();

        param.put("custId", custId);

        List<ResultVehicleVO> resultVehicle = dashboardService.getResultVehicle(param);

        map.put("result", Boolean.TRUE);
        map.put("data", resultVehicle);

        return "jsonView";
    }

        //전월 TOP 거래처 현황 - TopAccount
    @PostMapping(value = "/dashboard/mmtoprank.do")
    public String boardMmtopRank(HttpServletRequest request, Model model, ModelMap map, HttpSession session, @RequestParam Map<String, Object> param) throws Exception {

        LoginVO login = (LoginVO) session.getAttribute("userInfo");
        String custId = login.getCustId();

        param.put("custId", custId);

        List<MmtopRankVO> mmtopRank = dashboardService.getMmtopRank(param);

        map.put("result", Boolean.TRUE);
        map.put("data", mmtopRank);

        return "jsonView";
    }

    //Private 내역 - HeaderPrivate.
    @PostMapping(value = "/dashboard/header.do")
    public String boardHeader(HttpServletRequest request, Model model, ModelMap map, HttpSession session, @RequestParam Map<String, Object> param) throws Exception {

        LoginVO login = (LoginVO) session.getAttribute("userInfo");
        String custId = login.getCustId();

        param.put("custId", custId);

        String header = dashboardService.getHeader(param);

        map.put("result", Boolean.TRUE);
        map.put("data", header);

        return "jsonView";
    }
}
