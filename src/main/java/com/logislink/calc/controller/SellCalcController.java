package com.logislink.calc.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.logislink.calc.service.SellCalcService;
import com.logislink.calc.service.TaxService;
import com.logislink.calc.service.TranService;
import com.logislink.calc.vo.SellCalcVO;
import com.logislink.cmm.LinkMessage;
import com.logislink.cmm.LinkMessageData;
import com.logislink.cmm.util.EtcUtil;
import com.logislink.login.vo.LoginMenuVO;
import com.logislink.login.vo.LoginVO;

@Controller
public class SellCalcController {
	private Logger logger = Logger.getLogger(this.getClass());
	private String menuCode = "C3120";

	@Resource(name = "sellCalcService")
	private SellCalcService sellCalcService;
	@Resource(name = "tranService")
	private TranService tranService;
	@Resource(name = "taxService")
	private TaxService taxService;
	
	@Value("#{globalProperties['Globals.brokerCustId']}")
    private String brokerCustId;
	@Value("#{globalProperties['Globals.brokerDeptId']}")
	private String brokerDeptId;
	@Value("#{globalProperties['Globals.brokerBizNo']}")
	private String brokerBizNo;
	@Value("#{globalProperties['Globals.brokerBizType']}")
	private String brokerBizType;
	@Value("#{globalProperties['Globals.brokerBizName']}")
	private String brokerBizName;
	@Value("#{globalProperties['Globals.brokerBizClass']}")
	private String brokerBizClass;
	@Value("#{globalProperties['Globals.brokerBizSubNo']}")
	private String brokerBizSubNo;
	@Value("#{globalProperties['Globals.brokerCeo']}")
	private String brokerCeo;
	@Value("#{globalProperties['Globals.brokerMemDept']}")
	private String brokerMemDept;
	@Value("#{globalProperties['Globals.brokerMemName']}")
	private String brokerMemName;
	@Value("#{globalProperties['Globals.brokerMemEmail']}")
	private String brokerMemEmail;
	@Value("#{globalProperties['Globals.brokerMemTel']}")
	private String brokerMemTel;
	@Value("#{globalProperties['Globals.brokerAddr']}")
	private String brokerAddr;

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
		if (login.getMasterYn().equals("N")) {
			param.put("mngDeptId", login.getDeptId());
		} else {
			param.put("mngDeptId", param.get("sDeptId"));
		}

		// param.put("mngDeptId", login.getDeptId());

		List<SellCalcVO> sellCalcList = sellCalcService.getSellCalcList(param);
		Map<String, Object> sellCalcListCnt = sellCalcService.getSellCalcListCnt(param);

		map.put("result", Boolean.TRUE);
		map.put("data", sellCalcList);
		map.put("total", sellCalcListCnt.get("sellCalcListCnt"));
		map.put("sumUnpaidAmt", sellCalcListCnt.get("sumUnpaidAmt"));
		map.put("sumDepositAmt", sellCalcListCnt.get("sumDepositAmt"));
		
		return "jsonView";
	}
	
	@PostMapping(value = "/contents/calc/data/getTaxBizInfo.do")
	public String getTaxBizInfo(HttpServletRequest request, Model model, ModelMap map, HttpSession session, @RequestParam Map<String, Object> param) {
		LinkMessage linkMessage = new LinkMessage();
		try {
			
			Map<String, Object> supplierTaxBizInfo = sellCalcService.selectTaxBizInfo(param);
			
			// 결과값
			linkMessage.setSender(this.getClass().getName());
			linkMessage.setStatus(0);
			LinkMessageData linkMessageData = new LinkMessageData();
			linkMessageData.setData(supplierTaxBizInfo);
			linkMessageData.setDataType("Map");
			linkMessage.setData(linkMessageData);
		} catch (Exception e) {
			linkMessage.setSender(this.getClass().getName());
			linkMessage.setStatus(-1);
			linkMessage.setMessage(e.getMessage());
		}
		
		map.clear();
		map.put("linkMessage", linkMessage);
		
		return "jsonView";
	}
	
	@PostMapping(value = "/contents/calc/data/getSupplierTaxBizInfo.do")
	public String getSupplierTaxBizInfo(HttpServletRequest request, Model model, ModelMap map, HttpSession session, @RequestParam Map<String, Object> param) {
		
		LinkMessage linkMessage = new LinkMessage();
		try {
			
			Map<String, Object> supplierTaxBizInfo = sellCalcService.selectSupplierTaxBizInfo(param);
			
			// 결과값
			linkMessage.setSender(this.getClass().getName());
			linkMessage.setStatus(0);
			LinkMessageData linkMessageData = new LinkMessageData();
			linkMessageData.setData(supplierTaxBizInfo);
			linkMessageData.setDataType("Map");
			linkMessage.setData(linkMessageData);
		} catch (Exception e) {
			linkMessage.setSender(this.getClass().getName());
			linkMessage.setStatus(-1);
			linkMessage.setMessage(e.getMessage());
		}
		
		map.clear();
		map.put("linkMessage", linkMessage);
		
		return "jsonView";
	}
	
	@PostMapping(value = "/contents/calc/data/getBuyerTaxBizInfo.do")
	public String getBuyerTaxBizInfo(HttpServletRequest request, Model model, ModelMap map, HttpSession session, @RequestParam Map<String, Object> param) {
		
		LinkMessage linkMessage = new LinkMessage();
		try {
			
			Map<String, Object> buyerTaxBizInfo = sellCalcService.selectBuyerTaxBizInfo(param);
			
			// 결과값
			linkMessage.setSender(this.getClass().getName());
			linkMessage.setStatus(0);
			LinkMessageData linkMessageData = new LinkMessageData();
			linkMessageData.setData(buyerTaxBizInfo);
			linkMessageData.setDataType("Map");
			linkMessage.setData(linkMessageData);
		} catch (Exception e) {
			linkMessage.setSender(this.getClass().getName());
			linkMessage.setStatus(-1);
			linkMessage.setMessage(e.getMessage());
		}
		
		map.clear();
		map.put("linkMessage", linkMessage);
		
		return "jsonView";
	}
	
	@PostMapping(value = "/contents/calc/data/getSupplierTaxDriverInfo.do")
	public String getSupplierTaxDriverInfo(HttpServletRequest request, Model model, ModelMap map, HttpSession session, @RequestParam Map<String, Object> param) {
		
		LinkMessage linkMessage = new LinkMessage();
		try {
			
			Map<String, Object> supplierTaxDriverInfo = sellCalcService.selectSupplierTaxDriverInfo(param);
			
			// 결과값
			linkMessage.setSender(this.getClass().getName());
			linkMessage.setStatus(0);
			LinkMessageData linkMessageData = new LinkMessageData();
			linkMessageData.setData(supplierTaxDriverInfo);
			linkMessageData.setDataType("Map");
			linkMessage.setData(linkMessageData);
		} catch (Exception e) {
			linkMessage.setSender(this.getClass().getName());
			linkMessage.setStatus(-1);
			linkMessage.setMessage(e.getMessage());
		}
		
		map.clear();
		map.put("linkMessage", linkMessage);
		
		return "jsonView";
	}
	
	@PostMapping(value = "/contents/calc/data/updatePostSendYn.do")
	public String updatePostSendYn(HttpServletRequest request, Model model, ModelMap map, HttpSession session,
			@RequestParam Map<String, Object> param) {
		
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
			if (param.get("postSendYn").equals("Y"))
				linkMessage.setMessage("우편발송 처리를 완료했습니다.");
			else
				linkMessage.setMessage("우편발송 취소 처리를 완료했습니다.");
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
	
	@PostMapping(value = "/contents/calc/data/updateSellCalcDeleteYn.do")
	public String updateDeleteYn(HttpServletRequest request, Model model, ModelMap map, HttpSession session,
			@RequestParam Map<String, Object> param) {
		
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
			if (param.get("deleteYn").equals("Y"))
				linkMessage.setMessage("삭제 처리를 완료했습니다.");
			else
				linkMessage.setMessage("삭제 취소 처리를 완료했습니다.");
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
								@RequestParam Map<String, Object> param ) {
		
		// 권한 체크???
		
		LinkMessage linkMessage = new LinkMessage();
		try {
			
			sellCalcService.updateSellChangeReq(param);
			
			// 결과값
			if (param.get("retCode") != null && param.get("retCode").equals("00")) {
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
		
		map.clear();
		map.put("linkMessage", linkMessage);
		
		return "jsonView";
	}
	
	@PostMapping(value="/contents/calc/data/setSellCalcCharge.do")
	public String setSellCalcCharge(HttpServletRequest request, Model model, ModelMap map, HttpSession session, @RequestParam Map<String, Object> param) throws Exception {
		
		// 권한 체크???
		
		String json = param.get("params").toString();
	    ObjectMapper mapper = new ObjectMapper();
	    List<Map<String, Object>> editedList = mapper.readValue(json, new TypeReference<ArrayList<Map<String, Object>>>(){});
		
	    List<LinkMessage> linkMessages = new ArrayList<>();
		for (Map<String, Object> item : editedList) {
//			String calcTypeCode = (String) item.get("chargeCode");
//			if (calcTypeCode.equals("0002")) {
//				// 내수운송료의 경우 T_ORDER_ALLOC 테이블 정보도 업데이트
//				Map<String, Object> parameter = new HashMap<String, Object>();
//				parameter.put("allocId", item.get("allocId"));
//				parameter.put("allocCharge", item.get("value"));
//				
//				LinkMessage linkMessage = new LinkMessage();
//				try {
//					int resultCnt = sellCalcService.updateAllocCharge(parameter);
//					
//					// 별도 메시지 출력 안함.
//					System.out.println(parameter.get("retCode").toString());
//					System.out.println(parameter.get("retMsg").toString());
//				} catch (Exception e) {
//					linkMessage.setSender(this.getClass().getName());
//					linkMessage.setStatus(-1);
//					linkMessage.setMessage("오더ID: " + item.get("orderId") + "에 대한 내수운송료 변경 처리에 실패했습니다.\n다시 확인하세요.");
//					linkMessage.setDetailMessage(e.getMessage());
//					
//					LinkMessageData linkMesasgeData = new LinkMessageData();
//					linkMesasgeData.setData(item);
//					linkMesasgeData.setDataType("Map<String, Object>");
//					linkMessage.setData(linkMesasgeData);
//					
//					linkMessages.add(linkMessage);
//				}
//			}
			
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
				parameter.put("mode", "C");
			} else {
				parameter.put("sellBuySctn", "01");
				parameter.put("mode", "U");
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
	
	@PostMapping(value="/contents/calc/data/updateSellCalcFinish.do")
	public String updateSellCalcFinish(HttpServletRequest request, Model model, ModelMap map, HttpSession session, @RequestParam Map<String, Object> param) {
		
		// 권한 체크???

		// mngDeptId 조건 반드시 확인 필! -> 기존 항목에 mngDeptId를 따라야 함?
//		LoginVO login = (LoginVO) session.getAttribute("userInfo");
//		if("N".equals(login.getMasterYn())) {
//			param.put("mngDeptId", login.getDeptId());
//		} else {
//			param.put("mngDeptId", param.get("sDeptId"));
//		}
		
		param.put("editId", ((LoginVO) session.getAttribute("userInfo")).getUserId());
		
		LinkMessage linkMessage = new LinkMessage();
		try {
			sellCalcService.updateSellCalcFinish(param);
			
			linkMessage.setSender(this.getClass().getName());
			linkMessage.setStatus(0);
			linkMessage.setMessage(param.get("retMsg").toString());
		} catch (Exception e) {
			linkMessage.setSender(this.getClass().getName());
			linkMessage.setStatus(-1);
			linkMessage.setMessage("마감처리에 실패했습니다.\n시스템 관리자에게 문의하세요.");
			linkMessage.setDetailMessage(e.getMessage());
		}
		
		map.clear();
		map.put("linkMessage", linkMessage);
		
		return "jsonView";
	}
	
	@PostMapping(value="/contents/calc/data/updateSellCalcPayFinish.do")
	public String updateSellCalcPayFinish(HttpServletRequest request, Model model, ModelMap map, HttpSession session, @RequestParam Map<String, Object> param) {
		
		// 권한 체크???

		// mngDeptId 조건 반드시 확인 필! -> 기존 항목에 mngDeptId를 따라야 함?
//		LoginVO login = (LoginVO) session.getAttribute("userInfo");
//		if("N".equals(login.getMasterYn())) {
//			param.put("mngDeptId", login.getDeptId());
//		} else {
//			param.put("mngDeptId", param.get("sDeptId"));
//		}
		
		param.put("editId", ((LoginVO) session.getAttribute("userInfo")).getUserId());
		
		LinkMessage linkMessage = new LinkMessage();
		try {
			sellCalcService.updateSellCalcPayFinish(param);
			
			linkMessage.setSender(this.getClass().getName());
			linkMessage.setStatus(0);
			linkMessage.setMessage(param.get("retMsg").toString());
		} catch (Exception e) {
			linkMessage.setSender(this.getClass().getName());
			linkMessage.setStatus(-1);
			linkMessage.setMessage("입금확인 처리에 실패했습니다.\n시스템 관리자에게 문의하세요.");
			linkMessage.setDetailMessage(e.getMessage());
		}
		
		map.clear();
		map.put("linkMessage", linkMessage);
		
		return "jsonView";
	}
	
//	@PostMapping(value="/contents/calc/data/setTranReceipt.do")
//	public String setTranReceipt(HttpServletRequest request, Model model, ModelMap map, HttpSession session, @RequestParam Map<String, Object> param) {
//		
//		LoginVO login = (LoginVO) session.getAttribute("userInfo");
//		if(login.getMasterYn().equals("N")) {
//			param.put("mngDeptId", login.getDeptId());
//		} else {
//			param.put("mngDeptId", param.get("mngDeptId"));
//		}
//		
//		return "jsonView";
//	}
	
	@PostMapping(value="/contents/calc/data/setTranReceiptWithTaxinv.do")
	public String setTranReceiptWithTaxinv(HttpServletRequest request, Model model, ModelMap map, HttpSession session, @RequestParam Map<String, Object> param) {
		
		// 마스터 권한의 유저인지 체크 (???)
		LoginVO login = (LoginVO) session.getAttribute("userInfo");
		if (login.getMasterYn().equals("N")) {
			param.put("mngDeptId", login.getDeptId());
		} else {
			param.put("mngDeptId", param.get("mngDeptId"));
		}
		
		String taxYn = param.get("taxYn").toString();
		String tranMode = param.get("tranMode").toString();
		String writeDate = param.get("taxDate").toString();
		param.put("writeDate", writeDate);
		
		LinkMessage linkMessage = new LinkMessage();
		try {
			// 거래명세서 발행용 리스트 -> 이미 완료된 건은 제외
			String tranReceiptOrderList = "";
			
			// 거래명세서 발행 기간 설정
			Date minAllocDate = null;
			Date maxAllocDate = null;
			
			// 오더리스트
			String json = param.get("orderList").toString();
			ObjectMapper mapper = new ObjectMapper();
			List<Map<String, Object>> orderList = mapper.readValue(json, new TypeReference<ArrayList<Map<String, Object>>>(){});
			for (Map<String, Object> item : orderList) {
				// 이미 완료된 건 제외
//				if (item.get("tranReceiptYn").equals("N")) {
//					tranReceiptOrderList += item.get("orderId").toString() + ",";
//				}
				tranReceiptOrderList += item.get("orderId").toString() + ",";
				
				// 배차일자로 검색 범위 설정 
				String sAllocDate = item.get("allocDateFull").toString();
				if (sAllocDate != null && sAllocDate != "") {
					Date dAllocDate = new SimpleDateFormat("yyyy-MM-dd").parse(sAllocDate);
					if (minAllocDate == null || maxAllocDate == null) {
						minAllocDate = dAllocDate;
						maxAllocDate = dAllocDate;
					} else {
						if (dAllocDate.compareTo(minAllocDate) < 0)
							minAllocDate = dAllocDate;
						if (dAllocDate.compareTo(maxAllocDate) > 0)
							maxAllocDate = dAllocDate;
					}
				}
			}
			
			// fromDate, toDate 설정
			if (minAllocDate != null && maxAllocDate != null) {
				String sDate = new SimpleDateFormat("yyyy-MM-dd").format(minAllocDate);
				String eDate = new SimpleDateFormat("yyyy-MM-dd").format(maxAllocDate);
				param.put("fromDate", sDate);
				param.put("toDate", eDate);
			} else {
				// 검색 범위를 임의로 설정
				String sDate = "2020-01-01";
				String eDate = "2025-12-30";
				param.put("fromDate", sDate);
				param.put("toDate", eDate);
			}
			
			tranReceiptOrderList = tranReceiptOrderList.substring(0, tranReceiptOrderList.length() - 1);
			param.put("orderList", tranReceiptOrderList);
			
			// 세금계산서 연계 발행
			if (taxYn.equals("Y")) {
				// 인수증
				if (tranMode.equals("R")) {
					// 거래명세서 발행
					tranService.regTranReceipt(param);
					// 결과
					if (param.get("retCode").equals("00")) {
						// 세금계산서 발행
						param.put("receiptId", param.get("retId"));
						
						//공급자와 위탁자 사업자가 같으면 일반세금계산서, 다르면 위수탁
//						String supplierCustId = param.get("supplierCustId").toString();
						String supplierCustId = login.getCustId();
						if (supplierCustId.equals(brokerCustId)) {
							// 1: 일반
							param.put("billKind", "1");
							// 01: 일반
							param.put("docType", "01");
						} else {
							// 3: 위수탁
							param.put("billKind", "3");
							// 03: 위수탁
							param.put("docType", "03");
						}
						
						param.put("brokerCustId", brokerCustId);
						param.put("brokerDeptId", brokerDeptId);
						param.put("brokerBizNo", brokerBizNo);
						param.put("brokerBizType", brokerBizType);
						param.put("brokerBizName", brokerBizName);
						param.put("brokerBizClass", brokerBizClass);
						param.put("brokerBizSubNo", brokerBizSubNo);
						param.put("brokerCeo", brokerCeo);
						param.put("brokerMemDept", brokerMemDept);
						param.put("brokerMemName", brokerMemName);
						param.put("brokerMemEmail", brokerMemEmail);
						param.put("brokerMemTel", brokerMemTel);
						param.put("brokerAddr", brokerAddr);
						
						// 세금계산서 발행 시 작성일 포맷 변경 
						writeDate = writeDate.replace("-", "");
						param.put("writeDate", writeDate);
						
						taxService.insertReceiptTaxInvoice(param);
						// 결과
						if (param.get("retCode").equals("00")) {
							linkMessage.setSender(this.getClass().getName());
							linkMessage.setStatus(0);
							linkMessage.setMessage(param.get("retMsg").toString());
						} else {
							// 세금계산서 발행 실패
							linkMessage.setSender(this.getClass().getName());
							linkMessage.setStatus(-1);
							linkMessage.setMessage("세금계산서 발행에 실패했습니다.");
							linkMessage.setDetailMessage(param.get("retMsg").toString());
						}
					} else {
						// 거래명세서 발행 실패
						linkMessage.setSender(this.getClass().getName());
						linkMessage.setStatus(-1);
						linkMessage.setMessage("거래명세서 발행에 실패했습니다.");
						linkMessage.setDetailMessage(param.get("retMsg").toString());
					}
				} else {
					// 거래명세서 발행
					tranService.regTranReceiptForDriver(param);
					// 결과
					if (param.get("retCode").equals("00")) {
						// 세금계산서 발행
						param.put("receiptId", param.get("retId"));
						
						//공급자와 위탁자 사업자가 같으면 일반세금계산서, 다르면 위수탁
//						String supplierCustId = param.get("supplierCustId").toString();
						String supplierCustId = login.getCustId();
						if (supplierCustId.equals(brokerCustId)) {
							// 1: 일반
							param.put("billKind", "1");
							// 01: 일반
							param.put("docType", "01");
						} else {
							// 3: 위수탁
							param.put("billKind", "3");
							// 03: 위수탁
							param.put("docType", "03");
						}
						
						param.put("brokerCustId", brokerCustId);
						param.put("brokerDeptId", brokerDeptId);
						param.put("brokerBizNo", brokerBizNo);
						param.put("brokerBizType", brokerBizType);
						param.put("brokerBizName", brokerBizName);
						param.put("brokerBizClass", brokerBizClass);
						param.put("brokerBizSubNo", brokerBizSubNo);
						param.put("brokerCeo", brokerCeo);
						param.put("brokerMemDept", brokerMemDept);
						param.put("brokerMemName", brokerMemName);
						param.put("brokerMemEmail", brokerMemEmail);
						param.put("brokerMemTel", brokerMemTel);
						param.put("brokerAddr", brokerAddr);
						
						// 세금계산서 발행 시 작성일 포맷 변경 
						writeDate = writeDate.replace("-", "");
						param.put("writeDate", writeDate);
						
						taxService.insertReceiptTaxInvoiceForDriver(param);
						// 결과
						if (param.get("retCode").equals("00")) {
							linkMessage.setSender(this.getClass().getName());
							linkMessage.setStatus(0);
							linkMessage.setMessage(param.get("retMsg").toString());
						} else {
							// 세금계산서 발행 실패
							linkMessage.setSender(this.getClass().getName());
							linkMessage.setStatus(-1);
							linkMessage.setMessage("세금계산서 발행에 실패했습니다.");
							linkMessage.setDetailMessage(param.get("retMsg").toString());
						}
					} else {
						// 거래명세서 발행 실패
						linkMessage.setSender(this.getClass().getName());
						linkMessage.setStatus(-1);
						linkMessage.setMessage("거래명세서 발행에 실패했습니다.");
						linkMessage.setDetailMessage(param.get("retMsg").toString());
					}
				}
			} else {
				if (tranMode.equals("R")) {
					// 인수증
					tranService.regTranReceipt(param);
					
					// 결과
					if (param.get("retCode").equals("00")) {
						linkMessage.setSender(this.getClass().getName());
						linkMessage.setStatus(0);
						linkMessage.setMessage(param.get("retMsg").toString());
					} else {
						// 거래명세서 발행 실패
						linkMessage.setSender(this.getClass().getName());
						linkMessage.setStatus(-1);
						linkMessage.setMessage("거래명세서 발행에 실패했습니다.");
						linkMessage.setDetailMessage(param.get("retMsg").toString());
					}
				} else {
					// 기사발행
					tranService.regTranReceiptForDriver(param);
					
					// 결과
					if (param.get("retCode").equals("00")) {
						linkMessage.setSender(this.getClass().getName());
						linkMessage.setStatus(0);
						linkMessage.setMessage(param.get("retMsg").toString());
					} else {
						// 거래명세서 발행 실패
						linkMessage.setSender(this.getClass().getName());
						linkMessage.setStatus(-1);
						linkMessage.setMessage("거래명세서 발행에 실패했습니다.");
						linkMessage.setDetailMessage(param.get("retMsg").toString());
					}
				}
			}
		} catch (Exception e) {
			linkMessage.setSender(this.getClass().getName());
			linkMessage.setStatus(-1);
			linkMessage.setMessage("알수없는 오류입니다.\n시스템 관리자에게 문의하세요.");
			linkMessage.setDetailMessage(e.getMessage());
		}
		
		map.clear();
		map.put("linkMessage", linkMessage);
		
		return "jsonView";
	}
}
