package com.logislink.calc.controller;

import java.util.ArrayList;
import java.util.Arrays;
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

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.logislink.calc.service.BuyCalcService;
import com.logislink.calc.vo.BuyCalcVO;
import com.logislink.cmm.LinkMessage;
import com.logislink.cmm.LinkMessageData;
import com.logislink.cmm.util.EtcUtil;
import com.logislink.login.vo.LoginMenuVO;
import com.logislink.login.vo.LoginVO;

@Controller
public class BuyCalcController {
	private Logger logger = Logger.getLogger(this.getClass());
	private String menuCode = "C3130";
	
	@Resource(name = "buyCalcService")
	private BuyCalcService buyCalcService;
	
	@GetMapping(value = "/contents/calc/buyCalcList.do")
	public String buyCalcList(HttpServletRequest request, HttpSession session, ModelMap model) throws Exception {

		LoginMenuVO loginMenu = EtcUtil.checkAuth(request, menuCode);
		model.put("menuAuth", loginMenu);

		return "contents/calc/buyCalcList";
	}
	
	@PostMapping(value = "/contents/calc/data/buyCalcList.do")
	public String buyCalcListData(HttpServletRequest request, Model model, ModelMap map, HttpSession session, @RequestParam Map<String, Object> param) throws Exception {
		
		LoginVO login = (LoginVO) session.getAttribute("userInfo");
		if (login.getMasterYn().equals("N")) {
			param.put("mngDeptId", login.getDeptId());
		} else {
			param.put("mngDeptId", param.get("sDeptId"));
		}
		
		List<BuyCalcVO> buyCalcList = buyCalcService.getBuyCalcList(param);
		Map<String, Object> buyCalcListCnt = buyCalcService.getBuyCalcListCnt(param);
		
		map.put("result", Boolean.TRUE);
		map.put("data", buyCalcList);
		map.put("total", buyCalcListCnt.get("buyCalcListCnt"));
		map.put("sumPayableAmt", buyCalcListCnt.get("sumPayableAmt"));
		map.put("sumWithdrawalAmt", buyCalcListCnt.get("sumWithdrawalAmt"));
		
		return "jsonView";
	}
	
	@PostMapping(value = "/contents/calc/data/getTaxinv.do")
	public String getTaxinv(HttpServletRequest request, Model model, ModelMap map, HttpSession session, @RequestParam Map<String, Object> param) {
		
		map.clear();
		
		try {
			Map<String, Object> taxinv = buyCalcService.selectTaxinv(param);
			List<Map<String, Object>> taxinvDetailList = buyCalcService.selectTaxinvDetailList(param);
			
			map.put("result", Boolean.TRUE);
			map.put("taxinv", taxinv);
			map.put("taxinvDetailList", taxinvDetailList);
		} catch (Exception e) {
			map.put("result", Boolean.FALSE);
			map.put("msg", "세금계산서 내역을 가져올 수 없습니다.\n선택된 오더의 정산 내역을 확인해 주세요.");
		}
		
		return "jsonView";
	}
	
	/**
	 * 인수증 처리
	 * @param request
	 * @param model
	 * @param map
	 * @param session
	 * @param param
	 * @return
	 */
	@PostMapping(value = "/contents/calc/data/setReceiptSub.do")
	public String setReceiptSub(HttpServletRequest request, Model model, ModelMap map, HttpSession session, @RequestParam Map<String, Object> param) {
		
		LinkMessage linkMessage = new LinkMessage();
		try {
			List<String> orderIdList = Arrays.asList(((String)param.get("orderIdList")).split(","));
			
			param.put("orderIdList", orderIdList);
			
			int resultCnt = buyCalcService.updateReceiptSub(param);
			
			// 결과값
			linkMessage.setSender(this.getClass().getName());
			linkMessage.setStatus(0);
			if (!param.get("mode").equals("N"))
				linkMessage.setMessage("(" + resultCnt + ")건의 인수증 처리를 완료했습니다.");
			else
				linkMessage.setMessage("(" + resultCnt + ")건의 인수증 취소 처리를 완료했습니다.");
		} catch (Exception e) {
			linkMessage.setSender(this.getClass().getName());
			linkMessage.setStatus(-1);
			linkMessage.setMessage("인수증 처리에 실패했습니다.\n시스템 관리자에게 문의하세요.");
			linkMessage.setDetailMessage(e.getMessage());
		}
		
		map.clear();
		map.put("linkMessage", linkMessage);
		
		return "jsonView";
	}
	
	/**
	 * 실물/타사 계산서 수령
	 * @param request
	 * @param model
	 * @param map
	 * @param session
	 * @param param
	 * @return
	 */
	@PostMapping(value = "/contents/calc/data/setTaxinvSub.do")
	public String setTaxinvSub(HttpServletRequest request, Model model, ModelMap map, HttpSession session, @RequestParam Map<String, Object> param) {
		
		LinkMessage linkMessage = new LinkMessage();
		try {
			List<String> allocIdList = Arrays.asList(((String)param.get("allocIdList")).split(","));
			
			param.put("allocIdList", allocIdList);
			
			// 22.09.07 이건욱 Calc 단위가 아닌 Alloc 단위로 처리방법을 변경하여 결과 카운트가 다름.
			int resultCnt = buyCalcService.updateTaxinvSub(param);
			// 쿼리 처리 결과가 아닌 전달받은 Alloc 단위 카운트로 변경
			resultCnt = allocIdList.size();
			
			// 결과값
			linkMessage.setSender(this.getClass().getName());
			linkMessage.setStatus(0);
			if (!param.get("mode").equals("N"))
				linkMessage.setMessage("(" + resultCnt + ")건의 계산서 처리를 완료했습니다.");
			else
				linkMessage.setMessage("(" + resultCnt + ")건의 계산서 취소 처리를 완료했습니다.");
		} catch (Exception e) {
			linkMessage.setSender(this.getClass().getName());
			linkMessage.setStatus(-1);
			linkMessage.setMessage("계산서 처리에 실패했습니다.\n시스템 관리자에게 문의하세요.");
			linkMessage.setDetailMessage(e.getMessage());
		}
		
		map.clear();
		map.put("linkMessage", linkMessage);
		
		return "jsonView";
	}
	
	@PostMapping(value = "/contents/calc/data/setBuyCalcDeleteYn.do")
	public String updateDeleteYn(HttpServletRequest request, Model model, ModelMap map, HttpSession session, @RequestParam Map<String, Object> param) {
		
		// 권한 체크???
		
		LinkMessage linkMessage = new LinkMessage();
		try {
			// String -> Iterator로 변환
			List<String> orderIdList = Arrays.asList(((String)param.get("orderIdList")).split(","));
			List<String> allocIdList = Arrays.asList(((String)param.get("allocIdList")).split(","));
			
			param.put("orderIdList", orderIdList);
			param.put("allocIdList", allocIdList);
			
			int resultCnt = buyCalcService.updateDeleteYn(param);
			
			// 결과값
			linkMessage.setSender(this.getClass().getName());
			linkMessage.setStatus(0);
			if (param.get("deleteYn").equals("Y"))
				linkMessage.setMessage("(" + resultCnt + ")건의 삭제 처리를 완료했습니다.");
			else
				linkMessage.setMessage("(" + resultCnt + ")건의 삭제 취소 처리를 완료했습니다.");
		} catch (Exception e) {
			linkMessage.setSender(this.getClass().getName());
			linkMessage.setStatus(-1);
			linkMessage.setMessage("삭제 처리에 실패했습니다.\n시스템 관리자에게 문의하세요.");
			linkMessage.setDetailMessage(e.getMessage());
		}
		
		map.clear();
		map.put("linkMessage", linkMessage);
		
		return "jsonView";
	}
	
	@PostMapping(value="/contents/calc/data/setBuyCalcCharge.do")
	public String setBuyCalcCharge(HttpServletRequest request, Model model, ModelMap map, HttpSession session, @RequestParam Map<String, Object> param) throws Exception {
		
		// 권한 체크???

		String json = param.get("params").toString();
	    ObjectMapper mapper = new ObjectMapper();
	    List<Map<String, Object>> editedList = mapper.readValue(json, new TypeReference<ArrayList<Map<String, Object>>>(){});

	    List<LinkMessage> linkMessages = new ArrayList<>();
		for (Map<String, Object> item : editedList) {
			
			// 서비스로 넘길 파라미터 항목을 매핑한다.
			Map<String, Object> parameter = new HashMap<String, Object>();
			parameter.put("orderId", item.get("orderId"));
			parameter.put("allocId", item.get("allocId"));
			parameter.put("calcId", item.get("calcId"));
			parameter.put("calcTypeCode", item.get("chargeCode"));
			parameter.put("calcCharge", item.get("value"));
			
			parameter.put("regId", ((LoginVO) session.getAttribute("userInfo")).getUserId());
			
			if ((boolean)item.get("insert")) {
				parameter.put("sellBuySctn", "02");
				parameter.put("mode", "C");
			} else {
				parameter.put("sellBuySctn", "02");
				parameter.put("mode", "U");
			}
			
			LinkMessage linkMessage = new LinkMessage();
			try {
				buyCalcService.upsertCalcCharge(parameter);
				
				linkMessage.setSender(this.getClass().getName());
				linkMessage.setStatus(0);
				linkMessage.setMessage(parameter.get("retMsg").toString());
				
				linkMessages.add(linkMessage);
			} catch (Exception e) {
				linkMessage.setSender(this.getClass().getName());
				linkMessage.setStatus(-1);
				linkMessage.setMessage("오더ID: " + item.get("orderId") + "에 대한 청구 운송비 변경 처리에 실패했습니다.\n다시 확인하세요.");
				linkMessage.setDetailMessage(e.getMessage());
				
				logger.error("오더ID: " + item.get("orderId") + "에 대한 청구 운송비 변경 처리에 실패했습니다.");
				logger.error(e.getStackTrace().toString());
				
				LinkMessageData linkMesasgeData = new LinkMessageData();
				linkMesasgeData.setData(item);
				linkMesasgeData.setDataType("Map<String, Object>");
				linkMessage.setData(linkMesasgeData);
				
				linkMessages.add(linkMessage);
			}
		}
		
		map.clear();
		map.put("linkMessages", linkMessages);
		
		return "jsonView";
	}
	
	@PostMapping(value="/contents/calc/data/setBuyCalcFinish.do")
	public String setBuyCalcFinish(HttpServletRequest request, Model model, ModelMap map, HttpSession session, @RequestParam Map<String, Object> param) throws Exception {
		
		// 권한 체크???

		// mngDeptId 조건 반드시 확인 필! -> 기존 항목에 mngDeptId를 따라야 함?
//		LoginVO login = (LoginVO) session.getAttribute("userInfo");
//		if("N".equals(login.getMasterYn())) {
//			param.put("mngDeptId", login.getDeptId());
//		} else {
//			param.put("mngDeptId", param.get("sDeptId"));
//		}
		
		String finishMode = param.get("mode").toString();
		String json = param.get("param").toString();
		String finishMngDate = null;
		String withdrawalDueDate = null;
	    ObjectMapper mapper = new ObjectMapper();
	    List<Map<String, Object>> calcFinishList = mapper.readValue(json, new TypeReference<ArrayList<Map<String, Object>>>(){});
		
	    List<LinkMessage> linkMessages = new ArrayList<>();
	    for (Map<String, Object> item : calcFinishList) {
	    	
	    	// 모드에 따라 취소 시 마감 처리안된 건 제외 / 삭제건 제외, 마감 시 마감 처리된 건 제외 / 삭제건 제외
	    	if (finishMode.equals("Y")) {
	    		// 마감 처리
	    		if (!item.get("finishYn").equals("N"))
	    			continue;
	    		finishMngDate = param.get("finishMngDate").toString();
	    		withdrawalDueDate = param.get("withdrawalDueDate").toString();
	    	} else {
	    		// 마감 취소
	    		if (item.get("finishYn").equals("N"))
	    			continue;
	    	}
	    	
	    	// 삭제건 제외
	    	if (!item.get("deleteYn").equals("N"))
	    		continue;
	    	
	    	// 서비스로 넘길 파라미터 항목을 매핑한다.
			Map<String, Object> parameter = new HashMap<String, Object>();
			parameter.put("custId", item.get("custId"));
			parameter.put("deptId", item.get("deptId"));
			parameter.put("vehicId", item.get("vehicId"));
			parameter.put("driverId", item.get("driverId"));
			parameter.put("allocId", item.get("buyAllocId"));
			
			String calcIdList = "";
			String buyChargeId = item.get("buyChargeId").toString();
			if (buyChargeId != "")
				calcIdList += buyChargeId;
				
			String buyWaypointChargeId = item.get("buyWaypointChargeId").toString();
			if (buyWaypointChargeId != "")
				calcIdList += "," + buyWaypointChargeId;
			
			String buyStayChargeId = item.get("buyStayChargeId").toString();
			if (buyStayChargeId != "")
				calcIdList += "," + buyStayChargeId;
			
			String buyHandworkChargeId = item.get("buyHandworkChargeId").toString();
			if (buyHandworkChargeId != "")
				calcIdList += "," + buyHandworkChargeId;
			
			String buyRoundChargeId = item.get("buyRoundChargeId").toString();
			if (buyRoundChargeId != "")
				calcIdList += "," + buyRoundChargeId;
			
			String buyOtheraddChargeId = item.get("buyOtheraddChargeId").toString();
			if (buyOtheraddChargeId != "")
				calcIdList += "," + buyOtheraddChargeId;
			
			String buyServiceFeeChargeId = item.get("buyServiceFeeChargeId").toString();
			if (buyServiceFeeChargeId != "")
				calcIdList += "," + buyServiceFeeChargeId;
			parameter.put("calcIdList", calcIdList);
			
			parameter.put("mode", finishMode);
			parameter.put("regId", ((LoginVO)session.getAttribute("userInfo")).getUserId());
			parameter.put("withdrawalDueDate", withdrawalDueDate);
			parameter.put("finishMngDate", finishMngDate);
			
			LinkMessage linkMessage = new LinkMessage();
			try {
				buyCalcService.updateBuyCalcFinish(parameter);
				
				if (parameter.get("retCode").toString().equals("00")) {
					linkMessage.setStatus(0);
				} else {
					linkMessage.setStatus(1);
				}
				linkMessage.setSender(this.getClass().getName());
				linkMessage.setMessage(parameter.get("retMsg").toString());
				
				linkMessages.add(linkMessage);
			} catch (Exception e) {
				linkMessage.setSender(this.getClass().getName());
				linkMessage.setStatus(-1);
				linkMessage.setMessage("오더ID: " + item.get("orderId") + "에 대한 마감 처리에 실패했습니다.\n다시 확인하세요.");
				linkMessage.setDetailMessage(e.getMessage());
				
				logger.error("오더ID: " + item.get("orderId") + "에 대한 마감 처리에 실패했습니다.");
				logger.error(e.getStackTrace().toString());
				
				LinkMessageData linkMesasgeData = new LinkMessageData();
				linkMesasgeData.setData(item);
				linkMesasgeData.setDataType("Map<String, Object>");
				linkMessage.setData(linkMesasgeData);
				
				linkMessages.add(linkMessage);
			}
	    }
	    
	    map.clear();
		map.put("linkMessages", linkMessages);
		
		return "jsonView";
	}
}
