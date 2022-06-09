<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="pop-layer">
    <div class="editor_wrap pop-layer" id="layer1">
        <!-- wrap -->
        <div class="k-tabstrip-wrapper">
            <div id="editor_tabs" class="tabs_wrap k-widget k-tabstrip k-floatwrap k-tabstrip-top" data-role="tabstrip"
                tabindex="0" role="tablist" aria-activedescendant="editor_tabs_ts_active">
                <!-- content -->
                <div class="tab-content k-content k-state-active" id="editor_tabs-1" role="tabpanel"
                    aria-expanded="true" style="display: block;">
                    <div class="editor">
                       	<input type="hidden" name="orderId" id="orderId" value="${param.orderId}">
                           <fieldset>
                               <legend style="text-align: center;">운행차량 위치 관제</legend>
                               	<input type="hidden" name="orderId" id="orderId" value="${param.orderId}">
                               	<div id="viewGrid" style="min-width: 100%;" ></div>
                               	<div id="map" class="map" style="min-height:550px;height:100%;margin-top:0px;"></div>
                           </fieldset>
                        <div class="editor_btns" style="text-align:right;">
                        	<div class="padding">
						        <a onclick="viewLocationClose();" class="k-pager-refresh k-button"><b class="btn-g"><i class="k-icon k-i-cancel"></i>닫기</b></a>
					        </div>
					    </div>
                    </div>
                    <!-- editor -->
                </div>
            </div><!-- content -->
        </div>
    </div><!-- wrap -->
</div>

<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=b05648cb013320391f8186c36a97862f"></script>
<script type="text/javascript">
/* var oGrid = null;
oGrid = new gridData("grid");
oGrid.initGrid();
oGrid.setSendUrl("/contents/order/data/orderStopList.do");
oGrid.setPageable(false); */

var map;
var markersArray = [];
var marker;
var coordinates = [];
var infwin = [];
var polyArr = [];
var pathArr = [];
var bounds;

$(document).ready(function(){
	var options = {
			center: new kakao.maps.LatLng(33.450701, 126.570667),
			level: 12,
			streetViewControl: true,
			mapTypeControl: true,
			panControl: true,
			mapTypeId: daum.maps.MapTypeId.ROADMAP
	};	
	map = new kakao.maps.Map(document.getElementById('map'), options);

	setData();
	getLocData();
})

$("#viewGrid").kendoGrid({
	sortable: false,
	resizable: true,
	filterable: false,
	selectable: false,
	pageable: false,
	scrollable: false,
	columns: [
		{ field: "carNum", title: "차량번호", width: 100 },
		{ field: "driverName", title: "차주명", width: 100 },
		{ field: "driverTel", title: "전화번호", width: 100 },
		{ field: "sComName", title: "상차지", width: 100 },
		{ field: "eComName", title: "하차지", width: 100 },
		
	]
	/* dataSource: {
		data: [
			{ test: 1, },
		]
	} */
}); 

function setData() {
/* 	var carNum = Util.nvl($("#locationBuyCarNum", parent.document).val(), $("#carNumData", parent.document).val());
	var driverName = Util.nvl($("#locationBuyDriverName", parent.document).val(), $("#driverNameData", parent.document).val());
	var driverTel = Util.nvl($("#locationBuyDriverTel", parent.document).val(), $("#driverTelData", parent.document).val()); */
	var carNum = $("#locationCarNum", parent.document).val();
	var driverName = $("#locationDriverName", parent.document).val();
	var driverTel = $("#locationDriverTel", parent.document).val();
	var sComName = $("#locationSComName", parent.document).val();
	var eComName = $("#locationEComName", parent.document).val();
	
	var dataSource = new kendo.data.DataSource({
		data: [
			{
				carNum: carNum, 
				driverName: driverName, 
				driverTel: driverTel, 
				sComName: sComName, 
				eComName: eComName
			}
		]
	})
	
	var grid = $("#viewGrid").data("kendoGrid");
	grid.setDataSource(dataSource);
	bounds = new daum.maps.LatLngBounds();
	var sLat = $("#locationSLat", parent.document).val();
	var sLon = $("#locationSLon", parent.document).val();
	var eLat = $("#locationELat", parent.document).val();
	var eLon = $("#locationELon", parent.document).val();
	
	var markerImage = new daum.maps.MarkerImage("/images/icon/marker_s.png", new daum.maps.Size(24,40), null);
	var latlng = new kakao.maps.LatLng(sLat, sLon);
	bounds.extend(latlng);
	createMarker_RT(latlng, "(상차지)"+$("#locationSAddr", parent.document).val()+" "+$("#locationSAddrDetail", parent.document).val(), markerImage);

	var markerImage = new daum.maps.MarkerImage("/images/icon/marker_e.png", new daum.maps.Size(24,40), null);
	var latlng = new kakao.maps.LatLng(eLat, eLon);
	bounds.extend(latlng);
	createMarker_RT(latlng, "(하차지)"+$("#locationEAddr", parent.document).val()+" "+$("#locationEAddrDetail", parent.document).val(), markerImage);
}

function getLocData(){
	coordinates = [];
	$.ajax({
		url: "/contents/order/data/orderLbsList.do",
		type: "POST",
		dataType: "json",
		data: "orderId=" + $("#orderId").val(),
		success: function(data) {
			if(data.result) {
				var data = data.data;
				var path = [];
				
				for(var i=0, item; item=data[i]; i++) {
					var latlng = new kakao.maps.LatLng(item.lat, item.lon);
					path[i] = latlng;
					coordinates.push(latlng);
					bounds.extend(latlng);	
				}

				var markerImage = new daum.maps.MarkerImage("/images/icon/marker_q.png", new daum.maps.Size(36,36), null);
				
				createMarker_RT(latlng, "현재위치", markerImage);
				createPolyline(path);
			} else {
				
			}
			// 검색 결과(마커출력)에 따라 지도의 center와 zoom 자동 설정
			map.setBounds(bounds);
		}
	});
}

function viewLocationClose(){
	window.parent.$("#divViewLocation").data("kendoWindow").close();
}

function createPolyline(latlng) {
	var polyline = new daum.maps.Polyline({	//폴리라인
		path: latlng,
		//strokeColor: polylineColor,
		strokeOpacity: 1,
		strokeWeight: 2,
		strokeStyle:'solid',
		endArrow:true
	});
	//polyArr[loopNum] = polyline; 
	//pathArr.push(latlng);	//폴리라인 path
	polyline.setMap(map);
}

function createMarker_RT(latlng, title, markerImage){
	marker = new daum.maps.Marker({
		position: latlng,
		map : map,
		image : markerImage,	// 19,32  12,20
		title : title
	});
	
	markersArray.push(marker);
	
	//InfoWindow 출력
	//utilMap.popInfoWindow_RT(vehicNo, drvTel, drvNm, latlng, traceDate, marker, stat, loopNum);
}
</script>