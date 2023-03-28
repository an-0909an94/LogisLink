package com.logislink.dashboard.vo;

public class ResultRank {

    String custId;
    String searchDate;
    String resultFlag;
    String resultFlagNm;
    String userId;
    String userNm;
    String resultVal;
    String resultUnit;

    public String getCustId(){return custId;}
    public void setCustId(String custId){this.custId = custId;}

    public String getSearchDate(){return searchDate;}
    public void setSearchDate(String searchDate){this.searchDate = searchDate;}

    public String getResultFlag(){return resultFlag;}
    public void setResultFlag(String resultFlag){this.resultFlag = resultFlag;}

    public String getResultFlagNm(){return resultFlagNm;}
    public void setResultFlagNm(String resultFlagNm){this.resultFlagNm = resultFlagNm;}

    public String getUserId(){return userId;}
    public void setUserId(String userId){this.userId = userId;}

    public String getUserNm(){return userNm;}
    public void setUserNm(String userNm){this.userNm = userNm;}

    public String getResultVal(){return resultVal;}
    public void setResultVal(String resultVal){this.resultVal = resultVal;}

    public String getResultUnit(){return resultUnit;}
    public void setResultUnit(String resultUnit){this.resultUnit = resultUnit;}
}
