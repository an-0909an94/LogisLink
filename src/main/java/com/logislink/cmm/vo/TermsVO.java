package com.logislink.cmm.vo;


public class TermsVO {

    private int number;
    private String name;
    private String releaseDate;
    private String version;
    private String type;
    private String require;
    private String detail;

    public int getNumber() {return number;}
    public void setNumber(int number){this.number = number;}

    public String getName() {return name;}
    public void setName(String name){this.name=name;}

    public String getReleaseDate(){return releaseDate;}
    public void setReleaseDate(String releaseDate){this.releaseDate=releaseDate;}

    public String getVersion(){return version;}
    public void setVersion(String version){this.version=version;}

    public String getType(){return type;}
    public void setType(String type){this.type=type;}

    public String getRequire(){return require;}
    public void setRequire(String require){this.require=require;}

    public String getDetail(){return detail;}
    public void setDetail(String detail){this.detail=detail;}
}
