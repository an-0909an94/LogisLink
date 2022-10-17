package com.logislink.cmm.helper;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.io.UnsupportedEncodingException;
import java.net.URL;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.Map;

import javax.net.ssl.HttpsURLConnection;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Value;

public class RestApiHelper {

    public enum HttpMethodType { POST, GET, DELETE }

    private static final String KAKAO_API_SERVER_HOST  = "https://dapi.kakao.com";
    
    private static final String LOAD_ADDRESS_API_HOST = "https://www.juso.go.kr";

    private static final String NICE_DNB_SERVER_HOST = "https://gate.nicednb.com";
    
    private static final String GCEN_ROUTE_API_HOST = "http://ec2-13-124-182-36.ap-northeast-2.compute.amazonaws.com:88";

    private static final String NICE_ADDRESS_PATH = "/nice/bizinfo/v1.0/enterprise/general/search";

    private static final String NICE_TOKEN_PATH = "/nice/oauth/v1.0/accesstoken";

    private static final String SEARCH_ADDRESS_PATH = "/v2/local/search/address.json";
    
    private static final String LOAD_ADDRESS_PATH = "/addrlink/addrLinkApi.do";
    
    private static final String GCEN_ROUTE_PATH = "/route/api/lbs";

    //@Value("#{globalProperties['Globals.NiceDnbAppKey']}")
    //private String niceDnbAppKey;

    //@Value("#{globalProperties['Globals.NiceDnbAppSecret']}")
    //private String niceDnbAppSecret;

    private static final ObjectMapper JACKSON_OBJECT_MAPPER = new ObjectMapper();

    // Kakao, Juso Admin Key Setting
    private String adminKey;

    public void setAdminKey(final String adminKey) {
        this.adminKey = adminKey;
    }

    public String getAdminKey(){
        return this.adminKey;
    }

    ///////////////////////////////////////////////////////////////
    // User Management
    ///////////////////////////////////////////////////////////////

    // 주소 확인 Method
    public Map<String, String> searchAddress(Map<String, String> map) {
        return request(HttpMethodType.POST, LOAD_ADDRESS_API_HOST, LOAD_ADDRESS_PATH, mapToParams(map));
    }
    
    // KAKAO key를 바탕으로 값을 가져오는 Lat, Lon 데이터 Method
    public Map<String, String> getLatLon(Map<String, String> map) {
        return request(HttpMethodType.GET, KAKAO_API_SERVER_HOST, SEARCH_ADDRESS_PATH, "?" + mapToParams(map));
    }

    // NICE DNB 값 가져오는 HTTP 프로토콜 모듈 
    // 받고서 어떻게 오는지에 대한것은 확인 필요
    public Map<String, String> searchNice(Map<String, String> map){
        //return requestSub(HttpMethodType.POST, NICE_DNB_SERVER_HOST, NICE_ADDRESS_PATH, mapToParams(map));
        return requestSub(HttpMethodType.POST, NICE_DNB_SERVER_HOST, NICE_ADDRESS_PATH, map);
    }

    public Map<String, String> genNicekey(final String id, final String pw){
        return requestNiceKey(HttpMethodType.POST,NICE_DNB_SERVER_HOST,NICE_TOKEN_PATH,id,pw);
    }

    /*
    public Map<String, String> getRoute(Map<String, String> map) {
    	//return request(HttpMethodType.POST, GCEN_ROUTE_API_HOST, GCEN_ROUTE_PATH, mapToParams(map));

		HttpHeaders headers = new HttpHeaders();
		MultiValueMap<String, String> params = new LinkedMultiValueMap<>();
		params.setAll(map);
		HttpEntity<MultiValueMap<String, String>> request = new HttpEntity<MultiValueMap<String, String>>(params, headers);
		
		//RestTemplate rest = new RestTemplate();
		String result = restTemplate.postForObject(GCEN_ROUTE_API_HOST + GCEN_ROUTE_PATH, request, String.class);

		return parserMap(result);
    }
*/
    public Map<String, String> request(final String host, final String apiPath) {
        return request(HttpMethodType.GET, host, apiPath, null);
    }

    public Map<String, String> request(final HttpMethodType httpMethod, final String host, final String apiPath) {
        return request(httpMethod, host, apiPath, null);
    }

    public Map<String, String> request(HttpMethodType httpMethod, final String host, final String apiPath, final String params) {

        String requestUrl = host + apiPath;
        if (httpMethod == null) {
            httpMethod = HttpMethodType.GET;
        }
        if (params != null && params.length() > 0
                && (httpMethod == HttpMethodType.GET || httpMethod == HttpMethodType.DELETE)) {
            requestUrl += params;
        }
        
        HttpsURLConnection conn;
        
        OutputStreamWriter writer = null;
        BufferedReader reader = null;
        InputStreamReader isr = null;

        try {
            final URL url = new URL(requestUrl);
            conn = (HttpsURLConnection) url.openConnection();
            conn.setRequestMethod(httpMethod.toString());

            conn.setRequestProperty("Authorization", "KakaoAK " + this.adminKey);
            conn.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");
            conn.setRequestProperty("charset", "utf-8");

            if (params != null && params.length() > 0 && httpMethod == HttpMethodType.POST) {
                conn.setDoOutput(true);
                writer = new OutputStreamWriter(conn.getOutputStream());
                writer.write(params);
                writer.flush();
            }

            final int responseCode = conn.getResponseCode();
            if (responseCode == 200)
                isr = new InputStreamReader(conn.getInputStream(), "UTF-8");
            else
                isr = new InputStreamReader(conn.getErrorStream(), "UTF-8");

            reader = new BufferedReader(isr);
            final StringBuffer buffer = new StringBuffer();
            String line;
            while ((line = reader.readLine()) != null) {
                buffer.append(line);
            }
            Map<String, String> res = new HashMap<String, String>();
            res.put("resCode", "" + responseCode);
            res.put("result", buffer.toString());
            
            return res;

        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            if (writer != null) try { writer.close(); } catch (Exception ignore) { }
            if (reader != null) try { reader.close(); } catch (Exception ignore) { }
            if (isr != null) try { isr.close(); } catch (Exception ignore) { }
        }

        return null;
    }

    public Map<String, String> requestSub(HttpMethodType httpMethod, final String host, final String apiPath, final Map<String, String> params) {

        /*
         * Junghwan.Hwang - NICE_DNB
         * Nice DNB 용으로 따로 생성하여 이용
         */

        String requestUrl = host + apiPath;
        if (httpMethod == null) {
            httpMethod = HttpMethodType.POST;
        }

        HttpsURLConnection conn;
        InputStreamReader isr = null;
        BufferedReader reader = null;

        try {

            final URL url = new URL(requestUrl);
            conn = (HttpsURLConnection) url.openConnection();
            conn.setRequestMethod("POST");

            conn.setRequestProperty("Authorization","Bearer "+ this.adminKey);
            conn.setRequestProperty("Content-Type", "application/json");
            conn.setRequestProperty("charset", "UTF-8");

            conn.setReadTimeout(10000);
            conn.setConnectTimeout(15000);
            conn.setDoOutput(true);

            if (params != null && httpMethod == HttpMethodType.POST) {

                JSONObject data = new JSONObject();
                data.put("searchName",params.get("searchName"));
                data.put("searchValue",params.get("searchValue"));
                data.put("pageNum",params.get("pageNum"));
                data.put("pageCount",params.get("pageCount"));

                BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(conn.getOutputStream()));
                bw.write(data.toString());
                bw.flush();

            }

            final int responseCode = conn.getResponseCode();

            if (responseCode == 200)
                isr = new InputStreamReader(conn.getInputStream(), "UTF-8");
            else
                isr = new InputStreamReader(conn.getErrorStream(), "UTF-8");

            reader = new BufferedReader(isr);
            final StringBuffer buffer = new StringBuffer();
            String line;
            while ((line = reader.readLine()) != null) {
                buffer.append(line);
            }
            Map<String, String> res = new HashMap<String, String>();
            res.put("resCode", "" + responseCode);

            // Token 설정 Buffer
            res.put("result", buffer.toString());

            return res;

        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            //if (writer != null) try { writer.close(); } catch (Exception ignore) { }
            if (reader != null) try { reader.close(); } catch (Exception ignore) { }
            if (isr != null) try { isr.close(); } catch (Exception ignore) { }
        }

        return null;
    }

    public Map<String, String> requestNiceKey(HttpMethodType httpMethod, final String host, final String apiPath, final String id, final String pw) {

        String requestUrl = host + apiPath;
        if (httpMethod == null) {
            httpMethod = HttpMethodType.POST;
        }

        HttpsURLConnection conn;

        InputStreamReader isr = null;

        BufferedReader reader = null;

        try {

            final URL url = new URL(requestUrl);
            conn = (HttpsURLConnection) url.openConnection();
            conn.setRequestMethod("POST");
            conn.setRequestProperty("Content-Type", "application/json");
            conn.setRequestProperty("charset", "UTF-8");

            conn.setReadTimeout(10000);
            conn.setConnectTimeout(15000);
            conn.setDoOutput(true);

            if (httpMethod == HttpMethodType.POST) {

                JSONObject data = new JSONObject();
                data.put("appKey",id);
                data.put("appSecret",pw);
                data.put("grantType","client_credentials");
                data.put("scope","oob");

                BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(conn.getOutputStream()));
                bw.write(data.toString());
                bw.flush();
            }

            final int responseCode = conn.getResponseCode();

            if (responseCode == 200)
                isr = new InputStreamReader(conn.getInputStream(), "UTF-8");
            else
                isr = new InputStreamReader(conn.getErrorStream(), "UTF-8");

            reader = new BufferedReader(isr);
            final StringBuffer buffer = new StringBuffer();
            String line;
            while ((line = reader.readLine()) != null) {
                buffer.append(line);
            }
            Map<String, String> res = new HashMap<String, String>();
            res.put("resCode", "" + responseCode);
            res.put("result", buffer.toString());

            return res;

        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            //if (writer != null) try { writer.close(); } catch (Exception ignore) { }
            if (reader != null) try { reader.close(); } catch (Exception ignore) { }
            if (isr != null) try { isr.close(); } catch (Exception ignore) { }
        }

        return null;
    }



    public String urlEncodeUTF8(String s) {
        try {
            return URLEncoder.encode(s, "UTF-8");
        } catch (UnsupportedEncodingException e) {
            throw new UnsupportedOperationException(e);
        }
    }

    public String mapToParams(Map<String, String > map) {
        StringBuilder paramBuilder = new StringBuilder();
        for (String key : map.keySet()) {
            paramBuilder.append(paramBuilder.length() > 0 ? "&" : "");
            paramBuilder.append(String.format("%s=%s", urlEncodeUTF8(key),
                    urlEncodeUTF8(map.get(key).toString())));
        }
        return paramBuilder.toString();
    }

    public String mapToJsonStr(Map<String, String > map) throws JsonProcessingException {
        return JACKSON_OBJECT_MAPPER.writeValueAsString(map);
        // return GSON.toJson(map);
    }

	public static Map<String, String> parserMap(String result){

		ObjectMapper mapper = new ObjectMapper();
		Map<String, String> map = new HashMap<String, String>();		
		try {
			map = mapper.readValue(result, new TypeReference<Map<String, String>>(){});
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();			
		}
		
		//Distance : 거리, Time: 시간
		return map;
	}
}