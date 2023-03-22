package com.logislink.dashboard.dao;

import com.logislink.dashboard.vo.MmtopRankVO;
import com.logislink.dashboard.vo.ResultRankVO;
import com.logislink.dashboard.vo.MyResultVO;
import com.logislink.dashboard.vo.ResultVehicleVO;
import com.logislink.dashboard.vo.TodayCustResultVO;
import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

import java.util.ArrayList;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository("dashboardDao")
public class DashboardDao extends EgovAbstractMapper {

    // 최근 실적 랭킹
    public List<ResultRankVO> getResultRank(Map<String, Object> map){
        //List<ResultRankVO> rank = selectList("");

        List<ResultRankVO> rank = new ArrayList<ResultRankVO>();

        String custId = map.get("custId").toString();
        String today = map.get("today").toString();
        String yesterday = map.get("yesterday").toString();

        ResultRankVO rank1Dummy= new ResultRankVO();
        rank1Dummy.setCustId(custId);
        rank1Dummy.setSearchDate(today);
        rank1Dummy.setResultFlag("A");
        rank1Dummy.setResultFlagNm("배차1위");
        rank1Dummy.setUserId("lm_aaa");
        rank1Dummy.setUserNm("최유리");
        rank1Dummy.setResultVal("121");
        rank1Dummy.setResultUnit("건");
        rank.add(rank1Dummy);

        ResultRankVO rank2Dummy= new ResultRankVO();
        rank2Dummy.setCustId(custId);
        rank2Dummy.setSearchDate(today);
        rank2Dummy.setResultFlag("B");
        rank2Dummy.setResultFlagNm("매출1위");
        rank2Dummy.setUserId("lm_bbb");
        rank2Dummy.setUserNm("김유빈");
        rank2Dummy.setResultVal("3,700");
        rank2Dummy.setResultUnit("만원");
        rank.add(rank2Dummy);

        ResultRankVO rank3Dummy= new ResultRankVO();
        rank3Dummy.setCustId(custId);
        rank3Dummy.setSearchDate(today);
        rank3Dummy.setResultFlag("C");
        rank3Dummy.setResultFlagNm("이익1위");
        rank3Dummy.setUserId("lm_ccc");
        rank3Dummy.setUserNm("김하연");
        rank3Dummy.setResultVal("2,300");
        rank3Dummy.setResultUnit("만원");
        rank.add(rank3Dummy);

        ResultRankVO rank4Dummy= new ResultRankVO();
        rank4Dummy.setCustId(custId);
        rank4Dummy.setSearchDate(today);
        rank4Dummy.setResultFlag("D");
        rank4Dummy.setResultFlagNm("이익률1위");
        rank4Dummy.setUserId("lm_ddd");
        rank4Dummy.setUserNm("나소라");
        rank4Dummy.setResultVal("14.5");
        rank4Dummy.setResultUnit("%");
        rank.add(rank4Dummy);

        ResultRankVO rank5Dummy= new ResultRankVO();
        rank5Dummy.setCustId(custId);
        rank5Dummy.setSearchDate(yesterday);
        rank5Dummy.setResultFlag("A");
        rank5Dummy.setResultFlagNm("배차1위");
        rank5Dummy.setUserId("lm_aaa");
        rank5Dummy.setUserNm("김서연");
        rank5Dummy.setResultVal("121");
        rank5Dummy.setResultUnit("건");
        rank.add(rank5Dummy);

        ResultRankVO rank6Dummy= new ResultRankVO();
        rank6Dummy.setCustId(custId);
        rank6Dummy.setSearchDate(yesterday);
        rank6Dummy.setResultFlag("B");
        rank6Dummy.setResultFlagNm("매출1위");
        rank6Dummy.setUserId("lm_bbb");
        rank6Dummy.setUserNm("윤정임");
        rank6Dummy.setResultVal("6,700");
        rank6Dummy.setResultUnit("만원");
        rank.add(rank6Dummy);

        ResultRankVO rank7Dummy= new ResultRankVO();
        rank7Dummy.setCustId(custId);
        rank7Dummy.setSearchDate(yesterday);
        rank7Dummy.setResultFlag("C");
        rank7Dummy.setResultFlagNm("이익1위");
        rank7Dummy.setUserId("lm_ccc");
        rank7Dummy.setUserNm("채한울");
        rank7Dummy.setResultVal("1,300");
        rank7Dummy.setResultUnit("만원");
        rank.add(rank7Dummy);

        ResultRankVO rank8Dummy= new ResultRankVO();
        rank8Dummy.setCustId(custId);
        rank8Dummy.setSearchDate(yesterday);
        rank8Dummy.setResultFlag("D");
        rank8Dummy.setResultFlagNm("이익률1위");
        rank8Dummy.setUserId("lm_ddd");
        rank8Dummy.setUserNm("김선");
        rank8Dummy.setResultVal("14.5");
        rank8Dummy.setResultUnit("%");
        rank.add(rank8Dummy);

        return rank;
    }

    // 나의 실적
    public List<MyResultVO> getMyResult(Map<String, Object> map){
        //List<MyPerformanceVO> myResult = selectList("");

        List<MyResultVO> myResult = new ArrayList<MyResultVO>();

        MyResultVO myResult1Dummy = new MyResultVO();
        myResult1Dummy.setUserId("lm_ksh");
        myResult1Dummy.setResultFlag("D");
        myResult1Dummy.setAllocCnt("121");
        myResult1Dummy.setSales("3,700");
        myResult1Dummy.setProfit("3,700");
        myResult1Dummy.setProfitPer("14.5");
        myResult.add(myResult1Dummy);

        MyResultVO myResult2Dummy = new MyResultVO();
        myResult2Dummy.setUserId("lm_ksh");
        myResult2Dummy.setResultFlag("M");
        myResult2Dummy.setAllocCnt("325");
        myResult2Dummy.setSales("5,700");
        myResult2Dummy.setProfit("1,700");
        myResult2Dummy.setProfitPer("16.5");
        myResult.add(myResult2Dummy);

        return myResult;
    }

    // 배차 손익 추이
    public List<ResultVehicleVO> getResultVehicle(Map<String, Object>map){
        //List<ResultVehicleVO> ResultVehic = selectList("");

        List<ResultVehicleVO> ResultVehic = new ArrayList<ResultVehicleVO>();

        String custId = map.get("custId").toString();

        ResultVehicleVO ResultVehic1Dummy = new ResultVehicleVO();
        ResultVehic1Dummy.setCustId(custId);
        ResultVehic1Dummy.setVehicleYY("23");
        ResultVehic1Dummy.setVehicleMM("7월");
        ResultVehic1Dummy.setSales(5401);
        ResultVehic1Dummy.setProfit(270);
        ResultVehic1Dummy.setProfitLoss("5.0%");
        ResultVehic.add(ResultVehic1Dummy);

        ResultVehicleVO ResultVehic2Dummy = new ResultVehicleVO();
        ResultVehic2Dummy.setCustId(custId);
        ResultVehic2Dummy.setVehicleYY("23");
        ResultVehic2Dummy.setVehicleMM("8월");
        ResultVehic2Dummy.setSales(5596);
        ResultVehic2Dummy.setProfit(336);
        ResultVehic2Dummy.setProfitLoss("5.0%");
        ResultVehic.add(ResultVehic2Dummy);

        ResultVehicleVO ResultVehic3Dummy = new ResultVehicleVO();
        ResultVehic3Dummy.setCustId(custId);
        ResultVehic3Dummy.setVehicleYY("23");
        ResultVehic3Dummy.setVehicleMM("9월");
        ResultVehic3Dummy.setSales(5863);
        ResultVehic3Dummy.setProfit(460);
        ResultVehic3Dummy.setProfitLoss("5.0%");
        ResultVehic.add(ResultVehic3Dummy);

        ResultVehicleVO ResultVehic4Dummy = new ResultVehicleVO();
        ResultVehic4Dummy.setCustId(custId);
        ResultVehic4Dummy.setVehicleYY("23");
        ResultVehic4Dummy.setVehicleMM("10월");
        ResultVehic4Dummy.setSales(5860);
        ResultVehic4Dummy.setProfit(285);
        ResultVehic4Dummy.setProfitLoss("6.0%");
        ResultVehic.add(ResultVehic4Dummy);

        ResultVehicleVO ResultVehic5Dummy = new ResultVehicleVO();
        ResultVehic5Dummy.setCustId(custId);
        ResultVehic5Dummy.setVehicleYY("23");
        ResultVehic5Dummy.setVehicleMM("11월");
        ResultVehic5Dummy.setSales(5860);
        ResultVehic5Dummy.setProfit(340);
        ResultVehic5Dummy.setProfitLoss("7.0%");
        ResultVehic.add(ResultVehic5Dummy);

        ResultVehicleVO ResultVehic6Dummy = new ResultVehicleVO();
        ResultVehic6Dummy.setCustId(custId);
        ResultVehic6Dummy.setVehicleYY("23");
        ResultVehic6Dummy.setVehicleMM("이번달");
        ResultVehic6Dummy.setSales(5860);
        ResultVehic6Dummy.setProfit(340);
        ResultVehic6Dummy.setProfitLoss("7.0%");
        ResultVehic.add(ResultVehic6Dummy);

        return ResultVehic;
    }

    // Today's High Lights
    public List<TodayCustResultVO> getTodayCustResult(Map<String, Object>map){
        //List<TodyHighVO> todayCustResult = selectList("");

        List<TodayCustResultVO> todayCustResult = new ArrayList<TodayCustResultVO>();

        String custId = map.get("custId").toString();

        TodayCustResultVO tcr1 = new TodayCustResultVO();
        tcr1.setCustId(custId);
        tcr1.setAcountCnm("탐앤탐스");
        tcr1.setAcountDNm("테스트부서");
        tcr1.setAcountId("lm_aaa");
        tcr1.setAcountNm("홍길동");
        tcr1.setSales("1300000");
        tcr1.setPurchase("1000000");
        tcr1.setProfit("200000");
        tcr1.setProfitPersaint("23.10%");
        todayCustResult.add(tcr1);

        TodayCustResultVO tcr2 = new TodayCustResultVO();
        tcr2.setCustId(custId);
        tcr2.setAcountCnm("스타벅스");
        tcr2.setAcountDNm("테스트부서");
        tcr2.setAcountId("lm_aaa");
        tcr2.setAcountNm("홍길동");
        tcr2.setSales("1300000");
        tcr2.setPurchase("1000000");
        tcr2.setProfit("200000");
        tcr2.setProfitPersaint("23.10%");
        todayCustResult.add(tcr2);

        TodayCustResultVO tcr3 = new TodayCustResultVO();
        tcr3.setCustId(custId);
        tcr3.setAcountCnm("이디야");
        tcr3.setAcountDNm("테스트부서");
        tcr3.setAcountId("lm_aaa");
        tcr3.setAcountNm("홍길동");
        tcr3.setSales("1300000");
        tcr3.setPurchase("1000000");
        tcr3.setProfit("200000");
        tcr3.setProfitPersaint("23.10%");
        todayCustResult.add(tcr3);

        return todayCustResult;
    }

    // 전월 TOP 거래처 현황
    public List<MmtopRankVO> getMmtopRank(Map<String, Object>map){
        //List<MmtopRankVO> mmtopRank = selectList("");

        List<MmtopRankVO> mmtopRank = new ArrayList<MmtopRankVO>();

        String custId = map.get("custId").toString();

        MmtopRankVO mmtop1Dummy = new MmtopRankVO();
        mmtop1Dummy.setCustId(custId);
        mmtop1Dummy.setAcountNm("우리와팻푸드");
        mmtop1Dummy.setSales(435);
        mmtop1Dummy.setProfit(20);
        mmtop1Dummy.setProfitLoss("4.7%");
        mmtopRank.add(mmtop1Dummy);

        MmtopRankVO mmtop2Dummy = new MmtopRankVO();
        mmtop2Dummy.setCustId(custId);
        mmtop2Dummy.setAcountNm("NRS");
        mmtop2Dummy.setSales(273);
        mmtop2Dummy.setProfit(20);
        mmtop2Dummy.setProfitLoss("8.5%");
        mmtopRank.add(mmtop2Dummy);

        MmtopRankVO mmtop3Dummy = new MmtopRankVO();
        mmtop3Dummy.setCustId(custId);
        mmtop3Dummy.setAcountNm("카길애그리퓨리나");
        mmtop3Dummy.setSales(234);
        mmtop3Dummy.setProfit(20);
        mmtop3Dummy.setProfitLoss("9.3%");
        mmtopRank.add(mmtop3Dummy);

        MmtopRankVO mmtop4Dummy = new MmtopRankVO();
        mmtop4Dummy.setCustId(custId);
        mmtop4Dummy.setAcountNm("한국타이어");
        mmtop4Dummy.setSales(265);
        mmtop4Dummy.setProfit(25);
        mmtop4Dummy.setProfitLoss("10.1%");
        mmtopRank.add(mmtop4Dummy);

        MmtopRankVO mmtop5Dummy = new MmtopRankVO();
        mmtop5Dummy.setCustId(custId);
        mmtop5Dummy.setAcountNm("한솔페이퍼택");
        mmtop5Dummy.setSales(183);
        mmtop5Dummy.setProfit(18);
        mmtop5Dummy.setProfitLoss("10.0%");
        mmtopRank.add(mmtop5Dummy);

        return mmtopRank;
    }

    // Header 개인 내역
    public String getHeader(Map<String, Object>map){
        String headerPrivate = selectOne("");
        return headerPrivate;
    }
}
