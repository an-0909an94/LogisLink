package com.logislink.dashboard.vo;

// Today High-Light
public class TodayCustResultVO {

    String custId;  // 회사 ID
    String acountCNm;   // 거래처 회사명
    String acountDNm;   // 거래처 담당부서
    String acountId;    // 거래처 아이디
    String acountNm;    // 거래처 담당이름
    String sales;   // 매출
    String purchase;    // 매입
    String profit;  // 이익
    String profitPersaint;  // 이익률

    public String getCustId(){return custId;}
    public void setCustId(String custId){this.custId = custId;}

    public String getAcountCNm(){return acountCNm;}
    public void setAcountCnm(String acountCNm){this.acountCNm = acountCNm;}

    public String getAcountDNm(){return acountDNm;}
    public void setAcountDNm(String acountDNm){this.acountDNm = acountDNm;}

    public String getAcountId(){return acountId;}
    public void setAcountId(String acountId){this.acountId = acountId;}

    public String getAcountNm(){return acountNm;}
    public void setAcountNm(String acountNm){this.acountNm = acountNm;}

    public String getSales(){return sales;}
    public void setSales(String sales){this.sales = sales;}

    public String getPurchase(){return purchase;}
    public void setPurchase(String purchase){this.purchase = purchase;}

    public String getProfit(){return profit;}
    public void setProfit(String profit){this.profit = profit;}

    public String getProfitPersaint(){return profitPersaint;}
    public void setProfitPersaint(String profitPersaint){this.profitPersaint = profitPersaint;}
}
