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
    section .section_right .weather ul li p.weather_temperatures{font-size: 17px; font-weight: bold; position: absolute; top: 6px; left: 47px;}
    section .section_right .weather div.weather_afternoon{margin-left: 10px;}
    section .section_right .weather div.weather_afternoon span.weather_txt{left: 45px;}
    section .section_right .weather div.weather_afternoon p.weather_temperatures{left: 45px;}

    section .weather span[class ^="weather_icon_"]{font-size: 0px !important; width: 39px; height: 26px; display: block; background: url(../img/icon_weather.png) no-repeat; background-position: 0px 0px;}

    /* 날씨아이콘 S */

    /* 구름 */
    section .weather span.weather_icon_could{background-position: 0px -204px; height: 28px;}
    /* 맑음 */
    section .weather span.weather_icon_sun{background-position: 0px -140px; height: 30px;}
    /* 소나기 */
    section .weather span.weather_icon_shower{background-position: 0px -36px; height: 28px;}
    /* 눈 */
    section .weather span.weather_icon_snow{background-position: 0px -68px; height: 33px;}
    /* 비 */
    section .weather span.weather_icon_rain{background-position: 0px -4px; height: 28px;}
    /* 안개 */
    section .weather span.weather_icon_fag{background-position: 0px -175px; height: 28px;}
    /* 번개 */
    section .weather span.weather_icon_lightning{background-position: 0px -106px; height: 28px;}

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
            <a href="#" class="btn_gray region"><span>지역설정</span><p>지역설정</p></a>
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
                                <li class="vehicle">
                                    <p class="ranking_tit">배차 1위</p>
                                    <div>
                                        <p>최우리</p>
                                        <b>121</b>
                                        <span>건</span>
                                    </div>
                                </li>
                                <li class="sales">
                                    <p class="ranking_tit">매출 1위</p>
                                    <div>
                                        <p>깁유빈</p>
                                        <b>3,700</b>
                                        <span>만원</span>
                                    </div>
                                </li>
                                <li class="profit">
                                    <p class="ranking_tit">이익 1위</p>
                                    <div>
                                        <p>김하연</p>
                                        <b>2,300</b>
                                        <span>만원</span>
                                    </div>
                                </li>
                                <li class="profitRate">
                                    <p class="ranking_tit">이익률 1위</p>
                                    <div>
                                        <p>나소라</p>
                                        <b>14.5</b>
                                        <span>%</span>
                                    </div>
                                </li>
                            </ul>
                        </div>
                        <div>
                            <ul>
                                <li class="vehicle">
                                    <p class="ranking_tit">배차 1위</p>
                                    <div>
                                        <p>나소라</p>
                                        <b>121</b>
                                        <span>건</span>
                                    </div>
                                </li>
                                <li class="sales">
                                    <p class="ranking_tit">매출 1위</p>
                                    <div>
                                        <p>김하연</p>
                                        <b>3,700</b>
                                        <span>만원</span>
                                    </div>
                                </li>
                                <li class="profit">
                                    <p class="ranking_tit">이익 1위</p>
                                    <div>
                                        <p>깁유빈</p>
                                        <b>2,300</b>
                                        <span>만원</span>
                                    </div>
                                </li>
                                <li class="profitRate">
                                    <p class="ranking_tit">이익률 1위</p>
                                    <div>
                                        <p>최우리</p>
                                        <b>14.5</b>
                                        <span>%</span>
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
                        <div>
                            <ul>
                                <li class="vehicle">
                                    <p class="my_ranking_tit">배차건수</p>
                                    <span><b>121</b> 건</span>
                                </li>
                                <li class="sales">
                                    <p class="my_ranking_tit">매출액</p>
                                    <span><b>3,700</b> 만원</span>
                                </li>
                                <li class="profit">
                                    <p class="my_ranking_tit">이익</p>
                                    <span><b>3,700</b> 만원</span>
                                </li>
                                <li class="profitRate">
                                    <p class="my_ranking_tit">이익률</p>
                                    <span><b>14.5</b> %</span>
                                </li>
                            </ul>
                        </div>
                        <div>
                            <ul>
                                <li class="vehicle">
                                    <p class="my_ranking_tit">배차건수</p>
                                    <span><b>99</b> 건</span>
                                </li>
                                <li class="sales">
                                    <p class="my_ranking_tit">매출액</p>
                                    <span><b>3,400</b> 만원</span>
                                </li>
                                <li class="profit">
                                    <p class="my_ranking_tit">이익</p>
                                    <span><b>3,100</b> 만원</span>
                                </li>
                                <li class="profitRate">
                                    <p class="my_ranking_tit">이익률</p>
                                    <span><b>8.5</b> %</span>
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
                            <li>
                                <ul class="highLight_slide_cont">
                                    <li>
                                        거래처
                                        <span>테스트거래처</span>
                                    </li>
                                    <li>
                                        매출액
                                        <span>1,300,000</span>
                                    </li>
                                    <li>
                                        매입액
                                        <span>1,000,000</span>
                                    </li>
                                    <li>
                                        이익
                                        <span class="color_r">200,000</span>
                                    </li>
                                    <li>
                                        이익률
                                        <span class="color_r">23.1%</span>
                                    </li>
                                    <li>
                                        담당부서
                                        <span>테스트부서</span>
                                    </li>
                                    <li>
                                        담당자
                                        <span>홍길동</span>
                                    </li>
                                </ul>
                            </li>
                            <li>
                                <ul class="highLight_slide_cont">
                                    <li>
                                        거래처
                                        <span>로지스링크</span>
                                    </li>
                                    <li>
                                        매출액
                                        <span>1,700,000</span>
                                    </li>
                                    <li>
                                        매입액
                                        <span>1,854,000</span>
                                    </li>
                                    <li>
                                        이익
                                        <span class="color_r">193,000</span>
                                    </li>
                                    <li>
                                        이익률
                                        <span class="color_r">17.1%</span>
                                    </li>
                                    <li>
                                        담당부서
                                        <span>로지스부서</span>
                                    </li>
                                    <li>
                                        담당자
                                        <span>홍길동</span>
                                    </li>
                                </ul>
                            </li>
                        </ul>
                    </div>
                </div>

                <div class="graph_vehicle">
                    <h2>배차 손익추이</h2>
                    <div><canvas id="myChart"></canvas></div>
                </div>

                <div class="graph_top">
                    <h2>전월 TOP 거래처 현황</h2>
                    <div></div>
                </div>
            </div>
            <div id="temperature" class="section_right">
                <div class="weather">
                    <h2>날씨 <p>현재위치 : <span>서울</span></p></h2>
                    <div>
                        <ul>
                            <li>
                                <p class="weather_day">오늘</p>
                                <div class="weather_morning">
                                    <span class="weather_icon_fag">안개</span>
                                    <span class="weather_txt">오전</span>
                                    <p class="weather_temperatures">-2.4</p>
                                </div>
                                <div class="weather_afternoon">
                                    <span class="weather_icon_sun">맑음</span>
                                    <span class="weather_txt">오후</span>
                                    <p class="weather_temperatures">3.0</p>
                                </div>
                            </li>
                            <li>
                                <p class="weather_day">내일</p>
                                <div class="weather_morning">
                                    <span class="weather_icon_could">구름</span>
                                    <span class="weather_txt">오전</span>
                                    <p class="weather_temperatures">-2.4</p>
                                </div>
                                <div class="weather_afternoon">
                                    <span class="weather_icon_sun">맑음</span>
                                    <span class="weather_txt">오후</span>
                                    <p class="weather_temperatures">3.0</p>
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
                                <td class="color_b">서울평균</td>
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

<ul id="morningTemperature"></ul>
<ul id="afternoonTemperature"></ul>


<!-- BoardList -->
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js" integrity="sha512-qTXRIMyZIFb8iQcfjXWCO8+M5Tbc38Qi5WzdPOYZHIlZpzBHG3L3by84BBBOiRGiEb7KKtAOAs5qYdUiZiQNNQ==" crossorigin="anonymous"></script>
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
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


    /** 시도 유가정보 */
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
            $('.sido_oil_price').each((index, element)=>{
                $(element).text(oilPrices[index].price);
            });
            console.log(oilPrices); // oilPrices 배열에 PRICE 값만 추출하여 출력
        } else {
            console.error(response.message);
        }
    }).fail((xhr, status, error) => {
        console.error(error);
    });

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

    /** 시도 기상청 날씨정보 출력 */
    function getWeather() {
        // debugger;
        $.ajax({
            url: "/contents/basic/data/getOpenweather.do",
            type: "POST",
            dataType: "json",
            async: true,
            data: {
                base_date: getBaseDate(),
                base_time: getBaseTime(),
                nx: "59",
                ny: "127"
            },
            success: function(data) {
                if (data && data.result && data.item) {
                    console.log(data.item);

                    // 필터링된 기온 데이터에서 오전/오후 기온 추출
                    var temperatureData = data.item.filter(function(item) {
                        return item.category === "TMP";
                    });

                    // 오전 기온 정보 추출
                    var morningTemperature = [];
                    for (var i = 6; i <= 12; i++) {
                        var hour = (i < 10) ? "0" + i + "00" : i + "00";
                        var temp = temperatureData.find(function(item) {
                             return item.fcstTime === hour;
                        });
                        morningTemperature.push({
                            hour: hour,
                            temperature: temp.fcstValue
                        });
                    }

                    // 오후 기온 정보 추출
                    var afternoonTemperature = [];
                    for (var i = 13; i <= 23; i++) {
                        var hour = (i < 10) ? "0" + i + "00" : i + "00";
                        var temp = temperatureData.find(function(item) {
                            return item.fcstTime === hour;
                        });
                        afternoonTemperature.push({
                            hour: hour,
                            temperature: temp.fcstValue
                        });
                    }
                    // debugger;
                    var yesterday = new Date();
                    yesterday.setDate(yesterday.getDate() - 1);
                    var currentHour = new Date().getHours();
                    currentHour = (currentHour).toString().padStart(4,"");
                    currentHour = currentHour + "00";
                    console.log("currentHour: ", currentHour);
                     debugger;

                    if (currentHour >= morningTemperature[0].hour && currentHour < `1200`) {
                        // 오전
                        if (morningTemperature.length > 0) {
                            $("#morningTemperature").append("<li>" + morningTemperature[0].hour.substring(0, 2) + "시: " + morningTemperature[0].temperature + "도</li>");
                        }
                    } else if (currentHour >= `1300` && currentHour < `2300`) {
                    	
                    	
                    	 if (morningTemperature.length > 0) {
                    		 var c = "";
                         	 var d = "";
                         	 morningTemperature.forEach(function(value){
                       		 var obj_key = Object.keys(value); 
                       		  
                       		  	if(value["hour"] == '1200'){
	                        		  c = value["hour"]; 
	                        		  d = value["temperature"];
                       		  	}
                       		  
                       		 // console.log(obj_key + " : " + obj_value); //출력
                       		 });
                    		 
                             $("#morningTemperature").append("<li>" + c.substring(0, 2) + "시: " + d + "도</li>");
                         }
                    	
                    	
                        // 오후
                        if (afternoonTemperature.length > 0) {
                        	var a = "";
                        	var b = "";
                        	afternoonTemperature.forEach(function(value){
                        		  var obj_key = Object.keys(value); 
                        		  if(value["hour"] == currentHour){
	                        		  a = value["hour"]; 
	                        		  b = value["temperature"];
                        		  }
                        		  
                        		 // console.log(obj_key + " : " + obj_value); //출력
                        	});
                            $("#afternoonTemperature").append("<li>" + a.substring(0, 2) + "시: " + b + "도</li>");
                        }
                    }
                    /*                    // 오전 기온 정보 출력
                                        $.each(morningTemperature, function(index, temperature) {
                                            $("#morningTemperature").append("<li>" + temperature.hour.substring(0, 2) + "시: " + temperature.temperature + "도</li>");
                                        });
                                        // 오후 기온 정보 출력
                                        $.each(afternoonTemperature, function(index, temperature) {
                                            $("#afternoonTemperature").append("<li>" + temperature.hour.substring(0, 2) + "시: " + temperature.temperature + "도</li>");
                                        });*/

                    console.log("오전 기온: ", morningTemperature);
                    console.log("오후 기온: ", afternoonTemperature);

                    // 필터링된 날씨 데이터에서 오전/오후 날씨 추출 하늘의 상태확인
                    var weatherData = data.item.filter(function(item) {
                        return item.category === "SKY";
                    });
                    var morningWeather = weatherData.find(function(item) {
                        return item.fcstTime === "0600";
                    });
                    var afternoonWeather = weatherData.find(function(item) {
                        return item.fcstTime === "1500";
                    });
                    console.log("오늘오전 날씨: " + getWeatherIcon(morningWeather.fcstValue));
                    console.log("오늘오후 날씨: " + getWeatherIcon(afternoonWeather.fcstValue));

                    //필터링된 날씨 강수량 형태
                    var rainfallData = data.item.filter(function (item) {
                        return item.category === "PTY";
                    });
                    var morningRainfall = rainfallData.find(function(item) {
                        return item.fcstTime === "0600";
                    });
                    var afternoonRainfall = rainfallData.find(function(item) {
                        return item.fcstTime === "1500";
                    });
                    console.log("오늘강수형태: " + getRaninfallIcon(morningRainfall.fcstValue));
                    console.log("오늘강수형태: " + getRaninfallIcon(afternoonRainfall.fcstValue));

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

        function getRaninfallIcon(fcstValue) {
            var iconUrl = "";
            switch (fcstValue) {
                case "0":
                    iconUrl = "없음";
                    break;
                case "1":
                    iconUrl = "비";
                    break;
                case "2":
                    iconUrl = "비/눈";
                    break;
                case "3":
                    iconUrl = "눈";
                    break;
                case "4":
                    iconUrl = "소나기";
                    break;
                default:
                    iconUrl = "없음";
            }
            return iconUrl;
        }

        function getWeatherIcon(fcstValue) {
            var iconUrl = "";
            switch (fcstValue) {
                case "1":
                    iconUrl = "맑음";
                    break;
                case "3":
                    iconUrl = "구름";
                    break;
                case "4":
                    iconUrl = "흐림";
                    break;
                default:
                    iconUrl = "맑음";
            }
            return iconUrl;
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

    }
    $(document).ready(function() {
        // 최초 1회 호출
        getWeather();

        // 1시간 마다 호출
        setInterval(getWeather, 3600000);
    });

    //차트 JS  배차 손익추이
    const ctx = document.getElementById('myChart');

    new Chart(ctx, {
        type: 'bar',
        data: {
            labels: ['7월', '8월', '9월', '10월', '11월', '이번달'],
            datasets: [{
                label: '매출',
                data: [5401, 5596, 5760, 5660, 5860, 5260],
                width: 1,
                borderWidth: 0
            }]
        },
        options: {
            scales: {
                y: {
                    beginAtZero: true
                }
            }
        }
    });

</script>


</body>
</html>
