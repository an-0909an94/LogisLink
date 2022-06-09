package com.logislink.monitor.controller;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.logislink.cmm.util.EtcUtil;
import com.logislink.login.vo.LoginMenuVO;
import com.logislink.login.vo.LoginVO;
import com.logislink.monitor.service.MonitorService;

@Controller
public class MonitorController {
	private Logger log = Logger.getLogger(this.getClass());
	private String orderMonthlyMenuCode = "G7210";
	private String orderYearMenuCode = "G7410";
	private String profitInfoMonthlyMenuCode = "G7110";
	private String profitInfoYearMenuCode = "G7310";
	private String deptMonthlyMenuCode = "G7510";
	private String deptYearMenuCode = "G7610";
	
	@Resource(name="monitorService")
	private MonitorService monitorService;
	
	@GetMapping(value="/contents/monitor/orderMonthly.do")
	public String orderMonthly(HttpServletRequest request, HttpSession session, ModelMap model) {
		
		LoginMenuVO loginMenu = EtcUtil.checkAuth(request, orderMonthlyMenuCode);
		model.put("menuAuth", loginMenu);
		
		return "contents/monitor/orderMonthly";
	}
	
	@GetMapping(value="/contents/monitor/orderYear.do")
	public String orderYear(HttpServletRequest request, HttpSession session, ModelMap model) {
		
		LoginMenuVO loginMenu = EtcUtil.checkAuth(request, orderYearMenuCode);
		model.put("menuAuth", loginMenu);
		
		return "contents/monitor/orderYear";
	}
	
	@GetMapping(value="/contents/monitor/profitInfoMonthly.do")
	public String profitCustListMonth(HttpServletRequest request, HttpSession session, ModelMap model) {
		
		LoginMenuVO loginMenu = EtcUtil.checkAuth(request, profitInfoMonthlyMenuCode);
		model.put("menuAuth", loginMenu);
				
		return "contents/monitor/profitInfoMonthly";
	}
	
	@GetMapping(value="/contents/monitor/profitInfoYear.do")
	public String profitCustListYear(HttpServletRequest request, HttpSession session, ModelMap model) {
		
		LoginMenuVO loginMenu = EtcUtil.checkAuth(request, profitInfoYearMenuCode);
		model.put("menuAuth", loginMenu);
				
		return "contents/monitor/profitInfoYear";
	}
	
	@GetMapping(value="/contents/monitor/profitDeptMonthly.do")
	public String profitDeptListMonth(HttpServletRequest request, HttpSession session, ModelMap model) {
		
		LoginMenuVO loginMenu = EtcUtil.checkAuth(request, deptMonthlyMenuCode);
		model.put("menuAuth", loginMenu);
				
		return "contents/monitor/profitDeptMonthly";
	}
	
	@GetMapping(value="/contents/monitor/profitDeptYear.do")
	public String profitDeptListYear(HttpServletRequest request, HttpSession session, ModelMap model) {
		
		LoginMenuVO loginMenu = EtcUtil.checkAuth(request, deptYearMenuCode);
		model.put("menuAuth", loginMenu);

		return "contents/monitor/profitDeptYear";
	}
	
	@PostMapping(value="/contents/monitor/data/orderMonthly.do")
	public String orderMonthlyData(HttpServletRequest request, HttpSession session, 
								ModelMap map, @RequestParam Map<String, Object> param) {
		
		if(param.get("orderStates") != null && !"".equals(param.get("orderStates"))) {
			List<String> tmpList = Arrays.asList(((String)param.get("orderStates")).split(","));
			List<String> stateList = new ArrayList<String>();
			for(int i=0; i<tmpList.size(); i++) {
				stateList.add(tmpList.get(i));
				if("01".equals(tmpList.get(i))) {
					stateList.add("04");
					stateList.add("12");
				}
			}
			param.put("stateList", stateList);
		}
				
		List<Map<String, Object>> user = monitorService.selectOrderMonitorUserId(param);
		List<Map<String, Object>> total = monitorService.selectOrderMonitorMonthlySum(param);
		List<Map<String, Object>> data = monitorService.selectOrderMonitorMonthly(param);

		map.put("result", Boolean.TRUE);
		map.put("user", user);
		map.put("total", total);
		map.put("data", data);
		
		return "jsonView";  
	}
	
	@PostMapping(value="/contents/monitor/data/profitCustMonth.do")
	public String profitCustMonthData(HttpServletRequest request, HttpSession session, 
								ModelMap map, @RequestParam Map<String, Object> param) {

		LoginVO login = (LoginVO) session.getAttribute("userInfo");
		if("N".equals(login.getMasterYn())) {
			param.put("deptId", login.getDeptId());
		}
		
		List<Map<String, Object>> cust = monitorService.selectProfitCustId(param);
		List<Map<String, Object>> data = monitorService.selectProfitCustMonth(param);
		
		map.put("result", Boolean.TRUE);
		map.put("cust", cust);
		map.put("data", data);
		
		return "jsonView";
	}	
	
	@PostMapping(value="/contents/monitor/data/profitCustYear.do")
	public String profitCustYearData(HttpServletRequest request, HttpSession session, 
								ModelMap map, @RequestParam Map<String, Object> param) {

		LoginVO login = (LoginVO) session.getAttribute("userInfo");
		if("N".equals(login.getMasterYn())) {
			param.put("deptId", login.getDeptId());
		}
		
		List<Map<String, Object>> cust = monitorService.selectProfitCustId(param);
		List<Map<String, Object>> data = monitorService.selectProfitCustYear(param);
		
		map.put("result", Boolean.TRUE);
		map.put("cust", cust);
		map.put("data", data);
		
		return "jsonView";
	}	

	@PostMapping(value="/contents/monitor/data/orderYear.do")
	public String orderYearData(HttpServletRequest request, HttpSession session, 
								ModelMap map, @RequestParam Map<String, Object> param) {
		
		if(param.get("orderStates") != null && !"".equals(param.get("orderStates"))) {
			List<String> tmpList = Arrays.asList(((String)param.get("orderStates")).split(","));
			List<String> stateList = new ArrayList<String>();
			for(int i=0; i<tmpList.size(); i++) {
				stateList.add(tmpList.get(i));
				if("01".equals(tmpList.get(i))) {
					stateList.add("04");
					stateList.add("12");
				}
			}
			param.put("stateList", stateList);
		}
				
		List<Map<String, Object>> user = monitorService.selectOrderMonitorUserId(param);
		List<Map<String, Object>> total = monitorService.selectOrderMonitorYearSum(param);
		List<Map<String, Object>> data = monitorService.selectOrderMonitorYear(param);

		map.put("result", Boolean.TRUE);
		map.put("user", user);
		map.put("total", total);
		map.put("data", data);
		
		return "jsonView";  
	}
	
	@PostMapping(value="/contents/monitor/data/profitDeptMonth.do")
	public String profitDeptMonthData(HttpServletRequest request, HttpSession session, 
								ModelMap map, @RequestParam Map<String, Object> param) {

		LoginVO login = (LoginVO) session.getAttribute("userInfo");
		if("N".equals(login.getMasterYn())) {
			param.put("deptId", login.getDeptId());
		}
		
		List<Map<String, Object>> dept = monitorService.selectProfitDeptId(param);
		List<Map<String, Object>> data = monitorService.selectProfitDeptMonth(param);
		List<Map<String, Object>> total = monitorService.selectProfitDeptMonthlySum(param);
		
		map.put("result", Boolean.TRUE);
		map.put("dept", dept);
		map.put("data", data);
		map.put("total", total);
		
		return "jsonView";
	}	
	
	@PostMapping(value="/contents/monitor/data/profitDeptYear.do")
	public String profitDeptYearData(HttpServletRequest request, HttpSession session, 
								ModelMap map, @RequestParam Map<String, Object> param) {

		LoginVO login = (LoginVO) session.getAttribute("userInfo");
		if("N".equals(login.getMasterYn())) {
			param.put("deptId", login.getDeptId());
		}
		
		List<Map<String, Object>> dept = monitorService.selectProfitDeptId(param);
		List<Map<String, Object>> data = monitorService.selectProfitDeptYear(param);
		List<Map<String, Object>> total = monitorService.selectProfitDeptYearSum(param);
		
		map.put("result", Boolean.TRUE);
		map.put("dept", dept);
		map.put("data", data);
		map.put("total", total);
		
		return "jsonView";
	}

}
