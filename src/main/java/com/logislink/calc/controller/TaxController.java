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
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.logislink.calc.service.TaxService;
import com.logislink.calc.vo.TaxVO;
import com.logislink.cmm.util.EtcUtil;
import com.logislink.login.vo.LoginMenuVO;
import com.logislink.login.vo.LoginVO;

@Controller
public class TaxController {
	private Logger log = Logger.getLogger(this.getClass());

	private String taxCode = "C3310";
	
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
	
	@Resource(name="taxService")
	private TaxService taxService;
	
	@GetMapping(value="/contents/calc/taxList.do")
	public String getTaxList(HttpServletRequest request, HttpSession session, ModelMap model) {

		LoginMenuVO loginMenu = EtcUtil.checkAuth(request, taxCode);		
		model.put("menuAuth", loginMenu);
		model.put("brokerCustId", brokerCustId);
		
		return "contents/calc/taxList";
	}
	
	@PostMapping(value="/contents/tax/data/taxList.do")
	public String taxListData(HttpServletRequest request, Model model, ModelMap map, HttpSession session,
								@RequestParam Map<String, Object> param) throws Exception {
		
		//작성일자 검색시 데이터 형식 변경 
		String strFromDate = param.get("fromDate").toString();
		String strToDate = param.get("toDate").toString();
		
		param.put("fromDate", strFromDate.replace("-", ""));
		param.put("toDate", strToDate.replace("-", ""));
		
		List<TaxVO> taxList = taxService.getTaxInvoice(param);
		int count = taxService.getTaxInvoiceCnt(param);
		
		map.put("result", Boolean.TRUE);
		map.put("data", taxList);
		map.put("total", count);
		
		return "jsonView";
	}
	
	@GetMapping(value="/cmm/taxPrint.do")
	public String taxPrint(HttpServletRequest request, HttpSession session, ModelMap model) {
		return "cmm/taxPrint";
	}
	
	@PostMapping(value="/contents/tax/data/getTaxBizInfo.do")
	public String taxBizInfo(HttpServletRequest request, Model model, ModelMap map, HttpSession session,
								@RequestParam Map<String, Object> param ) throws Exception {
		
		if("01".equals((String)param.get("sellBuySctn"))) {
			param.put("supplierCustId", ((LoginVO) session.getAttribute("userInfo")).getCustId());
			param.put("supplierDeptId", ((LoginVO) session.getAttribute("userInfo")).getDeptId());
			param.put("buyerCustId", param.get("custId"));
			param.put("buyerDeptId", param.get("deptId"));
		} else {
			param.put("supplierCustId", param.get("custId"));
			param.put("supplierDeptId", param.get("deptId"));
			param.put("buyerCustId", ((LoginVO) session.getAttribute("userInfo")).getCustId());
			param.put("buyerDeptId", ((LoginVO) session.getAttribute("userInfo")).getDeptId());
		}
		
		TaxVO taxInfo = taxService.getTaxBizInfo(param);
		
		map.put("result", Boolean.TRUE);
		map.put("data", taxInfo);
		
		return "jsonView";
		
	}
	
	@PostMapping(value="/contents/tax/data/insertTaxInvoice.do")
	public String insertTaxInvoice(HttpServletRequest request, Model model, ModelMap map, HttpSession session,
								@RequestParam Map<String, Object> param ) throws Exception {
		
		LoginVO login = (LoginVO) session.getAttribute("userInfo");
		param.put("docAttr", "N");		//N: 신규발급
		param.put("docClass", "01");	//01: 세금계산서, 02:수정세금계산서
		param.put("loadStatus", "0");	//전송데이터 상태 0:미전송
		
		if(param.get("supplierCustId").equals(login.getCustId())) {	//공급자와 로그인한 사업자가 같으면 매출 세금계산서
			param.put("pubType", "S");
		} else {
			param.put("pubType", "R");
		}
		
		if (param.get("supplierCustId").equals(brokerCustId)) {	//공급자와 위탁자 사업자가 같으면 일반세금계산서, 다르면 위수탁
			param.put("billKind", "1");		//1: 일반, 3:위수탁
			param.put("docType", "01");		//03: 일반위수탁
		} else {
			param.put("billKind", "3");		//1: 일반, 3:위수탁
			param.put("docType", "03");		//03: 일반위수탁
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
		
		String jsonParam = String.valueOf(param.get("items"));
		
		ObjectMapper objectMapper = new ObjectMapper();
		List<Map<String, Object>> readValue = objectMapper.readValue(jsonParam, new TypeReference<List<Map<String, Object>>>(){});
				
		List<Map<String, Object>> items = new ArrayList<>();
		
		for(Map<String, Object> obj : readValue) {

			Map<String, Object> data  = new HashMap<>();
			
			data.put("seq", obj.get("seq"));
			data.put("itemRemarks", obj.get("itemRemarks"));
			data.put("itemSupprice", obj.get("itemSupprice"));
			data.put("itemQty", obj.get("itemQty"));
			data.put("itemType", obj.get("itemType"));
			data.put("itemName", obj.get("itemName"));
			data.put("itemDate", obj.get("itemDate"));
			data.put("itemTax", obj.get("itemTax"));
			data.put("itemPrice", obj.get("itemPrice"));
			data.put("orderId", obj.get("orderId"));
			data.put("allocId", obj.get("allocId"));
			
			items.add(data);
		}
		
		param.put("items", items);
		
		taxService.insertTaxInvoice(param);
		if(param.get("invId").equals("")) {
			taxService.insertTaxInvoiceDetail(param);
		}else {
			taxService.updateTaxInvoiceDetail(param);
		}
		
		map.put("result", Boolean.TRUE);
		map.put("retMsg", param.get("retMsg"));
		
		return "jsonView";
		
	}
	
	/*
	 * 일반 세금계산서 -> 전자세금계산서로 변환 (스마트빌에 발행 요청)
	 */
	@PostMapping(value="/contents/tax/data/issueEtax.do")
	public String requestETax(HttpServletRequest request, Model model, ModelMap map, HttpSession session,
			@RequestParam Map<String, Object> param ) throws Exception {
		if(!EtcUtil.checkAuth(request, taxCode, "E")) {
			map.put("result", Boolean.FALSE);
			map.put("msg", "해당 권한이 없습니다.");
			
			return "jsonView";
		}
		
		param.put("loadStatus", "1");	//전송데이터 상태 0:미전송
		
		List<String> multiSelectedData = Arrays.asList(((String)param.get("multiSelectedData")).split(","));
		param.put("multiSelectedData", multiSelectedData);
		
		taxService.updateLoadStatus(param);
		taxService.insertTaxInvoiceMonitor(param);
		
		map.put("result", Boolean.TRUE);
		map.put("retMsg", "전자발행 되었습니다.");
		
		return "jsonView";
	}
	
	@PostMapping(value="/contents/tax/data/getTaxXml.do")
	public String taxXmlData (HttpServletRequest request, Model model, ModelMap map, HttpSession session,
			@RequestParam Map<String, Object> param ) throws Exception {
		
		Map<String, Object> data = taxService.getTaxSendXml(param);

		if(data == null) {
			map.put("result", Boolean.FALSE);
			map.put("msg", "조회된 데이터가 없습니다.");
		} else {
			map.put("result", Boolean.TRUE);
			map.put("data", data);
		}
		
		return "jsonView";
	}
	
	@PostMapping(value="/contents/tax/data/taxStatus.do")
	public String taxCancle (HttpServletRequest request, Model model, ModelMap map, HttpSession session,
			@RequestParam Map<String, Object> param ) throws Exception {
		
		taxService.taxStatus(param);

		map.put("result", Boolean.TRUE);
		map.put("msg", "세금계산서 상태변경을 요청했습니다.");
		
		return "jsonView";
	}

	@PostMapping(value="/contents/tax/data/taxResend.do")
	public String taxResend (HttpServletRequest request, Model model, ModelMap map, HttpSession session,
			@RequestParam Map<String, Object> param ) throws Exception {
		
		param.put("invId", param.get("rInvId"));
		param.put("email", param.get("resendEmail"));
		taxService.taxResend(param);

		map.put("result", Boolean.TRUE);
		map.put("msg", "이메일 재전송 되었습니다.");
		
		return "jsonView";
	}

	@PostMapping(value="/contents/tax/data/viewTaxItem.do")
	public String viewTax(HttpServletRequest request, Model model, ModelMap map, HttpSession session,
								@RequestParam Map<String, Object> param ) throws Exception {

		List<Map<String, Object>> data = taxService.viewTaxItem(param);
		
		map.put("data", data);
		
		return "jsonView";
		
	}
	
	@PostMapping(value="/contents/tax/data/insertCalcTaxInvoice.do")
	public String calcTax(HttpServletRequest request, Model model, ModelMap map, HttpSession session,
			@RequestParam Map<String, Object> param ) throws Exception {
		
		LoginVO login = (LoginVO) session.getAttribute("userInfo");
		param.put("docAttr", "N");		//N: 신규발급
		param.put("docClass", "01");	//01: 세금계산서, 02:수정세금계산서
		param.put("loadStatus", "0");	//전송데이터 상태 0:미전송
		
		if(param.get("supplierCustId").equals(login.getCustId())) {	//공급자와 로그인한 사업자가 같으면 매출 세금계산서
			param.put("pubType", "S");
		} else {
			param.put("pubType", "R");
		}
		
		if (param.get("supplierCustId").equals(brokerCustId)) {	//공급자와 위탁자 사업자가 같으면 일반세금계산서, 다르면 위수탁
			param.put("billKind", "1");		//1: 일반, 3:위수탁
			param.put("docType", "01");		//03: 일반위수탁
		} else {
			param.put("billKind", "3");		//1: 일반, 3:위수탁
			param.put("docType", "03");		//03: 일반위수탁
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
		
		String jsonParam = String.valueOf(param.get("items"));
		
		ObjectMapper objectMapper = new ObjectMapper();
		List<Map<String, Object>> readValue = objectMapper.readValue(jsonParam, new TypeReference<List<Map<String, Object>>>(){});
				
		List<Map<String, Object>> items = new ArrayList<>();
		
		for(Map<String, Object> obj : readValue) {

			Map<String, Object> data  = new HashMap<>();
			
			data.put("seq", obj.get("seq"));
			data.put("itemRemarks", obj.get("itemRemarks"));
			data.put("itemSupprice", obj.get("itemSupprice"));
			data.put("itemQty", obj.get("itemQty"));
			data.put("itemType", obj.get("itemType"));
			data.put("itemName", obj.get("itemName"));
			data.put("itemDate", obj.get("itemDate"));
			data.put("itemTax", obj.get("itemTax"));
			data.put("itemPrice", obj.get("itemPrice"));
			data.put("orderId", obj.get("orderId"));
			data.put("allocId", obj.get("allocId"));
			
			items.add(data);
		}
		
		param.put("items", items);
		
		taxService.insertCalcTaxInvoice(param);
		
		if(!"00".equals(param.get("retCode"))) {
			map.put("result", Boolean.FALSE);
			map.put("msg", param.get("retMsg"));
		} else {
			taxService.insertTaxInvoiceDetail(param);
			map.put("result", Boolean.TRUE);
			map.put("msg", param.get("retMsg"));	
		}	
		
		return "jsonView";
	}
	
	@PostMapping(value="/contents/tax/data/taxModify.do")
	public String taxModifyData(HttpServletRequest request, Model model, ModelMap map, HttpSession session,
			@RequestParam Map<String, Object> param ) throws Exception {

		taxService.insertTaxModify(param);
		
		if(!"00".equals(param.get("retCode"))) {
			map.put("result", Boolean.FALSE);
			map.put("msg", param.get("retMsg"));
		} else {
			map.put("result", Boolean.TRUE);
			map.put("msg", param.get("retMsg"));	
		}	
		
		return "jsonView";
	}
	
	@PostMapping(value="/contents/tax/data/taxDelete.do")
	public String taxDelete(HttpServletRequest request, Model model, ModelMap map, HttpSession session,
			@RequestParam Map<String, Object> param ) throws Exception {
		if(!EtcUtil.checkAuth(request, taxCode, "D")) {
			map.put("result", Boolean.FALSE);
			map.put("msg", "해당 권한이 없습니다.");
			
			return "jsonView";
		}
		
		List<String> multiSelectedData = Arrays.asList(((String)param.get("multiSelectedData")).split(","));
		param.put("multiSelectedData", multiSelectedData);
		
		taxService.deleteTaxInvoiceDetail(param);
		
		map.put("result", Boolean.TRUE);
		map.put("retMsg", "세금계산서가 삭제 되었습니다.");
		
		return "jsonView";
	}
}
