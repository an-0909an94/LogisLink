package com.logislink.cmm.util;

import java.io.IOException;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.logislink.login.vo.LoginMenuVO;

public class EtcUtil {

	static Logger log = LogManager.getLogger();
	
	/**
	 * menu 별 전체 권한 정보를 UserMenuVO 형태로 리턴한다.
	 * @param request
	 * @param menuCode
	 * @return
	 */
	public static LoginMenuVO checkAuth(HttpServletRequest request, String menuCode) {
		
		LoginMenuVO userMenu = new LoginMenuVO();		
		String sessionMenu = String.valueOf(request.getSession().getAttribute("MenuList"));
		
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> map;
		try {
			map = mapper.readValue(sessionMenu, new TypeReference<HashMap<String, Object>>() {
			});
			
			List<LoginMenuVO> menuList = mapper.convertValue(map.get("menu"), new TypeReference<List<LoginMenuVO>>() {});
			
			for(LoginMenuVO pmenu :  menuList) {
				if (menuCode.equals(String.valueOf(pmenu.getMenuCode()))) {
					userMenu = (LoginMenuVO)pmenu;					
				}
			}
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return userMenu;
	}
	
	/**
	 * 메뉴 별 특정 권한 정보를 boolean 형태로 리턴한다.
	 * @param request
	 * @param menuCode
	 * @param authType
	 * @return
	 */
	public static boolean checkAuth(HttpServletRequest request, String menuCode, String authType) {
		
		LoginMenuVO userMenu = checkAuth(request, menuCode);
		if(userMenu.getAuthType() != null && !"".equals(userMenu.getAuthType())) {
			if(userMenu.getAuthType().indexOf(authType) >= 0) {
				return true;
			} else {
				return false;	
			}
		} else {
			return false;
		}
	}
	
	/**
	 * 파라미터 출력
	 * @param request
	 */
	public static void printParam(HttpServletRequest request) {
		Enumeration params = request.getParameterNames();
		System.out.println("------------------------");
		while(params.hasMoreElements()) {
			String name = (String)params.nextElement();
			System.out.println(name + " : " + request.getParameter(name));
		}
		System.out.println("------------------------");
	}
	
	public static String getClientIP(HttpServletRequest request) {
		
		String clientIp = request.getHeader("X-Forwarded=For");
		if(clientIp == null) {
			clientIp = request.getRemoteAddr();
		}
		
		return clientIp;
	}	
	
	public static String NumberToKor(String amt){
		amt = amt.replaceAll(",", "");
        String amt_msg = "";
        String[] arrayNum = {"", "일","이","삼","사","오","육","칠","팔","구"};
        String[] arrayUnit = {"","십","백","천","만","십만","백만","천만","억","십억","백업","천억","조","십조","백조","천조","경","십경","백경","천경","해","십해","백해","천해"};
   
        if(amt.length() > 0){
            int len = amt.length();
            
            String[] arrayStr = new String[len];
            String hanStr = "";
            String tmpUnit = "";
            for(int i = 0; i < len; i++){
                arrayStr[i] = amt.substring(i, i+1);
            }
            int code = len;
            for(int i = 0; i < len; i++){
                code--;
                tmpUnit = "";
                if(arrayNum[Integer.parseInt(arrayStr[i])] != ""){
                    tmpUnit = arrayUnit[code];
                    if(code > 4){
                        if((Math.floor(code/4) == Math.floor((code-1)/4) 
                        && arrayNum[Integer.parseInt(arrayStr[i+1])] != "") ||
                        (Math.floor(code/4) == Math.floor((code-2)/4)
                        && arrayNum[Integer.parseInt(arrayStr[i+2])] != "")) {
                            tmpUnit = arrayUnit[code].substring(0,1);
                        }
                    }
                }
                hanStr += arrayNum[Integer.parseInt(arrayStr[i])]+tmpUnit;
            }
            amt_msg = hanStr;
        }else{
            amt_msg = amt;
        }
     
        return amt_msg;
    }
}
