package com.logislink.cmm.vo;

public class TermsAgreeVO {
    private String tel;
    private String userID;
    private String necessary;
    private String selective;
    private String agreeDate;
    private String version;

    public String getTel() {
        return tel;
    }
    public void setTel(String tel){this.tel = tel;}

    public String getUserID(){
        return userID;
    }

    public void setUserID(String userID){this.userID=userID;}

    public String getNecessary(){return necessary;}

    public void setNecessary(String necessary){this.necessary=necessary;}

    public String getSelective(){return selective;}

    public void setSelective(String selective){this.selective=selective;}

    public String getAgreeDate(){return agreeDate;}

    public void setAgreeDate(String agreeDate){this.agreeDate=agreeDate;}

    public String getVersion(){return version;}

    public void setVersion(String version){this.version=version;}
}
