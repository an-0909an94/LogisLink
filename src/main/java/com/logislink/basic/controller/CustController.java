package com.logislink.basic.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttribute;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.logislink.basic.service.CompService;
import com.logislink.basic.service.CustService;
import com.logislink.basic.service.UserService;
import com.logislink.basic.vo.CustAddrVO;
import com.logislink.basic.vo.CustVO;
import com.logislink.cmm.helper.RestApiHelper;
import com.logislink.cmm.service.RestService;
import com.logislink.cmm.util.DateUtil;
import com.logislink.cmm.util.EncUtil;
import com.logislink.cmm.util.EtcUtil;
import com.logislink.login.vo.LoginMenuVO;
import com.logislink.login.vo.LoginVO;

@Controller
public class CustController {
	
	private Logger log = Logger.getLogger(this.getClass());
	private String menuCode = "A1310";
	private String menuCodeAddr = "A1510";
	private static RestApiHelper apiHelper = new RestApiHelper();
	
	@Value("#{globalProperties['Globals.kakaoKey']}")
	private String kakaoKey;

	@Resource(name="custService")
	private CustService custService;
	
	@Resource(name="userService")
	private UserService userService;
	
	@Resource(name="compService")
	private CompService compService;

	@GetMapping(value="/contents/basic/custList.do")
	public String getCustList(HttpServletRequest request, HttpSession session, ModelMap model) {

		LoginMenuVO loginMenu = EtcUtil.checkAuth(request, menuCode);		
		LoginVO login = (LoginVO) session.getAttribute("userInfo");
		String loginUser = login.getUserId();
		
		model.put("loginUser", loginUser);
		model.put("menuAuth", loginMenu);
		
		return "contents/basic/custList";
	}
	
	@GetMapping(value="/contents/basic/custAddrList.do")
	public String getCustAddrList(HttpServletRequest request, HttpSession session, ModelMap model) {
		
		LoginMenuVO loginMenu = EtcUtil.checkAuth(request, menuCodeAddr);		
		model.put("menuAuth", loginMenu);
		
		return "contents/basic/custAddrList";
	}
	
	@GetMapping(value="/contents/basic/custPriceList.do")
	public String getCustPriceList(HttpServletRequest request,  Model model, HttpSession session, ModelMap map, 
			 					@RequestParam Map<String, Object> param ) {
		
		map.put("custId", param.get("custId"));
		map.put("deptId", param.get("deptId"));

		LoginMenuVO loginMenu = EtcUtil.checkAuth(request, menuCode);		
		map.put("menuAuth", loginMenu);
		
		return "contents/basic/custPriceList";
	}
	
	@PostMapping(value="/contents/basic/data/custList.do")
	public String custList(HttpServletRequest request, Model model, ModelMap map, HttpSession session,
								@RequestParam Map<String, Object> param ) throws Exception {
		

		LoginVO login = (LoginVO) session.getAttribute("userInfo");
		if("N".equals(login.getMasterYn())) {
			param.put("deptId", login.getDeptId());
		}
		
		List<CustVO> custList = custService.getCustList(param);
		int count = custService.getCnt(param);
		
		map.put("result", Boolean.TRUE);
		map.put("data", custList);
		map.put("msg", "");
		map.put("total", count);
		
		return "jsonView";
	}
	
	@PostMapping(value="/contents/basic/data/custSearchList.do")
	public String custSearchList(HttpServletRequest request, Model model, ModelMap map, HttpSession session,
									@RequestParam Map<String, Object> param ) throws Exception {
				
		
		LoginVO login = (LoginVO) session.getAttribute("userInfo");
		if("N".equals(login.getMasterYn())) {
		param.put("deptId", login.getDeptId());
		}
		
		List<Map<String,Object>> custList = custService.getSearchCust(param);
		int count = custService.getSearchCustCnt(param);
		
		map.put("result", Boolean.TRUE);
		map.put("data", custList);
		map.put("msg", "");
		map.put("total", count);
		
		return "jsonView";
	}
	
	@PostMapping(value="/contents/basic/data/custAddrList.do")
	public String custAddrList(HttpServletRequest request, Model model, ModelMap map, HttpSession session,
									@RequestParam Map<String, Object> param ) throws Exception {
		LoginVO login = (LoginVO) session.getAttribute("userInfo");

		//마스터 권한인 경우, 부서 정보를 파라미터로 받는다.
		if("N".equals(login.getMasterYn())) {
			param.put("deptId",  login.getDeptId());
		}
		
		List<CustAddrVO> custAddrList = custService.getCustAddrList(param);
		int count = custService.getAddrCnt(param);
		
		map.put("result", Boolean.TRUE);
		map.put("data", custAddrList);
		map.put("msg", "");
		map.put("total", count);
		
		return "jsonView";
	}
	
	@PostMapping(value="/contents/basic/data/checkAddr.do")
	public String checkUserId(HttpServletRequest request, Model model, ModelMap map, HttpSession session,
								@RequestParam Map<String, Object> param ) throws Exception {	
		LoginVO login = (LoginVO) session.getAttribute("userInfo");
		String custId = login.getCustId();
		String deptId = login.getDeptId();
		
		param.put("custId", custId);
		param.put("deptId", deptId);
		
		HashMap<String, String> chk = custService.checkAddr(param);
		
		if("00".equals(param.get("retCode"))) {
			map.put("result", Boolean.TRUE);
		} else {
			map.put("result", Boolean.FALSE);
		}
		
		return "jsonView";
	}
	
	@PostMapping(value="/contents/basic/data/checkBizNum.do")
	public String checkBizNum(HttpServletRequest request, Model model, ModelMap map, HttpSession session,
								@RequestParam Map<String, Object> param ) throws Exception {
//		LoginVO login = (LoginVO) session.getAttribute("userInfo");
//		String custId = login.getCustId();
//		String deptId = login.getDeptId();
//		
//		param.put("custId", custId);
//		param.put("deptId", deptId);
		
		HashMap<String, Object> ret = custService.checkBizNum(param);
		
		if("00".equals(ret.get("retCode"))) {
			map.put("result", Boolean.TRUE);
//			map.put("data", custList);
			map.put("cnt", ret.get("retCnt"));
			map.put("msg", "");
		} else if("99".equals(ret.get("retCode"))) {
			map.put("result", Boolean.FALSE);
//			map.put("data", custList);
			map.put("msg", ret.get("retMsg"));
		}
		
		
		return "jsonView";
	}
	
	@PostMapping(value="/contents/basic/data/getCustInfo.do")
	public String getCustInfo(HttpServletRequest request, Model model, ModelMap map, HttpSession session,
								@RequestParam Map<String, Object> param ) throws Exception {
		LoginVO login = (LoginVO) session.getAttribute("userInfo");
		String custId = login.getCustId();
		String deptId = login.getDeptId();
		
		param.put("custId", custId);
		param.put("deptId", deptId);
		
	 	// 거래처 마스터 정보
		List<CustVO> custInfo = custService.getCustInfo(param);
		
		// 부서 정보
		for(CustVO cust : custInfo) {
			Map<String, Object> cMap = new HashMap<String, Object>();
			cMap.put("custId", cust.getCustId());
			cust.setDeptList(compService.getCompDeptList(cMap));
		}
		
		map.put("result", Boolean.TRUE);
		map.put("data", custInfo);
		map.put("msg", "");
		
		return "jsonView";
	}
	
	@PostMapping(value="/contents/basic/data/insertCust.do")
	public String insertCust(HttpServletRequest request, Model model, ModelMap map, HttpSession session,
								@RequestParam Map<String, Object> param ) throws Exception {
		String resMsg = "";
		
		param.put("regId", ((LoginVO) session.getAttribute("userInfo")).getUserId());
		param.put("editId", ((LoginVO) session.getAttribute("userInfo")).getUserId());
		
		// 등록/수정 권한체크
		if("".equals(param.get("custSeq")) || param.get("custSeq") == null) {
			if(!EtcUtil.checkAuth(request, menuCode, "W")) {
				map.put("result", Boolean.FALSE);
				map.put("msg", "해당 권한이 없습니다.");
				
				return "jsonView";
			}
		} else {
			if(!EtcUtil.checkAuth(request, menuCode, "E")) {
				map.put("result", Boolean.FALSE);
				map.put("msg", "해당 권한이 없습니다.");
				
				return "jsonView";
			}

		}
		
		if("".equals(param.get("custId"))) {
			HashMap<String, Object> ret = custService.checkBizNum(param);
			
			if ("00".equals(ret.get("retCode"))) {
				param.put("custId", ret.get("custId"));
			}
			
			if("99".equals(ret.get("retCode"))) {
				compService.updateComp(param);	
			}
		}else {
			compService.updateComp(param);
		}
		
		//HashMap<String, String> chk = custService.checkDeptId(param);
		
		if("".equals(param.get("deptId"))) {
			compService.insertCompDept(param);
			
			//새로운 부서 생성 시, 사용자 추가
			param.put("masterYn", "Y");
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
		}		
		
		
		//신규 등록일 경우 사용자 생성
//		if("".equals(param.get("custSeq")) || param.get("custSeq") == null) {
//
//		}
		
//		param.put("mngCustId", param.get("custId"));
//		param.put("mngDeptId", param.get("deptId"));
//		param.put("custId", ((LoginVO) session.getAttribute("userInfo")).getCustId());
//		param.put("deptId", ((LoginVO) session.getAttribute("userInfo")).getDeptId());

		if(!"".equals(param.get("passwd")) && param.get("passwd") != null ) {

			String passwd = String.valueOf(param.get("passwd"));
			passwd = EncUtil.sha256(passwd);
			
			param.put("passwd", passwd);
		}		

		if(!"".equals(param.get("userId")) && param.get("userId") != null && !"".equals(param.get("passwd")) && param.get("passwd") != null) {			
			userService.insertUser(param);
		}	
		
		custService.insertCustDtl(param);
		
		if("00".equals(param.get("retCode"))) {	
			map.put("result", Boolean.TRUE);
			map.put("data", null);
			map.put("msg", param.get("retMsg"));
		} else {	
			map.put("result", Boolean.FALSE);
			map.put("data", null);
			map.put("msg", param.get("retMsg"));
		}
		
		return "jsonView";
	}
	
	@PostMapping(value="/contents/basic/data/insertCustAddr.do")
	public String insertCustAddr(HttpServletRequest request, Model model, ModelMap map, HttpSession session,
								@RequestParam Map<String, Object> param ) throws Exception {
		
		//권한 체크
		if(!"".equals(param.get("addrSeq")) && param.get("addrSeq") != null ) {
			if(!EtcUtil.checkAuth(request, menuCodeAddr, "E")) {
				map.put("result", Boolean.FALSE);
				map.put("msg", "해당 권한이 없습니다.");
				
				return "jsonView";
			}
		} else {
			if(!EtcUtil.checkAuth(request, menuCodeAddr, "W")) {
				map.put("result", Boolean.FALSE);
				map.put("msg", "해당 권한이 없습니다.");
				
				return "jsonView";
			}
		}
		
		custService.insertCustAddr(param);
				
		map.put("result", Boolean.TRUE);
		map.put("data", null);
		map.put("msg", param.get("retMsg"));
		
		return "jsonView";
	}
	
	@GetMapping(value="/contents/basic/view/custBundle.do")
	public String getCustBundle(HttpServletRequest request,  Model model, HttpSession session, ModelMap map, 
		 						@RequestParam Map<String, Object> param ) {

		LoginMenuVO loginMenu = EtcUtil.checkAuth(request, menuCode);		
		map.put("menuAuth", loginMenu);
		
		return "contents/basic/view/custBundle";
	}
	
	@PostMapping(value="/contents/basic/data/frtCostList.do")
	public String frtCostListData(HttpServletRequest request, Model model, ModelMap map, @SessionAttribute("userInfo") LoginVO login, 
									@RequestParam Map<String, Object> param ) throws Exception {
				
		if("01".equals(param.get("sellBuySctn"))) {	// 매출처 단가 입력 시,
			param.put("sellCustId", param.get("custId"));
			param.put("sellDeptId", param.get("deptId"));
			param.put("buyCustId", login.getCustId());
			param.put("buyDeptId", login.getDeptId());
		} else {									// 매입처 단가 입력 시,
			param.put("buyCustId", param.get("custId"));
			param.put("buyDeptId", param.get("deptId"));
			param.put("sellCustId", login.getCustId());
			param.put("sellDeptId", login.getDeptId());
		}
		
		List<Map<String, Object>> list = custService.getCustFrtCost(param);
		
		map.put("result", Boolean.TRUE);
		map.put("data", list);
		
		return "jsonView";
	}

	
	@PostMapping(value="/contents/basic/data/insertFrtCost.do")
	public String insertFrtCost(HttpServletRequest request, Model model, ModelMap map, @SessionAttribute("userInfo") LoginVO login,
								@RequestParam Map<String, Object> param) throws Exception {

		if(!EtcUtil.checkAuth(request, menuCode, "E")) {
			map.put("result", Boolean.FALSE);
			map.put("msg", "해당 권한이 없습니다.");
			
			return "jsonView";
		}
		
		if("01".equals(param.get("sellBuySctn"))) {	// 매출처 단가 입력 시,
			param.put("sellCustId", param.get("custId"));
			param.put("sellDeptId", param.get("deptId"));
			param.put("buyCustId", login.getCustId());
			param.put("buyDeptId", login.getDeptId());
		} else {									// 매입처 단가 입력 시,
			param.put("buyCustId", param.get("custId"));
			param.put("buyDeptId", param.get("deptId"));
			param.put("sellCustId", login.getCustId());
			param.put("sellDeptId", login.getDeptId());
		}
		//거래처에 등록된 계약단가가 있으면 모두 삭제
		custService.deleteCustFrtCost(param);
		
		//계약단가 data set
		String jsonParam = String.valueOf(param.get("gridData"));
		
		ObjectMapper objectMapper = new ObjectMapper();
		List<Map<String, Object>> readValue = objectMapper.readValue(jsonParam, new TypeReference<List<Map<String, Object>>>(){});
		List<Map<String, Object>> list = new ArrayList<>();
		
		int insertCount = 0;
		
		for(Iterator<Map<String, Object>> iter = readValue.iterator(); iter.hasNext();) {
			Map<String, Object> obj = iter.next();
			for(Map.Entry<String, Object> entry : obj.entrySet()) {
				if(entry.getKey().contains("carTonCode") && entry.getValue() != null ) {

					Map<String, Object> data  = new HashMap<>();
					
					data.put("sSido", obj.get("sSido"));
					data.put("sGungu", obj.get("sGungu"));
					data.put("eSido", obj.get("eSido"));
					data.put("eGungu", obj.get("eGungu"));
					data.put("carTonCode", entry.getKey().split("_")[1]);
					data.put("unitCost", entry.getValue());
					
					list.add(data);
				}
			}
			

			if(insertCount == 5 || !iter.hasNext()) {
				param.put("list", list);
				custService.insertCustFrtCost(param);
				insertCount = 0;
				list = new ArrayList<>();
			} else {
				insertCount++;
			}
		}
		
		map.put("result", Boolean.TRUE);
		map.put("msg", "정상 등록되었습니다.");
		
		return "jsonView";
	}
	
	@PostMapping(value="/contents/basic/data/deleteCustAddr.do")
	public String deleteCustAddr(HttpServletRequest request, Model model, ModelMap map, HttpSession session,
								@RequestParam Map<String, Object> param ) throws Exception {
		//권한 체크
		if(!EtcUtil.checkAuth(request, menuCodeAddr, "D")) {
			map.put("result", Boolean.FALSE);
			map.put("msg", "해당 권한이 없습니다.");
			
			return "jsonView";
		}
		
		custService.deleteCustAddr(param);
				
		map.put("result", Boolean.TRUE);
		map.put("msg", "주소지를 삭제했습니다.");
		
		return "jsonView";
	}
	
	@GetMapping(value="/contents/basic/custAddrBundle.do")
	public String custAddrBundle(HttpServletRequest request, HttpSession session, ModelMap model) {
		
		LoginMenuVO loginMenu = EtcUtil.checkAuth(request, menuCodeAddr);		
		model.put("menuAuth", loginMenu);
		
		return "contents/basic/custAddrBundle";
	}
	
	@PostMapping(value="/contents/basic/data/custAddrBundleWrite.do")
	public String orderBundleWrite(HttpServletRequest request, HttpSession session, Model model, ModelMap map,
									@RequestParam Map<String, Object> param) throws Exception {
		
		if(!EtcUtil.checkAuth(request, menuCodeAddr, "W")) {
			map.put("result", Boolean.FALSE);
			map.put("msg", "해당 권한이 없습니다.");
			
			return "jsonView";
		}
		
		String jsonParam = String.valueOf(param.get("gridData"));
		
		Map<String, Object> result = new HashMap<>();
		
		
		ObjectMapper objectMapper = new ObjectMapper();
		List<Map<String, Object>> readValue = objectMapper.readValue(jsonParam, new TypeReference<List<Map<String, Object>>>(){});
		
		apiHelper.setAdminKey(kakaoKey);
		
		int insertCount = 0;
		List<Map<String, Object>> insertMap = new ArrayList<>();
		ArrayList<Object> errAddrMap = new ArrayList<>();
		
		for(Iterator<Map<String, Object>> iter = readValue.iterator(); iter.hasNext();) {
			Map<String, Object> data = iter.next();
			if(!"".equals(data.get("addr")) && data.get("addr") != null) {
				Map<String, String> addrData = getGeo(String.valueOf(data.get("addr")));
				if(addrData.get("lat") == "errAddr") {
					/*map.put("result", Boolean.FALSE);*/
					/*map.put("msg", "유효하지 않은 주소입니다. \n주소를 정확하게 입력해주세요. \n" + data.get("addr"));*/
					/*return "jsonView";*/
					/*정확하지 않은 주소 따로 담아놓음*/
					ArrayList<Object> errAddr = new ArrayList<>();
					errAddr.add(data.get("addrName"));
					errAddr.add(data.get("addr"));
					errAddr.add(data.get("addrDetail"));
					errAddr.add(data.get("staffName"));
					errAddr.add(data.get("staffTel"));;
					errAddr.add(data.get("memo"));
					errAddrMap.add(errAddr);
				}else {
					data.put("lat", addrData.get("lat"));
					data.put("lon", addrData.get("lon"));
					data.put("sido", addrData.get("sido"));
					data.put("gungu", addrData.get("gungu"));
					data.put("dong", addrData.get("dong"));
					insertMap.add(data);
				}
				
			}
			
			/*등록 가능한 주소는 등록*/
			if(insertCount == 100 || !iter.hasNext()) {
				Map<String, Object> param2 = new HashMap<>();
				param2.put("addrList", insertMap);
				custService.insertCustAddrBundle(param2);
				
				insertMap = new ArrayList<>();
				insertCount = 0;
			} else {
				insertCount++;
			}
		}
		
		/*정확하지 않았던 주소 return*/
		int errAddrSize = errAddrMap.size();
		if(errAddrSize != 0) {
			map.put("errAddrList", errAddrMap);
			map.put("result", Boolean.FALSE);
			map.put("msg", "정확하지 않은 주소지 "+errAddrSize+"건을 제외하고 등록하였습니다. \n주소를 정확하게 입력하여 다시 등록해 주세요.");
			return "jsonView";
		}

		map.put("result", Boolean.TRUE);
		map.put("msg", "등록되었습니다.");
		
		return "jsonView";
	}
	
	private Map<String, String> getGeo(String addr) {
		Map<String, String> result = new HashMap<>();

		Map<String, String> paramMap = new HashMap<String, String>();
		paramMap.put("query", addr);
		
		Map<String, String> res = apiHelper.getLatLon(paramMap);

		String data = res.get("result");
		JSONParser parser = new JSONParser();
		JSONObject jsonObject = new JSONObject();
		String lat = "";
		String lon = "";
		String sido = "";
		String gungu = "";
		String dong = "";
		
		try {
			jsonObject = (JSONObject)parser.parse(data);
			JSONArray jsonArray = (JSONArray) jsonObject.get("documents");
			JSONObject tmpObj = (JSONObject) jsonArray.get(0);
			JSONObject tmpAddress = (JSONObject) tmpObj.get("address");
			lon = String.valueOf(tmpObj.get("x"));
			lat = String.valueOf(tmpObj.get("y"));
			sido = String.valueOf(tmpAddress.get("region_1depth_name"));
			gungu = String.valueOf(tmpAddress.get("region_2depth_name"));
			dong = String.valueOf(tmpAddress.get("region_3depth_name"));
		} catch (NullPointerException e) {
			JSONArray jsonArray = (JSONArray) jsonObject.get("documents");
			JSONObject tmpObj = (JSONObject) jsonArray.get(0);
			JSONObject tmpAddress = (JSONObject) tmpObj.get("road_address");
			lon = String.valueOf(tmpObj.get("x"));
			lat = String.valueOf(tmpObj.get("y"));
			sido = String.valueOf(tmpAddress.get("region_1depth_name"));
			gungu = String.valueOf(tmpAddress.get("region_2depth_name"));
			dong = String.valueOf(tmpAddress.get("region_3depth_name"));
		} catch (IndexOutOfBoundsException e) {
			lon = String.valueOf("errAddr");
			lat = String.valueOf("errAddr");
			sido = String.valueOf("errAddr");
			gungu = String.valueOf("errAddr");
			dong = String.valueOf("errAddr");
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		result.put("lat", lat);
		result.put("lon", lon);
		result.put("sido", sido);
		result.put("gungu", gungu);
		result.put("dong", dong);
		
		return result;
	}
	
	@PostMapping(value="/contents/basic/data/bizInfo.do")
	public String bizInfo(HttpServletRequest request, Model model, ModelMap map, HttpSession session,
								@RequestParam Map<String, Object> param ) throws Exception {	
		
		CustVO data = custService.getBizInfo(param);
		
		map.put("result", Boolean.TRUE);
		map.put("data", data);
		
		return "jsonView";
	}
	
	@PostMapping(value="/contents/basic/data/searchBizinfo.do")
	public String searchBizinfo(HttpServletRequest request, Model model, ModelMap map, HttpSession session,
								@RequestParam Map<String, Object> param ) throws Exception {
		
		List<CustVO> searchBizinfo = custService.searchBizinfoList(param); 
		int count = custService.searchBizinfoCnt(param);
		
		map.put("result", Boolean.TRUE);
		map.put("data", searchBizinfo);
		map.put("total", count);
		
		return "jsonView";
	}
}
