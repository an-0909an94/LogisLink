<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <title>LOGISLINK DASHBOARD</title>
</head>
<body>

<style>

    *{margin: 0px; padding: 0px;}
    a{text-decoration: none; color: #333}
    li{list-style-type: none;}

    .color_b{color: #00d8ff;}
    .color_g{color: #00ffba;}
    .color_r{color: #ff624c;}

    body{background-color: #2a2a2a; color: white; letter-spacing: -0.05em; font-family: 'Noto Sans KR', sans-serif;}
    #wrap{width: 100%; margin: auto;}
    header{width: 1840px; height: 74px; padding: 12px 30px 14px 30px; box-sizing: border-box; margin: 24px auto 0; border-radius: 20px;; background-color: #191919; display: flex; justify-content: space-between;}
    header div{display: flex; justify-content: space-between;}
    header h1{font-size: 0px; width: 124px; height: 46px; background: url(/img/logo.png) no-repeat; margin-right: 34px;}
    header .header_left b{font-size: 30px; font-weight: 900; margin-top: 4px;}
    header .header_left b span{font-size: 16px; font-weight: 400; margin-left: 15px;;}

    header .header_right ul::after{content: ''; clear: both; display: block;}
    header .header_right ul{background-color: #0a0a0a; border-radius: 21px; padding: 10px 18px 10px 25px; box-sizing: border-box; margin: 0 10px 0 0; line-height: 26px;;}
    header .header_right ul li{float: left; font-size: 16px; position: relative; margin-right: 40px;}
    header .header_right ul:last-of-type li:nth-of-type(2), header .header_right ul li:last-of-type{margin-right: 0px;}
    header .header_right ul li[class ^= "color_"]{font-weight: bold;}
    header .header_right ul li[class ^= "color_"]::before{content: ''; width: 1px; height: 24px; background-color: white; position: absolute; top: 50%; transform: translateY(-50%); left: -20px;}

    header .header_right ul:nth-of-type(2) li:last-child::after{content: ''; width: 25px; height: 25px; background: url(/img/icon_all.png) no-repeat; background-position: 0px 0px; display: inline-block; position: absolute; top: 50%; right: -40px; transform: translateY(-50%);}
    header .header_right ul:nth-of-type(2) li:last-of-type{margin-right: 40px;}

    header .header_right ul:last-of-type a{background-color: #ff624c; border: none; border-radius: 14px; width: 64px; height: 28px; margin-left: 14px; font-weight: bold; letter-spacing: -0.02em; display: inline-block; text-align: center;}
    header .header_right ul:last-of-type li:nth-of-type(2){margin-top: 0;}

    header a.replay span{display: block; width: 26px; height: 25px; background: url(/img/icon_all.png) no-repeat; background-position: 1px -28px; font-size: 0; margin: 7px auto 0;}
    header a.region span{display: block; width: 25px; height: 25px; background: url(/img/icon_all.png) no-repeat; background-position: 0px -60px; font-size: 0; margin:  7px auto 0;}

    header a.btn_gray {width: 42px; height: 42px; background-color: #3b3b3b; border-radius: 14px;}
    header a.btn_gray:hover {width: 42px; height: 42px; box-shadow: inset 6px 4px 9px rgb(118 118 118 / 66%);}
    header a.btn_gray.replay{margin-right: 10px;}

    header a.btn_gray.region,header a.btn_gray.replay{position: relative;}
    header a.btn_gray.region p,header a.btn_gray.replay p{font-size: 0;}
    header a.btn_gray.region:hover p,header a.btn_gray.replay:hover p{width: 90px; height: 37px; font-size: 14px; color: black; position: absolute; top: 56px; right: 0px; background-color: white;  text-align: center; line-height: 37px; box-shadow: 18px 18px 9px rgba(0, 0, 0, 0.3); border-radius: 10px; }
    header a.btn_gray.region:hover p::before,header a.btn_gray.replay:hover p::before{content: ''; display: block; position: absolute; top: -12px; left: 62px; width: 0; height: 0; border-bottom: 10px solid white; border-top: 3px solid transparent; border-left: 5px solid transparent; border-right: 5px solid transparent;}

    /* section */
    section{max-width: 1920px; margin: auto;}
    section .layout{display: flex; justify-content: space-between; padding: 40px 80px 0 90px; box-sizing: border-box;}

    /* section_left */
    section .section_left{min-width: 1280px;}
    section .section_left::after{content: ''; clear: both; display: block;}

    section .recent_ranking{width: 620px; float: left;}
    section .recent_ranking::after{content: ''; clear: both; display: block;}
    section .section_left h2{float: left;}
    section .section_left input{display: none;}
    section .section_left .ranking_label{width: 112px; height: 30px; background-color: #151515; border-radius: 15px; border: 1px solid #434343; box-sizing: border-box; display: flex; float: right; margin-bottom: 14px;}
    section .section_left label{cursor: pointer; width: 50%; transition: 0.2s; color: #898989; text-align: center; line-height: 26px; font-size: 12px;}
    section .recent_ranking input:first-of-type:checked ~ .ranking_label label:first-of-type,
    section .recent_ranking input:last-of-type:checked ~ .ranking_label label:last-of-type{background-color: #434343; border-radius: 15px; color: white; font-weight: 700;}

    section .recent_ranking_box{clear: both; margin-top: 14px;}
    section .recent_ranking_box div{display: none;}
    section .recent_ranking_box ul{display: flex;}
    section .recent_ranking_box ul::after{content: ''; clear: both; display: block;}
    section .recent_ranking input:first-of-type:checked ~ .recent_ranking_box div:first-of-type,
    section .recent_ranking input:last-of-type:checked ~ .recent_ranking_box div:last-of-type{display: block;}
    section .recent_ranking_box ul li{width: 143px; height: 148px; padding: 18px; background-color: #191919; margin-right: 16px; float: left; border-radius: 20px; border: 3px solid #006dff; box-sizing: border-box;}
    section .recent_ranking_box ul li:last-of-type{margin-right: 0px;}

    section .recent_ranking_box ul li.sales{border: 3px solid #00d8ff;}
    section .recent_ranking_box ul li.profit{border: 3px solid #07c28f;}
    section .recent_ranking_box ul li.profitRate{border: 3px solid #ff624c;}

    section .recent_ranking_box ul li p.ranking_tit{width: 78px; height: 26px; border-radius: 7px; text-align: center; font-size: 14px; font-weight: 500; line-height: 26px;}
    section .recent_ranking_box ul li.vehicle .ranking_tit{background-color: #0c438c;}
    section .recent_ranking_box ul li.sales .ranking_tit{background-color: #0c798c;}
    section .recent_ranking_box ul li.profit .ranking_tit{background-color: #0c8c6a;}
    section .recent_ranking_box ul li.profitRate .ranking_tit{background-color: #8c3e33;}

    section .recent_ranking_box ul li>div{margin-top: 29px;}
    section .recent_ranking_box ul li>div p{font-size: 14px; color: #898989;}
    section .recent_ranking_box ul li>div b{font-size: 24px; color: white;}
    section .recent_ranking_box ul li>div span{font-size: 14px; color: white;}

    section .my_ranking{width: 620px; float: right;}
    section .my_ranking::after{content: ''; clear: both; display: block;}
    section .my_ranking input:first-of-type:checked ~ .ranking_label label:first-of-type,
    section .my_ranking input:last-of-type:checked ~ .ranking_label label:last-of-type{background-color: #434343; border-radius: 15px; color: white; font-weight: 700;}

    section .my_ranking input:first-of-type:checked ~ .my_ranking_box div:first-of-type,
    section .my_ranking input:last-of-type:checked ~ .my_ranking_box div:last-of-type{display: block;}

    section .my_ranking_box{background-color: #1d1d1d; border-radius: 20px; clear: both; display: block; width: 100%; height: 148px; padding: 15px 45px; box-sizing: border-box;}
    section .my_ranking_box div{display: none;}
    section .my_ranking_box ul::after{content: ''; clear: both; display: block;}
    section .my_ranking_box li{float: left; width: 50%; margin-bottom: 13px;}
    section .my_ranking_box li:nth-of-type(3),section .my_ranking_box li:last-of-type{margin-bottom: 0;}
    section .my_ranking_box .my_ranking_tit{background-color: #0e0e0e; display: inline-block; width: 104px; height: 40px; font-size: 18px; letter-spacing: -0.03em; border-radius: 10px; text-align: center; line-height: 36px;}
    section .my_ranking_box li.vehicle{color: #006dff;}
    section .my_ranking_box li.sales{color: #00d8ff;}
    section .my_ranking_box li.profit{color: #05d79d;}
    section .my_ranking_box li.profitRate{color: #ff624c;}
    section .my_ranking_box span{font-size: 20px; margin-left: 17px; position: relative; top: 4px;}
    section .my_ranking_box span b{font-size: 30px;}

    /* highLight */
    section .highLight{width: 100%; padding: 55px 0 0 0; clear: both;}
    section .highLight::after{content: ''; clear: both; display: block;}
    section .highLight h2{margin-top: 6px;}
    section .highLight h2 span{color: #898989; font-size: 14px; margin-left: 10px;}
    section .highLight_slide{width: 1114px; float: right; overflow: hidden; height: 80px; border-radius: 40px; border: 3px solid transparent; background-image: linear-gradient(#fff, #fff), linear-gradient(to right, #646464 45%, #b5b5b4  50%,  #646464 65%); background-origin: border-box; background-clip: content-box, border-box; box-sizing: border-box;}
    section .highLight_slide>ul{height: 80px;;}
    section .highLight_slide>ul>li{background-color: #434343; padding: 15px 50px; box-sizing: border-box; height: 80px;}
    section .highLight_slide ul.highLight_slide_cont{display: flex; justify-content: space-between;}
    section .highLight_slide ul.highLight_slide_cont li{font-size: 12px;}
    section .highLight_slide ul.highLight_slide_cont span{display: block; font-size: 19px; font-weight: bold;}

    section .graph_vehicle{margin-top: 50px; float: left; width: 620px;}
    section .graph_top{margin-top: 50px; float: right; width: 620px;}
    section div[class ^= "graph_"] h2{display: block; float: none; margin-bottom: 18px;}
    section div[class ^= "graph_"]>div{width: 620px; height: 360px; background-color: #1d1d1d; border-radius: 20px;;}

    /* section_right */
    section .section_right{width: 400px;}
    section .section_right .weather h2 p{font-size: 14px; color: #898989; display: inline-block;}
    section .section_right .weather>div{width: 100%; background-color: #1d1d1d; margin-top: 9px; border-radius: 20px;}
    section .section_right .weather>div>ul{padding: 0 15px; box-sizing: border-box;}
    section .section_right .weather>div li{border-bottom: 1px solid #535353; display: flex; padding: 22px 52px; box-sizing: border-box;}
    section .section_right .weather>div li:last-of-type{border-bottom: none;}

    section .section_right .weather .weather_day{display: inline-block; font-size: 20px; width: 89px;}
    section .section_right .weather ul li ul{display: inline-block;}
    section .section_right .weather ul li div{position: relative; width: 75px;}
    section .section_right .weather ul li div span.weather_txt{font-size: 10px; position: absolute; top: -5px; left: 52px;}
    section .section_right .weather ul li p.weather_temperatures{font-size: 17px; font-weight: bold; position: absolute; top: 6px; left: 40px; width: 39px!important; text-align: center;}
    section .section_right .weather div.weather_afternoon{margin-left: 10px;}
    section .section_right .weather div.weather_afternoon span.weather_txt{left: 45px;}
    section .section_right .weather div.weather_afternoon p.weather_temperatures{left: 34px;}

    section .weather span[class ^="weather_icon_"]{font-size: 0px !important; width: 39px; height: 26px; display: block; background: url('/img/icon_weather.png') no-repeat; background-position: 0px 0px;}

    /* 날씨아이콘 S */

    /* 구름 */
    section .weather span.weather_icon_cloud{background-position: 0px -204px; height: 28px;}
    /* 맑음 */
    section .weather span.weather_icon_sun{background-position: 0px -140px; height: 30px;}
    /* 소나기 */
    section .weather span.weather_icon_rainsnow{background-position: 0px -36px; height: 28px;}
    /* 눈 */
    section .weather span.weather_icon_snow{background-position: 0px -68px; height: 33px;}
    /* 비 */
    section .weather span.weather_icon_rain{background-position: 0px -4px; height: 28px;}
    /* 안개 */
    section .weather span.weather_icon_fag{background-position: 0px -175px; height: 28px;}
    /* 번개 */
    section .weather span.weather_icon_shower{background-position: 0px -106px; height: 28px;}

    /* 날씨아이콘 E */

    /* oilMoney */
    section .section_right .oilMoney{width: 100%; margin-top: 50px;}
    section .section_right .oilMoney>div{margin-top: 9px; background-color: #1d1d1d;  border-radius: 20px; overflow: hidden;}
    section .section_right .oilMoney table{width: 100%; border-radius: 20px; border-collapse: collapse; text-align: center;}
    section .section_right .oilMoney table tr:first-of-type{background-color: #3b3b3b;}
    section .section_right .oilMoney table th{font-size: 16px; font-weight: 400; padding: 12px 0 10px 0;}
    section .section_right .oilMoney table td{padding: 14px 0; font-size: 20px;}
    section .section_right .oilMoney table tr:nth-of-type(2){border-bottom: 1px solid #626262;}
    section .section_right .oilMoney .color_b, section .section_right .oilMoney .color_g{font-size: 16px;}

    /* notice */
    .notice_bg{display: none; width: 100%; height: 100vh; background-color: rgba(0, 0, 0, 0.5); position: fixed; top: 0px; left: 0px; z-index: 1;}

    section .section_right .notice{width: 100%; margin-top: 50px;}
    section .section_right .notice ul{ width: 100%;}
    section .section_right .notice ul li{background-color: #1d1d1d; margin-top: 10px; border-radius: 20px; font-size: 14px; word-spacing: 1px; line-height: 27px;}
    section .section_right .notice .notice_title{cursor: pointer;}
    .notice_box:hover{ box-shadow: inset 6px 4px 9px rgb(118 118 118 / 66%); }
    section .section_right .notice div.notice_title dt{width: 100%; height: 25px; overflow: hidden; white-space: nowrap; text-overflow: ellipsis;}
    section .section_right .notice div.notice_title dl{padding: 13.5px 30px;}
    section .section_right .notice div.notice_popup dd{font-family: 'Noto Sans KR', sans-serif; font-size: 14px; color: #898989; border-bottom: 1px solid #898989; padding: 0 0 15px 0;}

    section .section_right .notice_popup{display: none; position: fixed; top: 50%; left: 50%; transform: translateX(-50%) translateY(-50%); width: 556px; min-height: 520px; background-color: #2a2a2a; z-index: 9; border-radius: 20px; padding: 23px 20px 0 23px; box-sizing: border-box;}
    section .section_right .notice_popup p{font-size: 20px; font-weight: bold; text-align: center;}
    section .section_right .notice_popup>div{width: 100%; height: 360px; max-height: 360px; overflow-y: auto; background-color: #1d1d1d; margin-top: 23px; padding: 10px 15px; box-sizing: border-box;}
    section .section_right .notice_popup dt{font-size: 16px; font-weight: bold; width: 100%; height: 25px; overflow: hidden; white-space: nowrap; text-overflow: ellipsis;}
    section .section_right .icon_close{width: 26px; height: 25px; background: url(../img/icon_all.png) no-repeat; background-position: -1px -145px;  border: none; position: absolute; top: 26px; right: 15px; font-size: 0; cursor: pointer;}
    section .section_right .notice_popup div.contents{padding: 0px; margin-top: 15px;}
    section .section_right .btn_close{width: 170px; height: 44px; background-color: #3b3b3b; border-radius: 6px; color: white; border: none; margin: 22px auto; display: block; cursor: pointer; font-size: 14px; font-weight: 500; font-family: 'Noto Sans KR', sans-serif;}


    /* sns */
    section .section_right .sns{width: 100%; height: 72px; background-color: #3b3b3b; margin-top: 20px; border-radius: 20px;}
    section .section_right .sns ul{display: flex; padding: 14px 20px; box-sizing: border-box;}
    section .section_right .sns li{width: 50%; height: 44px; margin-right: 10px; background-color: #2f2f2f; border-radius: 8px; padding: 0 30px; box-sizing: border-box;}
    section .section_right .sns li:last-of-type{margin-right: 0px;}
    section .section_right .sns a{color: white; font-size: 12px; display: block;}
    section .section_right .sns a::before{content: ''; width: 26px; height: 26px; background: url(../img/icon_all.png) no-repeat; margin-right: 10px; display: inline-block; position: relative; top: 8px;}
    section .section_right .sns li.video a::before{background-position: 0px -90px;}
    section .section_right .sns li.blog a::before{background-position: 0px -120px;}
    .media { width: 100%;}

    @media screen and (max-width: 1870px){
        header{width: 95%; min-width: 1280px;}
        header h1{width: 90px; background-size: contain;}
        header .header_left b{font-size: 24px;}
        header .header_right ul{padding: 10px 15px;}
        header .header_right ul li{font-size: 14px;}

        /* section */
        section .layout{width: 90%; min-width: 1280px; margin: 40px auto; display: block; padding: 0;}

        /* recent_ranking */
        section .recent_ranking{width: 48%; min-width: 584px;}
        section .recent_ranking_box ul li{width: 100%; min-width: 134px; height: 148px;}

        section .my_ranking{width: 48%;}
        section .my_ranking_box{padding: 15px 30px;}

        section .highLight_slide{width: 85%;}

        section .graph_vehicle, section .graph_top{width: 48%; min-width: 584px;}
        section div[class ^= "graph_"]>div{width: 100%;}

        /* section_right */
        section .section_right{width: 100%; min-width: 1280px; display: flex; justify-content: space-between;}

        section .section_right .weather{width: 100%; margin-top: 45px; margin-right: 30px;}
        section .section_right .weather>div{height: 160px;}
        section .section_right .weather>div li{justify-content: space-evenly;}

        section .section_right .oilMoney{width: 100%; margin-top: 45px; margin-right: 30px;}
        section .section_right .oilMoney>div{width: 100%;}
        section .section_right .oilMoney table td{font-size: 17px;}

        section .section_right .notice{width: 100%; margin-top: 45px;}

        section .section_right .sns{width: 100%; margin-top: 16px;}

        section .section_right .notice ul li:last-of-type{display: none;}


    }

    @media screen and (max-width: 1300px){
        /* header */
        header{min-width: 1230px; padding: 12px 20px;}
        header h1{width: 90px; background-size: contain; margin-right: 25px;}

        header .header_left b{font-size: 23px;}
        header .header_left b span{margin-left: 5px; font-size: 14px;}
        header .header_right ul{padding: 10px 15px;}
        header .header_right ul li{font-size: 14px;}

        /* section */
        section .layout{width: 1200px; min-width: 1200px; margin: 40px auto; display: block; padding: 0;}
        section .section_left h2{font-size: 24px;}
        section .section_left{width: 100%; min-width: 1200px;}

        /* recent_ranking */
        section .recent_ranking{width: 48%; min-width: 584px;}
        section .recent_ranking_box ul li{width: 100%; min-width: 134px; height: 148px;}

        section .my_ranking{width: 48%;}
        section .my_ranking_box{padding: 15px 30px;}

        /* highLight */
        section .highLight{display: flex; justify-content: space-between;}
        section .highLight_slide{max-width: 1034px; }
        section .highLight::after{display: none;}

        section .graph_vehicle, section .graph_top{width: 48%; min-width: 584px;}
        section div[class^="graph_"] > div{width: 100%;}

        /* section .section_right */
        section .section_right{width: 100%; min-width: 1200px; display: flex; justify-content: space-between;}
        section .section_right>div{float: left;}
        section .section_right .weather{width: 380px; margin-top: 45px; margin-right: 30px;}
        section .section_right .weather>div{height: 160px;}

        section .section_right .oilMoney{width: 380px; margin-top: 45px; margin-right: 30px;}
        section .section_right .oilMoney>div{width: 100%;}
        section .section_right .oilMoney table td{font-size: 20px;}

        section .section_right .notice{width: 380px; margin-top: 45px;}

        section .section_right .sns{width: 380px; margin-top: 16px;}

    }

</style>
<div id="wrap">
    <div class="notice_bg"></div>
    <header>
        <div class="header_left">
            <h1><a href="${sessionScope.userInfo.userMainPage}">로지스링크</a></h1>
            <b>${sessionScope.userInfo.userName} 님<span>${sessionScope.userInfo.bizName.replace('주식회사', '㈜')}</span></b>
        </div>
        <div class="header_right">
            <ul>
                <li>배차 CREDIT</li>
                <li class="color_b">56,850 Point</li>
            </ul>
            <ul>
                <li>프로모션 목표</li>
                <li class="color_g">5,000 Point</li>
            </ul>
            <ul>
                <li>신청가능 상품</li>
                <li class="color_r">신세계 상품권</li>
                <li><a href="#">신청</a></li>
            </ul>
            <a href="#" class="btn_gray replay"><span onClick="window.location.reload()">새로고침</span><p>새로고침</p></a>
            <a href="#" id="navPopup" class="btn_gray region"><span>지역설정</span><p>지역설정</p></a>

            <style>
                /* 레이어팝업 */
                #popupLayer{}
                .nav-layer {
                    display: none;
                    position: fixed;
                    top: 24%;
                    left: 36%;
                    width: 500px;
                    height: 500px;
                    z-index: 100;
                }
                .navContents {
                    position: relative;
                    width: 500px;
                    height: 500px;
                    overflow-y: scroll;
                    -ms-overflow-style: none;
                    scrollbar-width: none;
                    background: #fff;
                    color: #333;
                    padding: 7%;
                    display: flex;
                    flex-direction: column;
                    align-items: center;
                    gap: 0.8px;
                    border-radius: 43px;
                }
                .navContents::-webkit-scrollbar {
                    display: none;
                }
                .navContents h2 {
                    font-size: 20px;
                    height: auto;
                }
                .navContents p {
                    font-size: 14px;
                    height: auto;
                }
                .navInfo {
                    display: flex;
                    flex-wrap: nowrap;
                    width: 400px;
                    margin: 0 auto;
                    align-content: space-around;
                    flex-direction: column;
                }
                .exitBtn {
                    cursor: pointer;
                }
                .navInfo label { margin: 10px 0px;}
                #morningTemperature span:nth-child(n+2) {
                    display: none;
                }
                #afternoonTemperature span:nth-child(n+2) {
                    display: none;
                }
                #tomorrowMorningTemperature span:nth-child(n+2) {
                    display: none;
                }
                #tomorrowAfternoonTemperature span:nth-child(n+2) {
                    display: none;
                }
                .graphB, .graphT {
                    position: relative;
                }
                #beGraph{
                    margin: 0 auto;
                    position: absolute;
                    top: 85px;
                    left: 26px;
                }
                #mmGraph {
                    margin: 0 auto;
                    position: absolute;
                    top: 85px;
                    left: 26px;
                }

                #custom1, #custom2 {
                    position: absolute;
                    display: flex;
                    justify-content: flex-end;
                    flex-direction: row;
                    width: 600px;
                }
                #custom1 ul, #custom2 ul {
                    position: relative;
                    width: 200px;
                    display: flex;
                    align-items: center;
                    justify-content: flex-end;
                    top: 44px;
                    left: 12px;
                }
                #custom1 ul li, #custom2 ul li {
                    position: relative;
                    display: flex;
                    flex-direction: row;
                    flex-wrap: nowrap;
                    width: 57px;
                    align-items: center;
                    font-size: 10px;
                }
                .g-square{
                    width: 17px;
                    height: 3px;
                    background: #a0a0a0;
                    margin-right: 3px;

                }
                .t-square1{
                    width: 17px;
                    height: 3px;
                    background: #a0a0a0;
                    margin-right: 3px;

                }
                .t-square2{
                    width: 17px;
                    height: 3px;
                    background: #ff624c;
                    margin-right: 3px;

                }
                .g-circle{
                    width: 5px;
                    height: 5px;
                    border-radius: 100px;
                    background: #ff0000;
                    margin-right: 3px;
                    border: 1px solid #ddd;
                }

                .graph_vehicle_percentage, .graph_top_percentage{
                    margin-left: 25px;
                    display: flex;
                    align-items: center;
                    justify-content: center;
                    position: absolute;
                    bottom: 47px;}
                .graph_vehicle_percentage::after,section .graph_vehicle .graph_vehicle_percentage ul::after, .graph_top_percentage::after,section .graph_top .graph_top_percentage ul::after{
                    content: '';
                    clear: both;
                    display: block;
                }
                .graph_vehicle_percentage p,.graph_top_percentage p{
                    float: left;
                    color: #00ffba;
                    font-size: 12px;
                    line-height: 30px;
                }
                .graph_vehicle_percentage ul{
                    width: 452px;
                    background-color: #3b3b3b;
                    border-radius: 50px;
                    padding: 3px 0px;
                    box-sizing: border-box;
                    float: left;
                    margin-left: 15px;
                    display: flex;
                    justify-content: center;
                }
                .graph_top_percentage ul{
                    width: 514px;
                    background-color: #3b3b3b;
                    border-radius: 50px;
                    padding: 3px 0px;
                    box-sizing: border-box;
                    float: left;
                    margin-left: 15px;
                    display: flex;
                    justify-content: center;
                }
                .graph_vehicle_percentage ul li{
                    float: left;
                    text-align: center;
                    color: #00ffba;
                    font-weight: bold;
                    font-size: 12px;
                    width: 17%;
                }
                .graph_top_percentage ul li{
                    float: left;
                    text-align: center;
                    color: #00ffba;
                    font-weight: bold;
                    font-size: 12px;
                    width: 21%;
                }
                .graph_vehicle_percentage ul li:first-of-type, .graph_top_percentage ul li:first-of-type{
                    display: flex;
                    justify-content: center;
                }
                .graph_vehicle_percentage ul li:last-of-type, .graph_top_percentage ul li:last-of-type{
                    padding-right: 0px;
                }
            </style>

            <!-- 지역 설정 -->
            <div class="nav-layer" id="popupLayer">
                <div class="navContents">
                    <h2>지역을 설정해주세요!</h2>
                    <p>지역을 설정하면 날씨와 유가정보를 확인할 수 있습니다.</p>
                    <div class="navInfo">
                        <label><input type="radio" class="navList" name="region" value="1" data-sido="01" data-sido-name="서울"><span id="region1">서울</span></label>
                        <label><input type="radio" class="navList" name="region" value="2" data-sido="02" data-sido-name="경기"><span id="region2">경기</span></label>
                        <label><input type="radio" class="navList" name="region" value="3" data-sido="03" data-sido-name="강원"><span id="region3">강원</span></label>
                        <label><input type="radio" class="navList" name="region" value="4" data-sido="04" data-sido-name="충북"><span id="region4">충북</span></label>
                        <label><input type="radio" class="navList" name="region" value="5" data-sido="05" data-sido-name="충남"><span id="region5">충남</span></label>
                        <label><input type="radio" class="navList" name="region" value="6" data-sido="06" data-sido-name="전북"><span id="region6">전북</span></label>
                        <label><input type="radio" class="navList" name="region" value="7" data-sido="07" data-sido-name="전남"><span id="region7">전남</span></label>
                        <label><input type="radio" class="navList" name="region" value="8" data-sido="08" data-sido-name="경북"><span id="region8">경북</span></label>
                        <label><input type="radio" class="navList" name="region" value="9" data-sido="09" data-sido-name="경남"><span id="region9">경남</span></label>
                        <label><input type="radio" class="navList" name="region" value="10" data-sido="10" data-sido-name="부산"><span id="region10">부산</span></label>
                        <label><input type="radio" class="navList" name="region" value="18" data-sido="18" data-sido-name="울산"><span id="region18">울산</span></label>
                        <label><input type="radio" class="navList" name="region" value="14" data-sido="14" data-sido-name="대구"><span id="region14">대구</span></label>
                        <label><input type="radio" class="navList" name="region" value="15" data-sido="15" data-sido-name="인천"><span id="region15">인천</span></label>
                        <label><input type="radio" class="navList" name="region" value="16" data-sido="16" data-sido-name="광주"><span id="region16">광주</span></label>
                        <label><input type="radio" class="navList" name="region" value="17" data-sido="17" data-sido-name="대전"><span id="region17">대전</span></label>
                        <label><input type="radio" class="navList" name="region" value="19" data-sido="19" data-sido-name="세종"><span id="region19">세종</span></label>
                        <label><input type="radio" class="navList" name="region" value="11" data-sido="11" data-sido-name="제주"><span id="region11">제주</span></label>
                    </div>
                    <div id="navClose" class="exitBtn">X</div>
                </div>
            </div>
        </div>
    </header>

    <section>
        <div class="layout">
            <div class="section_left">
                <div class="recent_ranking">
                    <h2>최근실적 Ranking</h2>
                    <input type="radio" id="ranking_today" name="recent_ranking" checked>
                    <input type="radio" id="ranking_yesterday" name="recent_ranking">
                    <div class="ranking_label">
                        <label for="ranking_today">오늘</label>
                        <label for="ranking_yesterday">어제</label>
                    </div>
                    <div class="recent_ranking_box">
                        <div>
                            <ul>
                                <li class="vehicle vehicletoday">
                                    <p class="ranking_tit title"></p>
                                    <div>
                                        <p class="name"></p>
                                        <b class="rank"></b>
                                        <span class="Unit"></span>
                                    </div>
                                </li>
                                <li class="sales salestoday">
                                    <p class="ranking_tit title"></p>
                                    <div>
                                        <p class="name"></p>
                                        <b class="rank"></b>
                                        <span class="Unit"></span>
                                    </div>
                                </li>
                                <li class="profit profittoday">
                                    <p class="ranking_tit title"></p>
                                    <div>
                                        <p class="name"></p>
                                        <b class="rank"></b>
                                        <span class="Unit"></span>
                                    </div>
                                </li>
                                <li class="profitRate profitRatetoday">
                                    <p class="ranking_tit title"></p>
                                    <div>
                                        <p class="name"></p>
                                        <b class="rank"></b>
                                        <span class="Unit"></span>
                                    </div>
                                </li>
                            </ul>
                        </div>
                        <div>
                            <ul>
                                <li class="vehicle vehicleyesterday">
                                    <p class="ranking_tit title"></p>
                                    <div>
                                        <p class="name"></p>
                                        <b class="rank"></b>
                                        <span class="Unit"></span>
                                    </div>
                                </li>
                                <li class="sales salesyesterday">
                                    <p class="ranking_tit title"></p>
                                    <div>
                                        <p class="name"></p>
                                        <b class="rank"></b>
                                        <span class="Unit"></span>
                                    </div>
                                </li>
                                <li class="profit profityesterday">
                                    <p class="ranking_tit title"></p>
                                    <div>
                                        <p class="name"></p>
                                        <b class="rank"></b>
                                        <span class="Unit"></span>
                                    </div>
                                </li>
                                <li class="profitRate profitRateyesterday">
                                    <p class="ranking_tit title"></p>
                                    <div>
                                        <p class="name"></p>
                                        <b class="rank"></b>
                                        <span class="Unit"></span>
                                    </div>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>

                <div class="my_ranking">
                    <h2>나의실적</h2>
                    <input type="radio" id="my_ranking_today" name="my_ranking" checked>
                    <input type="radio" id="my_ranking_thisMonth" name="my_ranking">
                    <div class="ranking_label">
                        <label for="my_ranking_today">오늘</label>
                        <label for="my_ranking_thisMonth">이번달</label>
                    </div>
                    <div class="my_ranking_box">
                        <div class="DPerformancetoday">
                            <ul>
                                <li class="vehicle">
                                    <p class="my_ranking_tit">배차건수</p>
                                    <span><b class="vehicleStr"></b> 건</span>
                                </li>
                                <li class="sales">
                                    <p class="my_ranking_tit">매출액</p>
                                    <span><b class="salesStr"></b> 만원</span>
                                </li>
                                <li class="profit">
                                    <p class="my_ranking_tit">이익</p>
                                    <span><b class="proiftStr"></b> 만원</span>
                                </li>
                                <li class="profitRate">
                                    <p class="my_ranking_tit">이익률</p>
                                    <span><b class="proiftRateStr"></b> %</span>
                                </li>
                            </ul>
                        </div>
                        <div class="MPerformancemonth">
                            <ul>
                                <li class="vehicle">
                                    <p class="my_ranking_tit">배차건수</p>
                                    <span><b class="vehicleStr"></b> 건</span>
                                </li>
                                <li class="sales">
                                    <p class="my_ranking_tit">매출액</p>
                                    <span><b class="salesStr"></b> 만원</span>
                                </li>
                                <li class="profit">
                                    <p class="my_ranking_tit">이익</p>
                                    <span><b class="proiftStr"></b> 만원</span>
                                </li>
                                <li class="profitRate">
                                    <p class="my_ranking_tit">이익률</p>
                                    <span><b class="proiftRateStr"></b> %</span>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>

                <div class="highLight">
                    <h2>Today 's <span>이익기준</span>
                        <br> High-Lights</h2>
                    <div class="highLight_slide">
                        <ul>
                            <c:forEach var="idx" begin="1" end="3">
                            <li>
                                <ul class="highLight_slide_cont">
                                    <li>
                                        거래처
                                        <span class="acountCNm"></span>
                                    </li>
                                    <li>
                                        매출액
                                        <span class="sales"></span>
                                    </li>
                                    <li>
                                        매입액
                                        <span class="purchase"></span>
                                    </li>
                                    <li>
                                        이익
                                        <span class="color_r profit"></span>
                                    </li>
                                    <li>
                                        이익률
                                        <span class="color_r profitPersaint"></span>
                                    </li>
                                    <li>
                                        담당부서
                                        <span class="acountDNm"></span>
                                    </li>
                                    <li>
                                        담당자
                                        <span class="acountNm"></span>
                                    </li>
                                </ul>
                            </li>
                            </c:forEach>
                        </ul>
                    </div>
                </div>

                <div class="graph_vehicle">
                    <h2>배차 손익추이</h2>
                    <div class="graphB">
                        <div id="custom1">
                            <ul>
                                <li><span class="g-square namelabel"></span><span>매출</span></li>
                                <li><span class="g-circle namelabel"></span><span>이익</span></li>
                            </ul>
                        </div>
                        <canvas id="beGraph" width="567" height="209"></canvas>
                        <div class="graph_vehicle_percentage">
                        <p>손이익률</p>
                        <ul class="profitLosslist1">
                            <li></li>
                            <li></li>
                            <li></li>
                            <li></li>
                            <li></li>
                            <li></li>
                        </ul>
                        </div>
                    </div>
                </div>

                <div class="graph_top">
                    <h2>전월 TOP 거래처 현황</h2>
                    <div class="graphT">
                        <div id="custom2">
                            <ul>
                                <li><span class="t-square1 namelabel"></span><span>매출</span></li>
                                <li><span class="t-square2 namelabel"></span><span>이익</span></li>
                            </ul>
                        </div>
                        <canvas id="mmGraph" width="567" height="209"></canvas>
                        <div class="graph_top_percentage">
                            <p>손이익률</p>
                            <ul class="profitLosslist2">
                                <li></li>
                                <li></li>
                                <li></li>
                                <li></li>
                                <li></li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
            <div id="temperature" class="section_right">
                <div class="weather">
                    <h2>날씨 <p>현재위치 : <span id="selectedRegionWeather">서울</span></p></h2>
                    <div>
                        <ul>
                            <li>
                                <p class="weather_day">오늘</p>
                                <div class="weather_morning">
                                    <span id="morningWeatherIcon"></span>
                                    <span class="weather_txt">오전</span>
                                    <p id="morningTemperature" class="weather_temperatures"></p>
                                </div>
                                <div class="weather_afternoon">
                                    <span id="afternoonWeatherIcon"></span>
                                    <span class="weather_txt">오후</span>
                                    <p id="afternoonTemperature" class="weather_temperatures"></p>
                                </div>
                            </li>
                            <li>
                                <p class="weather_day">내일</p>
                                <div class="weather_morning">
                                    <span id="morningIcon"></span>
                                    <span class="weather_txt">오전</span>
                                    <p id="tomorrowMorningTemperature" class="weather_temperatures"></p>
                                </div>
                                <div class="weather_afternoon">
                                    <span id="afternoonIcon"></span>
                                    <span class="weather_txt">오후</span>
                                    <p id="tomorrowAfternoonTemperature" class="weather_temperatures"></p>
                                </div>
                            </li>
                        </ul>

                    </div>
                </div>

                <div class="oilMoney">
                    <h2>오늘의 유가</h2>

                    <div>
                        <table>
                            <colgroup>
                                <col width="35.2%">
                                <col width="21.6%">
                                <col width="21.6%">
                                <col width="21.6%">
                            </colgroup>
                            <tbody>
                            <tr>
                                <th>구분</th>
                                <th>휘발유</th>
                                <th>경유</th>
                                <th>LPG</th>
                            </tr>
                            <tr>
                                <td class="color_g">전국평균</td>
                                <c:forEach var="idx" begin="0" end="4">
                                    <c:set var="oilType" value="${idx}" />
                                    <c:choose>
                                        <c:when test="${idx == 1}">
                                            <c:set var="oilName" value="휘발유"/>
                                            <td class="all_oil_price"></td>
                                        </c:when>
                                        <c:when test="${idx == 2}">
                                            <c:set var="oilName" value="경유"/>
                                            <td class="all_oil_price"></td>
                                        </c:when>
                                        <c:when test="${idx == 4}">
                                            <c:set var="oilName" value="가스부탄"/>
                                            <td class="all_oil_price"></td>
                                        </c:when>
                                    </c:choose>
                                </c:forEach>
                            </tr>
                            <tr>
                                <td id="selectedRegionOil" class="color_b">서울평균</td>
                                <c:forEach var="idx" begin="0" end="4">
                                    <c:set var="oilType" value="${idx}" />
                                    <c:choose>
                                        <c:when test="${idx == 1}">
                                            <c:set var="oilName" value="휘발유"/>
                                            <td class="sido_oil_price"></td>
                                        </c:when>
                                        <c:when test="${idx == 2}">
                                            <c:set var="oilName" value="경유"/>
                                            <td class="sido_oil_price"></td>
                                        </c:when>
                                        <c:when test="${idx == 4}">
                                            <c:set var="oilName" value="가스부탄"/>
                                            <td class="sido_oil_price"></td>
                                        </c:when>
                                    </c:choose>
                                </c:forEach>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                </div>

                <div class="media">
                    <div class="notice">
                        <h2>공지사항</h2>
                        <ul>
                            <!-- 공지사항 리스트 -->
                            <c:forEach var="idx" begin="1" end="2">
                                <c:set var="i" value="${idx+1}" />
                                <li class="notice_box">
                                    <div class="notice_title">
                                        <dl onclick="openpopup(${idx})">
                                            <dt class="n-title"></dt>
                                            <dd class="n-date"></dd>
                                        </dl>
                                    </div>
                                    <!-- 공지사항 팝업 -->
                                    <div id="noticeCon${idx}" class="notice_popup">
                                        <p>공지사항</p>
                                        <button type="button" class="icon_close" onclick="closepopup(${idx})">닫기</button>
                                        <div>
                                            <dl>
                                                <dt class="n-title"></dt>
                                                <dd>등록일 : <span class="n-date"></span></dd>
                                            </dl>
                                            <div class="contents">
                                                <span class="n-content"></span>
                                            </div>
                                        </div>
                                        <button type="button" class="btn_close" onclick="closepopup(${idx})">닫기</button>
                                    </div>
                                    <!-- 공지사항 팝업 -->
                                </li>
                            </c:forEach>
                        </ul>
                    </div>
                    <div class="sns">
                        <ul>
                            <li class="video">
                                <a href="https://www.youtube.com/@logis-link/featured" target="_blank">동영상메뉴얼</a>
                            </li>
                            <li class="blog">
                                <a href="https://blog.naver.com/logis-link" target="_blank">네이버블로그</a>
                            </li>
                        </ul>
                    </div>
                </div>

            </div>
        </div>
    </section>
</div>

<!-- BoardList -->

<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js" integrity="sha512-qTXRIMyZIFb8iQcfjXWCO8+M5Tbc38Qi5WzdPOYZHIlZpzBHG3L3by84BBBOiRGiEb7KKtAOAs5qYdUiZiQNNQ==" crossorigin="anonymous"></script>
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chartjs-plugin-datalabels@2.0.0-rc.1"></script>
<script>

    $(function(){
        setInterval(slide,5000);

        function slide(){
            $('.highLight_slide>ul').stop().animate({marginTop:-80},1000,slideNext);
        }

        function slideNext(){
            $('.highLight_slide>ul>li').eq(0).appendTo('.highLight_slide>ul');
            $('.highLight_slide>ul').stop().animate({marginTop:0},0);
        }
    });

    // $(function(){
    //     $('.notice_popup').hide();
    //     $('.notice_bg').hide();

    //     $('.notice>ul').on('click',function(){
    //         $(this).find('.notice_popup').show();
    //         $('.notice_bg').show();
    //     });

    //     $('.notice_popup .btn_close').on('click',function(){
    //         var $parent = $(this).parent();
    //         $parent.css("display","none");
    //         console.log('닫기');
    //     });
    // })

    function openpopup(idx){
        $("#noticeCon"+idx).show();
        $('.notice_bg').show();
    }
    function closepopup(idx){
        $("#noticeCon"+idx).hide();
        $('.notice_bg').hide();
    }

    /** 공지사항 노출 (제목, 년.월.일) */
    $.ajax({
        url: '/contents/notice/data/boardList.do',
        type: 'POST',
        dataType: 'json'
    }).done(response => {
        if (response.result) {
            const { data } = response;
            $('.n-title').each((index, element)=>{
                $(element).text(data[index].title);
            });
            $('.n-date').each((index, element)=>{
                $(element).text(moment(data[index].regDate).format('YYYY.MM.DD'));
            });
            $('.n-content').each((index, element)=>{
                $(element).text(data[index].content);
            });
            console.log(response)
        }else {
            console.error(response.message);
        }
    }).fail((xhr, status, error) => {
        console.error(error);
    });

    /** 전국 유가정보 */
    $.ajax({
        url: "/contents/basic/data/getOpinet.do",
        type: "POST",
        dataType: "json",
    }).done(response => {
        if (response.result) {
            const oilPrices = response.oil.OIL.map(({ PRICE }) => PRICE);
            $('.all_oil_price').each((index, element)=>{
                $(element).text(oilPrices[index]);
            });
            console.log(oilPrices); // oilPrices 배열에 PRICE 값만 추출하여 출력
        } else {
            console.error(response.message);
        }
    }).fail((xhr, status, error) => {
        console.error(error);
    });

    /*    /!** 전국 유가정보 에니메이션 버전 *!/
        $.ajax({
            url: "/contents/basic/data/getOpinet.do",
            type: "POST",
            dataType: "json",
        }).done(response => {
            if (response.result) {
                const oilPrices = response.oil.OIL.map(({ PRICE }) => PRICE);
                $('.all_oil_price').each((index, element) => {
                    const price = oilPrices[index];
                    $(element).attr('data-count', price).text(parseFloat('0').toFixed(2));
                    $({ Counter: 0 }).animate({ Counter: price }, {
                        duration: 2000,
                        easing: 'swing',
                        step: function () {
                            $(element).text(Math.round(this.Counter * 100) / 100);
                        }
                    });
                });
                console.log(oilPrices); // oilPrices 배열에 PRICE 값만 추출하여 출력
            } else {
                console.error(response.message);
            }
        }).fail((xhr, status, error) => {
            console.error(error);
        });*/

    // 쿠키를 저장해서 지역값을 저장해준다.
    function setCookie(name, value, days) {
        var expires = "";
        if (days) {
            const date = new Date();
            date.setTime(date.getTime() + (days * 24 * 60 * 60 * 1000));
            expires = "; expires=" + date.toUTCString();
        }
        document.cookie = name + "=" + (value || "") + expires + "; path=/";
    }

    function getCookie(name) {
        const nameEQ = name + "=";
        const ca = document.cookie.split(';');
        for (var i = 0; i < ca.length; i++) {
            var c = ca[i];
            while (c.charAt(0) === ' ') c = c.substring(1, c.length);
            if (c.indexOf(nameEQ) === 0) return c.substring(nameEQ.length, c.length);
        }
        return null;
    }

    /** 지역설정 팝업 */

    /** 시도 유가정보 */
    function  updateSidoInfo(sidoCode) {

        $.ajax({
            url: "/contents/basic/data/getOpinetsido.do",
            type: "POST",
            dataType: "json",
            async: true,
            data: {
                sido: encodeURIComponent(sidoCode), // 시도 값 서울 01, 경기도 02, 강원도 03, 충북 04, 충남 05, 전북 06, 전남 07, 경북 08, 경남 09, 부산 10, 제주 11, 대구 14, 인천 15, 광주 16, 대전 17, 울산 18, 세종 19
            }
        }).done(response => {
            // debugger;
            if (response.result) {
                const oilPrices = response.oil.OIL.filter(item => ["B027", "D047", "K015"].includes(item.PRODCD))
                    .map(({PRODCD, PRICE}) => {
                        switch (PRODCD) {
                            case "B027":
                                return {name: "휘발유", price: PRICE};
                            case "D047":
                                return {name: "경유", price: PRICE};
                            case "K015":
                                return {name: "LPG", price: PRICE};
                            default:
                                return {name: "", price: ""};
                        }
                    });
                $('.sido_oil_price').each((index, element) => {
                    $(element).text(oilPrices[index].price);
                });
                console.log(oilPrices); // oilPrices 배열에 PRICE 값만 추출하여 출력

            } else {
                console.error(response.message);
            }
        }).fail((xhr, status, error) => {
            console.error(error);
        });
    }



    /*    /!** 시도 유가정보 에니메이션 버전 *!/
        $.ajax({
            url: "/contents/basic/data/getOpinetsido.do",
            type: "POST",
            dataType: "json",
            async:false,
            data: {
                sido: "01", // 시도 값 서울 01, 경기도 02, 강원도 03, 충북 04, 충남 05, 전북 06, 전남 07, 경북 08, 경남 09, 부산 10, 제주 11, 대구 14, 인천 15, 광주 16, 대전 17, 울산 18, 세종 19
            }
        }).done(response => {
            if (response.result) {
                const oilPrices = response.oil.OIL.filter(item => ["B027", "D047", "K015"].includes(item.PRODCD))
                    .map(({ PRODCD, PRICE }) => {
                        switch(PRODCD){
                            case "B027":
                                return {name: "휘발유", price: PRICE};
                            case "D047":
                                return {name: "경유", price: PRICE};
                            case "K015":
                                return {name: "LPG", price: PRICE};
                            default:
                                return {name: "", price: ""};
                        }
                    });

                $('.sido_oil_price').each((index, element) => {
                    const { price } = oilPrices[index];
                    $(element).attr('data-count', price).text(parseFloat('0').toFixed(2));
                    $({ Counter: 0 }).animate({ Counter: price }, {
                        duration: 2000,
                        easing: 'swing',
                        step: function () {
                            $(element).text(Math.round(this.Counter * 100) / 100);
                        }
                    });
                    $(element).attr('data-count', price.toFixed(2)).text(price.toFixed(2));
                });
                console.log(oilPrices); // oilPrices 배열에 PRICE 값만 추출하여 출력
            } else {
                console.error(response.message);
            }
        }).fail((xhr, status, error) => {
            console.error(error);
        });*/

    $(document).ready(function () {
        //페이지 로드 시 초기 서울 기본값
        const savedSidoCode = getCookie('sidoCode');
        const sidoCode = savedSidoCode ? savedSidoCode : "01";
        const savedSidoName = getCookie('sidoName');
        const sidoName = savedSidoName ? savedSidoName : '서울';

        //지역정보 업데이트
        updateSidoInfo(sidoCode);
        updateSidoWeather(sidoCode, coordinatesObj[sidoCode] || coordinatesObj["01"]);
        $('#selectedRegionOil').text(sidoName + '평균');
        $('#selectedRegionWeather').text(sidoName);

        //라디오 버튼 상태를 업데이트
        $(`.navList[data-sido="${sidoCode}"]`).prop('checked', true);

        //팝업열기
        $('#navPopup').click(function () {
            $('#popupLayer').fadeIn();
        });

        //라디오 버튼 선택 시 지역명 업데이트
        $('.navList').on('change', function (){
            const sidoCode = $(this).data('sido');
            const sidoName = $(this).data('sido-name');
            const selectedRegionId = 'region' + $(this).val();
            const selectedRegion = $('#' + selectedRegionId).text();


            if (sidoCode !== undefined) {
                setCookie('sidoCode', sidoCode.toString(), 1);
                setCookie('sidoName', selectedRegion, 1);
                // 지역 정보 업데이트
                updateSidoInfo(sidoCode)
                updateSidoWeather(sidoCode, coordinatesObj[sidoCode]);
                console.log('지역 확인', sidoCode, coordinatesObj[sidoCode]);
            }else  {
                console.error("지역을 확인 할 수 없습니다.")
            }



            $('#selectedRegionOil').text(sidoName + '평균');
            $('#selectedRegionWeather').text(sidoName);
            $("#tomorrowMorningTemperature").empty();
            $("#tomorrowAfternoonTemperature").empty();

            // 새로고침
            // location.reload();

            //팝업 닫기
            $('#popupLayer').fadeOut();
        });

        //팝업 닫기 버튼
        $('#navClose').click(function (){
            $('#popupLayer').fadeOut();
        });

        //Esc 키를 누르면 팝업 닫기
        $(document).keyup(function (e){
            if(e.key === "Escape") {
                $('#popupLayer').fadeOut();
            }
        });
    });

    /** 시도 기상청 날씨정보 출력 */


    // 내일 기온 데이터에서 오전/오후 기온 추출
    function getTomorrowBaseDate() {
        var tomorrow = new Date();
        tomorrow.setDate(tomorrow.getDate() + 1);
        var yyyy = tomorrow.getFullYear().toString();
        var mm = (tomorrow.getMonth() + 1).toString().padStart(2, "0");
        var dd = tomorrow.getDate().toString().padStart(2, "0");
        return yyyy + mm + dd;
    }
    function getWeatherIconClass(category, value) {
        if (category === "PTY") {
            switch (value) {
                case "1":
                    return "weather_icon_rain";
                case "2":
                    return "weather_icon_rainsnow";
                case "3":
                    return "weather_icon_snow";
                case "4":
                    return "weather_icon_shower";
                default:
                    return "";
            }
        } else if (category === "SKY") {
            switch (value) {
                case "1":
                    return "weather_icon_sun";
                case "3":
                    return "weather_icon_cloud";
                case "4":
                    return "weather_icon_fag";
                default:
                    return "";
            }
        }
    }
    const coordinatesObj = {
        "01": {nx: '60', ny: '127'},
        "02": {nx: '60', ny: '120'},
        "03": {nx: '73', ny: '134'},
        "04": {nx: '69', ny: '107'},
        "05": {nx: '68', ny: '100'},
        "06": {nx: '63', ny: '89'},
        "07": {nx: '51', ny: '67'},
        "08": {nx: '89', ny: '91'},
        "09": {nx: '91', ny: '77'},
        "10": {nx: '98', ny: '76'},
        "11": {nx: '89', ny: '90'},
        "14": {nx: '55', ny: '124'},
        "15": {nx: '58', ny: '74'},
        "16": {nx: '67', ny: '100'},
        "17": {nx: '102', ny: '84'},
        "18": {nx: '66', ny: '103'},
        "19": {nx: '52', ny: '38'},
        "seoul":{nx: '60', ny: '127'}
    };

    function updateSidoWeather(sidoCode) {
        function getWeather() {
            function getTemperatureForPeriod(data, startHour, endHour) {

                var temperatureArray = [];
                for (var i = startHour; i <= endHour; i++) {
                    var hour = (i < 10) ? "0" + i + "00" : i + "00";

                    var temp = data.find(function (item) {
                        return item.fcstTime === hour && item.category === "TMP";
                    });

                    var sky = data.find(function (item) {
                        return item.fcstTime === hour && item.category === "SKY";
                    });

                    var pty = data.find(function (item) {
                        return item.fcstTime === hour && item.category === "PTY";
                    });

                    var weatherIcon = "";
                    if (pty && pty.fcstValue > 0) {
                        weatherIcon = getWeatherIconClass("PTY", pty.fcstValue);
                    } else {
                        weatherIcon = getWeatherIconClass("SKY", sky.fcstValue);
                    }

                    temperatureArray.push({
                        hour: hour,
                        temperature: temp.fcstValue,
                        sky: sky.fcstValue,
                        pty: pty.fcstValue,
                        icon: weatherIcon
                    });
                }
                return temperatureArray;
            }

            function displayTemperature(temperatureData, temperatureElementId, iconElementId) {
                var currentHour = new Date().getHours().toString().padStart(2, "0") + "00";
                var targetTemperature = temperatureData.find(function (value) {
                    return value.hour === currentHour;
                });

                if (!targetTemperature) {
                    targetTemperature = temperatureData[temperatureData.length - 1];
                }

                var iconClass = "";
                if (targetTemperature.pty > 0) {
                    iconClass = getWeatherIconClass("PTY", targetTemperature.pty.toString());
                } else {
                    iconClass = getWeatherIconClass("SKY", targetTemperature.sky.toString());
                }

                $(temperatureElementId).html("<span>" + targetTemperature.temperature + "</span>");
                $(iconElementId).toggleClass(iconClass);
            }

            $.ajax({
                url: "/contents/basic/data/getOpenweather.do",
                type: "POST",
                dataType: "json",
                async: true,
                data: {
                    base_date: getBaseDate(),
                    base_time: getBaseTime(),
                    nx: coordinatesObj[sidoCode].nx,
                    ny: coordinatesObj[sidoCode].ny
                },
                success: function (data) {
                    console.log("AJAX call successful");
                    if (data && data.result && data.item) {
                        console.log(data.item);
                        // debugger;
                        // Today 기온 데이터에서 오전/오후 기온 추출
                        var temperatureData = data.item.filter(function (item) {
                            return item.category === "TMP"|| item.category === "SKY" || item.category === "PTY";
                        });

                        // 오전 기온 정보 추출
                        var morningTemperature = getTemperatureForPeriod(temperatureData, 2, 12);
                        // 오후 기온 정보 추출
                        var afternoonTemperature = getTemperatureForPeriod(temperatureData, 13, 23);


                        var currentHour = new Date().getHours().toString().padStart(4, "") + "00";
                        console.log("currentHour:", currentHour);

                        // 오전 기온
                        if (parseInt(currentHour) < 1200) { //12시 이전이면
                            console.log("Displaying morning temperature");
                            displayTemperature(morningTemperature, "#morningTemperature", "#morningWeatherIcon");
                        } else {
                            console.log("Displaying 12 o'clock morning temperature");
                            var targetTemperature = morningTemperature.find(function (value) {
                                return value.hour === "1200";
                            });

                            if (!targetTemperature) {
                                targetTemperature = morningTemperature[morningTemperature.length - 1];
                            }

                            $("#morningTemperature").append("<span>" + targetTemperature.temperature + "</span>");
                            var iconClass = "";
                            if (targetTemperature.pty > 0) {
                                iconClass = getWeatherIconClass("PTY", targetTemperature.pty.toString());
                            } else {
                                iconClass = getWeatherIconClass("SKY", targetTemperature.sky.toString());
                            }
                            $("#morningWeatherIcon").addClass(iconClass);
                        }

                        // 오후 기온
                        if (parseInt(currentHour) >= 1300 && parseInt(currentHour) <= 2300) {
                            console.log("Displaying afternoon temperature");
                            displayTemperature(afternoonTemperature, "#afternoonTemperature", "#afternoonWeatherIcon");
                        } else {
                            console.log("Displaying 23 o'clock afternoon temperature");
                            var targetTemperature = afternoonTemperature.find(function (value) {
                                return value.hour === "2300";
                            });

                            if (!targetTemperature) {
                                targetTemperature = afternoonTemperature[afternoonTemperature.length - 1];
                            }
                            // debugger;
                            $("#afternoonTemperature").append("<span>" + targetTemperature.temperature + "</span>");
                            var iconClass = "";
                            if (targetTemperature.pty > 0) {
                                iconClass = getWeatherIconClass("PTY", targetTemperature.pty.toString());
                            } else {
                                iconClass = getWeatherIconClass("SKY", targetTemperature.sky.toString());
                            }
                            $("#afternoonWeatherIcon").addClass(iconClass);
                        }


                        console.log("오전 기온: ", morningTemperature);
                        console.log("오후 기온: ", afternoonTemperature);






                        // Tomorrow 기온 데이터에서 오전/오후 기온 추출
                        var temperatureData = data.item.filter(function (item) {
                            return item.category === "TMP" || item.category === "SKY" || item.category === "PTY";
                        });

                        // 내일의 날씨를 가져옵니다.
                        var tomorrowDate = getTomorrowBaseDate();

                        // 내일 오전 06시 기온 정보 추출
                        var tomorrowMorningTemperature = temperatureData.find(function (item) {
                            return item.fcstDate === tomorrowDate && item.fcstTime === "0600" && item.category === "TMP";
                        });
                        var tomorrowMorningPty = temperatureData.find(function (item) {
                            return item.fcstDate === tomorrowDate && item.fcstTime === "0600" && item.category === "PTY";
                        });
                        var tomorrowMorningSky = temperatureData.find(function (item) {
                            return item.fcstDate === tomorrowDate && item.fcstTime === "0600" && item.category === "SKY";
                        });

                        // 내일 오후 15시 기온 정보 추출
                        var tomorrowAfternoonTemperature = temperatureData.find(function (item) {
                            return item.fcstDate === tomorrowDate && item.fcstTime === "1500" && item.category === "TMP";
                        });
                        var tomorrowAfternoonPty = temperatureData.find(function (item) {
                            return item.fcstDate === tomorrowDate && item.fcstTime === "1500" && item.category === "PTY";
                        });
                        var tomorrowAfternoonSky = temperatureData.find(function (item) {
                            return item.fcstDate === tomorrowDate && item.fcstTime === "1500" && item.category === "SKY";
                        });

                        // debugger;
                        updateWeatherIcon(tomorrowMorningSky, tomorrowMorningPty, tomorrowAfternoonSky, tomorrowAfternoonPty);

                        // 내일 오전 기온 표시
                        if (tomorrowMorningTemperature) {
                            $("#tomorrowMorningTemperature").append("<span>" + tomorrowMorningTemperature.fcstValue + "</span>");
                        }
                        // 내일 오후 기온 표시
                        if (tomorrowAfternoonTemperature) {
                            $("#tomorrowAfternoonTemperature").append("<span>" + tomorrowAfternoonTemperature.fcstValue + "</span>");
                        }

                        // debugger;
                        // 날씨는 조건 PTY > 0 (아이콘 CLASS로 상속한다.)

                        function updateWeatherIcon(tomorrowMorningSky, tomorrowMorningPty, tomorrowAfternoonSky, tomorrowAfternoonPty) {
                            var weatherIconMorning = "";
                            var weatherIconAfternoon = "";

                            // 내일 WeatherICON PTY, SKY
                            if (tomorrowMorningPty && tomorrowMorningPty.fcstValue > 0) {
                                weatherIconMorning = getWeatherIconClass("PTY", tomorrowMorningPty.fcstValue);
                            } else {
                                weatherIconMorning = getWeatherIconClass("SKY", tomorrowMorningSky.fcstValue);
                            }
                            console.log("Morning icon class", weatherIconMorning); // 여기에 추가

                            if (tomorrowAfternoonPty && tomorrowAfternoonPty.fcstValue > 0) {
                                weatherIconAfternoon = getWeatherIconClass("PTY", tomorrowAfternoonPty.fcstValue);
                            } else {
                                weatherIconAfternoon = getWeatherIconClass("SKY", tomorrowAfternoonSky.fcstValue);
                            }
                            console.log("Afternoon icon class", weatherIconAfternoon); // 여기에 추가

                            $("#morningIcon").removeClass().addClass(weatherIconMorning);
                            $("#afternoonIcon").removeClass().addClass(weatherIconAfternoon);

                        }

                        //weatherIconMore( today, tomorrow )
                        function getWeatherIconClass(category, value) {
                            if (category === "PTY") {
                                switch (value) {
                                    case "1":
                                        return "weather_icon_rain";
                                        break;
                                    case "2":
                                        return "weather_icon_rainsnow";
                                        break;
                                    case "3":
                                        return "weather_icon_snow";
                                        break;
                                    case "4":
                                        return "weather_icon_shower";
                                        break;
                                    default:
                                        break;
                                }
                            } else if (category === "SKY") {
                                switch (value) {
                                    case "1":
                                        return "weather_icon_sun";
                                        break;
                                    case "3":
                                        return "weather_icon_cloud";
                                        break;
                                    case "4":
                                        return "weather_icon_fag";
                                        break;
                                    default:
                                        break;
                                }
                            }

                            // // 기본값으로 아무것도 반환하지 않을 때 반환되는 문자열
                            // return "weather_icon_none";
                        }


                        console.log("오전 기온: ", tomorrowMorningTemperature);
                        console.log("오전 하늘상태: ", tomorrowMorningSky);
                        console.log("오전 강수형태: ", tomorrowMorningPty);
                        console.log("오후 기온: ", tomorrowAfternoonTemperature);
                        console.log("오후 하늘상태: ", tomorrowAfternoonSky);
                        console.log("오후 강수상태: ", tomorrowAfternoonPty);

                    } else {
                        console.error("API response does not contain expected data");
                    }
                },
                error: function(xhr, status, error) {
                    console.error(xhr, status, error);
                },
                compact:function (){
                    setInterval(getWeather, 3600000);
                }
            });
        }

        /** 기본 날짜는 -1로 해줘야 값을 출력할 수 있음 */
        function getBaseDate() {
            var today = new Date();
            var currentHour = new Date().getHours();
            if (currentHour >= 6) {
                today.setDate(today.getDate());
            } else {
                today.setDate(today.getDate() - 1);
            }
            var year = today.getFullYear();
            var month = today.getMonth() + 1;
            var day = today.getDate();
            return year + "" + (month < 10 ? "0" : "") + month + "" + (day < 10 ? "0" : "") + day;
        }

        /** 23시까지를 기준으로 잡아야 온도를 측정할 수 있음 */
        function getBaseTime() {
            var today = new Date();
            var hour = today.getHours();
            if (hour >= 2 && hour < 5) {
                return "0200";
            } else if (hour >= 5 && hour < 8) {
                return "0500";
            } else if (hour >= 8 && hour < 11) {
                return "0800";
            } else if (hour >= 11 && hour < 14) {
                return "1100";
            } else if (hour >= 14 && hour < 17) {
                return "1400";
            } else if (hour >= 17 && hour < 20) {
                return "1700";
            } else if (hour >= 20 && hour < 23) {
                return "2000";
            } else {
                return "2300";
            }
        }

        $(document).ready(function() {
            // 최초 1회 호출
            getWeather();

            // 1시간 마다 호출
            setInterval(getWeather, 3600000);
        });
    };

    //차트 JS  배차 손익추이
    const data1 = {
            labels: [],
            datasets: [
                {
                    // label: '매출',
                    data: [], //NUM으로 가지고 와야합니다.
                    type: 'bar',
                    backgroundColor: 'rgba(160, 160, 160)',
                    borderColor: 'rgba(160, 160, 160)',
                    borderWidth: 1,
                    yAxisID: 'y2',
                    maxBarThickness: 22,
                    datalabels: {
                        display:true,
                        color: '#a0a0a0',
                        anchor: 'end',
                        align: 'top',
                        font: {
                            size: 12, // 원하는 폰트 크기로 설정하세요.
                            weight: '500' // 원하는 폰트 두께로 설정하세요. ('normal', 'bold', 또는 숫자)
                        },
                        formatter: function(value, context) {
                            return value.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
                        }
                    },
                    order: 2
                },
                {
                    // label: '이익',
                    data: [], //NUM으로 가지고 와야합니다.
                    type: 'line',
                    backgroundColor: 'rgba(255, 98, 76)',
                    borderColor: 'rgba(255, 98, 76)',
                    borderWidth: 1,
                    yAxisID: 'y1',
                    // pointStyle: 'circle',
                    datalabels: {
                        display:true,
                        color: '#fff',
                        anchor: 'end',
                        align: 'top',
                        font: {
                            size: 12, // 원하는 폰트 크기로 설정하세요.
                            weight: '500' // 원하는 폰트 두께로 설정하세요. ('normal', 'bold', 또는 숫자)
                        },
                    },
                    z: 1
                }
            ]
        };
    Chart.register(ChartDataLabels); // 화면에 금액표시하기 위해 필요합니다.
    const ctx1 = document.getElementById('beGraph').getContext('2d');
    const beGraph = new Chart(ctx1, {
        type: 'bar',
        data: data1,
        options: {
            interaction: {
                mode: 'none'
            },
            animation: {
                duration: 0,
            },
            plugins: {
                legend: {
                    display: false,
                },
            },
            responsive: false,
            scales: {
                x: {
                    // min: 0,
                    display: true,
                    title: {
                        display: true
                    },
                    barPercentage: 0.0, // 바의 너비를 조절합니다 (0.0 ~ 1.0)
                    categoryPercentage: 0.1,
                    ticks: {
                        color: '#fff',
                        font: {
                            size: 10, // 원하는 폰트 크기로 설정하세요.
                            weight: '500', // 원하는 폰트 두께로 설정하세요. ('normal', 'bold', 또는 숫자)
                        }
                    },
                },
                y1: {
                    position: 'right',
                    display: true,
                    title: {
                        display: true
                    },
                    beginAtZero: true,
                    max: Math.ceil(1000 / 2) * 2, //2의 배수
                    ticks: {
                        color: '#fff',
                        font: {
                            size: 10, // 원하는 폰트 크기로 설정하세요.
                            weight: 500, // 원하는 폰트 두께로 설정하세요. ('normal', 'bold', 또는 숫자)
                        },
                        stepSize: 200 // 눈금 간격 설정
                    },
                    grid: {
                        color: 'rgb(57 57 57)', // y축 그리드 라인 색상
                        lineWidth: 1, // y축 그리드 라인 두께
                        drawBorder: true, // y축 경계선 미표시
                    },
                },
                y2: {

                    position: 'left',
                    display: true,
                    title: {
                        display: true
                    },
                    beginAtZero: true,
                    max: Math.ceil(8000 / 2) * 2,//2의 배수
                    ticks: {
                        color: '#fff',
                        font: {
                            size: 10, // 원하는 폰트 크기로 설정하세요.
                            weight: 500, // 원하는 폰트 두께로 설정하세요. ('normal', 'bold', 또는 숫자)
                        },
                        stepSize: 2000 // 눈금 간격 설정
                    },
                }
            },
        }
    });

    const data2 = {
        labels: [],
        datasets: [
            {
                // label: '매출',
                data: [], //NUM으로 가지고 와야합니다.
                type: 'bar',
                backgroundColor: 'rgba(160, 160, 160)',
                borderColor: 'rgba(160, 160, 160)',
                borderWidth: 1,
                yAxisID: 'y1',
                maxBarThickness: 22,
                datalabels: {
                    display:true,
                    color: '#a0a0a0',
                    anchor: 'end',
                    align: 'top',
                    font: {
                        size: 12, // 원하는 폰트 크기로 설정하세요.
                        weight: '500' // 원하는 폰트 두께로 설정하세요. ('normal', 'bold', 또는 숫자)
                    },
                    formatter: function(value, context) {
                        return value.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
                    }
                },
            },
            {
                // label: '이익',
                data: [], //NUM으로 가지고 와야합니다.
                type: 'bar',
                backgroundColor: 'rgba(255, 98, 76)',
                borderColor: 'rgba(255, 98, 76)',
                borderWidth: 1,
                yAxisID: 'y2',
                maxBarThickness: 22,
                datalabels: {
                    display:true,
                    color: '#ff624c',
                    anchor: 'end',
                    align: 'top',
                    font: {
                        size: 12, // 원하는 폰트 크기로 설정하세요.
                        weight: '500' // 원하는 폰트 두께로 설정하세요. ('normal', 'bold', 또는 숫자)
                    },
                },
            }
        ]
    };
    Chart.register(ChartDataLabels); // 화면에 금액표시하기 위해 필요합니다.
    const ctx2 = document.getElementById('mmGraph').getContext('2d');
    const mmGraph = new Chart(ctx2, {
        type: 'bar',
        data: data2,
        options: {
            interaction: {
                mode: 'none'
            },
            animation: {
                duration: 0,
            },
            plugins: {
                legend: {
                    display: false,
                },
            },
            responsive: false,
            scales: {
                x: {
                    // min: 0,
                    display: true,
                    title: {
                        display: true
                    },
                    barPercentage: 0.0, // 바의 너비를 조절합니다 (0.0 ~ 1.0)
                    categoryPercentage: 0.1,
                    ticks: {
                        color: '#fff',
                        font: {
                            size: 10, // 원하는 폰트 크기로 설정하세요.
                            weight: '500', // 원하는 폰트 두께로 설정하세요. ('normal', 'bold', 또는 숫자)
                        }
                    },
                },
                y1: {
                    position: 'left',
                    display: true,
                    title: {
                        display: true
                    },
                    beginAtZero: true,
                    max: 500,
                    ticks: {
                        color: '#fff',
                        font: {
                            size: 10, // 원하는 폰트 크기로 설정하세요.
                            weight: 500, // 원하는 폰트 두께로 설정하세요. ('normal', 'bold', 또는 숫자)
                        },
                        stepSize:100,
                    },
                    grid: {
                        color: 'rgb(57 57 57)', // y축 그리드 라인 색상
                        lineWidth: 1, // y축 그리드 라인 두께
                        drawBorder: true, // y축 경계선 미표시
                    },
                },
                y2: {

                    position: 'right',
                    display: false,
                    title: {
                        display: false
                    },
                    beginAtZero: true,
                    ticks: {
                        color: '#fff',
                        font: {
                            size: 10, // 원하는 폰트 크기로 설정하세요.
                            weight: 500, // 원하는 폰트 두께로 설정하세요. ('normal', 'bold', 또는 숫자)
                        },
                        stepSize: 2000 // 눈금 간격 설정
                    },
                }
            },
        }
    });



    /*var custId = custIdcheck(); //거래처 확인
    if(custId) {
        // AJAX 요청을 통해 데이터를 가져옵니다.
        $.ajax({
            url: "/dashboard/resultvehicle.do",
            type: "POST",
            dataType: "json",
            data: {
                custId:custId,
            },
        }).done(response => {
            console.log("배차손익 : ", response);
            // debugger;
            if (response.result) {
                const data = response.data;

                // JSON 배열을 차트 데이터 형식으로 변환합니다.
                const labels = [];
                const sales = [];
                const profits = [];

                data.forEach(item => {
                    labels.push(item.vehicleMM);
                    sales.push(item.sales);
                    profits.push(item.profit);
                });
                // 손익은 따로 출력한다
                const profitLossList1 = $(".profitLosslist1 li");
                data.forEach((item, index) => {
                    const profitLoss = item.profitLoss;
                    $(profitLossList1[index]).text(profitLoss);
                });

                // 가져온 데이터를 차트에 적용합니다.
                beGraph.data.labels = labels;
                beGraph.data.datasets[0].data = sales;
                beGraph.data.datasets[1].data = profits;

                // 차트를 업데이트합니다.
                beGraph.update();

            } else {
                console.error('Error: response is empty or undefined');
            }
        }).fail((xhr, status, error) => {
            console.error(error);
        });
    }*/



 /*   var custId = custIdcheck(); //거래처 확인
    if(custId) {
        // AJAX 요청을 통해 데이터를 가져옵니다.
        $.ajax({
            url: "/dashboard//mmtoprank.do",
            type: "POST",
            dataType: "json",
            data: {
                custId:custId,
            },
        }).done(response => {
            console.log("전월TOP 거래처 현황 : ", response);
            // debugger;
            if (response.result) {
                const data = response.data;

                // JSON 배열을 차트 데이터 형식으로 변환합니다.
                const labels = [];
                const sales = [];
                const profits = [];

                data.forEach(item => {
                    labels.push(item.acountNm);
                    sales.push(item.sales);
                    profits.push(item.profit);
                });
                // 손익은 따로 출력한다
                const profitLossList2 = $(".profitLosslist2 li");
                data.forEach((item, index) => {
                    const profitLoss = item.profitLoss;
                    $(profitLossList2[index]).text(profitLoss);
                });

                // 가져온 데이터를 차트에 적용합니다.
                mmGraph.data.labels = labels;
                mmGraph.data.datasets[0].data = sales;
                mmGraph.data.datasets[1].data = profits;

                // 차트를 업데이트합니다.
                beGraph.update();

            } else {
                console.error('Error: response is empty or undefined');
            }
        }).fail((xhr, status, error) => {
            console.error(error);
        });
    }*/

    // 첫 번째 차트에 대한 AJAX 요청
    function bbGraphData() {
        return $.ajax({
            url: "/dashboard/resultvehicle.do",
            type: "POST",
            dataType: "json",
            data: {
                custId: custId,
            },
        });
    }

    // 두 번째 차트에 대한 AJAX 요청
    function mmGraphData() {
        return $.ajax({
            url: "/dashboard//mmtoprank.do",
            type: "POST",
            dataType: "json",
            data: {
                custId: custId,
            },
        });
    }

    var custId = custIdcheck(); // 거래처 확인

    if (custId) {
        // 두 차트에 대한 데이터를 동시에 가져옵니다.
        $.when(bbGraphData(), mmGraphData())
            .done((response1, response2) => {
                // 첫 번째 차트 데이터 처리
                if (response1[0].result) {
                    processDataForChart(beGraph, response1[0].data);
                    // // 손익은 따로 출력한다
                    // const profitLossList1 = $(".profitLosslist1 li");
                    // data.forEach((item, index) => {
                    //     const profitLoss = item.profitLoss;
                    //     $(profitLossList1[index]).text(profitLoss);
                    // });
                } else {
                    console.error("Error: response1 is empty or undefined");
                }

                // 두 번째 차트 데이터 처리
                if (response2[0].result) {
                    processDataForChart(mmGraph, response2[0].data);
                    // // 손익은 따로 출력한다
                    // const profitLossList2 = $(".profitLosslist2 li");
                    // data.forEach((item, index) => {
                    //     const profitLoss = item.profitLoss;
                    //     $(profitLossList2[index]).text(profitLoss);
                    // });
                } else {
                    console.error("Error: response2 is empty or undefined");
                }
            })
            .fail((xhr, status, error) => {
                console.error(error);
            });
    }


    function extractFunc(item) {
        return item.label;
    }

    // 차트 데이터 처리 함수
    function processDataForChart(chart, data, x) {
        const labels = [];
        const sales = [];
        const profits = [];

        data.forEach((item) => {
            labels.push(x (item));
            sales.push(item.sales);
            profits.push(item.profit);
        });

        // 가져온 데이터를 차트에 적용합니다.
        chart.data.labels = labels;
        chart.data.datasets[0].data = sales;
        chart.data.datasets[1].data = profits;

        // 차트를 업데이트합니다.
        chart.update();
    }

    function updateProfitLossList(profitLossListSelector, data) {
        const profitLossList = $(profitLossListSelector + " li");
        data.forEach((item, index) => {
            const profitLoss = item.profitLoss;
            $(profitLossList[index]).text(profitLoss);
        });
    }

    // 두 차트에 대한 데이터를 동시에 가져옵니다.
    $.when(bbGraphData(), mmGraphData())
        .done((response1, response2) => {
            // 첫 번째 차트 데이터 처리
            if (response1[0].result) {
                processDataForChart(beGraph, response1[0].data, (item) => item.vehicleMM);
                updateProfitLossList(".profitLosslist1", response1[0].data);
            } else {
                console.error("Error: response1 is empty or undefined");
            }

            // 두 번째 차트 데이터 처리
            if (response2[0].result) {
                processDataForChart(mmGraph, response2[0].data, (item) => item.acountNm);
                updateProfitLossList(".profitLosslist2", response2[0].data);
            } else {
                console.error("Error: response2 is empty or undefined");
            }
        })
        .fail((xhr, status, error) => {
            console.error(error);
        });






    /*async function fetchData(custId) {
        try {
            const response = await $.ajax({
                url: "/dashboard/resultvehicle.do",
                type: "POST",
                dataType: "json",
                data: {
                    custId: custId,
                },
            });

            return response;
        } catch (error) {
            console.error("데이터를 불러오는데 실패했습니다:", error);
            throw error;
        }
    }

    async function loadChartData(custId) {
        try {
            const response = await fetchData(custId);

            console.log("배차손익 : ", response);

            if (response.result) {
                const data = response.data;

                const labels = [];
                const sales = [];
                const profits = [];

                data.forEach(item => {
                    labels.push(item.vehicleMM);
                    sales.push(item.sales);
                    profits.push(item.profit);
                });

                beGraph.data.labels = labels;
                beGraph.data.datasets[0].data = sales;
                beGraph.data.datasets[1].data = profits;

                beGraph.update();
            } else {
                console.error('Error: response is empty or undefined');
            }
        } catch (error) {
            console.error("차트 데이터 로드에 실패했습니다.:", error);
        }
    }

    const customerId = custIdcheck(); // 거래처 확인
    if (customerId) {
        loadChartData(customerId);
    }*/



    // 현재를 기준으로 날짜를 가져온다.
    function formatDate(date) {
        const yyyy = date.getFullYear();
        const mm = ('0' + (date.getMonth() + 1)).slice(-2);
        const dd = ('0' + date.getDate()).slice(-2);
        return yyyy + mm + dd;
    }
    // 오늘&어제
    function getTodayAndYesterday() {
        const today = new Date();
        const yesterday = new Date(today);
        yesterday.setDate(today.getDate() - 1);

        return {
            today: formatDate(today),
            yesterday: formatDate(yesterday),
        };
    }
    // debugger;
    // 거래처 아디를 체크해주는 변수값
    function custIdcheck() {
        var custId = '${sessionScope.userInfo.custId}';
        return custId;
    }

    // 거래처 아디확인
   var custId = custIdcheck();
    if (custId) {
        const { today, yesterday } = getTodayAndYesterday();

        $.ajax({
            url: "/dashboard/resultrank.do",
            type: "POST",
            dataType: "json",
            data: {
                custId: custId,
                today: today,
                yesterday: yesterday,
            },
        }).done(response => {

            //업데이트된 데이터를 Class를 확인해서 각 위치에 출력
            function updateRanking(className, data, flag) {
                const filteredData = data.filter(item => item.resultFlag === flag);
                const filterItem = filteredData[0];
                if (filterItem) {
                $('.' + className + ' .title').text(filterItem.resultFlagNm);
                $('.' + className + ' .name').text(filterItem.userNm);
                $('.' + className + ' .rank').text(filterItem.resultVal);
                $('.' + className + ' .Unit').text(filterItem.resultUnit);
                }
            }
            // 카테고리 A:배차1위, B:매출 1위, C:이익 1위, D:이익율 1위
            if (response.result) {
                const { data } = response;
                const todayData = data.filter(item => item.searchDate === today);
                const yesterdayData = data.filter(item => item.searchDate === yesterday);
                const categories = {
                    A: 'vehicle',
                    B: 'sales',
                    C: 'profit',
                    D: 'profitRate',
                };

                Object.keys(categories).forEach(key => {
                    const todayItem = todayData.find(item => item.resultFlag === key);
                    const yesterdayItem = yesterdayData.find(item => item.resultFlag === key);
                    const className = categories[key];

                    if (todayItem) {
                        updateRanking(className + 'today', [todayItem], key);
                    }
                    if (yesterdayItem) {
                        updateRanking(className + 'yesterday', [yesterdayItem], key);
                    }
                });
;

            } else {
                console.error('Error: response is empty or undefined');
            }
        }).fail((xhr, status, error) => {
            console.error(error);
        });
    }
    function userIdcheck() {
       var userId = '${sessionScope.userInfo.userId}';
       return userId;
    }

    // 나의 실적
    var userId = userIdcheck();
    if(userId) {
        $.ajax({
            url: "/dashboard/myresult.do",
            type: "POST",
            dataType: "json",
            data: {
                userId: userId,
                // resultFlag: resultFlag,
            },
        }).done(response => {
            // 업데이트된 데이터를 Class를 확인해서 각 위치에 출력
            function updateRanking(className, data, flag) {
                const filteredData = data.filter(item => item.resultFlag === flag);
                const filterItem = filteredData[0];
                if (filterItem) {
                    $('.' + className + ' .vehicleStr').text(filterItem.allocCnt);
                    $('.' + className + ' .salesStr').text(filterItem.sales);
                    $('.' + className + ' .proiftStr').text(filterItem.profit);
                    $('.' + className + ' .proiftRateStr').text(filterItem.profitPer);
                }
            }
            // 카테고리 D:오늘, M:이번달
            if (response.result) {
                const { data } = response;
                const DData = data.filter(item => item.resultFlag);
                const MData = data.filter(item => item.resultFlag);
                const categories = {
                    D: 'DPerformance',
                    M: 'MPerformance',
                };
                Object.keys(categories).forEach(key => {
                    const todayItem = DData.find(item => item.resultFlag === key);
                    const monthItem = MData.find(item => item.resultFlag === key);
                    const className = categories[key];

                    if (todayItem) {
                        updateRanking(className + 'today', [todayItem], key);
                    }
                    if (monthItem) {
                        updateRanking(className + 'month', [monthItem], key);
                    }
                });

            } else {
                console.error('Error: response is empty or undefined');
            }
        }).fail((xhr, status, error) => {
            console.error(error);
        });
    }
    // Today's Hight-Light
    var custId = custIdcheck();
    if(custId) {
        $.ajax({
            url: "/dashboard/todaycustresult.do",
            type: "POST",
            dataType: "json",
            data:{
                custId:custId,
            },
        }).done(response => {
            if (response.result) {
                const { data } = response;
                $('.highLight_slide_cont .acountCNm').each((index, element)=>{
                    $(element).text(data[index].acountCNm);
                });
                $('.highLight_slide_cont .sales').each((index, element)=>{
                    $(element).text(data[index].sales.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",")); //1000단위 콤마
                });
                $('.highLight_slide_cont .purchase').each((index, element)=>{
                    $(element).text(data[index].purchase.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",")); //1000단위 콤마
                });
                $('.highLight_slide_cont .profit').each((index, element)=>{
                    $(element).text(data[index].profit.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",")); //1000단위 콤마
                });
                $('.highLight_slide_cont .profitPersaint').each((index, element)=>{
                    $(element).text(data[index].profitPersaint);
                });
                $('.highLight_slide_cont .acountDNm').each((index, element)=>{
                    $(element).text(data[index].acountDNm);
                });
                $('.highLight_slide_cont .acountNm').each((index, element)=>{
                    $(element).text(data[index].acountNm);
                });
                console.log(response)
            }else {
                console.error(response.message);
            }
        }).fail((xhr, status, error) => {
            console.error(error);
        });
    }

</script>


</body>
</html>