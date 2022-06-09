package com.logislink.basic.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.logislink.basic.service.CompService;
import com.logislink.basic.service.CustService;
import com.logislink.basic.vo.CompDeptVO;
import com.logislink.basic.vo.CompVO;
import com.logislink.cmm.util.EtcUtil;
import com.logislink.login.vo.LoginMenuVO;
import com.logislink.login.vo.LoginVO;
import com.nimbusds.jose.JOSEException;
import com.nimbusds.jose.JWSAlgorithm;
import com.nimbusds.jose.JWSHeader;
import com.nimbusds.jose.JWSSigner;
import com.nimbusds.jose.KeyLengthException;
import com.nimbusds.jose.crypto.MACSigner;
import com.nimbusds.jwt.JWTClaimsSet;
import com.nimbusds.jwt.SignedJWT;

@Controller
public class CompController {
	private Logger log = Logger.getLogger(this.getClass());
	private String menuCode = "A1110";
	private String masterMenuCode = "A1120";

	@Value("#{globalProperties['Globals.jwtApiKey']}")
	private String jwtApiKey;
	
	@Resource(name="compService")
	private CompService compService;
	
	@Resource(name="custService")
	private CustService custService;

	@GetMapping(value="/contents/basic/compList.do")
	public String getCompList(HttpServletRequest request, HttpSession session, ModelMap model, @RequestParam Map<String, Object> param) {

		if(param.get("custId") == null) {
			LoginMenuVO loginMenu = EtcUtil.checkAuth(request, menuCode);
			model.put("menuAuth", loginMenu);
			model.addAttribute("custId", ((LoginVO) session.getAttribute("userInfo")).getCustId());
		} else {
			LoginMenuVO loginMenu = EtcUtil.checkAuth(request, masterMenuCode);
			model.put("menuAuth", loginMenu);
			model.addAttribute("custId", param.get("custId"));
		}

		return "contents/basic/compList";
	}
	
	@GetMapping(value="/contents/basic/masterCompList.do")
	public String getMasterCompList(HttpServletRequest request, HttpSession session, ModelMap model) {

		LoginMenuVO loginMenu = EtcUtil.checkAuth(request, masterMenuCode);
		model.put("menuAuth", loginMenu);
		
		return "contents/basic/masterCompList";
	}
	
	@PostMapping(value="/contents/basic/data/compList.do")
	public String getCompData(HttpServletRequest request, Model model, ModelMap map, HttpSession session,
								@RequestParam Map<String, Object> param ) throws Exception {
		String custId = "";	
		String deptId = "";
		
		if("".equals(param.get("custId")) || param.get("custId") == null) {
			LoginVO login = (LoginVO) session.getAttribute("userInfo");
			custId = login.getCustId();
			deptId = login.getDeptId();
			
			param.put("custId", custId);
			param.put("deptId", deptId);
		}
		
		CompVO compInfo = compService.getComp(param);
		
		map.put("result", Boolean.TRUE);  
		map.put("data", compInfo);
		map.put("msg", "");
		
		return "jsonView";
		
	}
	
	@PostMapping(value="/contents/basic/data/compDeptList.do")
	public String getCompDeptList(HttpServletRequest request, Model model, ModelMap map, HttpSession session,
								@RequestParam Map<String, Object> param ) throws Exception {
		
		String custId = "";
		LoginVO login = (LoginVO) session.getAttribute("userInfo");
		
		if("".equals(param.get("custId"))) {			
			custId = login.getCustId();
			
			param.put("custId", custId);
		} else {
			custId = (String) param.get("custId");
		}
		
		//모든 검색 옵션에서 마스터 계정은 자기 조직의 전체 부서 select / 일반 계정은 자기 부서만 parameter 로 보냄. 
		if(login.getDeptId().equals(param.get("deptId")) && "Y".equals(login.getMasterYn())) {
			param.put("deptId", "");
		}
		
		List<CompDeptVO> compDeptList = compService.getCompDeptList(param);
		
		map.put("result", Boolean.TRUE);
		map.put("data", compDeptList);
		map.put("msg", "");
		
		return "jsonView";
		
	}
	
	@PostMapping(value="/contents/basic/data/masterCompList.do")
	public String getMasterCompList(HttpServletRequest request, Model model, ModelMap map, HttpSession session,
								@RequestParam Map<String, Object> param ) throws Exception {
		
		LoginVO loginUser = ((LoginVO) session.getAttribute("userInfo"));
		
		if(loginUser.getAuthSeq() != 100) {
			param.put("custId", loginUser.getCustId());
		}
		
		List<CompVO> masterCompList = compService.getMasterCompList(param);
		int count = compService.getCnt(param);
		
		map.put("result", Boolean.TRUE);
		map.put("data", masterCompList);
		map.put("total", count);
		map.put("msg", "");
		
		return "jsonView";
		
	}
	
	@PostMapping(value="/contents/basic/data/compUpdate.do")
	public String updateComp(HttpServletRequest request, Model model, ModelMap map, HttpSession session,
								@RequestParam Map<String, Object> param ) throws Exception {
		String resMsg = "";
		String mode = "";
	
		if("newComp".equals((String) param.get("custId"))) {

			if(!EtcUtil.checkAuth(request, masterMenuCode, "W") && !EtcUtil.checkAuth(request, menuCode, "W")) {
				map.put("result", Boolean.FALSE);
				map.put("msg", "해당 권한이 없습니다.");
				
				return "jsonView";
			}
			
			param.put("custId", "");
			
			param.put("regId", ((LoginVO) session.getAttribute("userInfo")).getUserId());
			mode = "create";
		} else {
			
			if(!EtcUtil.checkAuth(request, masterMenuCode, "E") && !EtcUtil.checkAuth(request, menuCode, "E")) {
				map.put("result", Boolean.FALSE);
				map.put("msg", "해당 권한이 없습니다.");
				
				return "jsonView";
			}
			
			param.put("editId", ((LoginVO) session.getAttribute("userInfo")).getUserId());
			mode = "update";
		}
		
		if("".equals(param.get("bizNumSub"))) {
			param.put("bizNumSub", "0000");
		}
		
		HashMap<String, Object> ret = custService.checkBizNum(param);
		CompVO compInfo = null;
		
		if("00".equals(ret.get("retCode")) && "create".equals(mode)) {
			resMsg = "이미 존재하는 사업자번호이거나 종사업장번호 입니다.";
		} else {
			compService.updateComp(param);
			resMsg = (String) param.get("retMsg");
			if("".equals(param.get("custId"))) {
				LoginVO login = (LoginVO) session.getAttribute("userInfo");
				param.put("custId", login.getCustId());
			}
			
			compInfo = compService.getComp(param);
		}
		
		map.put("result", Boolean.TRUE);
		map.put("data", compInfo);
		map.put("msg", resMsg);
		
		return "jsonView";
		
	}
	
	@PostMapping(value="/contents/basic/data/compDeptInsert.do")
	public String insertCompDept(HttpServletRequest request, Model model, ModelMap map, HttpSession session,
								@RequestParam Map<String, Object> param ) throws Exception {
		
		String custId = "";
		String deptId = "";

		if(!EtcUtil.checkAuth(request, masterMenuCode, "E") && !EtcUtil.checkAuth(request, menuCode, "E")) {
			map.put("result", Boolean.FALSE);
			map.put("msg", "해당 권한이 없습니다.");
			
			return "jsonView";
		}
		
		if("".equals(param.get("custId"))) {
			LoginVO login = (LoginVO) session.getAttribute("userInfo");
			custId = login.getCustId();
			
			param.put("custId", custId);
		} else {
			custId = (String) param.get("custId");
		}
		
//		Date now = new Date();
//
//		SimpleDateFormat format = new SimpleDateFormat("yyyyMMddHHmmss");
//		
//		String newDeptId = "D" + format.format(now) + "001"; 
		param.put("deptId", "");
		param.put("regId", ((LoginVO) session.getAttribute("userInfo")).getUserId());
		
		compService.insertCompDept(param);
		
		List<CompDeptVO> compDeptList = compService.getCompDeptList(param);
		
		map.put("result", Boolean.TRUE);
		map.put("data", compDeptList);
		map.put("msg", param.get("retMsg"));
		
		return "jsonView";
		
	}
	
	@PostMapping(value="/contents/basic/data/deptUpdate.do")
	public String updateCompDept(HttpServletRequest request, Model model, ModelMap map, HttpSession session,
								@RequestParam Map<String, Object> param ) throws Exception {
		if(!EtcUtil.checkAuth(request, masterMenuCode, "E") && !EtcUtil.checkAuth(request, menuCode, "E")) {
			map.put("result", Boolean.FALSE);
			map.put("msg", "해당 권한이 없습니다.");
			
			return "jsonView";
		}
		
		compService.updateCompDept(param);
		
		map.put("result", Boolean.TRUE);
		map.put("msg", "부서를 수정했습니다.");
		
		return "jsonView";
		
	}
	
	@PostMapping(value="/contents/basic/data/createToken.do")
	public String updateCompToken(HttpServletRequest request, Model model, ModelMap map, HttpSession session,
								@RequestParam Map<String, Object> param ) throws Exception {

		String jwtString = "";
		JWSSigner signer=null;
		
		if(((LoginVO) session.getAttribute("userInfo")).getAuthSeq() != 100) {

			map.put("result", Boolean.FALSE);
			map.put("msg", "토큰 생성 권한이 없습니다.");

			return "jsonView";
		}
		System.out.println(param.toString());
		try {
			signer = new MACSigner(jwtApiKey);
		} catch (KeyLengthException e) {
			// TODO Auto-generated catch block
			log.error("KeyLengthException " + e.getMessage());
		}
		JWTClaimsSet claimsSet = new JWTClaimsSet.Builder()
                .claim("custId", param.get("custId"))
                .claim("cType", param.get("custTypeCode"))
                .build();
		SignedJWT signedJWT = new SignedJWT(new JWSHeader(JWSAlgorithm.HS256), claimsSet);
		try {
			signedJWT.sign(signer);
		} catch (JOSEException e) {
			// TODO Auto-generated catch block
			log.error("JOSEException " + e.getMessage());
			
			map.put("result", Boolean.FALSE);
			map.put("msg", "오류가 발생했습니다. 관리자에게 문의하세요.");

			return "jsonView";
		}
		 
		jwtString = signedJWT.serialize();
		
		param.put("token", jwtString);
		param.put("oapiYn", "Y");
		
		compService.updateCompApi(param);
		
		map.put("result", Boolean.TRUE);
		map.put("msg", "토큰을 생성했습니다.");
		
		return "jsonView";
	}
	
}
