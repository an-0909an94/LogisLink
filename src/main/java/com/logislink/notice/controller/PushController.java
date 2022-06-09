package com.logislink.notice.controller;

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
import com.logislink.basic.service.CarService;
import com.logislink.basic.service.UserService;
import com.logislink.basic.vo.CarVO;
import com.logislink.basic.vo.UserVO;
import com.logislink.login.vo.LoginVO;
import com.logislink.notice.service.PushService;
import com.logislink.notice.vo.PushVO;

@Controller
public class PushController {

	private Logger log = Logger.getLogger(this.getClass());
	
	@Resource(name="pushService")
	private PushService pushService;
	
	@Resource(name="carService")
	private CarService carService;
	
	@Resource(name="userService")
	private UserService userService;
	
	@GetMapping(value="/contents/notice/pushList.do")
	public String getPushList(HttpServletRequest request, HttpSession session, ModelMap model) {
		return "contents/notice/pushList";
	}
	
	@PostMapping(value="/contents/notice/data/pushList.do")
	public String getPushList(HttpServletRequest request, Model model, ModelMap map, HttpSession session,
								@RequestParam Map<String, Object> param ) throws Exception {
		
		List<PushVO> pushList = pushService.getPushList(param);
		int count = pushService.getCnt(param);
		
		map.put("result", Boolean.TRUE);
		map.put("data", pushList);
		map.put("total", count);
		map.put("msg", "");
		
		return "jsonView";
		
	}
	
	@PostMapping(value="/contents/notice/data/searchPushUserList.do")
	public String searchPushUserList(HttpServletRequest request, Model model, ModelMap map, HttpSession session,
								@RequestParam Map<String, Object> param ) throws Exception {
		
		List<Map<String, String>> userList = pushService.searchPushUserList(param);
		
		map.put("result", Boolean.TRUE);
		map.put("data", userList);
		map.put("msg", "");
		
		return "jsonView";
		
	}
	
	@PostMapping(value="/contents/notice/data/sendPush.do")
	public String sendPush(HttpServletRequest request, Model model, ModelMap map, HttpSession session,
								@RequestParam Map<String, Object> param ) throws Exception {
		
		List<Map<String, Object>> userList = null;
		
		if(Integer.parseInt((String) param.get("searchUserTotalLength")) > 0) {
			String jsonParam = String.valueOf(param.get("searchUserList"));
			
			ObjectMapper objectMapper = new ObjectMapper();
			List<Map<String, Object>> readValue = objectMapper.readValue(jsonParam, new TypeReference<List<Map<String, Object>>>(){});

			ArrayList<String> userIdList = new ArrayList<String>();
			
			userList = new ArrayList<Map<String, Object>>(readValue);
			for(Map<String, Object> obj : readValue) {
				userIdList.add((String) obj.get("id"));
			}

			if(userIdList.size() > 0) {
				param.put("userIdList", userIdList);
				userList = userService.getSendPushUserList(param);
			}
		} else {
			List<String> custTypeCodeList = Arrays.asList(((String) param.get("custTypeCodeArray")).split(","));
			List<String> sendList = new ArrayList<>();
			
			for (int i=0; i <custTypeCodeList.size(); i++) {
				List<String> tmp = new ArrayList<>();
				tmp.add(custTypeCodeList.get(i));

				if ("09".equals(custTypeCodeList.get(i))) {
					userList = carService.getSendPushDriverList(param);
				}else {
					if("01".equals(custTypeCodeList.get(i))) {
						tmp.add("02");
						tmp.add("03");
					}
				}
				
				sendList.addAll(tmp);
			}

			param.put("sendList", sendList);
			userList = userService.getSendPushUserList(param);
			System.out.println(param);
		}
		
		param.put("userList", userList);
		
		if(userList != null && userList.size() > 0) {
			pushService.insertPushMsg(param);
			param.put("msgSeq", (int)param.get("msgSeq"));
			pushService.insertPushSendList(param);
		}
		
		map.put("result", Boolean.TRUE);
		//map.put("data", pushList);
		map.put("msg", "앱 푸시가 정상적으로 등록되었습니다.");
		
		return "jsonView";
		
	}
}
