package com.logislink.order.controller;

import java.math.BigInteger;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.logislink.basic.service.CarService;
import com.logislink.basic.service.CustService;
import com.logislink.basic.vo.CustAddrVO;
import com.logislink.basic.vo.DrvLocVO;
import com.logislink.calc.service.CalcService;
import com.logislink.cmm.service.CmmService;
import com.logislink.cmm.service.RestService;
import com.logislink.cmm.util.EtcUtil;
import com.logislink.login.vo.LoginMenuVO;
import com.logislink.login.vo.LoginVO;
import com.logislink.order.service.OrderService;
import com.logislink.order.vo.OrderStopVO;
import com.logislink.order.vo.OrderVO;

@Controller
public class OrderController {

	private Logger log = Logger.getLogger(this.getClass());
	private String orderCode = "B2110";
	private String addrCode = "A1510";
	private String situationCode = "B2410";
	private String freightControCode = "B2510";

	@Value("#{globalProperties['Globals.mainCustId']}")
	private String mainCustId;
	
	@Resource(name="orderService")
	private OrderService orderService;

	@Resource(name="custService")
	private CustService custService;
	
	@Resource(name="carService")
	private CarService carService;
	
	@Resource(name="calcService")
	private CalcService calcService;

	@Resource(name="cmmService")
	private CmmService cmmService;
	
	@Autowired
	private RestService restService;
	
	@GetMapping(value="/contents/order/view/orderStopDetail.do")
	public String getOrderStopDetail(HttpServletRequest request, HttpSession session, ModelMap model
									, @RequestParam Map<String, Object> param) {
		model.addAttribute("orderId", param.get("orderId"));
		model.addAttribute("deptId", param.get("deptId"));
		return "contents/order/view/orderStopDetail";
	}
	
	@GetMapping(value="/contents/order/orderList.do")
	public String getOrderList(HttpServletRequest request, HttpSession session, ModelMap model) {

		LoginMenuVO loginMenu = EtcUtil.checkAuth(request, orderCode);
		model.put("menuAuth", loginMenu);
		LoginMenuVO addrMenu = EtcUtil.checkAuth(request, addrCode);
		model.put("addrAuth", addrMenu);
		model.put("mainCustId", mainCustId);
		return "contents/order/orderList";
	}
	
	@GetMapping(value="/contents/order/view/sendLinkPop.do")
	public String sendLinkPop(HttpServletRequest request, HttpServletResponse response, Model model,
								ModelMap map, @RequestParam Map<String, Object> param) throws Exception {

		String charge = "";
		if(param.get("allocId") != null) {
			Map<String, Object> chargeMap = orderService.getAllocCharge(param);
			
			if(chargeMap != null) {
				charge = String.valueOf(chargeMap.get("charge"));
			}	
		}
		
		/*int avgFare = orderService.getAvgFare(param);
		model.addAttribute("avgFare", ("".equals(avgFare + "")) ? 0 : avgFare);*/
		model.addAttribute("allocCharge", charge);
		return "contents/order/view/sendLinkPop";
	}
	
	@PostMapping(value="/contents/order/data/orderWrite.do")
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
		} else if("N".equals(param.get("mode"))) {
			if(!EtcUtil.checkAuth(request, orderCode, "W")) {
				map.put("result", Boolean.FALSE);
				map.put("msg", "해당 권한이 없습니다.");
				
				return "jsonView";
			}			
			param.put("regId", ((LoginVO) session.getAttribute("userInfo")).getUserId());
		} 

		param.put("custId", ((LoginVO) session.getAttribute("userInfo")).getCustId());
		//param.put("deptId", ((LoginVO) session.getAttribute("userInfo")).getDeptId());
		
		
		param.put("loginId", ((LoginVO) session.getAttribute("userInfo")).getUserId());
		orderService.orderWrite(param);
		/*
		if(param.get("carSctnCode") != "") {
			carService.updateCarSctnCode(param);
		}*/
		
		param.put("orderId", param.get("retId"));	
		
		ObjectMapper objectMapper ;
		if(param.get("orderStopData") != null && !"".equals(param.get("orderStopData"))) {

			String jsonParam = String.valueOf(param.get("orderStopData"));
			
			objectMapper = new ObjectMapper(); 
			List<Map<String, Object>> readValue = objectMapper.readValue(jsonParam, new TypeReference<List<Map<String, Object>>>(){});
			
			param.put("list", readValue);
			orderService.insertOrderStop(param);

		}
		//매입추가비용 저장
		if(param.get("addCodeList") != null && param.get("outBuyTaxCnt") == null && "00".equals(param.get("retCode"))) {
			List<String> codeList = Arrays.asList(((String) param.get("addCodeList")).split("╊"));
			List<String> chargeList = Arrays.asList(((String) param.get("addChargeList")).split("╊"));
			List<String> memoList = Arrays.asList(((String) param.get("addMemoList")).split("╊"));
			
			if(!chargeList.isEmpty()) {
				List<Map<String, Object>> addList = new ArrayList<>();
				for(int i=0; i < codeList.size(); i++) {
					Map<String, Object > tmp = new HashMap<>();
					tmp.put("code", codeList.get(i));
					tmp.put("charge", chargeList.get(i));
					tmp.put("memo", memoList.get(i));
					
					addList.add(tmp);
				}

				if (!addList.isEmpty()) {
					if(param.get("allocId") == "" || param.get("allocId") == null){
						param.put("allocId", param.get("buyAllocId"));
					}else {
						param.put("allocId", param.get("allocId"));
					}
					param.put("sellBuySctn", "02");
					param.put("addList", addList);
					orderService.multOrderAllocAddInsert(param);

					//차량이나 운송사가 지정 됐을 경우, 추가운임을 정산에 반영한다.
					if(param.get("buyCarNum") != null && !"".equals(param.get("buyCarNum"))) {
						orderService.insertAllocAddToCalc(param);
					}
					
				}	
			}
		}
		
		//매출추가비용 저장
		if(param.get("addSellCodeList") != null && param.get("outSellTaxCnt") == null && "00".equals(param.get("retCode"))) {
			List<String> codeList = Arrays.asList(((String) param.get("addSellCodeList")).split("╊"));
			List<String> chargeList = Arrays.asList(((String) param.get("addSellChargeList")).split("╊"));
			List<String> memoList = Arrays.asList(((String) param.get("addSellMemoList")).split("╊"));
			
			if(!chargeList.isEmpty()) {
				List<Map<String, Object>> addList = new ArrayList<>();
				for(int i=0; i < codeList.size(); i++) {
					Map<String, Object > tmp = new HashMap<>();
					tmp.put("code", codeList.get(i));
					tmp.put("charge", chargeList.get(i));
					tmp.put("memo", memoList.get(i));
					
					addList.add(tmp);
				}

				if (!addList.isEmpty()) {
					if(param.get("sellAllocId") == "" || param.get("sellAllocId") == null){
						param.put("allocId", param.get("sellOutAllocId"));
					}else {
						param.put("allocId", param.get("sellAllocId"));
					}
					param.put("sellBuySctn", "01");
					param.put("addList", addList);
					orderService.multOrderAllocAddInsert(param);

					//차량이 지정 됐을 경우(배차 상태인 경우) 추가운임을 정산에 반영한다.
					if(param.get("buyCarNum") != null && !"".equals(param.get("buyCarNum"))) {
						orderService.insertAllocAddToCalc(param);
					}
					
				}	
			}
		}
		

		//날씨정보 (접수-> 배차 시 추가정보 요청)
		/*if(("00".equals(param.get("allocState")) || "".equals(param.get("allocState")) ) &&  param.get("buyCarNum") != null && !"".equals(param.get("buyCarNum"))) {
			//날씨 정보 요청
			Map<String, Object> apiParam = new HashMap<>();
			apiParam.put("lat", param.get("sLat"));
			apiParam.put("lon", param.get("sLon"));
			apiParam.put("orderId", param.get("orderId"));
			apiParam.put("allocState", "01");
			Map<String, String> weatherMap = restService.sendWeatherApi(apiParam);		
			if(weatherMap != null) cmmService.insertWeatherInfo(weatherMap);
			
			//유가 정보 요청
			apiParam = new HashMap<>();
			String sGungu = String.valueOf(param.get("sGungu"));
			if(!"".equals(sGungu) && sGungu != null  )	sGungu = sGungu.split(" ")[0];
			apiParam.put("sido", param.get("sSido"));
			apiParam.put("sigun", sGungu);
			Map<String, Object> opiMap = restService.sendOpinetApi(apiParam);	
			if(opiMap != null) cmmService.insertOpiInfo(opiMap);
		}*/
		
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
				   
			objectMapper = new ObjectMapper();
			Map<String, Object> param1 = objectMapper.convertValue(eAddr, Map.class);
			
			custService.insertCustAddr(param1);
		}
		
		
		resMsg = (String) param.get("retMsg");
		
		map.put("result", Boolean.TRUE);
		map.put("data", param);
		map.put("msg", resMsg);
		
		return "jsonView";
		
	}
	
	@PostMapping(value="/contents/order/data/orderList.do")
	public String orderList(HttpServletRequest request, HttpSession session, Model model, ModelMap map,
							@RequestParam Map<String, Object> param) throws Exception {
		LoginVO login = (LoginVO) session.getAttribute("userInfo");
		String custId = login.getCustId();
		//String deptId = login.getDeptId();

		String allocState = String.valueOf(param.get("sAllocState"));
		
		if (param.get("sAllocState") != null && !"".equals(param.get("sAllocState"))) {
			if ("01,04,05,12".indexOf(allocState) >= 0) {
				param.put("driverState", allocState);
			} else {
				param.put("allocState", allocState);
			}
		}
		
		param.put("custId", custId);
		param.put("deptId", param.get("sDeptId"));
		
		List<OrderVO> list = orderService.getOrderList(param);
		Map<String,Object> count = orderService.getCnt(param);
		
		map.put("data", list);
		map.put("total", count.get("retCnt"));
		map.put("summary", count);
		
		return "jsonView";
	}

	@PostMapping(value="/contents/order/data/orderDetail.do")
	public String orderDetail(HttpServletRequest request, HttpSession session, Model model, ModelMap map,
							@RequestParam Map<String, Object> param) throws Exception {
		LoginVO login = (LoginVO) session.getAttribute("userInfo");
		String custId = login.getCustId();

		param.put("custId", custId);
		
		OrderVO data = orderService.getOrderDetail(param);
		
		map.put("result", Boolean.TRUE);
		map.put("data", data);
		
		return "jsonView";
	}
	
	@PostMapping(value="/contents/order/data/orderStopList.do")
	public String orderStopList(HttpServletRequest request, HttpSession session, Model model, ModelMap map,
								@RequestParam Map<String, Object> param) throws Exception {
		
		List<OrderStopVO> list = orderService.getOrderStop(param);
		
		map.put("result", Boolean.TRUE);
		map.put("data", list);
		
		return "jsonView";
	}
	
	@PostMapping(value="/contents/order/data/orderLbsList.do")
	public String orderLbsList(HttpServletRequest request, HttpSession session, Model model, ModelMap map,
								@RequestParam Map<String, Object> param) throws Exception {
		
		List<DrvLocVO> list = orderService.getOrderLbs(param);

		if(list.isEmpty()) {
			map.put("result", Boolean.FALSE);
			map.put("msg", "위치 정보가 없습니다.");
		} else {
			map.put("result", Boolean.TRUE);
			map.put("data", list);	
		}
		
		return "jsonView";
	}
	
	@PostMapping(value="/contents/order/data/orderStopFinish.do")
	public String orderStopFinish(HttpServletRequest request, HttpSession session, Model model, ModelMap map,
			@RequestParam Map<String, Object> param) throws Exception {

		orderService.updateOrderStopFinish(param);
		
		map.put("result", Boolean.TRUE);
		map.put("msg", "도착 처리 되었습니다.");
		
		return "jsonView";
	}
		
	@GetMapping(value="/contents/order/view/viewLocation.do")
	public String orderCar(HttpServletRequest request, HttpSession session, ModelMap model) {
		return "contents/order/view/viewLocation";
	}	
	
	@PostMapping(value="/contents/order/data/linkList.do")
	public String linkList(HttpServletRequest request, HttpSession session, Model model, ModelMap map,
							@RequestParam Map<String, Object> param) throws Exception {
		List<Map<String, Object>> linkList = orderService.getLinkList(param);
		int count = orderService.getLinkCnt(param);
		
		map.put("data", linkList);
		map.put("total", count);
		
		return "jsonView";
	}
	
	@PostMapping(value="/contents/order/data/linkWrite.do")
	public String linkWrite(HttpServletRequest request, HttpSession session, Model model, ModelMap map,
							@RequestParam Map<String, Object> param) throws Exception{
		
		String resMsg = "";
		
		param.put("linkStatus", "11");
		param.put("regId", ((LoginVO) session.getAttribute("userInfo")).getUserId());
		List<String> linkTypeList = Arrays.asList(((String) param.get("linkTypes")).split(","));
		String[] linkTypeArr = ((String)param.get("linkTypes")).split(",");

		//정보망 상/하차일 검증
		if ("ADDORDER".equals(param.get("command")) || "MODORDER".equals(param.get("command")) || "REOPENORDER".equals(param.get("command"))) {

			HashMap<String, Object> linkDate = orderService.linkDateChk(param);
			
			if("00".equals(linkDate.get("retCode"))) {
				map.put("result", Boolean.TRUE);
				map.put("cnt", linkDate.get("retCnt"));
				map.put("msg", "");
			} else if("99".equals(linkDate.get("retCode"))) {
				map.put("result", Boolean.FALSE);
				map.put("msg", linkDate.get("retMsg"));
				return "jsonView";	
			}
		} 
		
		for(int i=0; i < linkTypeList.size(); i++) {
			//정보망 톤수 검증
			param.put("linkTypes", linkTypeArr[i]);
			HashMap<String, Object> carTon = orderService.linkCarTonChk(param);
			if("00".equals(carTon.get("retCode"))) {
				map.put("result", Boolean.TRUE);
				map.put("cnt", carTon.get("retCnt"));
				map.put("msg", "");
			} else if("99".equals(carTon.get("retCode"))) {
				map.put("result", Boolean.FALSE);
				map.put("msg", carTon.get("retMsg"));
				return "jsonView";	
			}
			
			//정보망 차종 검증		
			HashMap<String, Object> carType = orderService.linkCarTypeChk(param);
			if("00".equals(carType.get("retCode"))) {
				map.put("result", Boolean.TRUE);
				map.put("cnt", carType.get("retCnt"));
				map.put("msg", "");
			} else if("99".equals(carType.get("retCode"))) {
				map.put("result", Boolean.FALSE);
				map.put("msg", carType.get("retMsg"));
				return "jsonView";	
			}
			
			if(param.get("linkTypes") != null) {
				orderService.linkWrite(param);
			}
		}

		if(param.get("linkTypes") == null) {
	        param.put("linkTypes", param.get("linkType"));
			orderService.linkWrite(param);	
		}
		
		if(!"00".equals(param.get("retCode"))) {
			map.put("result", Boolean.FALSE);
			map.put("msg", param.get("retMsg"));
		} else {
			map.put("result", Boolean.TRUE);
			map.put("msg", param.get("retMsg"));	
			map.put("oAllocId", param.get("oAllocId"));
		}
		
		
		return "jsonView";		
	}

	@PostMapping(value="/contents/order/data/orderState.do")
	public String orderState(HttpServletRequest request, HttpSession session, Model model, ModelMap map,
								@RequestParam Map<String, Object> param ) throws Exception {

		orderService.updateOrderState(param);

		if(!"00".equals(param.get("retCode"))) {
			map.put("result", Boolean.FALSE);
			map.put("msg", param.get("retMsg"));
		} else {
			map.put("result", Boolean.TRUE);
			map.put("msg", param.get("retMsg"));	
		}
		return "jsonView";		
	}
	
	@PostMapping(value="/contents/order/data/orderAlloc.do")
	public String orderAlloc(HttpServletRequest request, HttpSession session, Model model, ModelMap map,
								@RequestParam Map<String, Object> param ) throws Exception {

		if("".equals(param.get("staffId")) || param.get("staffId") == null ) {
			param.put("staffId", ((LoginVO) session.getAttribute("userInfo")).getUserId());
		}
		
		orderService.updateOrderAlloc(param);

		if(!"00".equals(param.get("retCode"))) {
			map.put("result", Boolean.FALSE);
			map.put("msg", param.get("retMsg"));
		} else {
			map.put("result", Boolean.TRUE);
			map.put("msg", param.get("retMsg"));	
		}
		
		return "jsonView";		
	}	
	
	@PostMapping(value="/contents/order/data/allocState.do")
	public String allocState(HttpServletRequest request, HttpSession session, Model model, ModelMap map,
								@RequestParam Map<String, Object> param ) throws Exception {

		orderService.updateAllocState(param);
		
		if(!"00".equals(param.get("retCode"))) {
			map.put("result", Boolean.FALSE);
			map.put("msg", param.get("retMsg"));
		} else {
			map.put("result", Boolean.TRUE);
			map.put("msg", param.get("retMsg"));	
		}
		
		return "jsonView";		
	}
	
	@PostMapping(value="/contents/order/data/getCharge.do")
	public String getCharge(HttpServletRequest request, HttpSession session, Model model, ModelMap map,
							@RequestParam Map<String, Object> param) throws Exception{
		
		String resMsg = "";
		
		if("S".equals((String)param.get("mode"))) {
			param.put("buyCustId", ((LoginVO) session.getAttribute("userInfo")).getCustId());
			param.put("buyDeptId", ((LoginVO) session.getAttribute("userInfo")).getDeptId());
		} else if("B".equals((String)param.get("mode"))) {
			param.put("sellCustId", ((LoginVO) session.getAttribute("userInfo")).getCustId());
			param.put("sellDeptId", ((LoginVO) session.getAttribute("userInfo")).getDeptId());
		}
		
		BigInteger charge = orderService.getCharge(param);
		
		map.put("result", Boolean.TRUE);
		map.put("charge", charge.toString());
		
		return "jsonView";
		
	}
	
	@PostMapping(value="/contents/order/data/linkCancelOrder.do")
	public String linkCancelOrder(HttpServletRequest request, HttpSession session, Model model, ModelMap map,
							@RequestParam Map<String, Object> param) throws Exception{
		
		param.put("regId", ((LoginVO) session.getAttribute("userInfo")).getUserId());
		
		orderService.linkCancelOrder(param);
		
		if(!"00".equals(param.get("retCode"))) {
			map.put("result", Boolean.FALSE);
		} else {
			map.put("result", Boolean.TRUE);
		}
		
		
		return "jsonView";		
	}

	@PostMapping(value="/contents/order/data/linkSettle.do")
	public String linkSettle(HttpServletRequest request, HttpSession session, Model model, ModelMap map,
							@RequestParam Map<String, Object> param) throws Exception{

		param.put("regId", ((LoginVO) session.getAttribute("userInfo")).getUserId());
		
		orderService.linkSettle(param);
		
		if("00".equals(param.get("retCode"))) {
			map.put("result", Boolean.TRUE);
			map.put("msg", param.get("retMsg"));	
		} else if("99".equals(param.get("retCode"))) {
			map.put("result", Boolean.FALSE);
			map.put("msg", param.get("retMsg"));	
		}
		
		return "jsonView";		
	}

	@GetMapping(value="/contents/order/view/driverOrderHistory.do")
	public String driverOrderHistoryView(HttpServletRequest request, HttpSession session, ModelMap model) {
		return "contents/order/view/driverOrderHistory";
	}	
	
	@PostMapping(value="/contents/order/data/driverOrderHistory.do")
	public String driverOrderHistory(HttpServletRequest request, HttpSession session, Model model, ModelMap map,
							@RequestParam Map<String, Object> param) throws Exception {
		LoginVO login = (LoginVO) session.getAttribute("userInfo");
		String custId = login.getCustId();

		String allocState = String.valueOf(param.get("sAllocState"));
		
		if (param.get("sAllocState") != null && !"".equals(param.get("sAllocState"))) {
			if ("01,04,05,12".indexOf(allocState) >= 0) {
				param.put("driverState", allocState);
			} else {
				param.put("allocState", allocState);
			}
		}
		
		param.put("custId", custId);
		
		List<Map<String,Object>> list = orderService.getDriverOrderHistoryList(param);
		int count = orderService.getDriverOrderHistoryCnt(param);
		
		map.put("data", list);
		map.put("total", count);
		
		return "jsonView";
	}
	
	@GetMapping(value = "/contents/order/view/linkDriverView.do")
	public String linkDriverView(HttpServletRequest request, HttpSession session, ModelMap model) {
		return "contents/order/view/linkDriverView";
	}

	@PostMapping(value = "/contents/order/data/updateLinkDriver.do")
	public String updateLinkDriver(HttpServletRequest request, HttpSession session, Model model, ModelMap map,
			@RequestParam Map<String, Object> param) throws Exception {
		LoginVO login = (LoginVO) session.getAttribute("userInfo");
		String custId = login.getCustId();

		param.put("custId", custId);
		param.put("deptId", param.get("sDeptId"));

		orderService.updateLinkDriver(param);

		if ("00".equals(param.get("retCode"))) {
			map.put("result", Boolean.TRUE);
			map.put("msg", param.get("retMsg"));
		} else if ("99".equals(param.get("retCode"))) {
			map.put("result", Boolean.FALSE);
			map.put("msg", param.get("retMsg"));
		}

		return "jsonView";
	}

	@PostMapping(value = "/contents/order/data/priceDetail.do")
	public String priceDetail(HttpServletRequest request, HttpSession session, Model model, ModelMap map,
			@RequestParam Map<String, Object> param) throws Exception {

		Map<String, Object> data = orderService.priceDetail(param);
		
		map.put("data", data);

		return "jsonView";
	}

	@GetMapping(value = "/contents/order/orderSituation.do")
	public String orderSituation(HttpServletRequest request, HttpSession session, ModelMap model) {
		LoginMenuVO loginMenu = EtcUtil.checkAuth(request, situationCode);
		model.put("menuAuth", loginMenu);
		
		return "contents/order/orderSituation";
	}
	
	@PostMapping(value="/contents/order/data/orderSituation.do")
	public String orderSituation(HttpServletRequest request, HttpSession session, Model model, ModelMap map,
							@RequestParam Map<String, Object> param) throws Exception {
		LoginVO login = (LoginVO) session.getAttribute("userInfo");
		String custId = login.getCustId();
		
		if(param.get("checkCarSctnCodes") != null) {
			List<String> checkCarSctnCodes = Arrays.asList(((String) param.get("checkCarSctnCodes")).split(","));
			List<Map<String, Object>> addList = new ArrayList<>();
			for(int i=0; i < checkCarSctnCodes.size(); i++) {
				Map<String, Object > tmp = new HashMap<>();
				tmp.put("carSctnCode", checkCarSctnCodes.get(i));
				
				addList.add(tmp);
			}
			param.put("addList", addList);
		}
		param.put("custId", custId);
		
		List<OrderVO> list = orderService.getOrderSituation(param);
		
		map.put("data", list);
		
		return "jsonView";
	}
	
	@GetMapping(value="/contents/order/view/orderHistory.do")
	public String orderHistory(HttpServletRequest request, HttpSession session, ModelMap model) {
		return "contents/order/view/orderHistory";
	}	

	@PostMapping(value="/contents/order/data/orderHistory.do")
	public String orderHistoryData(HttpServletRequest request, HttpSession session, Model model, ModelMap map,
							@RequestParam Map<String, Object> param) throws Exception {

		List<Map<String,Object>> data = orderService.getOrderHistory(param);
		int count = orderService.getOrderHistoryCnt(param);
		
		map.put("data", data);
		map.put("total", count);
		
		return "jsonView";
	}
	
	@GetMapping(value="/contents/order/freightControl.do")
	public String freightControl(HttpServletRequest request, HttpSession session, ModelMap model) {
		LoginMenuVO loginMenu = EtcUtil.checkAuth(request, freightControCode);
		model.put("menuAuth", loginMenu);
		
		return "contents/order/freightControl";
	}	

	@PostMapping(value="/contents/order/data/freightControlList.do")
	public String freightControlList(HttpServletRequest request, HttpSession session, Model model, ModelMap map,
							@RequestParam Map<String, Object> param) throws Exception {
		
		if(!EtcUtil.checkAuth(request, freightControCode, "R")) {
			map.put("result", Boolean.FALSE);
			map.put("msg", "해당 권한이 없습니다.");
			
			return "jsonView";
		}
		
		LoginVO login = (LoginVO) session.getAttribute("userInfo");
		String custId = login.getCustId();

		String allocState = String.valueOf(param.get("sAllocState"));
		
		if (param.get("sAllocState") != null && !"".equals(param.get("sAllocState"))) {
			if ("01,04,05,12".indexOf(allocState) >= 0) {
				param.put("driverState", allocState);
			} else {
				param.put("allocState", allocState);
			}
		}
		
		param.put("custId", custId);
		param.put("deptId", param.get("sDeptId"));
		
		List<OrderVO> list = orderService.getFreightControlList(param);
		int count = orderService.getFreightControlCnt(param);

		map.put("result", Boolean.TRUE);
		map.put("data", list);
		map.put("total", count);
		
		return "jsonView";
	}

	@PostMapping(value="/contents/order/data/freightControlUpdate.do")
	public String freightControlWrite(HttpServletRequest request, HttpSession session, Model model, ModelMap map,
			@RequestParam Map<String, Object> param) throws Exception {
		if(!EtcUtil.checkAuth(request, freightControCode, "E") || !EtcUtil.checkAuth(request, freightControCode, "W")) {
			map.put("result", Boolean.FALSE);
			map.put("msg", "해당 권한이 없습니다.");
			
			return "jsonView";
		}
		
		String jsonParam = String.valueOf(param.get("orderData"));

		ObjectMapper objectMapper = new ObjectMapper();
		List<Map<String, Object>> readValue = objectMapper.readValue(jsonParam, new TypeReference<List<Map<String, Object>>>(){});

		for(Iterator<Map<String, Object>> iter = readValue.iterator(); iter.hasNext();) {
			Map<String, Object> data = iter.next();
			
			List<String> codeList = Arrays.asList("0023","0025","0371","0372","0294");
			List<String> sellChargeList = Arrays.asList((String) data.get("sellWayPointCharge"), (String) data.get("sellStayCharge"),(String) data.get("sellHandWorkCharge"),(String) data.get("sellRoundCharge"),(String) data.get("sellOtherAddCharge"));
			List<String> buyChargeList = Arrays.asList((String) data.get("wayPointCharge"), (String) data.get("stayCharge"),(String) data.get("handWorkCharge"),(String) data.get("roundCharge"),(String) data.get("otherAddCharge"));

			Map<String, Object> param2 = new HashMap<>();
			Map<String, Object> param3 = new HashMap<>();
			Map<String, Object> param4 = new HashMap<>();
			Map<String, Object> param5 = new HashMap<>();
			
			List<Map<String, Object>> addSellList = new ArrayList<>();
			List<Map<String, Object>> addBuyList = new ArrayList<>();

			param2.put("buyCharge", data.get("buyCharge"));
			param2.put("sellCustId", data.get("sellCustId"));
			param2.put("sellDeptId", data.get("sellDeptId"));
			param2.put("buyCustId", data.get("buyCustId"));
			param2.put("buyDeptId", data.get("buyDeptId"));
			param2.put("allocId", data.get("allocId"));
			param2.put("orderId", data.get("orderId"));
			orderService.multOrderAllocUpdate(param2);

			if(!"00".equals(param2.get("retCode"))) {
				map.put("result", Boolean.FALSE);
				map.put("msg", param2.get("retMsg"));
				return "jsonView";
			}
			
			param3.put("sellCharge", data.get("sellCharge"));
			param3.put("sellWeight", data.get("sellWeight"));
			param3.put("sellCustId", data.get("sellCustId"));
			param3.put("sellDeptId", data.get("sellDeptId"));
			param3.put("buyCustId", data.get("buyCustId"));
			param3.put("buyDeptId", data.get("buyDeptId"));
			param3.put("allocId", data.get("sellAllocId"));
			param3.put("orderId", data.get("orderId"));
			orderService.multOrderAllocUpdate(param3);

			if(!"00".equals(param3.get("retCode"))) {
				map.put("result", Boolean.FALSE);
				map.put("msg", param3.get("retMsg"));
				return "jsonView";
			}
			
			if(param2.get("outTaxCnt") == null) {
				for(int i=0; i < codeList.size(); i++) {
					Map<String, Object > tmp = new HashMap<>();
					tmp.put("code", codeList.get(i));
					tmp.put("charge", buyChargeList.get(i));
					
					addBuyList.add(tmp);
				}
				
				if(data.get("allocId") != "") {
					param4.put("allocId", data.get("allocId"));
				}else {
					param4.put("allocId", param2.get("newAllocId"));
				}
				param4.put("orderId", data.get("orderId"));
				param4.put("sellBuySctn", "02");
				param4.put("addList", addBuyList);
				orderService.multOrderAllocAddInsert(param4);
			} else {
				map.put("result", Boolean.FALSE);
				map.put("msg", "매입"+param2.get("retMsg"));
				return "jsonView";
			}
				
			if(param3.get("outTaxCnt") == null) {
				for(int i=0; i < codeList.size(); i++) {
					Map<String, Object > tmp2 = new HashMap<>();
					tmp2.put("code", codeList.get(i));
					tmp2.put("charge", sellChargeList.get(i));
					
					addSellList.add(tmp2);
				}
				param5.put("allocId", data.get("sellAllocId"));
				param5.put("orderId", data.get("orderId"));
				param5.put("sellBuySctn", "01");
				param5.put("addList", addSellList);
				orderService.multOrderAllocAddInsert(param5);
			} else {
				map.put("result", Boolean.FALSE);
				map.put("msg", "매출"+param3.get("retMsg"));
				return "jsonView";
			}
			
			if(data.get("buyCarNum") != null && !"".equals(data.get("buyCarNum"))) {
				orderService.insertAllocAddToCalc(param4);
				orderService.insertAllocAddToCalc(param5);
			}
		}

		map.put("result", Boolean.TRUE);
		map.put("msg", "수정되었습니다.");
		
		return "jsonView";
	}
}
