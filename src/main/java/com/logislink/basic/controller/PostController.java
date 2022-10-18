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

	@Value("#{globalProperties['Globals.NiceDnbAppKey']}")
	private String niceDnbAppKey;

	@Value("#{globalProperties['Globals.NiceDnbAppSecret']}")
	private String niceDnbAppSecret;


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

		map.put("bizname", param.get("bizname"));

		return "contents/basic/view/searchBizinfo";
	}

	@PostMapping(value="/contents/basic/data/searchNiceinfo.do")
	public String searchNiceinfo(HttpServletRequest request, Model model, HttpSession httpSession, ModelMap map,
								@RequestParam Map<String, Object> param) throws Exception {

		Map<String, String> paramMap = new HashMap<String, String>();
		String currentPage = param.get("page")==null ? "1" : (String)param.get("page");
		Map<String, String> res;
		Map<String, String> paramToken = new HashMap<String, String>();

		if(!"".equals((String) param.get("BizCode")) && param.get("BizValue") != null) {
			paramMap.put("searchName", param.get("BizCode").toString());
			paramMap.put("searchValue",param.get("BizValue").toString());

			paramMap.put("pageNum",param.get("page").toString());
			paramMap.put("resultType", "json");
			paramMap.put("pageCount", param.get("pageSize").toString());

			paramToken.put("kName","NICE_DNB_TOKEN");
			String tValue = postService.selectNDToken(paramToken);

			apiHelper.setAdminKey(tValue);
			res = apiHelper.searchNice(paramMap);
			apiHelper.setAdminKey("");

			// 일단 처음 보내는것으로 확인

			if("401".equals(res.get("resCode"))) {

				// Token Key 만료 시 Gen 되는 Method - Junghwan.Hwang
				// 설정 후 DataBase에 저장되도록 설정 되어 있음
				Map<String, String> genRes = apiHelper.genNicekey(niceDnbAppKey,niceDnbAppSecret);

				String resCode = genRes.get("result");

				if("200".equals(genRes.get("resCode"))){

					JSONParser jParser = new JSONParser();
					Object genObj = null;

					genObj = jParser.parse(genRes.get("result"));

					JSONObject jObj = (JSONObject) genObj;
					String token = (String)jObj.get("accessToken");
					Long expire = (Long)jObj.get("expiresIn");

					Map<String, String> tParam = new HashMap<String, String>();

					tParam.put("kValue",token);
					tParam.put("expire",String.valueOf(expire));
					tParam.put("kName","NICE_DNB_TOKEN");

					postService.updateNDToken(tParam);
					tValue = postService.selectNDToken(paramToken);

					apiHelper.setAdminKey(tValue);
					res = apiHelper.searchNice(paramMap);
					apiHelper.setAdminKey("");
				}
				//else {
					// 서버 통신 불능시 예외처리 내용
				//}

			}

			String result = res.get("result");

			JSONParser jsonParser = new JSONParser();
			Object obj = null;

			obj = jsonParser.parse(result);

			JSONObject jsonObject = (JSONObject) obj;
			JSONObject results = (JSONObject)jsonObject.get("dataBody");

			String count = "0";
			List<Map<String, Object>> list = new ArrayList<Map<String,Object>>();

			if(!"NOAG1001".equals(results.get("errorCode"))){
				JSONArray jsonArray = (JSONArray)results.get("list01");
				for(int i=0; i <jsonArray.size(); i++) {
					list.add((Map<String, Object>)jsonArray.get(i));
				}
				count = String.valueOf( results.get("totalCount"));
			}

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
