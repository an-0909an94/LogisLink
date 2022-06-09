package com.logislink.cmm.service.impl;

import java.io.IOException;
import java.nio.charset.Charset;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.util.UriComponents;
import org.springframework.web.util.UriComponentsBuilder;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.logislink.cmm.dao.CmmDao;
import com.logislink.cmm.service.RestService;
import com.logislink.cmm.vo.AreaVO;
import com.logislink.cmm.vo.OilAvgPriceVo;
import com.logislink.cmm.vo.OilAvgPriceVo.Oil;
import com.logislink.cmm.vo.WeatherFcstItemVo;
import com.logislink.cmm.vo.WeatherFcstResponseVo;
import com.logislink.cmm.vo.WeatherFcstVo;

@Service("restService")
public class RestServiceIml implements RestService {

	private Logger logger = LogManager.getLogger();
	
	@Autowired
	private RestTemplate restTemplate;

	@Autowired
	private CmmDao cmmDao;
	
	@Value("#{globalProperties['Globals.apiDataKey']}")
	private String apiDataKey;

	@Value("#{globalProperties['Globals.opinetKey']}")
	private String opinetKey;

	@Override
	public Map<String, Object> sendOpinetApi(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		
		int cnt = cmmDao.selectOpiInfoCnt(map);
		
		if(cnt > 0) return null;
		
		AreaVO area = cmmDao.selectAreaCode(map);
		
		if(area == null) return null;
		
        UriComponents builder = UriComponentsBuilder.fromHttpUrl("http://www.opinet.co.kr/api/avgSigunPrice.do")
                .queryParam("code", opinetKey)
                .queryParam("out", "json")
                .queryParam("sido", area.getSidoCd())
                .queryParam("sigun", area.getAreaCd())
                .build(false);    //자동으로 encode해주는 것을 막기 위해 false
        
        ResponseEntity<String> response = restTemplate.exchange(builder.toUriString(), HttpMethod.GET, null, String.class);
		ObjectMapper objectMapper = new ObjectMapper();
		
		OilAvgPriceVo oilAvgPrice = objectMapper.readValue(response.getBody(), OilAvgPriceVo.class);
				
		List<Oil> listItem = oilAvgPrice.getResult().getOils();
		
		Map<String, Object> result = new HashMap<>();
		
		result.put("sido", map.get("sido"));
		result.put("sigun", map.get("sigun"));
		for(Oil oil : listItem) {
			if("B034".equals(oil.getProdCd())) {
				result.put("premiumGasoline", oil.getPrice());
			} else if ("B027".equals(oil.getProdCd())) { 
				result.put("gasoline", oil.getPrice());
			} else if ("D047".equals(oil.getProdCd())) {
				result.put("diesel", oil.getPrice());
			} else if ("C004".equals(oil.getProdCd())) {
				result.put("lampOil", oil.getPrice());
			} else if ("K015".equals(oil.getProdCd())) {
				result.put("butane", oil.getPrice());
			}
		}
		
		return result;
	}
	
	@Override
	public Map<String, String> sendWeatherApi(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub

		SimpleDateFormat format = new SimpleDateFormat("yyyyMMdd HH");
		Calendar cal = Calendar.getInstance();
		
		String lat = String.valueOf(map.get("lat"));
		String lon = String.valueOf(map.get("lon"));
		String orderId = String.valueOf(map.get("orderId"));
		String allocState = String.valueOf(map.get("allocState"));
		
		Map<String, String> gridXY = getGridXY(Double.valueOf(lat), Double.valueOf(lon));
		
		cal.add(Calendar.HOUR, -1);
		String time = format.format(cal.getTime()).toString();
        String baseDate = time.split(" ")[0];
        String baseTime = time.split(" ")[1] + "00";

		HttpHeaders headers = new HttpHeaders();
        headers.setContentType(new MediaType("application","json",Charset.forName("UTF-8")));    //Response Header to UTF-8
        
        UriComponents builder = UriComponentsBuilder.fromHttpUrl("http://apis.data.go.kr/1360000/VilageFcstInfoService_2.0/getUltraSrtNcst")
                .queryParam("serviceKey", apiDataKey)
                .queryParam("dataType", "JSON")
                .queryParam("base_date", baseDate)
                .queryParam("base_time", baseTime)
                .queryParam("nx", gridXY.get("nx"))
                .queryParam("ny", gridXY.get("ny"))
                .build(false);    //자동으로 encode해주는 것을 막기 위해 false
        
        ResponseEntity<String> response = restTemplate.exchange(builder.toUriString(), HttpMethod.GET, new HttpEntity<String>(headers), String.class);
       
		ObjectMapper objectMapper = new ObjectMapper();
		
		WeatherFcstVo weatherFcst = objectMapper.readValue(response.getBody(), WeatherFcstVo.class);
		WeatherFcstResponseVo weatherFcstResponse = weatherFcst.getResponse();
		
		List<WeatherFcstItemVo> listItem = new ArrayList<WeatherFcstItemVo>();
		Map<String, String> result = new HashMap<>();
		if("00".equals(weatherFcstResponse.getHeader().getResultCode())) {
			
			listItem = (List<WeatherFcstItemVo>) weatherFcstResponse.getBody().getItems().getItem();
			
			result.put("baseDate", baseDate);
			result.put("baseTime", baseTime);
			result.put("nx", gridXY.get("nx"));
			result.put("ny", gridXY.get("ny"));
			result.put("orderId", orderId);
			result.put("allocState", allocState);
			for(WeatherFcstItemVo item : listItem) {
				result.put(item.getCategory(), item.getObsrValue());
			}
		}
							
		return result;
	}

	@Override
	public Map<String, String> sendRouteApi(Map<String, Object> map) {
		// TODO Auto-generated method stub
		MultiValueMap<String, String> params = new LinkedMultiValueMap<>();

		params.add("sLng", String.valueOf(map.get("sLng")));
		params.add("sLat", String.valueOf(map.get("sLat")));
		params.add("eLng", String.valueOf(map.get("eLng")));
		params.add("eLat", String.valueOf(map.get("eLat")));
		params.add("type", "json");

		HttpHeaders headers = new HttpHeaders();
		
		HttpEntity<MultiValueMap<String, String>> request = new HttpEntity<MultiValueMap<String, String>>(params, headers);
		
		String result = restTemplate.postForObject("http://ec2-13-124-182-36.ap-northeast-2.compute.amazonaws.com:88/route/api/lbs", request, String.class);

		return parserMap(result);
	}

	private Map<String, String> parserMap(String result){

		ObjectMapper mapper = new ObjectMapper();
		Map<String, String> map = new HashMap<String, String>();		
		try {
			map = mapper.readValue(result, new TypeReference<Map<String, String>>(){});
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();			
			logger.info(e.getMessage());
		}		
		return map;
	}
	
	  // 위도, 경도 -> X, Y 좌표
	private Map<String, String> getGridXY(double lat, double lon) {
        double RE = 6371.00877; // 지구 반경(km)
        double GRID = 5.0; // 격자 간격(km)
        double SLAT1 = 30.0; // 투영 위도1(degree)
        double SLAT2 = 60.0; // 투영 위도2(degree)
        double OLON = 126.0; // 기준점 경도(degree)
        double OLAT = 38.0; // 기준점 위도(degree)
        double XO = 43; // 기준점 X좌표(GRID)
        double YO = 136; // 기1준점 Y좌표(GRID)

        HashMap<String, String> resultMap = new HashMap<>();
        try {
            double DEGRAD = Math.PI / 180.0;
            double re = RE / GRID;
            double slat1 = SLAT1 * DEGRAD;
            double slat2 = SLAT2 * DEGRAD;
            double olon = OLON * DEGRAD;
            double olat = OLAT * DEGRAD;

            double sf = Math.tan(Math.PI * 0.25 + slat1 * 0.5);
            double sn = Math.tan(Math.PI * 0.25 + slat2 * 0.5) / sf;
            sn = Math.log(Math.cos(slat1) / Math.cos(slat2)) / Math.log(sn);

            sf = Math.pow(sf, sn) * Math.cos(slat1) / sn;

            double ro = Math.tan(Math.PI * 0.25 + olat * 0.5);
            ro = re * sf / Math.pow(ro, sn);

            double ra = Math.tan(Math.PI * 0.25 + (lat) * DEGRAD * 0.5);
            ra = re * sf / Math.pow(ra, sn);

            double theta = lon * DEGRAD - olon;
            if (theta > Math.PI) {
                theta -= 2.0 * Math.PI;
            }

            if (theta < -Math.PI) {
                theta += 2.0 * Math.PI;
            }

            theta *= sn;

            resultMap.put("nx", String.valueOf((int) Math.floor(ra * Math.sin(theta) + XO + 0.5)));
            resultMap.put("ny", String.valueOf((int) Math.floor(ro - ra * Math.cos(theta) + YO + 0.5)));

        } catch (Exception e) {
            e.printStackTrace();
        }
        return resultMap;
    }

}
