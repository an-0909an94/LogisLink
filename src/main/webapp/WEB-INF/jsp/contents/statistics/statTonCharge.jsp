<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="header">
	<div class="summary p30">
		<div class="hdr-tit">
			<P id="headerTitle">톤당 운송비 통계</P>
		</div>
	</div>
	<div class="contents">
		<div id="group-list" class="cont-wrapper-page-grid">
			<form id="fSearch" class="date-bnt">
				<input type="hidden" name="custId" id="custId" class="hiddenValue">
				<input type="hidden" name="maxSize" id="maxSize" class="hiddenValue">
				<div class="form-group row mt0">
					<div class="input-group input-group-sm wd90 middle-name div-min-col-1">
						<select class="custom-select wd90" id="selDate" name="selDate">
							<option value="DAY">일별</option>
							<option value="WEEK">주간별</option>
							<option value="MONTH">월별</option>
							<option value="YEAR">연별</option>
							<option value="AT">기간지정</option>
						</select>
					</div>
					<div class="input-group input-group-sm wd290 middle-name div-min-col-1">
						<input style="padding: 0;" type="text" id="fromDate" name="fromDate"
							   class="wd290" disabled="disabled">
					</div>
					<span style="margin-right: 10px">~</span>
					<div class="input-group input-group-sm wd290 middle-name div-min-col-1">
						<input style="padding: 0;" type="text" id="toDate" name="toDate"
							   class="wd290" disabled="disabled">
					</div>
				</div>
				<div class="form-group row" style="justify-content: space-between">
					<div>
						<div class="input-group input-group-sm wd90 middle-name div-min-col-1">
							<select class="custom-select wd90" id="selTon" name="selTon">
							</select>
						</div>
						<c:if test="${authChk}">
							<div class="input-group input-group-sm wd90 middle-name div-min-col-1">
								<select class="custom-select wd90" id="selCust" name="selCust">
									<option value="custAll">내조직</option>
									<option value="cust">고객사</option>
								</select>
							</div>
							<div class="input-group input-group-sm wd290 middle-name div-min-col-1">
								<input type="text" id="sCustName" name="sCustName" style="width:100%;">
							</div>
						</c:if>
					</div>

					<div class="row">
						<div class="input-group-sm middle-name mr10">
							<button onclick="getSearch();" type="button" class="form-control-sm middle-button btn_58 btn_b">검색</button>
						</div>
						<div class="input-group-sm middle-name">
							<button onclick="formReset();" type="button" class="form-control-sm middle-button btn_58 btn_black">초기화</button>
						</div>
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
							<!--
							<div style="height:calc(100vh - 741px);" id="grid"></div>
							-->
							<div style="height:246px" id="grid"></div>
							<!-- /table -->
						</div>
					</div>
				</div>
			</div>
			<!--  -->
		</div>
		<!-- group-list -->
	</div>
</div>
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
    var ds = e.sender.dataSource;
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

var headerTitle = ($("#headerTitle").text());
var oGrid = null;	
oGrid = new gridData("grid");
oGrid.initGrid();
oGrid.setSendUrl("/contents/statistics/data/statTonChargeGrid.do");

$(document).ready(function(){
	Util.setCmmCode("select", "selTon", "CAR_TON_CD", "", "전체");

	if("${authChk}" == "true") {
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
	}	
	
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
	if("${authChk}" == "true") {
		searchCustName.input.keydown(preventPost);
	}
	getSearch();
});

$(document).bind("kendo:skinChange", createChart);

var columns = [
	{ field: "number", title: "No", width: 50 },
	{ field: "custName", title: "조직", width: 100 },
	{ field: "tonCode", title: "톤급", width: 100 },
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
	{ field: "cnt", title: "배차대수", width: 70 },
	{ field: "tonCharge", title: "운송비", width: 70,
		template: function(dataItem) {
			return Util.formatNumber(dataItem.tonCharge);
		},
		attributes: { 
			style: "text-align: right" 
		}
	}
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
                    url: "/contents/statistics/data/statTonCharge.do",
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
				            category: response.data[i].date,
				            val: response.data[i].tonCharge
			        	});
			        }
					$("#maxSize").val(response.data.length);
					return response.data;
				}
			},
            pageSize: viewSize,
            page: 0,
            sort: SORT
        },
        title: {
            text: "톤당 운송비"
        },
        legend: {
            position: "bottom"
        },
        seriesDefaults: {
            type: "area",
            area: {
                line: {
                    style: "smooth"
                }
            }
        },
        series: [{
            field: "tonCharge",
            categoryField: "date",
            name: "운송비",
           	format: "N0",
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
            format: "N0",
           	template: "#= Util.formatNumber(value) #원"
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
    	tonCode: $("#selTon").val(),
    	custId: $("#custId").val()
    };
	
	createChart(param);
	goList(param)
}

function formReset(){
	if("${authChk}" == "true") {
		searchCustName.enable(false);
	}
	var fromDate = $("#fromDate").data("kendoDatePicker");
	var toDate = $("#toDate").data("kendoDatePicker");
	fromDate.enable(false);
	toDate.enable(false);
	fromDate.value("");
	toDate.value("");
	$("#fSearch")[0].reset();
}
</script>