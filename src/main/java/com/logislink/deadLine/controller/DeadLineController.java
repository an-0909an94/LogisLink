package com.logislink.deadLine.controller;


import com.logislink.deadLine.service.DeadLineService;
import com.logislink.cmm.util.EtcUtil;
import com.logislink.deadLine.vo.DeadLineVO;
import com.logislink.login.vo.LoginMenuVO;
import com.logislink.login.vo.LoginVO;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.List;
import java.util.Map;

@Controller
public class DeadLineController {

    private Logger logger = Logger.getLogger(this.getClass());
    private String menuCode = "C3910";
    @Resource(name = "deadLineService")
    private DeadLineService deadLineService;

    @GetMapping(value = "/contents/deadLine/deadLine.do")
    public String deadLine(HttpServletRequest request, HttpSession session, ModelMap model) throws Exception {

        LoginMenuVO loginMenu = EtcUtil.checkAuth(request, menuCode);
        model.put("menuAuth", loginMenu);

        return "contents/deadLine/deadLineList";
    }

    @PostMapping(value = "/contents/deadLine/data/deadLineList.do")
    public String deadLineList(HttpServletRequest request, Model model, ModelMap map, HttpSession session, @RequestParam Map<String, Object> param) throws Exception {

        LoginVO login = (LoginVO) session.getAttribute("userInfo");
        String custId = login.getCustId();

        param.put("custId", custId);

        List<DeadLineVO> buyCalcList = deadLineService.getBuyCalcList(param);
        Map<String, Object> buyCalcListCnt = deadLineService.getBuyCalcListCnt(param);

        map.put("result", Boolean.TRUE);
        map.put("data", buyCalcList);
        map.put("total", buyCalcListCnt.get("buyCalcListCnt"));
       /*  map.put("sumPayableAmt", buyCalcListCnt.get("sumPayableAmt"));
        map.put("sumWithdrawalAmt", buyCalcListCnt.get("sumWithdrawalAmt"));*/

        return "jsonView";
    }
}
