package com.logislink.basic.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.logislink.basic.vo.AddrVO;
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

	@GetMapping(value="/contents/basic/view/privInfo.do")
	public String privateInform(HttpServletRequest request, Model model, HttpSession httpSession, ModelMap map,
		@RequestParam Map<String, Object> param) throws Exception{

		return "contents/basic/view/privInfo";
	}

	//public String LoopNiceinfo(HttpServletRequest request, Model model, HttpSession httpSession, ModelMap map, @RequestParam Map<String, Object> param) throws Exception {
	public List<Map<String, Object>> LoopNiceinfo(int page, Map<String, Object> param) throws Exception {

		Map<String, String> paramMap = new HashMap<String, String>();
		Map<String, String> res;
		Map<String, String> paramToken = new HashMap<String, String>();
		List<Map<String, Object>> list = new ArrayList<Map<String,Object>>();

		if(!"".equals((String) param.get("BizCode")) && param.get("BizValue") != null) {
			paramMap.put("searchName", param.get("BizCode").toString());
			paramMap.put("searchValue",param.get("BizValue").toString());
			paramMap.put("pageNum",String.valueOf(page));
			paramMap.put("resultType", "json");
			//paramMap.put("pageCount", param.get("pageSize").toString());
			paramMap.put("pageCount", "100");


			//paramToken.put("kName","NICE_DNB_TOKEN");
			//String tValue = postService.selectNDToken(paramToken);

			//여기가 일단 데이터 넣는곳
			//apiHelper.setAdminKey(tValue);
			res = apiHelper.searchNice(paramMap);
			//apiHelper.setAdminKey("");

			// 일단 처음 보내는것으로 확인
			String result = res.get("result");

			JSONParser jsonParser = new JSONParser();
			Object obj = null;

			obj = jsonParser.parse(result);

			JSONObject jsonObject = (JSONObject) obj;
			JSONObject results = (JSONObject)jsonObject.get("dataBody");

			if(!"NOAG1001".equals(results.get("errorCode"))){
				JSONArray jsonArray = (JSONArray)results.get("list01");
				for(int i=0; i <jsonArray.size(); i++) {
					list.add((Map<String, Object>)jsonArray.get(i));
				}
			}
		}
		return list;
	}

	@PostMapping(value="/contents/basic/data/searchNiceinfo.do")
	public String searchNiceinfo(HttpServletRequest request, Model model, HttpSession httpSession, ModelMap map,
		@RequestParam Map<String, Object> param) throws Exception {

		Map<String, String> paramMap = new HashMap<String, String>();
		String currentPage = param.get("page")==null ? "1" : (String)param.get("page");
		Map<String, String> res;
		Map<String, String> paramToken = new HashMap<String, String>();
		List<Map<String, Object>> list = new ArrayList<Map<String,Object>>();

		String count = "0";
		int iTotal = 0;
		int iCount = 0;

		if(!"".equals((String) param.get("BizCode")) && param.get("BizValue") != null) {
			paramMap.put("searchName", param.get("BizCode").toString());
			paramMap.put("searchValue",param.get("BizValue").toString());

			paramMap.put("pageNum","1");
			paramMap.put("resultType", "json");
			//paramMap.put("pageCount", param.get("pageSize").toString());
			paramMap.put("pageCount", "100");

			paramToken.put("kName","NICE_DNB_TOKEN");
			String tValue = postService.selectNDToken(paramToken);

			//여기가 일단 데이터 넣는곳
			apiHelper.setAdminKey(tValue);
			res = apiHelper.searchNice(paramMap);
			//apiHelper.setAdminKey("");

			// 일단 처음 보내는것으로 확인

			if("401".equals(res.get("resCode"))) {

				// Token Key 만료 시 Gen 되는 Method - Junghwan.Hwang - 2022-10-19
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
				}
				else {
				// 서버 통신 불능시 예외처리 내용
					return "jsonView";
				}
			}

			String result = res.get("result");

			JSONParser jsonParser = new JSONParser();
			Object obj = null;

			obj = jsonParser.parse(result);

			JSONObject jsonObject = (JSONObject) obj;
			JSONObject results = (JSONObject)jsonObject.get("dataBody");

			count = String.valueOf( results.get("totalCount"));

			iTotal = Integer.parseInt(count);
			iCount = (iTotal/100)+1;

			for(int i = 1; i<=iCount ; i++){
				list.addAll(LoopNiceinfo(i,param));
			}

			apiHelper.setAdminKey("");

			if("200".equals(res.get("resCode"))) {
				map.put("result", Boolean.TRUE);
				map.put("total", Integer.parseInt(count));
				map.put("data", list);
			}
			else if("403".equals(res.get("resCode"))) {
				map.put("result",Boolean.TRUE);
				map.put("total",0);
				map.put("data",list);
			}
			else {
				map.put("result", Boolean.FALSE);
				map.put("data", res.get("result"));
			}
		} else {
			map.put("result", Boolean.FALSE);
			map.put("data", new HashMap<String, String>());
		}

		return "jsonView";
	}

	@PostMapping(value="/contents/basic/data/searchNiceinfoGet.do")
	public String searchNiceinfoGet(HttpServletRequest request, Model model, HttpSession httpSession, ModelMap map,
								@RequestParam Map<String, Object> param) throws Exception {

		Map<String, String> paramMap = new HashMap<String, String>();
		String currentPage = param.get("page")==null ? "1" : (String)param.get("page");
		Map<String, String> res;
		Map<String, String> paramToken = new HashMap<String, String>();
		List<Map<String, Object>> list = new ArrayList<Map<String,Object>>();

		String count = "0";

		if(!"".equals((String) param.get("BizCode")) && param.get("BizValue") != null) {
			paramMap.put("searchName", param.get("BizCode").toString());
			paramMap.put("searchValue",param.get("BizValue").toString());

			paramMap.put("pageNum",param.get("page").toString());
			paramMap.put("resultType", "json");
			paramMap.put("pageCount", param.get("pageSize").toString());

			paramToken.put("kName","NICE_DNB_TOKEN");
			String tValue = postService.selectNDToken(paramToken);

			//여기가 일단 데이터 넣는곳
			apiHelper.setAdminKey(tValue);
			res = apiHelper.searchNice(paramMap);
			apiHelper.setAdminKey("");

			// 일단 처음 보내는것으로 확인

			if("401".equals(res.get("resCode"))) {

				// Token Key 만료 시 Gen 되는 Method - Junghwan.Hwang - 2022-10-19
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

					
					// 여기가 Loop 해서 데이터 넣는곳
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

			if(!"NOAG1001".equals(results.get("errorCode")))
			{
				if(!"NOAG1201".equals(results.get("errorCode"))){
					JSONArray jsonArray = (JSONArray)results.get("list01");
					for(int i=0; i <jsonArray.size(); i++) {
						list.add((Map<String, Object>)jsonArray.get(i));
					}
					count = String.valueOf( results.get("totalCount"));
				}
			}

			if("200".equals(res.get("resCode"))) {
				map.put("result", Boolean.TRUE);
				map.put("total", Integer.parseInt(count));
				map.put("data", list);
			}else if("403".equals(res.get("resCode"))){
				map.put("result",Boolean.TRUE);
				map.put("total",0);
				map.put("data",list);
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

/*	@PostMapping(value="/contents/basic/data/getLatLon1.do")
	public String getLatLon1(HttpServletRequest request, Model model, ModelMap map, HttpSession session,
								@RequestParam Map<String, Object> param ) throws Exception {
		
		Map<String, String> paramMap = new HashMap<String, String>();

		if(param.get("filter[filters][0][value]") != null) {
			paramMap.put("query", (String) param.get("filter[filters][0][value]"));
		}
		if(param.get("analyze_type") != null) {
			paramMap.put("analyze_type", (String) param.get("analyze_type"));
		}
		
		if(param.get("page") != null) {
			paramMap.put("page", (String) param.get("page"));
		}
		
		if(param.get("pageSize") != null) {
			paramMap.put("size", (String) param.get("pageSize"));
		}
		
		apiHelper.setAdminKey(kakaoKey);
		Map<String, String> res = apiHelper.getLatLon(paramMap);

		System.out.println(res.get("result"));

		JSONObject jsonObject = new JSONObject();
		JSONParser jsonParser = new JSONParser();
		// 처음 유효 주소데이터를 json에 담기 위함
		jsonObject = (JSONObject) jsonParser.parse(res.get("result").toString());
		if("200".equals(res.get("resCode"))) {
			//유효주소에 대한 토탈 카운트 및 정보를 json에 담음
			JSONObject metaData = (JSONObject) jsonObject.get("meta");
			//유효주소에 대한 주소 리스트를 array애 담음
			JSONArray arr = (JSONArray)jsonObject.get("documents");

			List<AddrVO> addrList = new ArrayList<AddrVO>();
			for(Object addrArrObject : arr) {
				AddrVO addrVO = new AddrVO();
				JSONObject obj = (JSONObject) addrArrObject; // JSONArray 데이터를 하나씩 가져와 JSONObject로 변환해준다.
				if(obj.get("address_type").toString().equals("ROAD")){
					JSONObject addrData = (JSONObject) obj.get("road_address");


					addrVO.setFullAddr((String) obj.get("address_name"));
					addrVO.setSido((String) addrData.get("region_1depth_name"));
					addrVO.setGugun((String) addrData.get("region_2depth_name"));
					addrVO.setDong((String) addrData.get("road_name"));

				}else{
					JSONObject addrData = (JSONObject) obj.get("address");

					addrVO.setFullAddr((String) obj.get("address_name"));
					addrVO.setSido((String) addrData.get("region_1depth_name"));
					addrVO.setGugun((String) addrData.get("region_2depth_name"));
					addrVO.setDong((String) addrData.get("region_3depth_name"));
				}

				addrList.add(addrVO);
			}



			//arr.add((JSONArray)jsonObject.get("documents"));

			apiHelper.setAdminKey("");


			map.put("result", Boolean.TRUE);
			map.put("data", addrList);
			//map.put("result", Boolean.TRUE);
			map.put("total", metaData.get("total_count"));
			//map.put("data", res.get("result"));
		} else {
			map.put("result", Boolean.FALSE);
			map.put("data", res.get("result"));
		}
		
		return "jsonView";
	}*/
}
