package com.logislink.omsCust.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
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
import com.logislink.basic.service.CustService;
import com.logislink.basic.vo.CustAddrVO;
import com.logislink.basic.vo.CustVO;
import com.logislink.cmm.helper.RestApiHelper;
import com.logislink.cmm.util.EtcUtil;
import com.logislink.login.vo.LoginMenuVO;
import com.logislink.login.vo.LoginVO;

@Controller
public class OmsCustController {
	
	private Logger log = Logger.getLogger(this.getClass());
	private String custMenuCode = "Z5310";
	private String custAddrMenuCode = "Z5610";
	private static RestApiHelper apiHelper = new RestApiHelper();
	
	@Value("#{globalProperties['Globals.kakaoKey']}")
	private String kakaoKey;

	@Resource(name="custService")
	private CustService custService;
	
	@GetMapping(value="/oms/cust/omsCustList.do")
	public String getCustList(HttpServletRequest request, HttpSession session, ModelMap model
									, @RequestParam Map<String, Object> param) {
		
		LoginMenuVO loginMenu = EtcUtil.checkAuth(request, custMenuCode);
		model.put("menuAuth", loginMenu);
		LoginVO login = (LoginVO) session.getAttribute("userInfo");
		if("N".equals(login.getMasterYn())) {
			model.put("masterYn", "N");
		}else {
			model.put("masterYn", "Y");
		}
		
		return "oms/cust/custList";
	}
	
	@GetMapping(value="/oms/cust/omsCustAddrList.do")
	public String getCustAddrList(HttpServletRequest request, HttpSession session, ModelMap model
									, @RequestParam Map<String, Object> param) {
		
		LoginMenuVO loginMenu = EtcUtil.checkAuth(request, custAddrMenuCode);
		model.put("menuAuth", loginMenu);
		LoginVO login = (LoginVO) session.getAttribute("userInfo");
		if("N".equals(login.getMasterYn())) {
			model.put("masterYn", "N");
		}else {
			model.put("masterYn", "Y");
		}
		
		return "oms/cust/custAddrList";
	}
	
	@GetMapping(value="/oms/cust/omsCustPriceList.do")
	public String getCustPriceList(HttpServletRequest request,  Model model, HttpSession session, ModelMap map, 
			 					@RequestParam Map<String, Object> param ) {
		
		map.put("custId", param.get("custId"));
		map.put("deptId", param.get("deptId"));

		LoginMenuVO loginMenu = EtcUtil.checkAuth(request, custMenuCode);		
		map.put("menuAuth", loginMenu);
		
		return "oms/cust/custPriceList";
	}
	
	@PostMapping(value="/oms/cust/data/custList.do")
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
	
	@PostMapping(value="/oms/cust/data/custAddrList.do")
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
	
	@PostMapping(value="/oms/cust/data/insertCustAddr.do")
	public String insertCustAddr(HttpServletRequest request, Model model, ModelMap map, HttpSession session,
								@RequestParam Map<String, Object> param ) throws Exception {
		
		//권한 체크
		if(!"".equals(param.get("addrSeq")) && param.get("addrSeq") != null ) {
			if(!EtcUtil.checkAuth(request, custAddrMenuCode, "E")) {
				map.put("result", Boolean.FALSE);
				map.put("msg", "해당 권한이 없습니다.");
				
				return "jsonView";
			}
		} else {
			if(!EtcUtil.checkAuth(request, custAddrMenuCode, "W")) {
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

	@PostMapping(value="/oms/cust/data/frtCostList.do")
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
	
	@GetMapping(value="/oms/cust/custAddrBundle.do")
	public String custAddrBundle(HttpServletRequest request, HttpSession session, ModelMap model) {
		
		LoginMenuVO loginMenu = EtcUtil.checkAuth(request, custAddrMenuCode);		
		model.put("menuAuth", loginMenu);
		
		return "oms/cust/custAddrBundle";
	}
	
	@PostMapping(value="/oms/cust/data/custAddrBundleWrite.do")
	public String orderBundleWrite(HttpServletRequest request, HttpSession session, Model model, ModelMap map,
									@RequestParam Map<String, Object> param) throws Exception {
		
		if(!EtcUtil.checkAuth(request, custAddrMenuCode, "W")) {
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
		
		for(Iterator<Map<String, Object>> iter = readValue.iterator(); iter.hasNext();) {
			Map<String, Object> data = iter.next();
			if(!"".equals(data.get("addr")) && data.get("addr") != null) {
				Map<String, String> addrData = getGeo(String.valueOf(data.get("addr")));
				if(addrData.get("lat") == "errAddr") {
					map.put("result", Boolean.FALSE);
					map.put("msg", "유효하지 않은 주소입니다. \n주소를 정확하게 입력해주세요.");
					return "jsonView";
				}else {
					data.put("lat", addrData.get("lat"));
					data.put("lon", addrData.get("lon"));
					data.put("sido", addrData.get("sido"));
					data.put("gungu", addrData.get("gungu"));
					data.put("dong", addrData.get("dong"));
				}
				
			}
			
			insertMap.add(data); 
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
}
