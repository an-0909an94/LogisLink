package com.logislink.omsOrder.controller;

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

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.logislink.basic.service.CustService;
import com.logislink.basic.vo.CustAddrVO;
import com.logislink.cmm.helper.RestApiHelper;
import com.logislink.cmm.service.RestService;
import com.logislink.cmm.util.DateUtil;
import com.logislink.cmm.util.EtcUtil;
import com.logislink.login.vo.LoginMenuVO;
import com.logislink.login.vo.LoginVO;
import com.logislink.omsOrder.service.OmsOrderService;
import com.logislink.omsOrder.vo.OmsOrderVO;
import com.logislink.order.service.OrderService;


@Controller
public class OmsOrderController {
	
	private Logger log = Logger.getLogger(this.getClass());
	private String orderCode = "Z5110";
	private String bundleWriteCode = "Z5210";
	private String addrCode = "Z5610";
	private String locationCode = "Z5810";
	private static RestApiHelper apiHelper = new RestApiHelper();

	@Value("#{globalProperties['Globals.kakaoKey']}")
	private String kakaoKey;

	@Resource(name="orderService")
	private OrderService orderService;
	
	@Resource(name="omsOrderService")
	private OmsOrderService omsOrderService;
	
	@Resource(name="custService")
	private CustService custService;
	
	@Resource(name="restService")
	private RestService restService;
	
	
	@GetMapping(value="/oms/order/omsOrderList.do")
	public String getOrderList(HttpServletRequest request, HttpSession session, ModelMap model
									, @RequestParam Map<String, Object> param) {
		
		LoginMenuVO loginMenu = EtcUtil.checkAuth(request, orderCode);
		model.put("menuAuth", loginMenu);
		LoginMenuVO addrMenu = EtcUtil.checkAuth(request, addrCode);
		model.put("addrAuth", addrMenu);
		LoginVO login = (LoginVO) session.getAttribute("userInfo");
		if("N".equals(login.getMasterYn())) {
			model.put("masterYn", "N");
		}else {
			model.put("masterYn", "Y");
		}
		
		return "oms/order/orderList";
	}
	
	@GetMapping(value="/oms/order/orderBundle.do")
	public String getOrderBundle(HttpServletRequest request, HttpSession session, ModelMap model) {
		LoginMenuVO loginMenu = EtcUtil.checkAuth(request, bundleWriteCode);
		model.put("menuAuth", loginMenu);
		
		return "oms/order/orderBundle";
	}
	
	@PostMapping(value="/oms/order/data/omsOrderList.do")
	public String orderListData(HttpServletRequest request, HttpSession session, Model model, ModelMap map,
							@RequestParam Map<String, Object> param) throws Exception {
		LoginVO login = (LoginVO) session.getAttribute("userInfo");
		String custId = login.getCustId();
		param.put("custId", custId);
		if("N".equals(login.getMasterYn())) {
			param.put("deptId", login.getDeptId());
		}
		
		List<OmsOrderVO> list = omsOrderService.getOmsOrderList(param);
		int count = omsOrderService.getCnt(param);
		
		map.put("data", list);
		map.put("total", count);
		
		return "jsonView";
	}
	
	//일괄등록
	@PostMapping(value="/oms/order/data/orderBundleWrite.do")
	public String orderBundleWrite(HttpServletRequest request, HttpSession session, Model model, ModelMap map,
									@RequestParam Map<String, Object> param) throws Exception {

		if(!EtcUtil.checkAuth(request, bundleWriteCode, "W")) {
			map.put("result", Boolean.FALSE);
			map.put("msg", "해당 권한이 없습니다.");
			
			return "jsonView";
		}
		
		String jsonParam = String.valueOf(param.get("gridData"));
		int index = 0;
		
		Map<String, Object> result = new HashMap<>();
		LoginVO login = (LoginVO) session.getAttribute("userInfo");
		String regId = login.getUserId();
		
		ObjectMapper objectMapper = new ObjectMapper();
		List<Map<String, Object>> readValue = objectMapper.readValue(jsonParam, new TypeReference<List<Map<String, Object>>>(){});
		List<Map<String, Object>> deptList = new ArrayList<>();
		LinkedHashSet<Map<String, Object>> linkedHashSet = new LinkedHashSet<>();
		
		apiHelper.setAdminKey(kakaoKey);
		for(Iterator<Map<String, Object>> iter = readValue.iterator(); iter.hasNext();) {
			
			Map<String, Object> data = iter.next();
			Map<String, Object> tmpDept = new HashMap<String, Object>();
			
			tmpDept.put("buyCustName", data.get("buyCustName"));
			tmpDept.put("buyDeptName", data.get("buyDeptName"));
			
			linkedHashSet.add(tmpDept);
		}
		Map<String, Object> custParam = new HashMap<>();
		List<Map<String, Object>> custList = new ArrayList<>();
		custParam.put("deptList", linkedHashSet);
		custList = omsOrderService.getCustId(custParam);
		
		if(linkedHashSet.size() != custList.size()) {
			map.put("result", Boolean.FALSE);
			map.put("msg", "유효하지 않은 거래처가 있습니다.");
		} else {
			for(Iterator<Map<String, Object>> iter = readValue.iterator(); iter.hasNext();) {				
				Map<String, Object> data = iter.next();

				String orderId = "O" + DateUtil.getDate("") + DateUtil.getHHmmss().replace(":", "");
				String allocId = "A" + DateUtil.getDate("") + DateUtil.getHHmmss().replace(":", "");

				String tmp = "00" + index ++; 
				orderId += tmp.substring(tmp.length()-3, tmp.length());
				allocId += tmp.substring(tmp.length()-3, tmp.length());			
				
				data.put("orderId", orderId);
				data.put("allocId", allocId);
				data.put("reqStaffId", regId);
				data.put("regId", regId);
				
				for(Map<String, Object> deptMap : custList) {
					if(deptMap.get("DEPT_NAME").equals(data.get("buyDeptName")) && deptMap.get("CUST_NAME").equals(data.get("buyCustName"))) {
						data.put("buyCustId", deptMap.get("CUST_ID"));
						data.put("buyDeptId", deptMap.get("DEPT_ID"));
						data.put("buyStaff", deptMap.get("MANAGER"));
						break;
					}
				}			
				
				if(!"".equals(data.get("sAddr")) && data.get("sAddr") != null) {
					Map<String, String> sData = getGeo(String.valueOf(data.get("sAddr")));
					
					data.put("sLat", sData.get("lat"));
					data.put("sLon", sData.get("lon"));
					data.put("sSido", sData.get("sido"));
					data.put("sGungu", sData.get("gungu"));
					data.put("sDong", sData.get("dong"));
				}

				if(!"".equals(data.get("eAddr")) && data.get("eAddr") != null) {
					Map<String, String> eData = getGeo(String.valueOf(data.get("eAddr")));
					
					data.put("eLat", eData.get("lat"));
					data.put("eLon", eData.get("lon"));
					data.put("eSido", eData.get("sido"));
					data.put("eGungu", eData.get("gungu"));
					data.put("eDong", eData.get("dong"));
				}
				
				data.put("sDate", data.get("sDate") + " " + data.get("sTime"));
				data.put("eDate", data.get("eDate") + " " + data.get("eTime"));
				
				Map<String, Object> routeMap = new HashMap<>();
				routeMap.put("sLat", data.get("sLat"));
				routeMap.put("sLng", data.get("sLon"));
				routeMap.put("eLat", data.get("eLat"));
				routeMap.put("eLng", data.get("eLon"));
				Map<String, String> routeRlt = restService.sendRouteApi(routeMap);
				
				param.put("time", routeRlt.get("Time"));
				param.put("distance", routeRlt.get("Distance"));	
			}

			
			apiHelper.setAdminKey("");
			param.put("orderList", readValue);
			
			omsOrderService.insertOrderBundle(param);
			map.put("result", Boolean.TRUE);
			map.put("msg", "등록되었습니다.");
		}
		
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
	
	@PostMapping(value="/oms/order/data/orderWrite.do")
	public String orderWrite(HttpServletRequest request, HttpSession session, Model model, ModelMap map,
							@RequestParam Map<String, Object> param) throws Exception{
		
		String resMsg = "";
		
		if("E".equals(param.get("mode"))) {
			if(!EtcUtil.checkAuth(request, orderCode, "E")) {
				map.put("result", Boolean.FALSE);
				map.put("msg", "해당 권한이 없습니다.");
				
				return "jsonView";
			}
			param.put("editId", ((LoginVO) session.getAttribute("userInfo")).getUserId());
//			
//			param.put("custId", param.get("buyCustId"));
//			param.put("deptId", param.get("buyDeptId"));				

		} else {
			if(!EtcUtil.checkAuth(request, orderCode, "W")) {
				map.put("result", Boolean.FALSE);
				map.put("msg", "해당 권한이 없습니다.");
				
				return "jsonView";
			}			
			param.put("regId", ((LoginVO) session.getAttribute("userInfo")).getUserId());

			param.put("sellCustId", ((LoginVO) session.getAttribute("userInfo")).getCustId());
			param.put("sellDeptId", ((LoginVO) session.getAttribute("userInfo")).getDeptId());
			param.put("sellStaffId", ((LoginVO) session.getAttribute("userInfo")).getUserId());
//			param.put("custId", param.get("buyCustId"));
//			param.put("deptId", param.get("buyDeptId"));
			param.put("chargeType", "01");
		} 
		
		
		param.put("loginId", ((LoginVO) session.getAttribute("userInfo")).getUserId());
		
		omsOrderService.orderWrite(param);
		
		param.put("orderId", param.get("retId"));	
		
		ObjectMapper objectMapper ;
		if(param.get("orderStopData") != null && !"".equals(param.get("orderStopData"))) {

			String jsonParam = String.valueOf(param.get("orderStopData"));
			
			objectMapper = new ObjectMapper(); 
			List<Map<String, Object>> readValue = objectMapper.readValue(jsonParam, new TypeReference<List<Map<String, Object>>>(){});
			
			param.put("list", readValue);
			orderService.insertOrderStop(param);

		}
		if ("Y".equals(param.get("sAreaSave"))) {
			CustAddrVO sAddr = new CustAddrVO((String) param.get("custId")
					, (String) param.get("deptId") 
					, (String) param.get("sComName")
					, (String) param.get("sAddr")
					, (String) param.get("sAddrDetail")
					, (String) param.get("sLat")
					, (String) param.get("sLon")
					, (String) param.get("sStaff")
					, (String) param.get("sTel")
					, (String) param.get("sMemo")
					, (String) param.get("regId")
					, (String) param.get("sSido")
					, (String) param.get("sGungu")
					, (String) param.get("sDong")
					, "O");
				
					
			objectMapper = new ObjectMapper();
			Map<String, Object> param1 = objectMapper.convertValue(sAddr, Map.class);
			
			custService.insertCustAddr(param1);
		}
		
		if ("Y".equals(param.get("eAreaSave"))) {
			CustAddrVO eAddr = new CustAddrVO((String) param.get("custId")
					, (String) param.get("deptId") 
					, (String) param.get("eComName")
					, (String) param.get("eAddr")
					, (String) param.get("eAddrDetail")
					, (String) param.get("eLat")
					, (String) param.get("eLon")
					, (String) param.get("eStaff")
					, (String) param.get("eTel")
					, (String) param.get("eMemo")
					, (String) param.get("regId")
					, (String) param.get("eSido")
					, (String) param.get("eGungu")
					, (String) param.get("eDong")
					, "O");
				   
				
					
			objectMapper = new ObjectMapper()	;
			Map<String, Object> param1 = objectMapper.convertValue(eAddr, Map.class);
			
			custService.insertCustAddr(param1);
		}
		
		
		resMsg = (String) param.get("retMsg");
		
		map.put("result", Boolean.TRUE);
		map.put("data", param);
		map.put("msg", resMsg);
		
		return "jsonView";
		
	}
	
	@GetMapping(value="/oms/order/view/orderStopDetail.do")
	public String getOrderStopDetail(HttpServletRequest request, HttpSession session, ModelMap model
									, @RequestParam Map<String, Object> param) {
		model.addAttribute("orderId", param.get("orderId"));
		return "contents/order/view/orderStopDetail";
	}
	
	@GetMapping(value="/oms/order/omsOrderLocationList.do")
	public String getOrderLocationList(HttpServletRequest request, HttpSession session, ModelMap model
									, @RequestParam Map<String, Object> param) {
		
		LoginMenuVO loginMenu = EtcUtil.checkAuth(request, locationCode);
		model.put("menuAuth", loginMenu);

		LoginVO login = (LoginVO) session.getAttribute("userInfo");
		if("N".equals(login.getMasterYn())) {
			model.put("masterYn", "N");
		}else {
			model.put("masterYn", "Y");
		}
		
		return "oms/order/orderLocationList";
	}
	
	@PostMapping(value="/oms/order/data/omsOrderLocationList.do")
	public String orderLocationListData(HttpServletRequest request, HttpSession session, Model model, ModelMap map,
							@RequestParam Map<String, Object> param) throws Exception {
		LoginVO login = (LoginVO) session.getAttribute("userInfo");
		String custId = login.getCustId();
		param.put("custId", custId);
		if("N".equals(login.getMasterYn())) {
			param.put("deptId", login.getDeptId());
		}
		
		List<OmsOrderVO> list = omsOrderService.getOmsOrderLocationList(param);
		int count = omsOrderService.getOmsOrderLocationCnt(param);
		
		map.put("data", list);
		map.put("total", count);
		
		return "jsonView";
	}
	
	@PostMapping(value="/contents/order/data/omsOrderSummary.do")
	public String orderCount(HttpServletRequest request, HttpSession session, Model model, ModelMap map,
							@RequestParam Map<String, Object> param) throws Exception {
		LoginVO login = (LoginVO) session.getAttribute("userInfo");
		String custId = login.getCustId();
		param.put("custId", custId);
		if("N".equals(login.getMasterYn())) {
			param.put("deptId", login.getDeptId());
		}

		Map<String, Object> data = omsOrderService.getOmsOrderSummary(param);
		
		map.put("data", data);
		
		return "jsonView";
	}
}
