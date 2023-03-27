
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
        // location.reload();

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
