package com.logislink.dashboard.vo;

// 나의 실적
public class MyResultVO {

    String userId;  // 조회 아이디
    String resultFlag;  // 실적 구분
    String allocCnt;    // 배차 건수
    String sales;   // 매출액
    String profit;  // 이익
    String profitPer;   // 이익률

    public String getUserId(){return userId;}
    public void setUserId(String userId){this.userId=userId;}

    public String getResultFlag(){return resultFlag;}
    public void setResultFlag(String resultFlag){this.resultFlag = resultFlag;}

    public String getAllocCnt(){return allocCnt;}
    public void setAllocCnt(String allocCnt){this.allocCnt = allocCnt;}

    public String getSales(){return sales;}
    public void setSales(String sales){this.sales = sales;}

    public String getProfit(){return profit;}
    public void setProfit(String profit){this.profit = profit;}

    public String getProfitPer(){return profitPer;}
    public void setProfitPer(String profitPer){this.profitPer = profitPer;}
}
