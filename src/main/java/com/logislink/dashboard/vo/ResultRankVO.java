package com.logislink.dashboard.vo;

// 최근 실적 랭킹
public class ResultRankVO {

    String custId;  // 조회회사 ID
    String searchDate;  // 조회일
    String resultFlag;  // 실적 구분 CD
    String resultFlagNm;    // 실적 구분
    String userId;  // 아이디
    String userNm;  // 이름
    String resultVal;   // 결과값
    String resultUnit;  // 결과 단위

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
