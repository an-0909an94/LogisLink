package com.logislink.dashboard.vo;

// 배차손익추이
public class ResultVehicleVO {
    String custId;  // 거래처
    String vehicleYY;   // 년도
    String vehicleMM;   // 월
    int sales;     // 매출
    int profit;     // 이익
    String profitLoss;  // 손익이익률

    public String getCustId(){return custId;}
    public void setCustId(String custId){this.custId = custId;}

    public String getVehicleYY(){return vehicleYY;}
    public void setVehicleYY(String vehicleYY){this.vehicleYY = vehicleYY;}

    public String getVehicleMM(){return vehicleMM;}
    public void setVehicleMM(String vehicleMM){this.vehicleMM = vehicleMM;}

    public int getSales(){return sales;}
    public void setSales(int sales){this.sales = sales;}

    public int getProfit(){return profit;}
    public void setProfit(int profit){this.profit = profit;}

    public String getProfitLoss(){return profitLoss;}
    public void setProfitLoss(String profitLoss){this.profitLoss = profitLoss;}
}
