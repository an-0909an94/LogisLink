package com.logislink.order.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class OrderSheetController {
	private Logger log = Logger.getLogger(this.getClass());
	
	@GetMapping(value="/contents/order/orderSheet.do")
	public String getOrderSheetView(HttpServletRequest request, HttpSession session, ModelMap model) {
		return "contents/order/orderSheet";
	}
}
