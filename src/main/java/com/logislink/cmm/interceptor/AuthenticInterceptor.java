package com.logislink.cmm.interceptor;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.ModelAndViewDefiningException;
import org.springframework.web.servlet.mvc.WebContentInterceptor;

import com.logislink.login.vo.LoginMenuVO;
import com.logislink.login.vo.LoginVO;

public class AuthenticInterceptor extends WebContentInterceptor {

	Logger log = Logger.getLogger(this.getClass());
	/**
	 * 세션에 계정정보(LoginVO)가 있는지 여부로 인증 여부를 체크한다.
	 * 계정정보(LoginVO)가 없다면, 로그인 페이지로 이동한다.
	 */
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws ServletException {
		
		HttpSession session = request.getSession();
		if (session.getAttribute("userInfo") != null) {			
			return true;
		} else {
			if(isAjaxRequest(request)) {
				try {
					response.sendError(400);
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				return false;
			} else {
				ModelAndView modelAndView = new ModelAndView("redirect:/index.do");
				throw new ModelAndViewDefiningException(modelAndView);	
			}
		}
	}
	
		
	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		// TODO Auto-generated method stub
		//super.postHandle(request, response, handler, modelAndView);
		
		LoginVO loginVO = null;
		String requestURI = request.getRequestURI();
		
		if(!requestURI.equals("/index.do")) {
			
			LoginMenuVO loginMenuVO = (LoginMenuVO) modelAndView.getModel().get("menuAuth");
			
			if(loginMenuVO != null) {
				if(loginMenuVO.getMenuCode() == null || "".equals(loginMenuVO.getMenuCode())) {
					modelAndView = new ModelAndView("redirect:/index.do");
					throw new ModelAndViewDefiningException(modelAndView);	
				}
			}
		}
	}



	private boolean isAjaxRequest(HttpServletRequest request) {
		String header = request.getHeader("AJAX");
		if("true".equals(header)) {
			return true;
		} else {
			return false;
		}
	}
}
