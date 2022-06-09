package com.logislink.calc.controller;

import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.logislink.calc.service.CalcService;
import com.logislink.calc.vo.CalcVO;
import com.logislink.calc.vo.OrderCalcVO;
import com.logislink.cmm.util.EtcUtil;
import com.logislink.cmm.vo.FileVO;
import com.logislink.login.vo.LoginMenuVO;
import com.logislink.login.vo.LoginVO;

@Controller
public class CalcController {
	private Logger log = Logger.getLogger(this.getClass());
	private String menuCode = "C3110";
	private String purchaseDeadlineCode = "C3710";
	private String sellPurchaseDeadlineCode = "C3810";
	
	@Resource(name="calcService")
	private CalcService calcService;
	
	@GetMapping(value="/contents/calc/calcList.do")
	public String calcList(HttpServletRequest request, HttpSession session, ModelMap model) {
		
		LoginMenuVO loginMenu = EtcUtil.checkAuth(request, menuCode);
		model.put("menuAuth", loginMenu);
				
		return "contents/calc/calcList";
	}
	
	@PostMapping(value="/contents/calc/data/calcList.do")
	public String calcListData(HttpServletRequest request, Model model, ModelMap map, HttpSession session,
								@RequestParam Map<String, Object> param ) throws Exception {
		

		LoginVO login = (LoginVO) session.getAttribute("userInfo");
		if("N".equals(login.getMasterYn())) {
			param.put("mngDeptId", login.getDeptId());
		} else {
			param.put("mngDeptId", param.get("sDeptId"));
		}
		
		//param.put("mngDeptId", login.getDeptId());
		
		List<CalcVO> calcList = calcService.getCalcList(param);
		int count = calcService.getCnt(param);
		
		map.put("result", Boolean.TRUE);
		map.put("data", calcList);
		map.put("total", count);
		
		return "jsonView";
		
	}

	@PostMapping(value="/contents/calc/data/calcSummary.do")
	public String calcSummaryData(HttpServletRequest request, Model model, ModelMap map, HttpSession session,
			@RequestParam Map<String, Object> param ) throws Exception {

		LoginVO login = (LoginVO) session.getAttribute("userInfo");
		if("N".equals(login.getMasterYn())) {
			param.put("mngDeptId", login.getDeptId());
		} else {
			param.put("mngDeptId", param.get("sDeptId"));
		}

		Map<String, Object> summary = calcService.getSummary(param);
		
		map.put("result", Boolean.TRUE);
		map.put("data", summary);
		
		return "jsonView";
	}
	
	@PostMapping(value="/contents/calc/data/updateCarrierAmt.do")
	public String updateCarrierAmt(HttpServletRequest request, Model model, ModelMap map, HttpSession session,
								@RequestParam Map<String, Object> param ) throws Exception {
		
		if(!EtcUtil.checkAuth(request, menuCode, "E")) {
			map.put("result", Boolean.FALSE);
			map.put("msg", "해당 권한이 없습니다.");
			
			return "jsonView";
		}
		
		calcService.updateAllocCharge(param);

		if(!"00".equals(param.get("retCode"))) {
			map.put("result", Boolean.FALSE);
			map.put("msg", param.get("retMsg"));
		} else {
			map.put("result", Boolean.TRUE);
			map.put("msg", param.get("retMsg"));	
		}
		
		return "jsonView";
		
	}

	@PostMapping(value="/contents/calc/data/updateChangeReq.do")
	public String updateChangeReq(HttpServletRequest request, Model model, ModelMap map, HttpSession session,
								@RequestParam Map<String, Object> param ) throws Exception {
		
		if(!EtcUtil.checkAuth(request, menuCode, "E")) {
			map.put("result", Boolean.FALSE);
			map.put("msg", "해당 권한이 없습니다.");
			
			return "jsonView";
		}
		
		calcService.updateChangeReq(param);

		if(!"00".equals(param.get("retCode"))) {
			map.put("result", Boolean.FALSE);
			map.put("msg", param.get("retMsg"));
		} else {
			map.put("result", Boolean.TRUE);
			map.put("msg", param.get("retMsg"));	
		}
		
		return "jsonView";
		
	}
	
	@PostMapping(value="/contents/calc/data/custFinishCalc.do")
	public String custFinishCalc(HttpServletRequest request, Model model, ModelMap map, HttpSession session,
								@RequestParam Map<String, Object> param ) throws Exception {
		
		if(!EtcUtil.checkAuth(request, menuCode, "E")) {
			map.put("result", Boolean.FALSE);
			map.put("msg", "해당 권한이 없습니다.");
			
			return "jsonView";
		}

		LoginVO login = (LoginVO) session.getAttribute("userInfo");
		if("N".equals(login.getMasterYn())) {
			param.put("mngDeptId", login.getDeptId());
		} else {
			param.put("mngDeptId", param.get("sDeptId"));
		}
		
		calcService.custFinishCalc(param);

		if(!"00".equals(param.get("retCode"))) {
			map.put("result", Boolean.FALSE);
			map.put("msg", param.get("retMsg"));
		} else {
			map.put("result", Boolean.TRUE);
			map.put("msg", param.get("retMsg"));	
		}
		
		
		return "jsonView";
		
	}
	
	@PostMapping(value="/contents/calc/data/multiFinishCalc.do")
	public String multiFinishCalc(HttpServletRequest request, Model model, ModelMap map, HttpSession session,
								@RequestParam Map<String, Object> param ) throws Exception {
		
		if(!EtcUtil.checkAuth(request, menuCode, "E")) {
			map.put("result", Boolean.FALSE);
			map.put("msg", "해당 권한이 없습니다.");
			
			return "jsonView";
		}

		LoginVO login = (LoginVO) session.getAttribute("userInfo");
		if("N".equals(login.getMasterYn())) {
			param.put("mngDeptId", login.getDeptId());
		} else {
			param.put("mngDeptId", param.get("sDeptId"));
		}
		
		
		/*List<String> calcIdList = Arrays.asList(((String)param.get("calcIdArr")).split(","));
		param.put("calcIdList", calcIdList);*/
		calcService.multiFinishCalc(param);

		if(!"00".equals(param.get("retCode"))) {
			map.put("result", Boolean.FALSE);
			map.put("msg", param.get("retMsg"));
		} else {
			map.put("result", Boolean.TRUE);
			map.put("msg", param.get("retMsg"));	
		}
		
		return "jsonView";
		
	}
	
	@PostMapping(value="/contents/calc/data/newCalcCharge.do")
	public String newCalcCharge(HttpServletRequest request, Model model, ModelMap map, HttpSession session,
								@RequestParam Map<String, Object> param ) throws Exception {
		
		if("E".equals(param.get("fCalcMode"))) {			
			if(!EtcUtil.checkAuth(request, menuCode, "E")) {
				map.put("result", Boolean.FALSE);
				map.put("msg", "해당 권한이 없습니다.");
				
				return "jsonView";
			}			
		} else if("N".equals(param.get("fCalcMode"))) {
			if(!EtcUtil.checkAuth(request, menuCode, "W")) {
				map.put("result", Boolean.FALSE);
				map.put("msg", "해당 권한이 없습니다.");
				
				return "jsonView";
			}			
		}
		
		param.put("regId", ((LoginVO) session.getAttribute("userInfo")).getUserId());
		
		calcService.newCalcCharge(param);
		
		map.put("result", Boolean.TRUE);
		map.put("msg", (String) param.get("retMsg"));
		
		return "jsonView";
		
	}

	@GetMapping(value="/contents/calc/view/orderFile.do")
	public String getOrderFile(HttpServletRequest request, Model model, HttpSession httpSession, ModelMap map, 
			@RequestParam Map<String, Object> param) throws Exception {
		
		map.put("orderId", param.get("orderId"));
		return "contents/calc/view/orderFile";
	}
	
	@PostMapping(value="/contents/calc/data/multiDeleteCalc.do")
	public String multiDeleteCalc(HttpServletRequest request, Model model, ModelMap map, HttpSession session,
								@RequestParam Map<String, Object> param ) throws Exception {
		
		if(!EtcUtil.checkAuth(request, menuCode, "D")) {
			map.put("result", Boolean.FALSE);
			map.put("msg", "해당 권한이 없습니다.");
			
			return "jsonView";
		}
		
		Map<String, Object> param2 = new HashMap<String, Object>();
		
		List<String> calcIdList = Arrays.asList(((String)param.get("calcIdArr")).split(","));
		List<String> allocIdArr = Arrays.asList(((String)param.get("allocIdArr")).split(","));
		List<String> calcTypeCodeArr = Arrays.asList(((String)param.get("calcTypeCodeArr")).split(","));
		
		param.put("calcIdList", calcIdList);
		param2.put("allocIdArr", allocIdArr);
		param2.put("calcTypeCodeArr", calcTypeCodeArr);
		
		calcService.multiDeleteCalc(param);
		calcService.multiDeleteAllocAdd(param2);
		
		map.put("result", Boolean.TRUE);
		map.put("msg", "정산내역을 삭제했습니다.");
		
		return "jsonView";
		
	}
	
	@PostMapping(value="/contents/calc/data/custList.do")
	public String custListData(HttpServletRequest request, Model model, HttpSession session, ModelMap map, 
			@RequestParam Map<String, Object> param) throws Exception {

		LoginVO login = (LoginVO) session.getAttribute("userInfo");
		if("N".equals(login.getMasterYn())) {
			param.put("mngDeptId", login.getDeptId());
		} else {
			param.put("mngDeptId", param.get("sDeptId"));
		}
		
		List<Map<String, Object>> list = calcService.getCustByBiz(param);

		map.put("result", Boolean.TRUE);
		map.put("data", list);
		return "jsonView";
	}

	@PostMapping(value="/contents/calc/data/deptList.do")
	public String deptListData(HttpServletRequest request, Model model, HttpSession session, ModelMap map, 
			@RequestParam Map<String, Object> param) throws Exception {

		LoginVO login = (LoginVO) session.getAttribute("userInfo");
		if("N".equals(login.getMasterYn())) {
			param.put("mngDeptId", login.getDeptId());
		} else {
			param.put("mngDeptId", param.get("sDeptId"));
		}
		
		List<Map<String, Object>> list = calcService.getDeptByCust(param);

		map.put("result", Boolean.TRUE);
		map.put("data", list);
		return "jsonView";
	}
	
	@PostMapping(value="/contents/calc/data/calcCheck.do")
	public String calcCheck(HttpServletRequest request, Model model, ModelMap map, HttpSession session,
								@RequestParam Map<String, Object> param ) throws Exception {
		HashMap<String, String> chk = calcService.calcCheck(param);
		
		if("00".equals(chk.get("retCode"))) {
			map.put("result", Boolean.TRUE);
			map.put("data", chk);
		}else {
			map.put("result", Boolean.FALSE);
		}
		
		return "jsonView";
	}
	
	@PostMapping(value="/contents/calc/data/multPaperReceipt.do")
	public String multPaperReceipt(HttpServletRequest request, Model model, ModelMap map, HttpSession session,
								@RequestParam Map<String, Object> param ) throws Exception {
		
		if(!EtcUtil.checkAuth(request, menuCode, "E")) {
			map.put("result", Boolean.FALSE);
			map.put("msg", "해당 권한이 없습니다.");
			
			return "jsonView";
		}

		//List<String> orderList = Arrays.asList(((String)param.get("orderIdArr")).split(","));
		param.put("orderList", param.get("orderIdArr"));
		calcService.multPaperReceipt(param);

		if(!"00".equals(param.get("retCode"))) {
			map.put("result", Boolean.FALSE);
			map.put("msg", param.get("retMsg"));
		} else {
			map.put("result", Boolean.TRUE);
			map.put("msg", param.get("retMsg"));	
		}
		
		return "jsonView";
		
	}
	
	@PostMapping(value="/contents/calc/data/multPaperTax.do")
	public String multPaperTax(HttpServletRequest request, Model model, ModelMap map, HttpSession session,
								@RequestParam Map<String, Object> param ) throws Exception {
		
		if(!EtcUtil.checkAuth(request, menuCode, "E")) {
			map.put("result", Boolean.FALSE);
			map.put("msg", "해당 권한이 없습니다.");
			
			return "jsonView";
		}

		param.put("calcList", param.get("calcIdArr"));
		calcService.multPaperTax(param);
		
		if(!"00".equals(param.get("retCode"))) {
			map.put("result", Boolean.FALSE);
			map.put("msg", param.get("retMsg"));
		} else {
			map.put("result", Boolean.TRUE);
			map.put("msg", param.get("retMsg"));	
		}
		
		return "jsonView";
		
	}

	@PostMapping(value="/contents/calc/data/detailCalcUpdate.do")
	public String detailCalcUpdate(HttpServletRequest request, Model model, ModelMap map, HttpSession session,
								@RequestParam Map<String, Object> param ) throws Exception {
		
		if(!EtcUtil.checkAuth(request, menuCode, "E")) {
			map.put("result", Boolean.FALSE);
			map.put("msg", "해당 권한이 없습니다.");
			
			return "jsonView";
		}

		calcService.detailCalcUpdate(param);
		
		map.put("result", Boolean.TRUE);
		map.put("msg", "정산정보를 수정했습니다.");
		
		return "jsonView";
		
	}

	@PostMapping(value="/contents/calc/data/viewTax.do")
	public String viewTax(HttpServletRequest request, Model model, ModelMap map, HttpSession session,
								@RequestParam Map<String, Object> param ) throws Exception {

		Map<String, Object> data = calcService.viewTax(param);
		List<Map<String, Object>> data2 = calcService.viewTaxDetail(param);
		
		map.put("data", data);
		map.put("data2", data2);
		
		return "jsonView";
		
	}

	@PostMapping(value="/contents/calc/data/viewReceipt.do")
	public String viewReceipt(HttpServletRequest request, Model model, ModelMap map, HttpSession session,
								@RequestParam Map<String, Object> param ) throws Exception {

		List<FileVO> data = calcService.viewReceipt(param);
		
		map.put("data", data);
		
		return "jsonView";
		
	}

	@PostMapping(value="/contents/calc/data/calcAllocIdChk.do")
	public String calcAllocIdChk(HttpServletRequest request, Model model, ModelMap map, HttpSession session,
								@RequestParam Map<String, Object> param ) throws Exception {

		HashMap<String, Object> data = calcService.allocIdChk(param);

		if("00".equals(data.get("retCode"))) {
			map.put("result", Boolean.TRUE);
			map.put("msg", "");
		} else if("99".equals(data.get("retCode"))) {
			map.put("result", Boolean.FALSE);
			map.put("msg", data.get("retMsg"));
		}
		return "jsonView";	
	}
	
	@GetMapping(value="/contents/calc/purchaseDeadline.do")
	public String purchaseDeadline(HttpServletRequest request, HttpSession session, ModelMap model) {
		LoginMenuVO loginMenu = EtcUtil.checkAuth(request, purchaseDeadlineCode);
		model.put("menuAuth", loginMenu);
		
		return "contents/calc/purchaseDeadline";
	}	
	
	@GetMapping(value="/contents/calc/sellPurchaseDeadline.do")
	public String sellPurchaseDeadline(HttpServletRequest request, HttpSession session, ModelMap model) {
		LoginMenuVO loginMenu = EtcUtil.checkAuth(request, sellPurchaseDeadlineCode);
		model.put("menuAuth", loginMenu);
		
		return "contents/calc/sellPurchaseDeadline";
	}	
	
	@PostMapping(value="/contents/calc/data/purchaseDeadline.do")
	public String purchaseDeadlineData(HttpServletRequest request, Model model, ModelMap map, HttpSession session,
								@RequestParam Map<String, Object> param ) throws Exception {
		LoginMenuVO loginMenu = EtcUtil.checkAuth(request, purchaseDeadlineCode);
		
		param.put("deptId", param.get("sDeptId"));
		Map<String, Object> summary = null;
		List<OrderCalcVO> list = calcService.getPurchaseDeadline(param);
		if(list.size() > 0) {
			summary = calcService.getPurchaseDeadlineSummary(param);	
		}
		
		map.put("result", Boolean.TRUE);
		map.put("data", list);
		map.put("summary", summary);
		
		return "jsonView";	
	}

	@PostMapping(value="/contents/calc/data/sellPurchaseDeadline.do")
	public String sellPurchaseDeadlineData(HttpServletRequest request, Model model, ModelMap map, HttpSession session,
								@RequestParam Map<String, Object> param ) throws Exception {
		LoginMenuVO loginMenu = EtcUtil.checkAuth(request, sellPurchaseDeadlineCode);
		
		return "jsonView";	
	}
	
	@PostMapping(value="/contents/calc/data/updateCharge.do")
	public String updateChargeData(HttpServletRequest request, HttpServletResponse response, Model model, HttpSession session,
								ModelMap map, @RequestParam Map<String, Object> param) throws Exception {
		
		if(!EtcUtil.checkAuth(request, purchaseDeadlineCode, "E") || !EtcUtil.checkAuth(request, purchaseDeadlineCode, "W")) {
			map.put("result", Boolean.FALSE);
			map.put("msg", "해당 권한이 없습니다.");
			
			return "jsonView";
		}
				
		String jsonParam = String.valueOf(param.get("orderData"));

		ObjectMapper objectMapper = new ObjectMapper();
		List<Map<String, Object>> readValue = objectMapper.readValue(jsonParam, new TypeReference<List<Map<String, Object>>>(){});

		for(Map<String, Object> data :readValue) {
			String divisionCharge = String.valueOf(data.get("divisionCharge"));
			String addCharge = String.valueOf(data.get("addCharge"));
			int allocCharge = Integer.valueOf(divisionCharge) - Integer.valueOf(addCharge);
			data.put("allocCharge", allocCharge);
			data.put("allocList", data.get("allocId"));
			
			calcService.updateAllocCharge(data);
		}
				
		map.put("result", Boolean.TRUE);
		map.put("msg", "운송비를 수정했습니다.");
		
		return "jsonView";
	}
	
	@PostMapping(value="/contents/calc/data/getDriverCommission.do")
	public String getDriverCommission(HttpServletRequest request, Model model, ModelMap map, HttpSession session,
								@RequestParam Map<String, Object> param ) throws Exception {
		
		Map<String, Object> data = calcService.getDriverCommission(param);
		
		map.put("data", data); 
		
		return "jsonView";	
	}

	@PostMapping(value="/contents/calc/data/addChargeList.do")
	public String allocAddChargeList (HttpServletRequest request, HttpServletResponse response, Model model, HttpSession session,
								ModelMap map, @RequestParam Map<String, Object> param) throws Exception {

		List<Map<String, Object>> data = calcService.getOrderAllocAdd(param);
		
		map.put("result", Boolean.TRUE);
		map.put("data", data);
		
		return "jsonView";
	}
	
	@PostMapping(value="/contents/order/data/serchCustDeptInfo.do")
	public String serchCustDeptInfo(HttpServletRequest request, Model model, ModelMap map, HttpSession session,
			@RequestParam Map<String, Object> param ) throws Exception {

		Map<String, Object> param2 = new HashMap<String, Object>();
		List<String> orderList = Arrays.asList(((String)param.get("orderList")).split(","));
		List<String> allocList = Arrays.asList(((String)param.get("allocList")).split(","));
		param2.put("orderList", orderList);
		param2.put("allocList", allocList);

		List<CalcVO> list = calcService.serchCustDeptInfo(param2);
		
		map.put("result", Boolean.TRUE);
		map.put("data", list);
		
		return "jsonView";
	}
}
