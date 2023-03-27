package com.logislink.dashboard.vo;

import org.apache.ibatis.mapping.ResultFlag;

public class ResultRank {

    String resultFlag;
    String resultFlagNm;
    String userId;
    String userNm;
    String resultVal;
    String resultUnit;

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
