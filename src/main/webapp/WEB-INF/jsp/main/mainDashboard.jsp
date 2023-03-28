<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>

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
                                <li><span class="g-square namelabel"></span><span>매출</span><span class="bunit">(만원)</span></li>
                                <li><span class="g-circle namelabel"></span><span>이익</span><span class="bunit">(만원)</span></li>
                            </ul>
                        </div>
                        <canvas id="beGraph" width="600" height="209"></canvas>
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
                                <li><span class="t-square1 namelabel"></span><span>매출</span><span class="bunit">(만원)</span></li>
                                <li><span class="t-square2 namelabel"></span><span>이익</span><span class="bunit">(만원)</span></li>
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
<script src="/js/mainDashboard.js"></script>


</body>
</html>