package com.logislink.order.controller;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collection;
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
import com.logislink.cmm.helper.RestApiHelper;
import com.logislink.cmm.service.RestService;
import com.logislink.cmm.util.DateUtil;
import com.logislink.cmm.util.EtcUtil;
import com.logislink.login.vo.LoginMenuVO;
import com.logislink.order.service.OrderBundleService;

@Controller
public class OrderBundleController {

	private Logger log = Logger.getLogger(this.getClass());
	private String bundleWriteCode = "B2310";
	private static RestApiHelper apiHelper = new RestApiHelper();
	
	@Value("#{globalProperties['Globals.kakaoKey']}")
	private String kakaoKey;
		
	@Resource(name="orderBundleService")
	private OrderBundleService orderBundleService;
	
	@Resource(name="restService")
	private RestService restService;

	@GetMapping(value="/contents/order/orderBundle.do")
	public String getOrderBundle(HttpServletRequest request, HttpSession session, ModelMap model) {
		LoginMenuVO loginMenu = EtcUtil.checkAuth(request, bundleWriteCode);
		model.put("menuAuth", loginMenu);
		
		return "contents/order/orderBundle";
	}
	
	@PostMapping(value="/contents/order/data/orderBundleWrite.do")
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
		
		
		ObjectMapper objectMapper = new ObjectMapper();
		List<Map<String, Object>> readValue = objectMapper.readValue(jsonParam, new TypeReference<List<Map<String, Object>>>(){});
		LinkedHashSet<Map<String, Object>> linkedHashSet = new LinkedHashSet<>();
		LinkedHashSet<Map<String, Object>> linkedHashSet2 = new LinkedHashSet<>();
		Map<String, Object> tmpDept;
		Map<String, Object> tmpCar;
		
		apiHelper.setAdminKey(kakaoKey);
		//excel 첫번째 필수항목(화주명) 이 없는 경우, list에서 삭제한다.
		for(Iterator<Map<String, Object>> iter = readValue.iterator(); iter.hasNext();) {
			
			Map<String, Object> data = iter.next();
			tmpDept = new HashMap<String, Object>();
			tmpCar = new HashMap<String, Object>();
			if("".equals(data.get("reqCustName")) || null == data.get("reqCustName")) {
				iter.remove();
				continue;
			}
			tmpDept.put("reqCustName", data.get("reqCustName"));
			tmpDept.put("reqDeptName", data.get("reqDeptName"));
			
			if(!"".equals(data.get("carNum")) && null != data.get("carNum") 
					&& !"".equals(data.get("driverTel")) && null != data.get("driverTel")) {
				tmpCar.put("carNum", data.get("carNum"));
				tmpCar.put("driverTel", data.get("driverTel"));
				tmpCar.put("driverName", data.get("driverName"));
				linkedHashSet2.add(tmpCar);
			}
			
			linkedHashSet.add(tmpDept);
		}
		
		// 등록된 거래처 목록 select
		Map<String, Object> custParam = new HashMap<>();
		List<Map<String, Object>> custList = new ArrayList<>();
		custParam.put("deptList", linkedHashSet);
		custList = orderBundleService.getCustId(custParam);
		
		List<Map<String, Object>> vehicList = new ArrayList<>();
		if(!linkedHashSet2.isEmpty()) {
			custParam = new HashMap<>();
			custParam.put("vehicList", linkedHashSet2);
			vehicList = orderBundleService.getVehicId(custParam);
		}
		
		int insertCount = 0;
		List<Map<String, Object>> insertMap = new ArrayList<>();
		List<String> calcOrderList = new ArrayList<>();
		
		if(linkedHashSet.size() != custList.size()) {
			List<Map<String, Object>> objList1 = new ArrayList<>();
			List<Map<String, Object>> objList2 = new ArrayList<>();

			for(Map<String, Object> item : custList) {
				Map<String, Object> obj = new HashMap<>();
				obj.put("custName", item.get("CUST_NAME"));
				obj.put("deptName", item.get("DEPT_NAME"));
				
				objList1.add(obj);
			}
			
			for(Map<String, Object> item : linkedHashSet) {
				Map<String, Object> obj = new HashMap<>();
				obj.put("custName", item.get("reqCustName"));
				obj.put("deptName", item.get("reqDeptName"));
				
				objList2.add(obj);
			}

			objList2.removeAll(objList1);
			
			map.put("result", Boolean.FALSE);
			map.put("msg", "유효하지 않은 거래처가 있습니다.\n\n등록된 거래처명과 담당부서를 정확하게 입력해주세요.");
			map.put("errReqInfo", objList2);
		} else if (linkedHashSet2.size() != vehicList.size()) {
			List<Map<String, Object>> objList1 = new ArrayList<>();
			List<Map<String, Object>> objList2 = new ArrayList<>();
			for(Map<String, Object> item : vehicList) {
				Map<String, Object> obj = new HashMap<>();
				obj.put("carNum", item.get("CAR_NUM"));
				obj.put("driverName", item.get("DRIVER_NAME"));
				obj.put("mobile", item.get("MOBILE").toString().replace("-", ""));
				
				objList1.add(obj);
			}
			
			for(Map<String, Object> item : linkedHashSet2) {
				Map<String, Object> obj = new HashMap<>();
				obj.put("carNum", item.get("carNum"));
				obj.put("driverName", item.get("driverName"));
				obj.put("mobile", item.get("driverTel").toString().replace("-", ""));
				
				objList2.add(obj);
			}
			
			objList2.removeAll(objList1);
			
			map.put("result", Boolean.FALSE);
			map.put("msg", "유효하지 않은 차량이 있습니다.\n\n등록된 차량정보를 정확하게 입력해주세요.");
			map.put("errDriverInfo", objList2);
		} else {
			for(Iterator<Map<String, Object>> iter = readValue.iterator(); iter.hasNext();) {				
				Map<String, Object> data = iter.next();

				String orderId = "E" + DateUtil.getDate("") + DateUtil.getHHmmss().replace(":", "");
				String allocId = "B" + DateUtil.getDate("") + DateUtil.getHHmmss().replace(":", "");
				String buyAllocId = allocId;

				String tmp = "00" + index ++; 
				orderId += tmp.substring(tmp.length()-3, tmp.length());
				allocId += tmp.substring(tmp.length()-3, tmp.length());
				tmp = "00" + index ++;
				buyAllocId += tmp.substring(tmp.length()-3, tmp.length());
				
				data.put("orderId", orderId);
				data.put("allocId", allocId);
				data.put("buyAllocId", buyAllocId);
				
				for(Map<String, Object> deptMap : custList) {
					if(deptMap.get("DEPT_NAME").equals(data.get("reqDeptName")) && deptMap.get("CUST_NAME").equals(data.get("reqCustName"))) {
						data.put("reqCustId", deptMap.get("CUST_ID"));
						data.put("reqDeptId", deptMap.get("DEPT_ID"));
						data.put("buyStaffId", deptMap.get("MANAGER"));
						break;
					}
				}
				
				if(data.get("carNum") != null && !"".equals(data.get("carNum"))) {
					for(Map<String, Object> vehicMap : vehicList) {
						if(vehicMap.get("CAR_NUM").equals(data.get("carNum")) && vehicMap.get("MOBILE").equals(data.get("driverTel"))
								&& vehicMap.get("DRIVER_NAME").equals(data.get("driverName"))) {
							data.put("vehicId", vehicMap.get("VEHIC_ID"));
							data.put("driverId", vehicMap.get("DRIVER_ID"));
							data.put("carNum", vehicMap.get("CAR_NUM"));
							data.put("driverName", vehicMap.get("DRIVER_NAME"));
							data.put("driverTel", vehicMap.get("MOBILE"));
							data.put("driverCarTonCode", vehicMap.get("CAR_TON_CODE"));
							data.put("driverCarTypeCode", vehicMap.get("CAR_TYPE_CODE"));
							
							data.put("orderState", "01");
							data.put("buyAllocState", "01");
							
							calcOrderList.add(String.valueOf(data.get("orderId")));
							break;
						}
					}
				}
/*				if(!"".equals(data.get("sAddr")) && data.get("sAddr") != null) {
					String sAddr = String.valueOf(data.get("sAddr")) + " ";
					int beginIndex = sAddr.indexOf(" ");
					int sLength = sAddr.length();
					data.put("sSido", sAddr.substring(0, beginIndex -1));
					
					if(beginIndex != sLength) {
						data.put("sGungu", sAddr.substring(beginIndex + 1, sLength -1));
					}
				}
				if(!"".equals(data.get("eAddr")) && data.get("eAddr") != null) {
					String eAddr = String.valueOf(data.get("eAddr")) + " ";
					int beginIndex = eAddr.indexOf(" ");
					int sLength = eAddr.length();
					data.put("eSido", eAddr.substring(0, beginIndex -1));
					
					if(beginIndex != sLength) {
						data.put("eGungu", eAddr.substring(beginIndex + 1, sLength -1));
					}
				}*/

				//과거 운송실적 저장 - API 통신 X
				if(!"".equals(data.get("sAddr")) && data.get("sAddr") != null) {
					Map<String, String> sData = getGeo(String.valueOf(data.get("sAddr")));
					
					if(sData == null) {
						map.put("result", Boolean.FALSE);
						map.put("msg", "잘못된 상차지주소지입니다. (" + data.get("sAddr") + ")");
						return "jsonView";
					}
					
					data.put("sLat", sData.get("lat"));
					data.put("sLon", sData.get("lon"));
					data.put("sSido", sData.get("sido"));
					data.put("sGungu", sData.get("gungu"));
					data.put("sDong", sData.get("dong"));
				}

				if(!"".equals(data.get("eAddr")) && data.get("eAddr") != null) {
					Map<String, String> eData = getGeo(String.valueOf(data.get("eAddr")));

					if(eData == null) {
						map.put("result", Boolean.FALSE);
						map.put("msg", "잘못된 하차지주소지입니다. (" + data.get("eAddr") + ")");
						return "jsonView";
					}
					
					data.put("eLat", eData.get("lat"));
					data.put("eLon", eData.get("lon"));
					data.put("eSido", eData.get("sido"));
					data.put("eGungu", eData.get("gungu"));
					data.put("eDong", eData.get("dong"));
				}
				
				Map<String, Object> routeMap = new HashMap<>();
				routeMap.put("sLat", data.get("sLat"));
				routeMap.put("sLng", data.get("sLon"));
				routeMap.put("eLat", data.get("eLat"));
				routeMap.put("eLng", data.get("eLon"));
				Map<String, String> routeRlt = restService.sendRouteApi(routeMap);
								
				data.put("time", routeRlt.get("Time"));
				data.put("distance", routeRlt.get("Distance"));
				
				data.put("sDate", data.get("sDate") + " " + data.get("sTime"));
				data.put("eDate", data.get("eDate") + " " + data.get("eTime"));
								
				insertMap.add(data);
				//mssql 최대 요청 가능 파라미터 갯수 2100개,, 이슈로 인해 30개씩 끊어서 저장
				if(insertCount == 30 || !iter.hasNext()) {
					Map<String, Object> param2 = new HashMap<>();
					param2.put("orderList", insertMap);
					orderBundleService.insertOrderBundle(param2);

					//배차 완료된 오더일 경우, 정산 정보 insert
					if(!calcOrderList.isEmpty()) {						
						param2.put("calcOrderList", calcOrderList);
						orderBundleService.insertCalc(param2);
					}
					insertMap = new ArrayList<>();
					calcOrderList = new ArrayList<>();
					insertCount = 0;
				} else {
					insertCount++;
				}
			}

			apiHelper.setAdminKey("");
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

		if (res == null) {
			return null;
		} else {
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
				
				if(jsonArray.isEmpty()) {
					return null;
				}
				
				JSONObject tmpObj = (JSONObject) jsonArray.get(0);
								
				JSONObject tmpAddress = null;
				if("ROAD".equals(tmpObj.get("address_type"))) {
					tmpAddress = (JSONObject) tmpObj.get("road_address");
				} else {
					tmpAddress = (JSONObject) tmpObj.get("address");
				}
				
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
		
	}
	
	@GetMapping(value="/contents/order/errDriverInfo.do")
	public String errDriverInfo(HttpServletRequest request, HttpSession session, ModelMap model) {
		return "contents/order/view/errDriverInfo";
	}	
	
	@GetMapping(value="/contents/order/errReqInfo.do")
	public String errReqInfo(HttpServletRequest request, HttpSession session, ModelMap model) {
		return "contents/order/view/errReqInfo";
	}	
}
