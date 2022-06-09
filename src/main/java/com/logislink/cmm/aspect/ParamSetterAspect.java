package com.logislink.cmm.aspect;

import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.springframework.stereotype.Component;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import com.logislink.login.vo.LoginVO;

@Component
@Aspect
public class ParamSetterAspect {
	/**
	 * 서비스 동작 전 공통 파라미터를 추가한다.
	 * @param joinPoint
	 */

	@Before("execution(* com.logislink..*service.impl..*(..))")
	public void setParam(JoinPoint joinPoint) {
		
		Object[] params = joinPoint.getArgs();
		
		ServletRequestAttributes attr = (ServletRequestAttributes) RequestContextHolder.currentRequestAttributes();
		HttpServletRequest request = attr.getRequest();
		HttpSession session = request.getSession();
		
		LoginVO login = (LoginVO) session.getAttribute("userInfo");
		
			for(Object param: params) {
				
				HashMap<String, Object> map = (HashMap<String, Object>) param;
				
				if(map.get("start") == null || map.get("end") == null) {
					String pageStart	= map.get("page")==null ? "1" : (String)map.get("page");
					String pageEnd		= map.get("pageSize")==null ? "20" : (String)map.get("pageSize");
					
					map.put("start", (Integer.parseInt(pageStart) - 1) * Integer.parseInt(pageEnd) + 1);
					map.put("end", Integer.parseInt(pageStart) * Integer.parseInt(pageEnd));
					map.put("pageSize", Integer.parseInt(pageEnd));					
				}
				
				if(!"".equals(map.get("filter[filters][0][value]")) && map.get("filter[filters][0][value]") != null) {
					map.put(String.valueOf(map.get("filter[filters][0][field]")), map.get("filter[filters][0][value]"));			
				}

				if (login != null) {
					map.put("loginId", login.getUserId());
					map.put("regId", login.getUserId());
					map.put("loginCustId", login.getCustId());
					map.put("loginDeptId", login.getDeptId());
					map.put("loginAuthSeq", login.getAuthSeq());
				}
			}	
		
		
	}
}
