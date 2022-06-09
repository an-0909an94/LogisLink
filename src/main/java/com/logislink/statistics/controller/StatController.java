package com.logislink.statistics.controller;

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
public class StatController {

	private Logger log = Logger.getLogger(this.getClass());
	private String dispatchCountMenuCode = "F6110";
	private String statAllocationMenuCode = "F6210";
	private String statUrgentMenuCode = "F6310";
	private String statEnterMenuCode = "F6410";
	private String statArrivalMenuCode = "F6510";
	private String statLoadMenuCode = "F6610";
	private String statChargeMenuCode = "F6710";
	private String statTonChargeMenuCode = "F6810";
	
	@Resource(name="statService")
	private StatService statService;
	
	@GetMapping(value="/contents/statistics/dispatchCount.do")
	public String dispatchCount(HttpServletRequest request, HttpSession session, ModelMap model) {

		LoginMenuVO loginMenu = EtcUtil.checkAuth(request, dispatchCountMenuCode);
		LoginVO loginUserInfo = ((LoginVO) session.getAttribute("userInfo"));
		
		if(loginUserInfo.getAuthSeq() == 100) {
			model.addAttribute("authChk", true);
		} else {
			model.addAttribute("authChk", false);
		}
		model.put("menuAuth", loginMenu);
		
		return "contents/statistics/dispatchCount";
	}
	
	@GetMapping(value="/contents/statistics/statAllocation.do")
	public String statAllocation(HttpServletRequest request, HttpSession session, ModelMap model) {

		LoginMenuVO loginMenu = EtcUtil.checkAuth(request, statAllocationMenuCode);
		LoginVO loginUserInfo = ((LoginVO) session.getAttribute("userInfo"));
		
		if(loginUserInfo.getAuthSeq() == 100) {
			model.addAttribute("authChk", true);
		} else {
			model.addAttribute("authChk", false);
		}
		model.put("menuAuth", loginMenu);
		
		return "contents/statistics/statAllocation";
	}
	
	@GetMapping(value="/contents/statistics/statUrgent.do")
	public String statUrgent(HttpServletRequest request, HttpSession session, ModelMap model) {

		LoginMenuVO loginMenu = EtcUtil.checkAuth(request, statUrgentMenuCode);
		LoginVO loginUserInfo = ((LoginVO) session.getAttribute("userInfo"));
		
		if(loginUserInfo.getAuthSeq() == 100) {
			model.addAttribute("authChk", true);
		} else {
			model.addAttribute("authChk", false);
		}
		model.put("menuAuth", loginMenu);
		
		return "contents/statistics/statUrgent";
	}
	
	@GetMapping(value="/contents/statistics/statEnter.do")
	public String statEnter(HttpServletRequest request, HttpSession session, ModelMap model) {

		LoginMenuVO loginMenu = EtcUtil.checkAuth(request, statEnterMenuCode);
		LoginVO loginUserInfo = ((LoginVO) session.getAttribute("userInfo"));
		
		if(loginUserInfo.getAuthSeq() == 100) {
			model.addAttribute("authChk", true);
		} else {
			model.addAttribute("authChk", false);
		}
		model.put("menuAuth", loginMenu);
		
		return "contents/statistics/statEnter";
	}
	
	@GetMapping(value="/contents/statistics/statArrival.do")
	public String statArrival(HttpServletRequest request, HttpSession session, ModelMap model) {

		LoginMenuVO loginMenu = EtcUtil.checkAuth(request, statArrivalMenuCode);
		LoginVO loginUserInfo = ((LoginVO) session.getAttribute("userInfo"));
		
		if(loginUserInfo.getAuthSeq() == 100) {
			model.addAttribute("authChk", true);
		} else {
			model.addAttribute("authChk", false);
		}
		model.put("menuAuth", loginMenu);
		
		return "contents/statistics/statArrival";
	}
	
	@GetMapping(value="/contents/statistics/statLoad.do")
	public String statLoad(HttpServletRequest request, HttpSession session, ModelMap model) {

		LoginMenuVO loginMenu = EtcUtil.checkAuth(request, statLoadMenuCode);
		LoginVO loginUserInfo = ((LoginVO) session.getAttribute("userInfo"));
		
		if(loginUserInfo.getAuthSeq() == 100) {
			model.addAttribute("authChk", true);
		} else {
			model.addAttribute("authChk", false);
		}
		model.put("menuAuth", loginMenu);
		
		return "contents/statistics/statLoad";
	}
	
	@GetMapping(value="/contents/statistics/statCharge.do")
	public String statCharge(HttpServletRequest request, HttpSession session, ModelMap model) {

		LoginMenuVO loginMenu = EtcUtil.checkAuth(request, statChargeMenuCode);
		LoginVO loginUserInfo = ((LoginVO) session.getAttribute("userInfo"));
		
		if(loginUserInfo.getAuthSeq() == 100) {
			model.addAttribute("authChk", true);
		} else {
			model.addAttribute("authChk", false);
		}
		model.put("menuAuth", loginMenu);
		
		return "contents/statistics/statCharge";
	}
	
	@GetMapping(value="/contents/statistics/statTonCharge.do")
	public String statTonCharge(HttpServletRequest request, HttpSession session, ModelMap model) {

		LoginMenuVO loginMenu = EtcUtil.checkAuth(request, statTonChargeMenuCode);
		LoginVO loginUserInfo = ((LoginVO) session.getAttribute("userInfo"));
		
		if(loginUserInfo.getAuthSeq() == 100) {
			model.addAttribute("authChk", true);
		} else {
			model.addAttribute("authChk", false);
		}
		model.put("menuAuth", loginMenu);
		
		return "contents/statistics/statTonCharge";
	}

	@PostMapping(value="/contents/statistics/data/dispatchCount.do") 
	public String dispatchCount(HttpServletRequest request, Model model, HttpSession session,
								ModelMap map, @RequestParam Map<String, Object> param) throws Exception {
		
		List<StatVO> dispatchList = statService.getStatDispatch(param);
		
		map.put("data", dispatchList);
		
		return "jsonView";
	}
	
	@PostMapping(value="/contents/statistics/data/dispatchCountGrid.do") 
	public String dispatchCountGrid(HttpServletRequest request, Model model, HttpSession session,
								ModelMap map, @RequestParam Map<String, Object> param) throws Exception {

		List<StatVO> dispatchList = statService.getStatDispatchGrid(param);
		int count = statService.getStatDispatchGridCount(param);
		
		map.put("data", dispatchList);
		map.put("total", count);
		
		return "jsonView";
	}
	
	@PostMapping(value="/contents/statistics/data/statAllocation.do") 
	public String statAllocation(HttpServletRequest request, Model model, HttpSession session,
								ModelMap map, @RequestParam Map<String, Object> param) throws Exception {
		
		List<StatVO> allocList = statService.getStatAllocation(param);
		
		map.put("data", allocList);
		
		return "jsonView";
	}
	
	@PostMapping(value="/contents/statistics/data/statAllocationGrid.do") 
	public String statAllocationGrid(HttpServletRequest request, Model model, HttpSession session,
								ModelMap map, @RequestParam Map<String, Object> param) throws Exception {
		
		List<StatVO> allocList = statService.getStatAllocationGrid(param);
		int count = statService.getStatAllocationGridCount(param);
		
		map.put("data", allocList);
		map.put("total", count);
		
		return "jsonView";
	}
	
	// STAT URGENT
	@PostMapping(value="/contents/statistics/data/statUrgent.do") 
	public String statUrgent(HttpServletRequest request, Model model, HttpSession session,
								ModelMap map, @RequestParam Map<String, Object> param) throws Exception {
		
		List<StatVO> list = statService.getStatUrgent(param);
		
		map.put("data", list);
		
		return "jsonView";
	}
	
	@PostMapping(value="/contents/statistics/data/statUrgentGrid.do") 
	public String statUrgentGrid(HttpServletRequest request, Model model, HttpSession session,
								ModelMap map, @RequestParam Map<String, Object> param) throws Exception {
		
		List<StatVO> list = statService.getStatUrgentGrid(param);
		int count = statService.getStatUrgentGridCount(param);
		
		map.put("data", list);
		map.put("total", count);
		
		return "jsonView";
	}
	
	// STAT ENTER
	@PostMapping(value="/contents/statistics/data/statEnter.do") 
	public String statEnter(HttpServletRequest request, Model model, HttpSession session,
								ModelMap map, @RequestParam Map<String, Object> param) throws Exception {
		
		List<StatVO> list = statService.getStatEnter(param);
		
		map.put("data", list);
		
		return "jsonView";
	}
	
	@PostMapping(value="/contents/statistics/data/statEnterGrid.do") 
	public String statEnterGrid(HttpServletRequest request, Model model, HttpSession session,
								ModelMap map, @RequestParam Map<String, Object> param) throws Exception {
		
		List<StatVO> list = statService.getStatEnterGrid(param);
		int count = statService.getStatEnterGridCount(param);
		
		map.put("data", list);
		map.put("total", count);
		
		return "jsonView";
	}
	
	// STAT ARRIVAL
	@PostMapping(value="/contents/statistics/data/statArrival.do") 
	public String statArrival(HttpServletRequest request, Model model, HttpSession session,
								ModelMap map, @RequestParam Map<String, Object> param) throws Exception {
		
		List<StatVO> list = statService.getStatArrival(param);
		
		map.put("data", list);
		
		return "jsonView";
	}
	
	@PostMapping(value="/contents/statistics/data/statArrivalGrid.do") 
	public String statArrivalGrid(HttpServletRequest request, Model model, HttpSession session,
								ModelMap map, @RequestParam Map<String, Object> param) throws Exception {
		
		List<StatVO> list = statService.getStatArrivalGrid(param);
		int count = statService.getStatArrivalGridCount(param);
		
		map.put("data", list);
		map.put("total", count);
		
		return "jsonView";
	}
	
	// STAT LOAD
	@PostMapping(value="/contents/statistics/data/statLoad.do") 
	public String statLoad(HttpServletRequest request, Model model, HttpSession session,
								ModelMap map, @RequestParam Map<String, Object> param) throws Exception {
		
		List<StatVO> list = statService.getStatLoad(param);
		
		map.put("data", list);
		
		return "jsonView";
	}
	
	@PostMapping(value="/contents/statistics/data/statLoadGrid.do") 
	public String statLoadGrid(HttpServletRequest request, Model model, HttpSession session,
								ModelMap map, @RequestParam Map<String, Object> param) throws Exception {
		
		List<StatVO> list = statService.getStatLoadGrid(param);
		int count = statService.getStatLoadGridCount(param);
		
		map.put("data", list);
		map.put("total", count);
		
		return "jsonView";
	}
	
	// STAT CHARGE
	@PostMapping(value="/contents/statistics/data/statCharge.do") 
	public String statCharge(HttpServletRequest request, Model model, HttpSession session,
								ModelMap map, @RequestParam Map<String, Object> param) throws Exception {
		
		List<StatVO> list = statService.getStatCharge(param);
		
		map.put("data", list);
		
		return "jsonView";
	}
	
	@PostMapping(value="/contents/statistics/data/statChargeGrid.do") 
	public String statChargeGrid(HttpServletRequest request, Model model, HttpSession session,
								ModelMap map, @RequestParam Map<String, Object> param) throws Exception {
		
		List<StatVO> list = statService.getStatChargeGrid(param);
		int count = statService.getStatChargeGridCount(param);
		
		map.put("data", list);
		map.put("total", count);
		
		return "jsonView";
	}
	
	// STAT TONCHARGE
	@PostMapping(value="/contents/statistics/data/statTonCharge.do") 
	public String statTonCharge(HttpServletRequest request, Model model, HttpSession session,
								ModelMap map, @RequestParam Map<String, Object> param) throws Exception {
		
		List<StatVO> list = statService.getStatTonCharge(param);
		
		map.put("data", list);
		
		return "jsonView";
	}
	
	@PostMapping(value="/contents/statistics/data/statTonChargeGrid.do") 
	public String statTonChargeGrid(HttpServletRequest request, Model model, HttpSession session,
								ModelMap map, @RequestParam Map<String, Object> param) throws Exception {
		
		List<StatVO> list = statService.getStatTonChargeGrid(param);
		int count = statService.getStatTonChargeGridCount(param);
		
		map.put("data", list);
		map.put("total", count);
		
		return "jsonView";
	}
}
