<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;300;400;500;700;900&amp;display=swap" rel="stylesheet">
<style>
body { 
	font-family: 'Noto Sans KR', sans-serif;
	font-weight: bold;
	margin: 0;
	font-size: 1rem;
	line-height: 1.5;
	color: #212529;
	text-align: left;
	background-color: #fff;
}
</style>

<div id="group-list" class="cont-wrapper-page-grid">
	<form id="fSearch" class="date-bnt">
		<input type="hidden" name="custId" id="custId" class="hiddenValue">
		<input type="hidden" name="maxSize" id="maxSize" class="hiddenValue">
	<div class="form-group row p30">
		<div class="input-group input-group-sm col-1 middle-name">
		<span>기간</span>
		    <select class="custom-select col-12" id="selDate" name="selDate">
		        <option value="DAY">일별</option>
		        <option value="WEEK">주간별</option>
		        <option value="MONTH">월별</option>
		        <option value="YEAR">연별</option>
		        <option value="AT">기간지정</option>
		    </select>
		</div>
		<div class="input-group input-group-sm col-3 middle-name">
		<span>　</span>
		    <input style="padding: 0;" type="text" id="fromDate" name="fromDate" class="col-12" disabled="disabled">
		</div>
		<span style="margin-top: 31px;">~</span>
		<div class="input-group input-group-sm col-3 middle-name">
		<span>　</span>
		    <input style="padding: 0;" type="text" id="toDate" name="toDate" class="col-12" disabled="disabled">
		</div>

		<div class="input-group input-group-sm col-4 middle-name"></div>
		
		<div class="input-group input-group-sm col-1 middle-name">
		<span>고객사</span>
		    <select class="custom-select col-12" id="selCust" name="selCust">
		        <option value="custAll">내조직</option>
		        <option value="cust">고객사</option>
		    </select>
		</div>
		<div class="input-group input-group-sm col-3 middle-name">
		<span>　</span>
		    <input type="text" id="sCustName" name="sCustName" style="width:100%;">
		</div>
              
              <div style="padding: 1em;" class="input-group input-group-sm col-1"></div>
		<div class="input-group input-group-sm col-1 middle-name">
		<span>　</span>
		    <button onclick="getSearch();" type="button" class="form-control form-control-sm middle-button"><i class="k-icon k-i-check"></i>검색</button>
		</div>
		<div class="input-group input-group-sm col-1 middle-name">
		<span>　</span>
		    <button onclick="formReset()"  type="button" class="form-control form-control-sm middle-button"><i class="k-icon k-i-check"></i>초기화</button>
		</div>
	</div>
	</form>                
	<!--  -->
	<div class="cont-body">
		<!-- f-wrap -->
		<div class="k-wrap content">
			<div class="lookup_table">
				<div class="k-content wide">
			        <div id="chart"></div>
			    </div>
				<div style="min-width: 500px;">
					<div style="height: 210px;" id="grid"></div>
					<!-- /table -->
				</div>
			</div>
		</div>
	</div>
	<!--  -->
</div>
<!-- group-list -->
<script type="text/javascript">
var MIN_SIZE = 10;
var SORT = {
    field: "date",
    dir: "asc"
}
var data = [];
var DRAG_THR = 50;
var viewStart = 0;
var viewSize = MIN_SIZE;
var newStart;
var searchCustName = null;

//Drag handler
function onDrag(e) {
    var chart = e.sender;
    var ds = chart.dataSource;
    var delta = Math.round(e.originalEvent.x.initialDelta / DRAG_THR);

    if (delta != 0) {
    newStart = Math.max(0, viewStart - delta);
    newStart = Math.min(data.length - viewSize, newStart);
    ds.query({
        skip: newStart,
        page: 0,
        pageSize: viewSize,
        sort: SORT
    });
    }
}

function onDragEnd() {
    viewStart = newStart;
}

// Zoom handler
function onZoom(e) {
	if($("#maxSize").val() > 20){
		var MAX_SIZE = 20	
	}else{
		var MAX_SIZE = $("#maxSize").val();
	}
    var chart = e.sender;
    var ds = chart.dataSource;
    viewSize = Math.min(Math.max(viewSize + e.delta, MIN_SIZE), MAX_SIZE);
    ds.query({
        skip: viewStart,
        page: 0,
        pageSize: viewSize,
        sort: SORT
    });

    // Prevent document scrolling
    e.originalEvent.preventDefault();
}

var oGrid = null;	
oGrid = new gridData("grid");
oGrid.initGrid();
oGrid.setSendUrl("/contents/statistics/data/statArrivalGrid.do");

$(document).ready(function(){

	searchCustName = MultiColumnComboBox.setCustName("s");
	searchCustName.bind("select", changeSearchCust);
	searchCustName.bind("change", searchCustSelectTrigger);
	searchCustName.enable(false);
	$("#selCust").on("change", function(){
		searchCustName.value("");
		searchCustName.refresh();
		$(".hiddenValue").val("");
		var sel = $(this).val();
		if(sel == "custAll") {	
			searchCustName.enable(false);
		} else {
			searchCustName.enable(true);
			searchCustName.bind("select", changeSearchCust);
			searchCustName.bind("change", searchCustSelectTrigger);
		}
	}); 
	
	$("#fromDate").kendoDatePicker({format:"yyyy-MM-dd"});
	$("#toDate").kendoDatePicker({format:"yyyy-MM-dd"});
	
	$("#selDate").on("change", function(){
		var sel = $(this).val();
		var fromDate = $("#fromDate").data("kendoDatePicker");
		var toDate = $("#toDate").data("kendoDatePicker");
		
		if(sel == 'AT') {
			fromDate.enable(true);
			toDate.enable(true);
		} else {
			fromDate.enable(false);
			toDate.enable(false);
			fromDate.value("");
			toDate.value("");
		}
	});
	
	function preventPost(e) {
    	if (e.keyCode === 13) {
    		getSearch();
    	}
    }
	searchCustName.input.keydown(preventPost);
	
	//getSearch();
});

$(document).bind("kendo:skinChange", createChart);

var columns = [
	{ field: "number", title: "No", width: 50 },
	{ field: "custName", title: "조직", width: 100 },
	{ field: "qTime", title: "기간", width: 70,
		template: function(dataItem) {
			if(dataItem.qBy == 'DAY'){
				return Util.formatDate(dataItem.qTime);
			}else if(dataItem.qBy == 'WEEK'){
				return (dataItem.year+"년 "+dataItem.qTime+"주")
			}else if(dataItem.qBy == 'MONTH'){
				return (dataItem.year+"년 "+dataItem.qTime+"월")
			}else if(dataItem.qBy == 'YEAR'){
				return (dataItem.qTime+"년 ")
			}
		} 
	},
	{ field: "carNum", title: "차량번호", width: 70 },
	{ field: "cnt", title: "배차횟수", width: 70 },
	{ field: "overTime", title: "2시간초과소요", width: 70 },
	{ field: "rate", title: "도착준수율", width: 70 }
];

function goList(param) {
	var grid = $("#grid").data("kendoGrid");
	
	oGrid.setSearchData(param);
	if(grid == null) {
		oGrid.setGrid(columns);
		grid = $("#grid").data("kendoGrid");
	} else {
		grid.setDataSource(oGrid.gridOption.dataSource);
	}
}

function changeSearchCust(e) {
	var dataItem = e.dataItem;
	if(dataItem != null) {
		$("#custId").val(dataItem.custId);
	}else{
		if(e.sender.selectedIndex != -1){
			searchCustName.select(e.sender.selectedIndex);
			var data = e.sender.listView._view[e.sender.selectedIndex];
			$("#custId").val(data.item.custId);
		}
	}
}

function searchCustSelectTrigger(e){
	if(this.value() != ""){
		searchCustName.trigger("select");
	}else{
		$("#custId").val("");
	}
}

function createChart(param) {
    $("#chart").kendoChart({
    	dataSource: {
            transport: {
                read: {
                    url: "/contents/statistics/data/statArrival.do",
                    type : "post",
                    dataType: "json",
                    data : param,
                    beforeSend: function(req) {
						req.setRequestHeader("AJAX", true);
					}
                }
            },
            schema : {
				data : function(response) {
					data = [];
					for (var i = 0; i < response.data.length; i++) {
			        	data.push({
				            category: response.data[i].carNum,
				            val: response.data[i].rate
			        	});
			        }
					$("#maxSize").val(response.data.length);
					return response.data;
				}
			},
            pageSize: viewSize,
            page: 0
        },
        title: {
            text: "배차대수 통계 (" + moment(param.fromDate).format('YYYY-MM-DD') + " ~ " + moment(param.toDate).format('YYYY-MM-DD') + ")"
            
        },
        legend: {
            position: "bottom"
        },
        seriesDefaults: {
            type: "bar"
        },
        series: [{
            field: "rate",
            categoryField: "carNum",
            name: "도착준수율",
            type: "column"
        }],
        transitions: false,
        drag: onDrag,
        dragEnd: onDragEnd,
        zoom: onZoom,
        valueAxis: {
            labels: {
                format: "N0"
            },
            line: {
                visible: false
            },
            axisCrossingValue: -10
        },
        categoryAxis: {
            labels: {
                rotation: "auto"
            },
            crosshair: {
                visible: true
            }
        },
        tooltip: {
            visible: true,
            shared: true,
            format: "N0"
        }
    });
}

function getSearch() {
	var fromYear = "";
	var fromDate = "";
	var toYear = "";
	var toDate = "";
	var from = "";
	var to = "";
	var qBy = $("#selDate").val();
	
	switch($("#selDate").val()) {
	case "DAY":
		from = moment().subtract(1, "month");
		to = moment();
		fromDate = from.format("YYYYMMDD");
		toDate = to.format("YYYYMMDD");
		fromYear = from.year();
		toYear = to.year();
		break; 
	case "WEEK":
		from = moment().subtract(16, "week");
		to = moment();
		fromDate = from.weeks();
		toDate = to.weeks();
		fromYear = from.year();
		toYear = to.year();
		break;
	case "MONTH":
		from = moment().subtract(12, "month");
		to = moment();
		fromDate = from.format("YYYY-M");
		toDate = to.format("YYYY-M");
		fromYear = from.year();
		toYear = to.year();
		break;
	case "YEAR":
		from = moment().subtract(10, "year");
		to = moment();
		fromDate = from.year();
		toDate = to.year();
		fromYear = from.year();
		toYear = to.year();
		break;
	case "AT":
		from = moment($("#fromDate").val());
		to = moment($("#toDate").val());
		fromDate = from.format("YYYYMMDD");
		toDate = to.format("YYYYMMDD");
		fromYear = from.year();
		toYear = to.year();
		break;
	}
	
	if(qBy == "AT") {
		qBy = "DAY";
		var tempTo = moment($("#toDate").val()).subtract(1, "month").subtract(1, "day").format("YYYY-MM-DD");
		if(!moment(from.format("YYYY-MM-DD")).isBetween(tempTo, to.format("YYYY-MM-DD"))) {
			alert("한달 내 데이터만 조회 가능합니다.");
			return;
		}
	}
	
	var param = {
    	qBy: qBy,
    	fromDate: fromDate,
    	toDate: toDate,
    	fromYear: fromYear,
    	toYear: toYear,
    	custId: $("#custId").val()
    };
	
	createChart(param);
	goList(param);
}

function formReset(){
	var fromDate = $("#fromDate").data("kendoDatePicker");
	var toDate = $("#toDate").data("kendoDatePicker");
	searchCustName.enable(false);
	fromDate.enable(false);
	toDate.enable(false);
	fromDate.value("");
	toDate.value("");
	$("#fSearch")[0].reset();
}
</script>