package com.logislink.dashboard.vo;

// 배차손익추이
public class ResultVehicleVO {
    String searchMonth; // 날짜
    String custId;  // 거래처
    String yyyy;   // 년도
    String vehicleMM;   // 월
    int sales;     // 매출
    int profit;     // 이익
    String profitLoss;  // 손익이익률

    public String getSearchMonth(){return searchMonth;}

    public void setSearchMonth(String searchMonth) {
        this.searchMonth = searchMonth;
    }

    public String getCustId(){return custId;}
    public void setCustId(String custId){this.custId = custId;}

    public String getYyyy(){return yyyy;}
    public void setYyyy(String yyyy){this.yyyy = yyyy;}

    public String getVehicleMM(){return vehicleMM;}
    public void setVehicleMM(String vehicleMM){this.vehicleMM = vehicleMM;}

    public int getSales(){return sales;}
    public void setSales(int sales){this.sales = sales;}

    public int getProfit(){return profit;}
    public void setProfit(int profit){this.profit = profit;}

    public String getProfitLoss(){return profitLoss;}
    public void setProfitLoss(String profitLoss){this.profitLoss = profitLoss;}
}
