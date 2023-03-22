package com.logislink.dashboard.vo;

// 전월 Top 거래처 현황
public class MmtopRankVO {

    String custId;  // 회사 ID 
    String acountNm;    // 거래처 회사면
    int sales;  // 매출
    int profit; // 이익
    String profitLoss;  // 손익이익률

    public String getCustId(){return custId;}
    public void setCustId(String custId){this.custId = custId;}

    public String getAcountNm(){return acountNm;}
    public void setAcountNm(String acountNm){this.acountNm = acountNm;}

    public int getSales(){return sales;}
    public void setSales(int sales){this.sales = sales;}

    public int getProfit(){return profit;}
    public void setProfit(int profit){this.profit = profit;}

    public String getProfitLoss(){return profitLoss;}
    public void setProfitLoss(String profitLoss){this.profitLoss = profitLoss;}
}
