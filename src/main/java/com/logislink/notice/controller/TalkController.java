package com.logislink.notice.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.codehaus.jackson.map.ObjectMapper;
import org.codehaus.jackson.type.TypeReference;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.logislink.basic.service.CarService;
import com.logislink.basic.service.UserService;
import com.logislink.basic.vo.CarVO;
import com.logislink.basic.vo.UserVO;
import com.logislink.login.vo.LoginVO;
import com.logislink.notice.service.TalkService;
import com.logislink.notice.vo.TalkTemplateVO;
import com.logislink.notice.vo.TalkVO;

@Controller
public class TalkController {

	private Logger log = Logger.getLogger(this.getClass());
	
	@Resource(name="talkService")
	private TalkService talkService;

	@Resource(name="carService")
	private CarService carService;
	
	@Resource(name="userService")
	private UserService userService;
	

	@Value("#{globalProperties['Globals.talkUserCode']}")
	private String userCode;
	@Value("#{globalProperties['Globals.talkDeptCode']}")
	private String deptCode;
	@Value("#{globalProperties['Globals.talkYellowidKey']}")
	private String yellowidKey;
	
	
	@GetMapping(value="/contents/notice/talkList.do")
	public String getTalkList(HttpServletRequest request, HttpSession session, ModelMap model) {
		return "contents/notice/talkList";
	}

	@PostMapping(value="/contents/notice/data/talkList.do")
	public String talkListData(HttpServletRequest request, Model model, ModelMap map, HttpSession session,
								@RequestParam Map<String, Object> param ) throws Exception {

		List<TalkVO> list = talkService.talkList(param);
		int count = talkService.getCnt(param);
		
		map.put("result", Boolean.TRUE);
		map.put("data", list);
		map.put("total", count);
		
		return "jsonView";
	}
	
	@GetMapping(value="/contents/notice/data/talkTemplate.do") 
	public String talkTemplateData(HttpServletRequest request, Model model, ModelMap map, HttpSession session,
								@RequestParam Map<String, Object> param) throws Exception{
		
		List<TalkTemplateVO> data = talkService.getTalkTemplate(param);

		map.put("result", Boolean.TRUE);
		map.put("data", data);
		
		return "jsonView";
	}
	
	@PostMapping(value="/contents/notice/data/talkSend.do")
	public String talkSend(HttpServletRequest request, Model model, HttpSession session, ModelMap map, 
							@RequestParam Map<String, Object> param) throws Exception {
		
		LoginVO login = (LoginVO) session.getAttribute("userInfo");

		List<Map<String, Object>> userList = null;
		
		if(Integer.parseInt((String) param.get("searchUserTotalLength")) > 0) {
			String jsonParam = String.valueOf(param.get("searchUserList"));
			
			ObjectMapper objectMapper = new ObjectMapper();
			List<Map<String, Object>> readValue = objectMapper.readValue(jsonParam, new TypeReference<List<Map<String, Object>>>(){});
			
			userList = new ArrayList<Map<String, Object>>(readValue);
		} else {
			String custTypeCode = String.valueOf(param.get("custTypeCode"));
			ArrayList<String> sendList = new ArrayList<String>();
			sendList.add(custTypeCode);
			if("09".equals(custTypeCode)) {
				userList = carService.getSendTalkDriverList(param);
			}
			else {
				if("01".equals(custTypeCode)) {
					sendList.add("02");
					sendList.add("03");
				}	

				param.put("sendList", sendList);
				userList = userService.getSendTalkUserList(param);
			}
		}
		
		param.put("userList", userList);
		param.put("userCode", userCode);
		param.put("deptCode", deptCode);
		param.put("yellowidKey", yellowidKey);
		

		if(userList != null && userList.size() > 0) {
			talkService.talkSendUser(param);
		}
				
		map.put("result", Boolean.TRUE);
		//map.put("data", pushList);
		map.put("msg", "알림톡이 정상적으로 등록되었습니다.");
		
		return "jsonView";
	}
}
