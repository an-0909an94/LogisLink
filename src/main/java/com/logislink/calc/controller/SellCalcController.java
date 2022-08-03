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
import com.logislink.calc.service.SellCalcService;
import com.logislink.cmm.LinkMessage;
import com.logislink.cmm.LinkMessageData;
import com.logislink.cmm.util.EtcUtil;
import com.logislink.login.vo.LoginMenuVO;
import com.logislink.login.vo.LoginVO;

@Controller
public class SellCalcController {
	private Logger log = Logger.getLogger(this.getClass());
	private String menuCode = "C3120";

	@Resource(name = "sellCalcService")
	private SellCalcService sellCalcService;

	@GetMapping(value = "/contents/calc/sellCalcList.do")
	public String sellCalcList(HttpServletRequest request, HttpSession session, ModelMap model) {

		LoginMenuVO loginMenu = EtcUtil.checkAuth(request, menuCode);
		model.put("menuAuth", loginMenu);

		return "contents/calc/sellCalcList";
	}

	@PostMapping(value = "/contents/calc/data/sellCalcList.do")
	public String sellCalcListData(HttpServletRequest request, Model model, ModelMap map, HttpSession session,
			@RequestParam Map<String, Object> param) throws Exception {

		LoginVO login = (LoginVO) session.getAttribute("userInfo");
		if ("N".equals(login.getMasterYn())) {
			param.put("mngDeptId", login.getDeptId());
		} else {
			param.put("mngDeptId", param.get("sDeptId"));
		}

		// param.put("mngDeptId", login.getDeptId());

		List<com.logislink.calc.vo.SellCalcVO> sellCalcList = sellCalcService.getSellCalcList(param);
		int count = sellCalcService.getSellCalcListCnt(param);

		map.put("result", Boolean.TRUE);
		map.put("data", sellCalcList);
		map.put("total", count);
		
		/*
		SellCalcVO sellCalcVo1 = new SellCalcVO();
		sellCalcVo1.number = 1;
		sellCalcVo1.orderId = "O20220315130322724";
		sellCalcVo1.allocId = "A20220315130322413";
		sellCalcVo1.finishYn = "N";
		sellCalcVo1.allocDate = "03.15";
		sellCalcVo1.eDate = "03.15";
		sellCalcVo1.sAddr = "전라북도 군산시 소룡동 1669-2 이스턴물류";
		sellCalcVo1.eAddr = "전라북도 군산시 오식도동 806-3 한성필하우스";
		sellCalcVo1.unpaidAmt = 3200;
		sellCalcVo1.sellCharge = 200;
		sellCalcVo1.sellWayPointCharge = 3000;
		sellCalcVo1.sellStayCharge = 0;
		sellCalcVo1.sellHandWorkCharge = 0;
		sellCalcVo1.sellRoundCharge = 0;
		sellCalcVo1.sellOtherAddCharge = 0;
		sellCalcVo1.goodsName = "테스트화물3.14.1번";
		sellCalcVo1.unitPriceTypeName = "대당단가";
		sellCalcVo1.unitPrice = 0;
		sellCalcVo1.goodsWeight = 0;
		sellCalcVo1.chargeTypeName = "인수증";
		sellCalcVo1.allocFee = 0;
		sellCalcVo1.tranReceiptYn = "Y";
		sellCalcVo1.tranReceiptDate = "03.15";
		sellCalcVo1.payableAmt = 8865;
		sellCalcVo1.carNum = "인천99아9999";
		sellCalcVo1.carSctnName = "외부용차";
		sellCalcVo1.driverName = "김진";
		sellCalcVo1.driverMobile = "01000000000";
		sellCalcVo1.reqPayYn = "N";
		sellCalcVo1.mngDeptName = "[관리팀]";
		sellCalcVo1.mngUserName = "김진";
		sellCalcVo1.taxInvYn = "Y";
		sellCalcVo1.taxInvDate = "03.15";
		
		SellCalcVO sellCalcVo2 = new SellCalcVO();
		sellCalcVo2.number = 2;
		sellCalcVo2.orderId = "O20220325094351656";
		sellCalcVo2.allocId = "A20220325094351536";
		sellCalcVo2.finishYn = "N";
		sellCalcVo2.allocDate = "03.15";
		sellCalcVo2.eDate = "03.15";
		sellCalcVo2.sAddr = "전라북도 군산시 소룡동 1669-2 이스턴물류";
		sellCalcVo2.eAddr = "전라북도 군산시 오식도동 806-3 한성필하우스";
		sellCalcVo2.unpaidAmt = 3200;
		sellCalcVo2.sellCharge = 200;
		sellCalcVo2.sellWayPointCharge = 3000;
		sellCalcVo2.sellStayCharge = 0;
		sellCalcVo2.sellHandWorkCharge = 0;
		sellCalcVo2.sellRoundCharge = 0;
		sellCalcVo2.sellOtherAddCharge = 0;
		sellCalcVo2.goodsName = "테스트화물3.14.1번";
		sellCalcVo2.unitPriceTypeName = "대당단가";
		sellCalcVo2.unitPrice = 0;
		sellCalcVo2.goodsWeight = 0;
		sellCalcVo2.chargeTypeName = "인수증";
		sellCalcVo2.allocFee = 0;
		sellCalcVo2.tranReceiptYn = "Y";
		sellCalcVo2.tranReceiptDate = "03.15";
		sellCalcVo2.payableAmt = 8865;
		sellCalcVo2.carNum = "인천99아9999";
		sellCalcVo2.carSctnName = "외부용차";
		sellCalcVo2.driverName = "김진";
		sellCalcVo2.driverMobile = "01000000000";
		sellCalcVo2.reqPayYn = "N";
		sellCalcVo2.mngDeptName = "[관리팀]";
		sellCalcVo2.mngUserName = "김진";
		sellCalcVo2.taxInvYn = "E";
		sellCalcVo2.taxInvDate = "03.16";
		
		List<SellCalcVO> sellCalcList = new ArrayList<>();
		sellCalcList.add(sellCalcVo1);
		sellCalcList.add(sellCalcVo2);
		int count = calcService.getCnt(param);

		map.put("result", Boolean.TRUE);
		map.put("data", sellCalcList);
		map.put("total", count);
		*/
		
		return "jsonView";
	}
	
	@PostMapping(value = "/contents/calc/data/updatePostSendYn.do")
	public String updatePostSendYn(HttpServletRequest request, Model model, ModelMap map, HttpSession session,
			@RequestParam Map<String, Object> param) throws Exception {
		
		// 권한 체크???
		
		LinkMessage linkMessage = new LinkMessage();
		try {
			List<String> orderIdList = Arrays.asList(((String)param.get("orderIdList")).split(","));
			List<String> allocIdList = Arrays.asList(((String)param.get("allocIdList")).split(","));
			
			param.put("orderIdList", orderIdList);
			param.put("allocIdList", allocIdList);
			
			int resultCnt = sellCalcService.updatePostSendYn(param);
			
			// 결과값
			linkMessage.setSender(this.getClass().getName());
			linkMessage.setStatus(0);
			linkMessage.setMessage(resultCnt + " 건에 대해 우편발송 처리를 완료했습니다.");
		} catch (Exception e) {
			linkMessage.setSender(this.getClass().getName());
			linkMessage.setStatus(-1);
			linkMessage.setMessage("우편발송 처리에 실패했습니다.\n시스템 관리자에게 문의하세요.");
			linkMessage.setDetailMessage(e.getMessage());
		}
		
		map.clear();
		map.put("linkMessage", linkMessage);
		
		return "jsonView";
	}
	
	@PostMapping(value = "/contents/calc/data/updateDeleteYn.do")
	public String updateDeleteYn(HttpServletRequest request, Model model, ModelMap map, HttpSession session,
			@RequestParam Map<String, Object> param) throws Exception {
		
		// 권한 체크???
		
		LinkMessage linkMessage = new LinkMessage();
		try {
			// String -> Iterator로 변환
			List<String> orderIdList = Arrays.asList(((String)param.get("orderIdList")).split(","));
			List<String> allocIdList = Arrays.asList(((String)param.get("allocIdList")).split(","));
			
			param.put("orderIdList", orderIdList);
			param.put("allocIdList", allocIdList);
			
			int resultCnt = sellCalcService.updateDeleteYn(param);
			
			// 결과값
			linkMessage.setSender(this.getClass().getName());
			linkMessage.setStatus(0);
			linkMessage.setMessage(resultCnt + " 건에 대해 삭제 처리를 완료했습니다.");
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
	
	@PostMapping(value="/contents/calc/data/updateSellChangeReq.do")
	public String updateSellChangeReq(HttpServletRequest request, Model model, ModelMap map, HttpSession session,
								@RequestParam Map<String, Object> param ) throws Exception {
		
		// 권한 체크???
		
		LinkMessage linkMessage = new LinkMessage();
		try {
			
			sellCalcService.updateSellChangeReq(param);
			
			// 결과값
			if (param.get("retCode") != null && param.get("retCode") == "00") {
				// 처리성공
				linkMessage.setSender(this.getClass().getName());
				linkMessage.setStatus(0);
				linkMessage.setMessage(param.get("retMsg").toString());
			} else {
				// 처리실패
				linkMessage.setSender(this.getClass().getName());
				linkMessage.setStatus(1);
				linkMessage.setMessage(param.get("retMsg").toString());
			}
		} catch (Exception e) {
			linkMessage.setSender(this.getClass().getName());
			linkMessage.setStatus(-1);
			linkMessage.setMessage("화주 변경 처리에 실패했습니다.\n시스템 관리자에게 문의하세요.");
			linkMessage.setDetailMessage(e.getMessage());
		}
		
		
		
		return "jsonView";
	}
	
	@PostMapping(value="/contents/calc/data/upsertCalcCharge.do")
	public String upsertCalcCharge(HttpServletRequest request, Model model, ModelMap map, HttpSession session,
								@RequestParam Map<String, Object> param ) throws Exception {
		
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
				parameter.put("sellBuySctn", "01");
				parameter.put("mode", "N");
			} else {
				parameter.put("sellBuySctn", "01");
				parameter.put("mode", "E");
			}
			
			LinkMessage linkMessage = new LinkMessage();
			try {
				sellCalcService.upsertCalcCharge(parameter);
				
				linkMessage.setSender(this.getClass().getName());
				linkMessage.setStatus(0);
				linkMessage.setMessage(parameter.get("retMsg").toString());
				
				linkMessages.add(linkMessage);
			} catch (Exception e) {
				linkMessage.setSender(this.getClass().getName());
				linkMessage.setStatus(-1);
				linkMessage.setMessage("오더ID: " + item.get("orderId") + "에 대한 청구 운송비 변경 처리에 실패했습니다.\n다시 확인하세요.");
				linkMessage.setDetailMessage(e.getMessage());
				
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
	
//	@PostMapping(value="/contents/calc/data/sellFinishCalc.do")
//	public String multiFinishCalc(HttpServletRequest request, Model model, ModelMap map, HttpSession session,
//								@RequestParam Map<String, Object> param ) throws Exception {
//		
//		// 권한 체크???
//
//		LoginVO login = (LoginVO) session.getAttribute("userInfo");
//		if("N".equals(login.getMasterYn())) {
//			param.put("mngDeptId", login.getDeptId());
//		} else {
//			param.put("mngDeptId", param.get("sDeptId"));
//		}
//		
//		
//		/*List<String> calcIdList = Arrays.asList(((String)param.get("calcIdArr")).split(","));
//		param.put("calcIdList", calcIdList);*/
////		calcService.multiFinishCalc(param);
//
//		if(!"00".equals(param.get("retCode"))) {
//			map.put("result", Boolean.FALSE);
//			map.put("msg", param.get("retMsg"));
//		} else {
//			map.put("result", Boolean.TRUE);
//			map.put("msg", param.get("retMsg"));
//		}
//		
//		return "jsonView";
//		
//	}
}
