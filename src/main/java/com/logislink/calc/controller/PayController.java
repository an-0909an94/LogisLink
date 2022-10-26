package com.logislink.calc.controller;

import java.util.Arrays;
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

import com.logislink.calc.service.PayService;
import com.logislink.calc.vo.CalcVO;
import com.logislink.calc.vo.PayVO;
import com.logislink.cmm.util.EtcUtil;
import com.logislink.login.vo.LoginMenuVO;
import com.logislink.login.vo.LoginVO;

@Controller
public class PayController {

	private Logger log = Logger.getLogger(this.getClass());
	private String menuCode = "C3610";
	
	@Resource(name="payService")
	private PayService payService;

	@GetMapping(value="/contents/calc/payList.do")
	public String payList(HttpServletRequest request, HttpSession session, ModelMap model) {
		
		LoginMenuVO loginMenu = EtcUtil.checkAuth(request, menuCode);
		model.put("menuAuth", loginMenu);
				
		return "contents/calc/payList";
	}
	
	@PostMapping(value="/contents/calc/data/payList.do")
	public String calcListData(HttpServletRequest request, Model model, ModelMap map, HttpSession session,
								@RequestParam Map<String, Object> param ) throws Exception {

		LoginVO login = (LoginVO) session.getAttribute("userInfo");
		if("N".equals(login.getMasterYn())) {
			param.put("mngDeptId", login.getDeptId());
		} else {
			param.put("mngDeptId", param.get("sDeptId"));
		}
		
		//param.put("mngDeptId", login.getDeptId());
		
		List<PayVO> calcList = payService.getPayList(param);
		
		map.put("result", Boolean.TRUE);
		map.put("data", calcList);
		
		return "jsonView";
	}

	@PostMapping(value="/contents/calc/data/payCalcList.do")
	public String payCalcListData(HttpServletRequest request, Model model, ModelMap map, HttpSession session,
								@RequestParam Map<String, Object> param ) throws Exception {

		List<CalcVO> calcList = payService.getPayCalcList(param);
		
		map.put("result", Boolean.TRUE);
		map.put("data", calcList);
		
		return "jsonView";
	}

	@PostMapping(value="/contents/calc/data/payApproUpdate.do")
	public String payApproUpdate(HttpServletRequest request, Model model, ModelMap map, HttpSession session,
								@RequestParam Map<String, Object> param ) throws Exception {
		
		List<String> paySeqList = Arrays.asList(((String)param.get("paySeqArr")).split(","));
		
		param.put("paySeqList", paySeqList);
		
		payService.payApproUpdate(param);
		
		map.put("result", Boolean.TRUE);
		map.put("msg", "지급승인 처리가 완료되었습니다.");
		
		return "jsonView";
	}

	@PostMapping(value="/contents/calc/data/outreqUpdate.do")
	public String outreqUpdate(HttpServletRequest request, Model model, ModelMap map, HttpSession session,
								@RequestParam Map<String, Object> param ) throws Exception {
		
		param.put("paySeqList", param.get("paySeqArr"));
		
		payService.outreqUpdate(param);
		
		map.put("result", Boolean.TRUE);
		map.put("msg", "출금요청 처리가 완료되었습니다.");
		
		return "jsonView";
	}

	@PostMapping(value="/contents/calc/data/outUpdate.do")
	public String outUpdate(HttpServletRequest request, Model model, ModelMap map, HttpSession session,
								@RequestParam Map<String, Object> param ) throws Exception {
		
		List<String> paySeqList = Arrays.asList(((String)param.get("paySeqArr")).split(","));
		
		param.put("paySeqList", paySeqList);
		
		payService.outUpdate(param);
		
		map.put("result", Boolean.TRUE);
		map.put("msg", "출금처리가 완료되었습니다.");
		
		return "jsonView";
	}

	@PostMapping(value="/contents/calc/data/payReturn.do")
	public String payReturn(HttpServletRequest request, Model model, ModelMap map, HttpSession session,
								@RequestParam Map<String, Object> param ) throws Exception {
		
		List<String> paySeqList = Arrays.asList(((String)param.get("paySeqArr")).split(","));
		List<String> orderIdList = Arrays.asList(((String)param.get("orderIdArr")).split(","));
		List<String> allocIdList = Arrays.asList(((String)param.get("allocIdArr")).split(","));
		
		param.put("paySeqList", paySeqList);
		param.put("orderIdList", orderIdList);
		param.put("allocIdList", allocIdList);
		
		payService.payReturn(param);
		
		map.put("result", Boolean.TRUE);
		map.put("msg", "지급반려 처리가 완료되었습니다.");
		
		return "jsonView";
	}

	@PostMapping(value="/contents/calc/data/bankChk.do")
	public String bankChk(HttpServletRequest request, Model model, ModelMap map, HttpSession session,
								@RequestParam Map<String, Object> param ) throws Exception {
		payService.insertVacs(param);
		
		Thread.sleep(5000);
		Map<String, Object> rlt = payService.getVacsSendRlt(param);

		String acctNm = String.valueOf(param.get("acctNm"));
		if("0000".equals(rlt.get("INP_CD"))) {
			String racctNm = String.valueOf(rlt.get("IACCT_NM"));
			if(acctNm.equals(racctNm.trim())) {
				payService.bankChkDateupdate(param);
				map.put("result", Boolean.TRUE);
				map.put("msg", "사용가능한 계좌입니다.");
			} else {
				map.put("result", Boolean.FALSE);
				map.put("msg", "예금주가 일치하지 않습니다.");
			}
		} else if (rlt.get("INP_CD") == null) {
			map.put("result", Boolean.FALSE);
			map.put("msg", "예금주 조회에 실패했습니다. 잠시 후 다시 시도해주세요.");
		} else {
			map.put("result", Boolean.FALSE);
			map.put("msg", "사용하실 수 없는 계좌입니다.");	
		}
		
		return "jsonView";
	}
	
	@PostMapping(value="/contents/calc/data/setWithdrawalDueDate.do")
	public String setWithdrawalDueDate(HttpServletRequest request, Model model, ModelMap map, HttpSession session, @RequestParam Map<String, Object> param ) throws Exception {
		List<String> paySeqList = Arrays.asList(((String)param.get("paySeqArr")).split(","));
		
		param.put("paySeqList", paySeqList);
		
		int resultCnt = payService.updateWithdrawalDueDate(param);
		
		map.put("result", Boolean.TRUE);
		map.put("resultCnt", resultCnt);
		map.put("msg", "(" + resultCnt + ")건의 출금예정일 변경 처리가 완료되었습니다.");
		
		return "jsonView";
	}
	
	@PostMapping(value="/contents/calc/data/getPaySummary.do")
	public String getPaySummary(HttpServletRequest request, Model model, ModelMap map, HttpSession session, @RequestParam Map<String, Object> param ) throws Exception {

		LoginVO login = (LoginVO) session.getAttribute("userInfo");
		if("N".equals(login.getMasterYn())) {
			param.put("mngDeptId", login.getDeptId());
		} else {
			param.put("mngDeptId", param.get("sDeptId"));
		}
		
		//param.put("mngDeptId", login.getDeptId());
		
		Map<String, Object> paySummary = payService.selectPaySummary(param);
		
		map.put("result", Boolean.TRUE);
		map.put("data", paySummary);
		
		return "jsonView";
	}
}
