package com.logislink.dashboard.vo;

// 배차손익추이
public class ResultVehicleVO {
    String YYYYMM; // 날짜
    String custId;  // 거래처
    String YYYY;   // 년도
    String MM;   // 월
    String sales;     // 매출
    String profit;     // 이익
    String profitPer;  // 손익이익률

    public String getYYYYMM(){return YYYYMM;}

    public void setYYYYMM(String YYYYMM) {
        this.YYYYMM = YYYYMM;
    }

    public String getCustId(){return custId;}
    public void setCustId(String custId){this.custId = custId;}

    public String getYYYY(){return YYYY;}
    public void setYYYY(String YYYY){this.YYYY = YYYY;}

    public String getMM(){return MM;}
    public void setMM(String MM){this.MM = MM;}

    public String getSales(){return sales;}
    public void setSales(String sales){this.sales = sales;}

    public String getProfit(){return profit;}
    public void setProfit(String profit){this.profit = profit;}

    public String getProfitPer(){return profitPer;}
    public void setProfitPer(String profitPer){this.profitPer = profitPer;}
}
