<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>

<div class="oms_header omsOrderLocationList">
	<div class="summary p30">
		<div class="hdr-tit">
			<p style="display: inline;" id="headerTitle">상황실</p>
		</div>
		<div style="display: inline;" id="groupCount" class="hdr-tit"></div>
	</div>
	<div class="contents">
		<form id="fSearch" method="POST" autocomplete="off" onSubmit="return false;">
			<div style="display: inline; vertical-align: top;" class="hdr-tit">
			    <input style="padding: 0;" type="text" id="fromDate" name="fromDate" class="wd100">
				<span>~</span>
			    <input style="padding: 0;" type="text" id="toDate" name="toDate" class="wd100">
		    	<c:if test="${masterYn eq 'Y'}">
					<div class="input-group input-group-sm wd90 mr10 middle-name div-min-col-1">
						<select class="form-control" class="custom-select col-12" id="deptId" name="deptId"></select>
					</div>
				</c:if>
			    <button onclick="goList()" type="button" style="display: inherit; position: relative; top: 2px;" class="form-control form-control-sm wd90 mr10 btn_58 btn_b">검색</button>
			</div>
			<div style="display: inline;" class="hdr-tit autoRefresh">자동새로고침
	           	<input type="checkbox" id="autoRefresh" name="autoRefresh" class="input_on-off">
				<label for="autoRefresh" class="label_on-off" style="position: absolute;margin: 1px 0px 0px 6px;">
				  <span class="marble"></span>
				  <span class="on">ON</span>
				  <span class="off">OFF</span>
				</label>
			</div>
		    <input type="hidden" name="locationSLat" id="locationSLat">
		    <input type="hidden" name="locationSLon" id="locationSLon">
		    <input type="hidden" name="locationELat" id="locationELat">
		    <input type="hidden" name="locationELon" id="locationELon">
		    <input type="hidden" name="fromDate" id="fFromDate">
		    <input type="hidden" name="toDate" id="fToDate">
		</form>
		<div id="group-list" class="cont-wrapper-page-grid mt15 bortop pt20">
			<div id="location" style="width: 25%; float: left;">
				<div id="map" class="map" style="min-height:846px;height:100%;margin-top:0px;"></div>
			</div>
	   		<div id="grid" style="width: 75%; float: right;"></div>
		</div>
	</div>
</div>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=b05648cb013320391f8186c36a97862f"></script>
<script type="text/javascript">
var map;
var markersArray = [];
var marker;
var coordinates = [];
var infwin = [];
var polyArr = [];
var pathArr = [];
var bounds;

var columns = [
	{width: 180, template:'#if (orderStateName == "취소") {# <div style="color:\\\#FF0000;" class="grid-tr-18">#: orderStateName #</div> #} else if (orderStateName != "접수") {# <div style="color:\\\#0369DE;" class="grid-tr-18">#: orderStateName #</div> #} else {# <div class="grid-tr-18">#: orderStateName #</div> #} #'
						 +'<div class="grid-tr-14">#: orderId #</div>'
						 +'#if (buyCharge != 0) {# <div style="color:\\\#00152A;" class="grid-tr-18">#: Util.formatNumber(buyCharge) #원</div> #} else {# <div class="grid-tr-18">0원</div> #} #'
						 +'#if (chargeTypeName == null || chargeTypeName == "") {# <div class="grid-tr-14">인수증</div> #} else {# <div class="grid-tr-14">#: chargeTypeName #</div> #} #'},

    {width: 160, template:'<div style="color: \\\#00152A; text-align: center;" class="grid-tr-14">#if (carNum == null) {# #=""# #} else {# #=carNum# #} #</div>'
				  		 +'<div style="color: \\\#00152A; text-align: center;" class="grid-tr-14">#if (driverTel == null) {# #=""# #} else {# #=Util.formatPhone(driverTel)# #} #</div>'
				  		 +'<div style="padding-bottom: 10px; color: \\\#00152A; text-align: center;" class="grid-tr-14">#if (driverName == null) {# #=""# #} else {# #=driverName# #} #</div>'
				  		 +'<div style="color: \\\#00152A; text-align: center;" class="grid-tr-14">#if (carNum, driverTel, driverName == null) {# #=""# #} else {# #=carTypeName# #=carTonName# #=returnName# #=mixName# #} #</div>'
				  		 +'#if (carNum, driverTel, driverName == null) {# <div style="text-align: center;" class="grid-tr-14">#: carTypeName # #: carTonName # #: returnName # #: mixName #</div> #} #'},

    {width: 70, template:'#if (orderStateName == "접수") {# <div style="text-align: center; color: \\\#0369DE;" class="grid-tr-14">접수</div> #} else {# <div style="text-align: center;" class="grid-tr-14">접수</div> #} #'},

    //접수(불투명), 배차, 입차, 출발, 도착
    {width: 70, template:'#if (orderStateName == "접수") {# <div style="text-align: center; color: \\\#00152A;" class="grid-tr-14"><span style="opacity: 0.3;">▶</span><span style="opacity: 0.6;">▶</span>▶</div> #} else if (orderStateName != "취소") {# <div style="text-align: center; color: \\\#00152A;" class="grid-tr-14">▶▶▶</div> #} #'},

    {width: 80, template:'#if (orderStateName == "배차") {# <div style="text-align: center; color:\\\#0369DE;" class="grid-tr-14">배차완료</div> #} else {# <div style="text-align: center;" class="grid-tr-14">배차완료</div> #} #'},

    //입차(불투명), 출발, 도착
    {width: 70, template:'#if (orderStateName == "입차") {# <div style="text-align: center; color: \\\#00152A;" class="grid-tr-14"><span style="opacity: 0.3;">▶</span><span style="opacity: 0.6;">▶</span>▶</div> #} else if (orderStateName == "출발") {# <div style="text-align: center; color: \\\#00152A;" class="grid-tr-14">▶▶▶</div> #} else if (orderStateName == "도착") {# <div style="text-align: center; color: \\\#00152A;" class="grid-tr-14">▶▶▶</div> #} #'},

    {template:'#if (orderStateName == "출발") {# <div class="grid-tr-18" style="padding-bottom: 10px; text-align: center; color: \\\#0369DE;">#: sComName #(출발)</div> #} else {# <div class="grid-tr-18" style="padding-bottom: 10px; text-align: center;">#: sComName #(출발)</div> #} #'
    		 +'#if (orderStateName == "출발") {# <div class="grid-tr-14" style="text-align: center; color: \\\#0369DE;">#: sAddr #</div> #} else {# <div class="grid-tr-14" style="text-align: center;">#: sAddr #</div> #} #'
    		 +'#if (orderStateName == "출발") {# <div class="grid-tr-14" style="text-align: center; color: \\\#0369DE;">#: sDateDay #(상차)</div> #} else {# <div class="grid-tr-14" style="text-align: center;">#: sDateDay #(상차)</div> #} #'},

   	//출발(불투명), 도착
    {width: 70, template:'#if (orderStateName == "출발") {# <div style="text-align: center; color: \\\#00152A;" class="grid-tr-14"><span style="opacity: 0.3;">▶</span><span style="opacity: 0.6;">▶</span>▶</div> #} else if (orderStateName == "도착") {# <div style="text-align: center; color: \\\#00152A;" class="grid-tr-14">▶▶▶</div> #} #'},

    {template:'#if (orderStateName == "도착") {# <div class="grid-tr-18" style="padding-bottom: 10px; text-align: center; color: \\\#0369DE;">#: eComName #(도착)</div> #} else {# <div class="grid-tr-18" style="padding-bottom: 10px;text-align: center;">#: eComName #(도착)</div> #} #'
		  	 +'#if (orderStateName == "도착") {# <div class="grid-tr-14" style="text-align: center; color: \\\#0369DE;">#: eAddr #</div> #} else {# <div class="grid-tr-14" style="text-align: center;">#: eAddr #</div> #} #'
		  	 +'#if (orderStateName == "도착") {# <div class="grid-tr-14" style="text-align: center; color: \\\#0369DE;">#: eDateDay #(하차)</div> #} else {# <div class="grid-tr-14" style="text-align: center;">#: eDateDay #(하차)</div> #} #'},
];

var headerTitle = ($("#headerTitle").text());
var oGrid = null;
oGrid = new gridData("grid");
oGrid.initGrid();
oGrid.setSendUrl("/oms/order/data/omsOrderLocationList.do");
oGrid.setSelectable(true);
oGrid.setExcelFile(headerTitle+"(" + new Date().yyyymmdd() + ").xlsx");
oGrid.setDetailTemplate("<div style='padding: 0px;' class='detail-row'><span>#:regdate# #:mngDeptName# → #:buyCustName# #:buyDeptName#</span></div>");

var refresh_timer;
var autoRefresh;
$(document).ready(function(){
	if("${masterYn}" == "Y"){
		Util.setSelectBox("/contents/basic/data/compDeptList.do", "deptId", {custId:'${custId}', deptId:'${sessionScope.userInfo.deptId}', useYn:'Y'}, "deptId", "deptName", "${sessionScope.userInfo.deptId}", "--부서명--");
	}

 	var date = new Date();

 	var year = date.getFullYear();
 	var month = date.getMonth();
 	var day = date.getDate();

 	$("#fromDate").kendoDatePicker({format:"yyyy-MM-dd", value : new Date(year, month, day - 1), dateInput: true});
	$("#toDate").kendoDatePicker({format:"yyyy-MM-dd", value : new Date(), dateInput: true});

	$("#fFromDate").val($("#fromDate").val());
	$("#fToDate").val($("#toDate").val());

	goList();

	$(".k-grid-header").css("display","none");

	var options = {
			center: new kakao.maps.LatLng(36.36672131946701, 127.38845474793871),
			level: 12,
			streetViewControl: true,
			mapTypeControl: true,
			panControl: true,
			mapTypeId: daum.maps.MapTypeId.ROADMAP
	};
	map = new kakao.maps.Map(document.getElementById('map'), options);

 	var rCookie = $.cookie("autoRefresh");
	if(rCookie == null) {
		$.cookie("autoRefresh", 30000, {expires:10000,path:"/"});
		rCookie = $.cookie("autoRefresh");
	}

	if(rCookie != "0") {
		startInterval();
		$("#autoRefresh").prop("checked", true);
	} else {
		$("#autoRefresh").prop("checked", false);
	}

	$("#autoRefresh").on("click", function(){
		if($(this).is(":checked")) {
			$.cookie("autoRefresh", 30000, {expires:9999,path:"/"});
			startInterval();
		} else {
			$.cookie("autoRefresh", 0, {expires:9999,path:"/"});
			stopInterval();
		}
	});
});

function goList() {
	simpleOrderData();

	var grid = $("#grid").data("kendoGrid");

	oGrid.setSearchData($("#fSearch").serializeObject());
	if(grid == null) {
		oGrid.setGrid(columns);
		grid = $("#grid").data("kendoGrid");
		grid.bind("change", onChange);
	} else {
		grid.setDataSource(oGrid.gridOption.dataSource);
	}
	grid.bind("dataBound", grid_dataBound);
}

function grid_dataBound(e) {
	var grid = $("#grid").data("kendoGrid");
    $( ".k-master-row" ).each(function( index ) {
    	grid.expandRow(this);
    });
}

function onChange(e){
	deleteMarkers()
	var row = this.select();
	var data = this.dataItem(row);
	$("#locationSLat").val(data.sLat);
	$("#locationSLon").val(data.sLon);
	$("#locationELat").val(data.eLat);
	$("#locationELon").val(data.eLon);
	if($("#locationSLat").val() == "0" || $("#locationSLon").val() == "0" || $("#locationELat").val() == "0" || $("#locationELon").val() == "0"){
		alert("더미 상/하차지가 포함된 오더는 조회 할 수 없습니다.");
		return
	}
	setData(data);
	getLocData(data.orderId);
}

function setData(data) {
	bounds = new daum.maps.LatLngBounds();
	var sLat = $("#locationSLat").val();
	var sLon = $("#locationSLon").val();
	var eLat = $("#locationELat").val();
	var eLon = $("#locationELon").val();

	var markerImage = new daum.maps.MarkerImage("/images/icon/marker_s.png", new daum.maps.Size(24,40), null);
	var latlng = new kakao.maps.LatLng(sLat, sLon);
	bounds.extend(latlng);
	createMarker_RT(latlng, "(상차지)"+data.sAddr+" "+data.sAddrDetail, markerImage);

	var markerImage = new daum.maps.MarkerImage("/images/icon/marker_e.png", new daum.maps.Size(24,40), null);
	var latlng = new kakao.maps.LatLng(eLat, eLon);
	bounds.extend(latlng);
	createMarker_RT(latlng, "(하차지)"+data.eAddr+" "+data.eAddrDetail, markerImage);
}

function getLocData(orderId){

alert(coordinates.length);

	coordinates = [];
	$.ajax({
		url: "/contents/order/data/orderLbsList.do",
		type: "POST",
		dataType: "json",
		data: "orderId=" + orderId,
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
}

function deleteMarkers() {
    for (var i = 0; i < markersArray.length; i++) {
    	markersArray[i].setMap(null);
    }
}


function simpleOrderData(){
	$.ajax({
		url: "/contents/order/data/omsOrderSummary.do",
		type: "POST",
		dataType: "json",
		data: {
			fromDate : $("#fromDate").val(),
			toDate : $("#toDate").val(),
			deptId : $("#deptId").val()
		},
		success: function(data){
			var	groupCount = ""
			groupCount = "<i class=\"btn_b\">접수 " + data.data.registerOrderCount + "건</i> " +
						 "<i class=\"btn_g\">배차 " + data.data.dispatchOrderCount + "건</i> " +
						 "<i class=\"btn_gray\">취소 " + data.data.cancelOrderCount + "건</i>" +
						 "<i style=\"color: #000000; display: inline; margin-left: 7px;\">입차 " + data.data.entranceOrderCount + "건</i>, " +
						 "<i style=\"color: #000000; display: inline;\">이동 " + data.data.moveOrderCount + "건</i>, " +
						 "<i style=\"color: #000000; display: inline;\">도착 " + data.data.arrivallOrderCount + "건</i>, " +
						 "<i style=\"color: #000000; display: inline;\">운송비 " + Util.nvl(Util.formatNumber(data.data.sumBuyCharge),'0') + "원</i>";
// 						 "<p style=\"color: #000000; display: inline;\">운송비 " + Util.nvl(Util.formatNumber(data.data.sumBuyCharge+data.data.sumAddCharge),'0') + "원</p>";
			$("#groupCount").html(groupCount);
		}
	});
}

$("#toDate, #fromDate").on("change", function(){
	$("#fFromDate").val($("#fromDate").val());
	$("#fToDate").val($("#toDate").val());
});

function startInterval() {
	refresh_timer = 31;
	autoRefresh = setInterval(function(){
		refresh_timer --;
		if(refresh_timer < 2) {
			refresh_timer = 31;
			goList();
		}
	}, 1000);
}

function stopInterval() {
	clearInterval(autoRefresh);
}

</script>
<style>
.grid-tr-14 {
  	font-size: 14px;
  	color: #73777E;
    text-overflow: ellipsis;
    overflow: hidden;
}

.grid-tr-18 {
  	font-size: 18px;
  	color: #73777E;
  	text-overflow: ellipsis;
  	overflow: hidden;
}

.k-grid-content table td{
  	text-align: left;
  	border-left: none;
   	box-shadow: none;
}

.k-grid-content.k-auto-scrollable {
    height: 795px;
}
</style>