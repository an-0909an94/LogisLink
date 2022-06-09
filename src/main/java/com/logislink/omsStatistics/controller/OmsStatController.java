package com.logislink.omsStatistics.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.logislink.cmm.util.EtcUtil;
import com.logislink.login.vo.LoginMenuVO;
import com.logislink.login.vo.LoginVO;
import com.logislink.statistics.service.StatService;
import com.logislink.statistics.vo.StatVO;

@Controller
public class OmsStatController {

	private Logger log = Logger.getLogger(this.getClass());
	private String StatCode = "Z5510";
	@Resource(name="statService")
	private StatService statService;
	
	@GetMapping(value="/oms/statistics/statisticsGroup.do")
	public String statisticsGroup(HttpServletRequest request, HttpSession session, ModelMap model) {

		LoginMenuVO loginMenu = EtcUtil.checkAuth(request, StatCode);
		
		model.put("menuAuth", loginMenu);
		
		return "oms/statistics/statisticsGroup";
	}
	
	@GetMapping(value="/oms/statistics/dispatchCount.do")
	public String dispatchCount(HttpServletRequest request, HttpSession session, ModelMap model) {
		return "oms/statistics/view/dispatchCount";
	}
	
	@GetMapping(value="/oms/statistics/statAllocation.do")
	public String statAllocation(HttpServletRequest request, HttpSession session, ModelMap model) {
		return "oms/statistics/view/statAllocation";
	}
	
	@GetMapping(value="/oms/statistics/statUrgent.do")
	public String statUrgent(HttpServletRequest request, HttpSession session, ModelMap model) {
		return "oms/statistics/view/statUrgent";
	}
	
	@GetMapping(value="/oms/statistics/statEnter.do")
	public String statEnter(HttpServletRequest request, HttpSession session, ModelMap model) {
		return "oms/statistics/view/statEnter";
	}
	
	@GetMapping(value="/oms/statistics/statArrival.do")
	public String statArrival(HttpServletRequest request, HttpSession session, ModelMap model) {
		return "oms/statistics/view/statArrival";
	}
	
	@GetMapping(value="/oms/statistics/statLoad.do")
	public String statLoad(HttpServletRequest request, HttpSession session, ModelMap model) {
		return "oms/statistics/view/statLoad";
	}
	
	@GetMapping(value="/oms/statistics/statCharge.do")
	public String statCharge(HttpServletRequest request, HttpSession session, ModelMap model) {
		return "oms/statistics/view/statCharge";
	}
	
	@GetMapping(value="/oms/statistics/statTonCharge.do")
	public String statTonCharge(HttpServletRequest request, HttpSession session, ModelMap model) {
		return "oms/statistics/view/statTonCharge";
	}
}
