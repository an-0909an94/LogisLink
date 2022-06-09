package com.logislink.basic.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.logislink.basic.service.PostService;
import com.logislink.cmm.helper.RestApiHelper;

@Controller
public class PostController {
	
	private Logger log = Logger.getLogger(this.getClass());
	private static RestApiHelper apiHelper = new RestApiHelper();

	@Resource(name="postService")
	private PostService postService;
	
	@Value("#{globalProperties['Globals.kakaoKey']}")
	private String kakaoKey;
	
	@Value("#{globalProperties['Globals.cmmAPIKey']}")
	private String cmmApiKey;

	@GetMapping(value="/contents/basic/view/searchPost.do")
	public String searchPost(HttpServletRequest request, Model model, HttpSession httpSession, ModelMap map, 
			@RequestParam Map<String, Object> param) throws Exception {
		map.put("mode", param.get("mode"));
		return "contents/basic/view/searchPost";
	}

	@GetMapping(value="/contents/basic/view/dummySearchPost.do")
	public String dummySearchPost(HttpServletRequest request, Model model, HttpSession httpSession, ModelMap map, 
			@RequestParam Map<String, Object> param) throws Exception {
		map.put("mode", param.get("mode"));
		return "contents/basic/view/dummySearchPost";
	}

	@GetMapping(value="/contents/basic/view/searchBizinfo.do")
	public String searchBizinfo(HttpServletRequest request, Model model, HttpSession httpSession, ModelMap map, 
			@RequestParam Map<String, Object> param) throws Exception {
		return "contents/basic/view/searchBizinfo";
	}
	
	@PostMapping(value="/contents/basic/data/searchAddress.do")
	public String searchAddress(HttpServletRequest request, Model model, ModelMap map, HttpSession session,
								@RequestParam Map<String, Object> param ) throws Exception {
		Map<String, String> paramMap = new HashMap<String, String>();
		String currentPage	= param.get("page")==null ? "1" : (String)param.get("page");
		if(!"".equals((String) param.get("keyword")) && param.get("keyword") != null) {
			paramMap.put("keyword", (String) param.get("keyword"));
			paramMap.put("confmKey", cmmApiKey);
			paramMap.put("resultType", "json");
			paramMap.put("currentPage", currentPage);
			paramMap.put("countPerPage", "10");
			
			Map<String, String> res = apiHelper.searchAddress(paramMap);
			String result = res.get("result");
			
			//JSONObject jsonObject = new JSONObject(); 
			JSONParser jsonParser = new JSONParser(); 
			Object obj = null;
			ObjectMapper mapper = new ObjectMapper();
			
			obj = jsonParser.parse(result);
			JSONObject jsonObject = (JSONObject) obj;
			JSONObject results = (JSONObject)jsonObject.get("results");
			JSONObject common = (JSONObject)results.get("common");
			JSONArray jsonArray = (JSONArray)results.get("juso");
			
			List<Map<String, Object>> list = new ArrayList<Map<String,Object>>();
			for(int i=0; i <jsonArray.size(); i++) {
				list.add((Map<String, Object>)jsonArray.get(i));
			}
			String count = String.valueOf( common.get("totalCount"));
			
			if("200".equals(res.get("resCode"))) {
				map.put("result", Boolean.TRUE);
				map.put("total", Integer.parseInt(count));
				map.put("data", list);
			} else {
				map.put("result", Boolean.FALSE);
				map.put("data", res.get("result"));
			}
		} else {
			map.put("result", Boolean.FALSE);
			map.put("data", new HashMap<String, String>());
		}
		
		return "jsonView";
	}
	
	@PostMapping(value="/contents/basic/data/getLatLon.do")
	public String getLatLon(HttpServletRequest request, Model model, ModelMap map, HttpSession session,
								@RequestParam Map<String, Object> param ) throws Exception {
		
		Map<String, String> paramMap = new HashMap<String, String>();

		paramMap.put("query", (String) param.get("searchAddress"));
		
		if(param.get("analyze_type") != null) {
			paramMap.put("analyze_type", (String) param.get("analyze_type"));
		}
		
		if(param.get("page") != null) {
			paramMap.put("page", (String) param.get("page"));
		}
		
		if(param.get("size") != null) {
			paramMap.put("size", (String) param.get("size"));
		}
		
		apiHelper.setAdminKey(kakaoKey);
		Map<String, String> res = apiHelper.getLatLon(paramMap);
		apiHelper.setAdminKey("");
		
		if("200".equals(res.get("resCode"))) {
			map.put("result", Boolean.TRUE);
			map.put("data", res.get("result"));
		} else {
			map.put("result", Boolean.FALSE);
			map.put("data", res.get("result"));
		}
		
		return "jsonView";
	}
}
