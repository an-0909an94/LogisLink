package com.logislink.calc.controller;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.logislink.calc.service.TaxService;
import com.logislink.calc.service.TranService;
import com.logislink.calc.vo.TranDtlVO;
import com.logislink.calc.vo.TranVO;
import com.logislink.cmm.util.DateUtil;
import com.logislink.cmm.util.EtcUtil;
import com.logislink.login.vo.LoginMenuVO;
import com.logislink.login.vo.LoginVO;

@Controller
public class TranController {
	private Logger log = Logger.getLogger(this.getClass());
	private String menuCode = "C3210";

	@Value("#{globalProperties['Globals.filepath']}")
	private String filepath;
	
	@Resource(name="tranService")
	private TranService tranService;
	
	@Resource(name="taxService")
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
	

	@GetMapping(value="/contents/calc/tranList.do")
	public String getTranList(HttpServletRequest request, HttpSession session, ModelMap model) {
		LoginMenuVO loginMenu = EtcUtil.checkAuth(request, menuCode);
		model.put("menuAuth", loginMenu);
		return "contents/calc/tranList";
	}
	
	@PostMapping(value="/contents/calc/data/tranList.do")
	public String tranList(HttpServletRequest request, Model model, ModelMap map, HttpSession session,
								@RequestParam Map<String, Object> param ) throws Exception {
		
		LoginVO login = (LoginVO) session.getAttribute("userInfo");
		if("N".equals(login.getMasterYn())) {
			param.put("mngDeptId", login.getDeptId());
		} else {
			param.put("mngDeptId", "");
		}
		
		
		List<TranVO> tList = tranService.selectTranList(param);
		int cnt = tranService.getCnt(param);
		
		map.put("result", Boolean.TRUE);
		map.put("total", cnt);
		map.put("data", tList);
		
		return "jsonView";
		
	}	
	
	@PostMapping(value="/contents/calc/data/tranDtlList.do")
	public String tranDtlList(HttpServletRequest request, Model model, ModelMap map, HttpSession session,
								@RequestParam Map<String, Object> param ) throws Exception {
		
		List<TranDtlVO> tList = tranService.selectTranDtlList(param);
		
		map.put("result", Boolean.TRUE);
		map.put("data", tList);
		
		return "jsonView";
		
	}	
	
	@PostMapping(value="/contents/calc/data/regTranReceipt.do")
	public String regTranReceipt(HttpServletRequest request, Model model, ModelMap map, HttpSession session,
								@RequestParam Map<String, Object> param ) throws Exception {

		LoginVO login = (LoginVO) session.getAttribute("userInfo");
		param.put("mngDeptId", param.get("sDeptId"));

		if("N".equals(login.getMasterYn())) {
			param.put("mngDeptId", login.getDeptId());
		}

		String toDay = DateUtil.getDate("");
		String writeDate = DateUtil.dateYYYYmmdd(String.valueOf(param.get("taxDate")), "");
		
		if (brokerCustId.equals(login.getCustId())) {	//공급자와 위탁자 사업자가 같으면 일반세금계산서, 다르면 위수탁
			param.put("billKind", "1");		//1: 일반, 3:위수탁
			param.put("docType", "01");		//03: 일반위수탁
		} else {
			param.put("billKind", "3");		//1: 일반, 3:위수탁
			param.put("docType", "03");		//03: 일반위수탁
		}
		param.put("remarks", param.get("tranRemarksDefault") + " " + param.get("tranRemarks"));
		param.put("pubForm", param.get("tranPubForm"));
		param.put("writeDate", writeDate);
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
		
		if("D".equals(param.get("tranMode"))) {
			param.put("vehicId", param.get("tranSupplierVehicId"));
			param.put("driverId", param.get("tranSupplierDriverId"));
			param.put("custId", param.get("tranBuyerCustId"));
			param.put("deptId", param.get("tranBuyerDeptId"));
		}
		if(param.get("custId") == "" && param.get("deptId") == "") {
			param.put("custId", param.get("tranCustId"));
			param.put("deptId", param.get("tranDeptId"));
		}
		
		if((String)writeDate != "null") {
			if(toDay.compareTo(writeDate) < 0) {
				map.put("result", Boolean.FALSE);
				map.put("msg", "발행일자가 현재날짜보다 높으면 세금계산서를 발행할 수 없습니다.");
			} else {
				if(!"R".equals(param.get("tranMode"))) {
					tranService.regTranReceiptForDriver(param);
				}else{
					tranService.regTranReceipt(param);
				}
				if(!"00".equals(param.get("retCode"))) {
					map.put("result", Boolean.FALSE);
					map.put("msg", param.get("retMsg"));
				} else {
					if ("Y".equals(param.get("taxYn"))) {
						param.put("receiptId", param.get("retId"));
						if(!"R".equals(param.get("tranMode"))) {
							taxService.insertReceiptTaxInvoiceForDriver(param);
						}else{
							taxService.insertReceiptTaxInvoice(param);
						}
					}
					map.put("result", Boolean.TRUE);
					map.put("msg", param.get("retMsg"));	
				}
			}
		}else {
			param.put("writeDate", "");
			if(!"R".equals(param.get("tranMode"))) {
				tranService.regTranReceiptForDriver(param);
			}else{
				tranService.regTranReceipt(param);
			}
			if(!"00".equals(param.get("retCode"))) {
				map.put("result", Boolean.FALSE);
				map.put("msg", param.get("retMsg"));
			} else {
				if ("Y".equals(param.get("taxYn"))) {
					param.put("receiptId", param.get("retId"));
					if(!"R".equals(param.get("tranMode"))) {
						taxService.insertReceiptTaxInvoiceForDriver(param);
					}else{
						taxService.insertReceiptTaxInvoice(param);
					}
				}
				map.put("result", Boolean.TRUE);
				map.put("msg", param.get("retMsg"));	
			}
		}
				
		return "jsonView";
		
	}
	
	// 사용안함.
	@PostMapping(value="/contents/calc/data/getInvoicePdf.do")
	public String getInvoicePdf(HttpServletRequest request, HttpServletResponse response, HttpSession session, Model model, ModelMap map,
							@RequestParam Map<String, Object> param) throws Exception{
		
		TranVO tran = tranService.selectTranInfo(param);
		tran.setAmtKrw(EtcUtil.NumberToKor(tran.getAmt()));
		tran.setTranDtlList(tranService.selectTranDtlList(param));
				
		param.put("tran", tran);
		param.put("locale", Locale.forLanguageTag("ko"));
		param.put("root_path", filepath);
		
		File invoicePdf = tranService.generateInvoiceFor(param);
		
        map.put("fileName", invoicePdf.getName());
        map.put("message", "pdf 생성 성공");
		
		return "jsonView";
    }
	
	@PostMapping(value="/contents/calc/data/getInvoice.do")
	public String getInvoice(HttpServletRequest request, HttpServletResponse response, HttpSession session, Model model, ModelMap map, @RequestParam Map<String, Object> param) throws Exception{
		TranVO tran = tranService.selectTranInfo(param);
		tran.setAmtKrw(EtcUtil.NumberToKor(tran.getAmt()));
		tran.setTranDtlList(tranService.selectTranDtlList(param));
				
		param.put("tran", tran);
		param.put("locale", Locale.forLanguageTag("ko"));
		param.put("root_path", filepath);
		
		File invoiceFile = tranService.generateInvoice(param);
		
        map.put("fileName", invoiceFile.getName());
        map.put("message", "거래명세서 생성 성공");
		
		return "jsonView";
    }
	
	@PostMapping(value="/contents/calc/data/deleteTran.do")
	public String deleteTran(HttpServletRequest request, Model model, ModelMap map, HttpSession session,
								@RequestParam Map<String, Object> param ) throws Exception {

		if(!EtcUtil.checkAuth(request, menuCode, "D")) {
			map.put("result", Boolean.FALSE);
			map.put("msg", "해당 권한이 없습니다.");
			
			return "jsonView";
		}
		
		tranService.deleteTranReceipt(param);
		
		if(!"00".equals(param.get("retCode"))) {
			map.put("result", Boolean.FALSE);
			map.put("msg", param.get("retMsg"));
		} else {
			map.put("result", Boolean.TRUE);
			map.put("msg", param.get("retMsg"));	
		}
		
		
		return "jsonView";
	}
}
