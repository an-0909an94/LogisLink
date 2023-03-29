<%@ page import="com.logislink.login.vo.LoginVO" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>

<%
    String aaaa = request.getParameter("custId");
    if(aaaa !=null) {
        LoginVO login = (LoginVO) session.getAttribute("userInfo");
        login.setCustId(request.getParameter("custId").toString());
        login.setUserId(request.getParameter("userid").toString());
        login.setUserName(request.getParameter("userNm").toString());
        session.setAttribute("userInfo", login);
    }
%>
<html>
<head>
    <title>LOGISLINK DASHBOARD</title>
    <link rel="stylesheet" href="/css/mainDashboard.css" />
</head>
<body>
<div id="wrap">
    <div class="notice_bg"></div>
    <header>
        <div class="header_left">
            <h1><a href="${sessionScope.userInfo.userMainPage}">로지스링크</a></h1>
            <b>${sessionScope.userInfo.userName} 님<span>${sessionScope.userInfo.bizName.replace('주식회사', '㈜')}</span></b>
        </div>
        <div class="header_right">
            <%--<ul>
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
            </ul>--%>
                <a href="#"><span onClick="location.replace('/mainDashboard.do?userid=est0302&custId=C20210802130835001&userNm=김영철')">김영철</span></a>
                <a href="#"><span onClick="location.replace('/mainDashboard.do?userid=input13&custId=C20230203133001001&userNm=김옥순')">김옥순</span></a>

            <a href="#" class="btn_gray replay"><span onClick="window.location.reload()">새로고침</span><p>새로고침</p></a>
            <a href="#" id="navPopup" class="btn_gray region"><span>지역설정</span><p>지역설정</p></a>



            <!-- 지역 설정 -->
            <div class="nav-layer" id="popupLayer">
                    <h2>지역을 설정해주세요!</h2>
                    <p>지역을 설정하면 날씨와 유가정보를 확인할 수 있습니다.</p>
                    <div class="navContents">
                        <div class="navInfo">
                        <label><input type="radio" class="navList" name="region" value="1" data-sido="01" data-sido-name="서울시"><span id="region1">서울시</span></label>
                        <label><input type="radio" class="navList" name="region" value="2" data-sido="02" data-sido-name="경기도"><span id="region2">경기도</span></label>
                        <label><input type="radio" class="navList" name="region" value="3" data-sido="03" data-sido-name="강원도"><span id="region3">강원도</span></label>
                        <label><input type="radio" class="navList" name="region" value="4" data-sido="04" data-sido-name="충북북도"><span id="region4">충청북도</span></label>
                        <label><input type="radio" class="navList" name="region" value="5" data-sido="05" data-sido-name="충청남도"><span id="region5">충청남도</span></label>
                        <label><input type="radio" class="navList" name="region" value="6" data-sido="06" data-sido-name="전라북도"><span id="region6">전라북도</span></label>
                        <label><input type="radio" class="navList" name="region" value="7" data-sido="07" data-sido-name="전라남도"><span id="region7">전라남도</span></label>
                        <label><input type="radio" class="navList" name="region" value="8" data-sido="08" data-sido-name="경상북도"><span id="region8">경상북도</span></label>
                        <label><input type="radio" class="navList" name="region" value="9" data-sido="09" data-sido-name="경상남도"><span id="region9">경상남도</span></label>
                        <label><input type="radio" class="navList" name="region" value="10" data-sido="10" data-sido-name="부산시"><span id="region10">부산시</span></label>
                        <label><input type="radio" class="navList" name="region" value="18" data-sido="18" data-sido-name="울산시"><span id="region18">울산시</span></label>
                        <label><input type="radio" class="navList" name="region" value="14" data-sido="14" data-sido-name="대구시"><span id="region14">대구시</span></label>
                        <label><input type="radio" class="navList" name="region" value="15" data-sido="15" data-sido-name="인천시"><span id="region15">인천시</span></label>
                        <label><input type="radio" class="navList" name="region" value="16" data-sido="16" data-sido-name="광주시"><span id="region16">광주시</span></label>
                        <label><input type="radio" class="navList" name="region" value="17" data-sido="17" data-sido-name="대전시"><span id="region17">대전시</span></label>
                        <label><input type="radio" class="navList" name="region" value="19" data-sido="19" data-sido-name="세종시"><span id="region19">세종시</span></label>
                        <label><input type="radio" class="navList" name="region" value="11" data-sido="11" data-sido-name="제주도"><span id="region11">제주도</span></label>
                    </div>
                    </div>
                <div id="navClose1" class="exitBtn btn_dash_close">닫기</div>
<%--                <button id="navClose2" type="button" class="icon_dash_close btn_dash_close">닫기</button>--%>
                </div>
            </div>
    </header>

    <section>
        <div class="layout">
            <div class="section_left">
                <div class="recent_ranking">
                    <h2>최근실적 Ranking</h2>
                    <input type="radio" id="ranking_today" name="recent_ranking" value="today" checked>
                    <input type="radio" id="ranking_yesterday" name="recent_ranking" value="yesterday">
                    <div class="ranking_label">
                        <label for="ranking_today">오늘</label>
                        <label for="ranking_yesterday">어제</label>
                    </div>
                    <div class="recent_ranking_box">
                        <div>
                            <ul>
                                <li class="vehicle vehicletoday">
                                    <p class="ranking_tit title">배차1위</p>
                                    <div>
                                        <p class="name"></p>
                                        <b class="rank">0</b>
                                        <span class="Unit">건</span>
                                    </div>
                                </li>
                                <li class="sales salestoday">
                                    <p class="ranking_tit title">매춯1위</p>
                                    <div>
                                        <p class="name"></p>
                                        <b class="rank">0</b>
                                        <span class="Unit">만원</span>
                                    </div>
                                </li>
                                <li class="profit profittoday">
                                    <p class="ranking_tit title">이익1위</p>
                                    <div>
                                        <p class="name"></p>
                                        <b class="rank">0</b>
                                        <span class="Unit">만원</span>
                                    </div>
                                </li>
                                <li class="profitRate profitRatetoday">
                                    <p class="ranking_tit title">이익율1위</p>
                                    <div>
                                        <p class="name"></p>
                                        <b class="rank">0</b>
                                        <span class="Unit">%</span>
                                    </div>
                                </li>
                            </ul>
                        </div>
                        <div>
                            <ul>
                                <li class="vehicle vehicleyesterday">
                                    <p class="ranking_tit title">배차1위</p>
                                    <div>
                                        <p class="name"></p>
                                        <b class="rank">0</b>
                                        <span class="Unit">건</span>
                                    </div>
                                </li>
                                <li class="sales salesyesterday">
                                    <p class="ranking_tit title">매출1위</p>
                                    <div>
                                        <p class="name"></p>
                                        <b class="rank">0</b>
                                        <span class="Unit">만원</span>
                                    </div>
                                </li>
                                <li class="profit profityesterday">
                                    <p class="ranking_tit title">이익1위</p>
                                    <div>
                                        <p class="name"></p>
                                        <b class="rank">0</b>
                                        <span class="Unit">만원</span>
                                    </div>
                                </li>
                                <li class="profitRate profitRateyesterday">
                                    <p class="ranking_tit title">이익율1위</p>
                                    <div>
                                        <p class="name"></p>
                                        <b class="rank">0</b>
                                        <span class="Unit">%</span>
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
                                    <span><b class="vehicleStr">0</b> 건</span>
                                </li>
                                <li class="sales">
                                    <p class="my_ranking_tit">매출액</p>
                                    <span><b class="salesStr">0</b> 만원</span>
                                </li>
                                <li class="profit">
                                    <p class="my_ranking_tit">이익</p>
                                    <span><b class="proiftStr">0</b> 만원</span>
                                </li>
                                <li class="profitRate">
                                    <p class="my_ranking_tit">이익률</p>
                                    <span><b class="proiftRateStr">0</b> %</span>
                                </li>
                            </ul>
                        </div>
                        <div class="MPerformancemonth">
                            <ul>
                                <li class="vehicle">
                                    <p class="my_ranking_tit">배차건수</p>
                                    <span><b class="vehicleStr">0</b> 건</span>
                                </li>
                                <li class="sales">
                                    <p class="my_ranking_tit">매출액</p>
                                    <span><b class="salesStr">0</b> 만원</span>
                                </li>
                                <li class="profit">
                                    <p class="my_ranking_tit">이익</p>
                                    <span><b class="proiftStr">0</b> 만원</span>
                                </li>
                                <li class="profitRate">
                                    <p class="my_ranking_tit">이익률</p>
                                    <span><b class="proiftRateStr">0</b> %</span>
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
                                        <span class="acountCNm">-</span>
                                    </li>
                                    <li>
                                        매출액
                                        <span class="sales">0</span>
                                    </li>
                                    <li>
                                        매입액
                                        <span class="purchase">0</span>
                                    </li>
                                    <li>
                                        이익
                                        <span class="color_r profit">0</span>
                                    </li>
                                    <li>
                                        이익률
                                        <div class="color_r" style="display: flex;">
                                            <span class="profitPersaint" style="display: flex;justify-content: center;">0</span><span>%</span>
                                        </div>
                                    </li>
                                    <li>
                                        담당부서
                                        <span class="acountDNm">-</span>
                                    </li>
                                    <li>
                                        담당자
                                        <span class="acountNm">-</span>
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
                                <li><span class="g-square namelabel"></span><span>매출</span><span class="bunit">(만원)</span></li>
                                <li><span class="g-circle namelabel"></span><span>이익</span><span class="bunit">(만원)</span></li>
                                <li><span class="g-square2 namelabel"></span><span>이익율</span><span class="bunit">(%)</span></li>
                            </ul>
                        </div>
                        <div class="chart-wrap" style="width:900px; height:350px;">
                        <canvas id="beGraph"></canvas>
                        </div>
                        <div class="graph_vehicle_percentage">
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
                                <li><span class="t-square1 namelabel"></span><span>매출</span><span class="bunit">(만원)</span></li>
                                <li><span class="t-square2 namelabel"></span><span>이익</span><span class="bunit">(만원)</span></li>
                                <li><span class="g-square2 namelabel"></span><span>이익율</span><span class="bunit">(%)</span></li>
                            </ul>
                        </div>
                        <div class="chart-wrap" style="width:900px; height:350px;">
                        <canvas id="mmGraph"></canvas>
                        </div>
                        <div class="graph_top_percentage">
                            <ul class="profitLosslist2">
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
                                <%--<c:forEach var="idx" begin="0" end="4">--%>
                                <c:forEach var="idx" items="${[1, 2, 4]}">
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
        dataType: 'json',
        data: {
            boardType: "dashboard",
        }
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
            const oilIndexes = [1, 2, 4];
            const oilPrices = [];

            oilIndexes.forEach(index => {
                oilPrices.push(response.oil.OIL[index].PRICE);
            });

            $('.all_oil_price').each((index, element)=>{
                $(element).text(Math.round(oilPrices[index]).toString().replace(/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ",") + " 원");
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
                    $(element).text(Math.round(oilPrices[index].price).toString().replace(/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ",") + " 원");
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
            $('.notice_bg').fadeIn();
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
            location.reload();

            //팝업 닫기
            $('#popupLayer').fadeOut();
            $('.notice_bg').fadeOut();
        });

        //팝업 닫기 버튼
        $('#navClose1').click(function (){
            $('#popupLayer').fadeOut();
            $('.notice_bg').fadeOut();
        });
        $('#navClose2').click(function (){
            $('#popupLayer').fadeOut();
            $('#noticeCon1').fadeOut();
            $('#noticeCon2').fadeOut();
            $('.notice_bg').fadeOut();
        });

        //Esc 키를 누르면 팝업 닫기
        $(document).keyup(function (e){
            if(e.key === "Escape") {
                $('#popupLayer').fadeOut();
                $('.notice_bg').fadeOut();
                $('#noticeCon1').fadeOut();
                $('#noticeCon2').fadeOut();
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
                backgroundImage: '',
                borderWidth: 1,
                yAxisID: 'y2',
                maxBarThickness: 22,
                barPercentage: 1.0,
                categoryPercentage: 1.0,
                datalabels: {
                    display:true,
                    color: '#fff',
                    anchor: 'end',
                    align: 'top',
                    font: {
                        family: 'Noto Sans KR',
                        size: 14,
                        weight: 800
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
                backgroundColor: '#ff624c',
                borderColor: '#ff624c',
                borderWidth: 1,
                yAxisID: 'y1',
                // pointStyle: 'circle',
                datalabels: {
                    display:true,
                    color: '#ff624c',
                    anchor: 'end',
                    align: 'top',
                    font: {
                        family: 'Noto Sans KR',
                        size: 14,
                        weight: 800
                    },
                    formatter: function(value, context) {
                        return value.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
                    }
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
            layout: {
                padding: {
                    left: 10, //차트의 넓이를 지정할 수 있다.
                    right: 40,
                    top: 50,
                    bottom: 80
                }
            },
            interaction: {
                mode: 'none'
            },
            animation: {
                duration: 0,
            },
            plugins: {
                legend: {
                    padding: 1,
                    display: false,
                },
            },
            responsive: true,
            scales: {
                x: {
                    // min: 0,
                    display: true,
                    title: {
                        display: true
                    },
                    ticks: {
                        color: '#fff',
                        font: {
                            size: 13,
                            weight: 'bold',
                        }
                    },
                },
                y1: {
                    position: 'right',
                    display: true,
                    title: {
                        display: false
                    },
                    beginAtZero: true,
                    // min: 0,
                    // max: Math.ceil(300000 / 2) * 2, //2의 배수
                    ticks: {
                        stepSize:1,
                        color: '#fff',
                        font: {
                            size: 0,
                            weight: 800,
                        },
                    },
                    grid: {
                        color: 'rgb(57 57 57)',
                        lineWidth: 1,
                        drawBorder: true,
                    },
                },
                y2: {

                    position: 'left',
                    display: true,
                    title: {
                        display: true
                    },
                    beginAtZero: true,
                    // min: 0,
                    // max: Math.ceil(400000 / 2) * 2,
                    ticks: {
                        beginAtZero : true,
                        stepSize:1,
                        color: '#fff',
                        font: {
                            size: 0,
                            weight: 800
                        },
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
                // barPercentage: 1.0,
                // categoryPercentage: 0.1,
                datalabels: {
                    display:true,
                    color: '#fff',
                    anchor: 'end',
                    align: 'top',
                    font: {
                        family: 'Noto Sans KR',
                        size: 13,
                        weight: 800
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
                    family: 'Noto Sans KR',
                    display:true,
                    color: '#ff624c',
                    anchor: 'end',
                    align: 'top',
                    font: {
                        size: 13,
                        weight: 800

                    },
                    formatter: function(value, context) {
                        return value.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
                    }
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
            layout: {
                padding: {
                    left: 20,
                    right: 30,
                    top: 50,
                    bottom: 80
                }
            },
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
            responsive: true,
            scales: {
                x: {
                    // min: 0,
                    display: true,
                    title: {
                        display: true
                    },
                    ticks: {
                        color: '#fff',
                        font: {
                            size: 10,
                            weight: 800
                        }
                    },
                },
                y1: {
                    position: 'left',
                    display: true,
                    title: {
                        display: true
                    },
                    /*min: -800,
                    max: 200000,*/
                    ticks: {
                        suggestedMin: 0,
                        beginAtZero : true,
                        stepSize:1,
                        color: '#fff',
                        font: {
                            size: 0,
                            weight: 800,
                        },

                    },
                    grid: {
                        color: 'rgb(57 57 57)',
                        lineWidth: 1,
                        drawBorder: true,
                    },
                },
                y2: {

                    position: 'right',
                    display: true,
                    title: {
                        display: false
                    },
                    /*min: -800,
                    max: 200000,*/
                    ticks: {
                        beginAtZero : true,
                        stepSize:1,
                        color: '#fff',
                        font: {
                            size: 0,
                            weight: 800,
                        },
                    },
                }
            },
        }
    });



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
                console.log('차트1번', response1);
                console.log('차트2번', response2);
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
    function processDataForChart(chart, data, mm) {
        const labels = [];
        const sales = [];
        const profits = [];

        data.forEach((item) => {
            labels.push(mm(item));
            sales.push(item.sales); // 매출
            profits.push(item.profit); // 이익
        });

        // debugger;

        // sales와 profit에서 최소값과 최대값 찾기
        const salesMin = Math.min(...sales);
        const salesMax = Math.max(...sales);
        const profitMin = Math.min(...profits);
        const profitMax = Math.max(...profits);

        // 전체 최소값과 최대값 찾기
        const minValue1 = chart.options.scales.y1.min || Math.min(salesMin, profitMin);
        const maxValue1 = chart.options.scales.y1.max || Math.max(salesMax, profitMax);
        const minValue2 = chart.options.scales.y2.min || Math.min(salesMin, profitMin);
        const maxValue2 = chart.options.scales.y2.max || Math.max(salesMax, profitMax);

        // 가져온 데이터를 차트에 적용합니다.
        chart.data.labels = labels;
        chart.data.datasets[0].data = sales;
        chart.data.datasets[1].data = profits;

        // debugger;
        // 차트를 업데이트합니다.
        chart.options.scales.y1.min = minValue1;
        chart.options.scales.y1.max = maxValue1;
        chart.options.scales.y2.min = minValue2;
        chart.options.scales.y2.max = maxValue2;
        chart.update();
    }

    function updateProfitLossList(profitLossListSelector, data) {
        const profitLossList = $(profitLossListSelector + " li");
        data.forEach((item, index) => {
            const profitLoss = item.profitLoss;
            $(profitLossList[index]).text(profitLoss + "%");
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
    // 거래처 아디를 체크해주는 변수값
    function custIdcheck() {
        var custId = '${sessionScope.userInfo.custId}';
        return custId;
    }

    // 거래처 아디확인
    var custId = custIdcheck();
    if (custId) {
        const { today, yesterday } = getTodayAndYesterday();

        // 라디오버튼 이벤트
        $('input[name="recent_ranking"]').on('change', function () {
            const selectedDate = this.value === 'today' ? today : yesterday;

            $.ajax({
                url: "/dashboard/resultrank.do",
                type: "POST",
                dataType: "json",
                data: {
                    custId: custId,
                    searchDate: selectedDate,
                },
            }).done(response => {
                console.log('최근실적', response);

                //업데이트된 데이터를 Class를 확인해서 각 위치에 출력

                // debugger;
                function updateRanking(className, data, flag) {
                    const filteredData = data.filter(item => item.resultFlag === flag);
                    const filterItem = filteredData[0];
                    if (filterItem) {
                        $('.' + className + ' .title').text(filterItem.resultFlagNm);
                        $('.' + className + ' .name').text(filterItem.userNm);
                        $('.' + className + ' .rank').text(filterItem.resultVal.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ","));
                        $('.' + className + ' .Unit').text(filterItem.resultUnit);
                    }
                }

                // 카테고리 A:배차1위, B:매출 1위, C:이익 1위, D:이익율 1위
                if (response.result) {
                    const {data} = response;
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

                } else {
                    console.error('Error: response is empty or undefined');
                }
            }).fail((xhr, status, error) => {
                console.error(error);
            });
        });
        // 페이지 로드 시 라디오 버튼의 change 이벤트를 트리거
        $('input[name="recent_ranking"]:checked').trigger('change');
    }



    // 유저 아이디 확인
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
            console.log('나의실적', response);
            // 업데이트된 데이터를 Class를 확인해서 각 위치에 출력
            function updateRanking(className, data, flag) {
                const filteredData = data.filter(item => item.resultFlag === flag);
                const filterItem = filteredData[0];
                if (filterItem) {
                    $('.' + className + ' .vehicleStr').text(filterItem.allocCnt);
                    $('.' + className + ' .salesStr').text(filterItem.sales.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ","));
                    $('.' + className + ' .proiftStr').text(filterItem.profit.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ","));
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
            console.log('투데이', response);
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
            }else {
                console.error(response.message);
            }
        }).fail((xhr, status, error) => {
            console.error(error);
        });
    }


</script>
<%--<script src="/js/mainDashboard.js"></script>--%>
</body>
</html>