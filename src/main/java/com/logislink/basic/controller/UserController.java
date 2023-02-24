package com.logislink.basic.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.logislink.basic.vo.CargoNetVO;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.logislink.basic.service.CompService;
import com.logislink.basic.service.UserService;
import com.logislink.basic.vo.CompVO;
import com.logislink.basic.vo.UserOptionVO;
import com.logislink.basic.vo.UserVO;
import com.logislink.cmm.util.EncUtil;
import com.logislink.cmm.util.EtcUtil;
import com.logislink.login.vo.LoginMenuVO;
import com.logislink.login.vo.LoginVO;

@Controller
public class UserController {
	
	private Logger log = Logger.getLogger(this.getClass());
	private String menuCode = "A1210";

	@Value("#{globalProperties['Globals.mainCustId']}")
	private String mainCustId;
	
	@Resource(name="userService")
	private UserService userService;
	
	@Resource(name="compService")
	private CompService compService;

	@PostMapping(value="/contents/basic/data/userOne.do")
	public String getUserOne(HttpServletRequest request, Model model, ModelMap map, HttpSession session,
		@RequestParam Map<String, Object> param ) throws Exception {

		UserVO userOne = userService.getUserOne(param);

		map.put("result", Boolean.TRUE);
		map.put("data", userOne);
		map.put("total", 1);
		map.put("msg", "");

		return "jsonView";
	}

	@GetMapping(value="/contents/basic/userList.do")
	public String getUserList(HttpServletRequest request, HttpSession session, ModelMap model) {
		LoginVO loginUserInfo = ((LoginVO) session.getAttribute("userInfo"));
		int custAuthSeq = 0;
		
		LoginMenuVO loginMenu = EtcUtil.checkAuth(request, menuCode);
		
		if(loginUserInfo.getAuthSeq() == 100) {
			model.addAttribute("authChk", true);
			model.addAttribute("custId", "");
			model.addAttribute("custAuthSeq", custAuthSeq);
			// 22.06.24 이건욱 전역변수 추가 (T11 > J41)
			model.addAttribute("adminChk", true);
			model.addAttribute("custName", "");
			model.addAttribute("deptId", loginUserInfo.getDeptId());
		} else {
			model.addAttribute("authChk", false);
			model.addAttribute("custId", loginUserInfo.getCustId());
			
			HashMap<String, Object> map = new HashMap<String, Object>();
			
			map.put("custId", loginUserInfo.getCustId());
			CompVO compInfo = compService.getComp(map);
			
			String custTypeCode = compInfo.getCustTypeCode();
			
			if("01".equals(custTypeCode)) {
				custAuthSeq =  230;
			} else if("02".equals(custTypeCode)) {
				custAuthSeq =  220;
			} else if("03".equals(custTypeCode)) {
				custAuthSeq =  240;
			} else if("04".equals(custTypeCode)) {
				custAuthSeq =  210;
			}

			model.addAttribute("custAuthSeq", custAuthSeq);
			
			// 22.06.24 이건욱 전역변수 추가 (T11 > J41)
			// 로그인한 유저의 권한이 999일 경우 해당 조직의 슈퍼관리자
			model.addAttribute("adminChk", loginUserInfo.getAuthSeq() == 999 ? true : false);
			model.addAttribute("custName", loginUserInfo.getBizName());
			model.addAttribute("deptId", loginUserInfo.getDeptId());
		}

		model.put("mainCustId", mainCustId);
		model.put("menuAuth", loginMenu);
		return "contents/basic/userList";
	}
	
	@PostMapping(value="/contents/basic/data/userList.do")
	public String getUserList(HttpServletRequest request, Model model, ModelMap map, HttpSession session,
								@RequestParam Map<String, Object> param ) throws Exception {
		
		LoginVO loginUser = ((LoginVO) session.getAttribute("userInfo"));
		
		//최고 관리자가 아니고, 거래처 담당자가 조회가 아닐 경우
		//사용자 관리는 부서별이 아니라 거래처별 조회
		if(loginUser.getAuthSeq() != 100 ) {
			String custId = ((LoginVO) session.getAttribute("userInfo")).getCustId();
			
			param.put("custId", custId);
		}
		
		List<UserVO> userList = userService.getUserList(param);
		int count = userService.getCnt(param);
		
		map.put("result", Boolean.TRUE);
		map.put("data", userList);
		map.put("total", count);
		map.put("msg", "");
		
		return "jsonView";
		
	}
	
	@PostMapping(value="/contents/basic/data/checkUserId.do")
	public String checkUserId(HttpServletRequest request, Model model, ModelMap map, HttpSession session,
								@RequestParam Map<String, Object> param ) throws Exception {
		HashMap<String, String> chk = userService.checkUserId(param);
		
		if("0".equals(param.get("retCode"))) {
			map.put("result", Boolean.TRUE);
			map.put("msg", param.get("retMsg"));
		} else {
			map.put("result", Boolean.FALSE);
			map.put("msg", param.get("retMsg"));
		}
		
		return "jsonView";
	}
	
	@PostMapping(value="/contents/basic/data/insertUser.do")
	public String insertUser(HttpServletRequest request, Model model, ModelMap map, HttpSession session,
								@RequestParam Map<String, Object> param ) throws Exception {
		
		String resMsg = "";

		if("N".equals(param.get("mode"))) {
			if(!EtcUtil.checkAuth(request, menuCode, "W")) {
				map.put("result", Boolean.FALSE);
				map.put("msg", "해당 권한이 없습니다.");
				
				return "jsonView";
			}
			param.put("regId", ((LoginVO) session.getAttribute("userInfo")).getUserId());
		} else if("E".equals(param.get("mode"))) {
			if(!EtcUtil.checkAuth(request, menuCode, "E")) {
				map.put("result", Boolean.FALSE);
				map.put("msg", "해당 권한이 없습니다.");
				
				return "jsonView";
			}
			param.put("editId", ((LoginVO) session.getAttribute("userInfo")).getUserId());
		}

		if(!"".equals(param.get("passwd")) && param.get("passwd") != null ) {

			String passwd = String.valueOf(param.get("passwd"));
			passwd = EncUtil.sha256(passwd);

			param.put("passwd", passwd);
		}

		userService.insertUser(param);

		resMsg = (String) param.get("retMsg");

		HashMap<String, Object> cargoNetAccountMap = new HashMap<String, Object>();

		List<CargoNetVO> cargoNetAccountList = new ArrayList<CargoNetVO>();
		CargoNetVO cargoNetVO = new CargoNetVO();

		boolean cargoNetFlag = false;

		cargoNetVO.setUserId(param.get("userId").toString());
		cargoNetVO.setLinkCd("03");
		cargoNetVO.setLinkUserId(param.get("link24Id").toString());
		cargoNetVO.setLinkPasswd(param.get("link24Pass").toString());
		cargoNetVO.setUseYN(param.get("useYn").toString());
		cargoNetVO.setTalkYN(param.get("talkYn").toString());
		cargoNetVO.setMemo(param.get("memo").toString());
		cargoNetVO.setRegId(((LoginVO) session.getAttribute("userInfo")).getUserId());
		cargoNetVO.setEditId(((LoginVO) session.getAttribute("userInfo")).getUserId());
		cargoNetAccountList.add(cargoNetVO);

		cargoNetVO = new CargoNetVO();
		cargoNetVO.setUserId(param.get("userId").toString());
		cargoNetVO.setLinkCd("21");
		cargoNetVO.setLinkUserId(param.get("man24Id").toString());
		cargoNetVO.setLinkPasswd(param.get("man24Pass").toString());
		cargoNetVO.setUseYN(param.get("useYn").toString());
		cargoNetVO.setTalkYN(param.get("talkYn").toString());
		cargoNetVO.setMemo(param.get("memo").toString());
		cargoNetVO.setRegId(((LoginVO) session.getAttribute("userInfo")).getUserId());
		cargoNetVO.setEditId(((LoginVO) session.getAttribute("userInfo")).getUserId());
		cargoNetAccountList.add(cargoNetVO);

		cargoNetVO = new CargoNetVO();
		cargoNetVO.setUserId(param.get("userId").toString());
		cargoNetVO.setLinkCd("18");
		cargoNetVO.setLinkUserId(param.get("one24Id").toString());
		cargoNetVO.setLinkPasswd(param.get("one24Pass").toString());
		cargoNetVO.setUseYN(param.get("useYn").toString());
		cargoNetVO.setTalkYN(param.get("talkYn").toString());
		cargoNetVO.setMemo(param.get("memo").toString());
		cargoNetVO.setRegId(((LoginVO) session.getAttribute("userInfo")).getUserId());
		cargoNetVO.setEditId(((LoginVO) session.getAttribute("userInfo")).getUserId());
		cargoNetAccountList.add(cargoNetVO);
		cargoNetFlag = true;

		cargoNetAccountMap.put("list",cargoNetAccountList);
		//if(cargoNetFlag ) {
		userService.insertUserCargoAccount(cargoNetAccountMap);
		//}
		
		map.put("result", Boolean.TRUE);
		map.put("data", param);
		map.put("msg", resMsg);
		
		return "jsonView";
	}
		
	@PostMapping(value="/contents/basic/data/getUserInfo.do")
	public String getUserInfo(HttpServletRequest request, Model model, ModelMap map, HttpSession session,
								@RequestParam Map<String, Object> param ) throws Exception {
		
		String custTypeCode = (String) param.get("custTypeCode");
		if("01".equals(custTypeCode)) {
			param.put("authSeq", "230");
		} else if("02".equals(custTypeCode)) {
			param.put("authSeq", "220");
		} else if("03".equals(custTypeCode)) {
			param.put("authSeq", "240");
		} else if("04".equals(custTypeCode)) {
			param.put("authSeq", "210");
		}
		
		// 담장자 정보
		UserVO userInfo = userService.getUserInfo(param);
		
		map.put("result", Boolean.TRUE);
		map.put("data", userInfo);
		map.put("msg", "");
		
		return "jsonView";
	}
	
	/*
	 * 담당자 검색
	 * 부서 ID 파라미터가 없으면 로그인한 부서ID 로 검색한다.
	 */
	@PostMapping(value="/contents/basic/data/userNameList.do")
	public String allAuthList(HttpServletRequest request, Model model, ModelMap map, HttpSession session,
								@RequestParam Map<String, Object> param ) throws Exception {
		
		if (param.get("deptId") == null || "".equals(param.get("deptId"))) {
			LoginVO login = (LoginVO) session.getAttribute("userInfo");
			String deptId = login.getDeptId();
			
			param.put("deptId", deptId);
		}
		
		List<UserVO> list = userService.getUserNameList(param);
		
		map.put("result", Boolean.TRUE);
		map.put("data", list);
		map.put("msg", "");
		
		return "jsonView";
	}
	
	/*
	 * 22.06.23 이건욱 거래처별 담당자 조회
	 * 거래처별 (CUST_ID)로 담당자를 조회한다.
	 */
	@PostMapping(value="/contents/basic/data/userNameListCust.do")
	public String getUserNameListCust(HttpServletRequest request, Model model, ModelMap map, HttpSession session,
										@RequestParam Map<String, Object> param) throws Exception {
		if (param.get("custId") == null || param.get("custId").equals("")) {
			LoginVO login = (LoginVO) session.getAttribute("userInfo");
			String custId = login.getCustId();
			
			param.put("custId", custId);
		}
		
		List<UserVO> list = userService.getUserNameList(param);
		
		map.put("result", Boolean.TRUE);
		map.put("data", list);
		map.put("msg", "");
		
		return "jsonView";
	}
	
	@PostMapping(value="/contents/basic/data/userMainPage.do")
	public String userMainPage(HttpServletRequest request, Model model, ModelMap map, HttpSession session,
								@RequestParam Map<String, Object> param ) throws Exception {
		
		
		userService.updateUserMainPage(param);

		map.put("result", Boolean.TRUE);
		map.put("msg", "시작페이지로 설정했습니다.");

		return "jsonView";
		
	}
	
	@PostMapping(value="/contents/basic/data/insertUserOption.do")
	public String insertUserOption(HttpServletRequest request, Model model, ModelMap map, HttpSession session,
								@RequestParam Map<String, Object> param ) throws Exception {
		
		
		userService.insertUserOption(param);

		map.put("result", Boolean.TRUE);
		map.put("data", param);
		map.put("msg", param.get("retMsg"));

		return "jsonView";
		
	}
	
	@PostMapping(value="/contents/basic/data/getUserOption.do")
	public String getUserOption(HttpServletRequest request, Model model, ModelMap map, HttpSession session,
								@RequestParam Map<String, Object> param ) throws Exception {
		
		UserOptionVO data = userService.getUserOption(param);

		map.put("result", Boolean.TRUE);
		map.put("data", data);
		map.put("msg", "");

		return "jsonView";
		
	}

	/*
	 * 유저정보검색
	 * T_USER 톡 알림 사용여부 체크
	 */
	@PostMapping(value="/contents/basic/data/getUserTalk.do")
	public String getUserTalk(HttpServletRequest request, Model model, ModelMap map, HttpSession session,
								@RequestParam Map<String, Object> param ) throws Exception {

		UserVO userInfo = userService.getUserInfo(param);
		if(userInfo ==null){
			map.put("result", Boolean.FALSE);
		}else{
			map.put("result", Boolean.TRUE);
		}

		map.put("userInfo", userInfo);

		return "jsonView";

	}

}
