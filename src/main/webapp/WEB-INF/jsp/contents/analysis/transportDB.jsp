<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="header">
    <div class="summary p30">
        <div class="hdr-tit">
            <P id="headerTitle">운송DB(user)</P>
        </div>
    </div>
    <div class="contents">
        <div id="group-list" class="cont-wrapper-page-grid">
            <form id="fSearch" class="date-bnt" method="post">
                <div class="row mt0" style="justify-content: space-between">
                    <div class="row">
                        <div class="input-group input-group-sm wd90 middle-name div-min-col-1">
                            <input style="width: 100%; padding: 0px" id="searchYear" name="searchYear" data-role="datepicker" data-start="decade" data-depth="decade" data-format="yyyy" />
                            <input type="hidden" id="fromDate" name="fromDate">
                            <input type="hidden" id="toDate" name="toDate">
                        </div>
                        <div class="input-group input-group-sm wd90 middle-name div-min-col-1">
                            <select class="form-control" class="custom-select wd90" id="s_dept" name="deptId">
                                <option>부서명</option>
                            </select>
                        </div>
                        <div class="input-group input-group-sm wd290 media290 middle-name div-min-col-1">
                            <input type="hidden" id="sCustId" name="sCustId">
                            <input type="hidden" id="sDeptId" name="sDeptId">
                            <input type="text" id="sCustName" name="sCustName" style="width: 100%;" placeholder="거래처명" class="p-input">
                        </div>
                    </div>
                    <div class="row">
                        <div class="input-group input-group-sm middle-name">
                            <button onclick="goList()" type="button" class="form-control-sm btn_58 btn_b">검색</button>
                        </div>
                    </div>
                </div>
            </form>
            <div class="cont-body">
                <!-- f-wrap -->
                <div class="k-wrap content">
                    <div class="lookup_table">
                        <div class="toolbar row">
                            <div class="tool_form col">
                                <div style="width: 80px; float: left; margin-top: 30px;">(단위:원)</div>
                                <div class="btn-row">
                                    <div class="tool_group">
                                        <div class="padding">
                                            <a href="#" class="k-pager-refresh k-button wd100" onClick="goExcel();"><b class="btn-x">엑셀출력</b></a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- /toolbar -->
                        <div id="grid" style="height: calc(100vh - 346px);"></div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript">
	var headerTitle = ($("#headerTitle").text());
	var columns;
	var searchYear = "";

	$(document).ready(function() {

		Util.setSelectBox("/contents/basic/data/compDeptList.do", "s_dept", {
			custId : '${custId}',
			deptId : '${sessionScope.userInfo.deptId}',
			useYn : 'Y'
		}, "deptId", "deptName", "${sessionScope.userInfo.deptId}", "부서명");

		searchCustName = MultiColumnComboBox.setCustName("s");
		searchCustName.bind("select", changeSearchCust);
		searchCustName.bind("change", searchCustSelectTrigger);
		searchCustName.bind("dataBound", function() {
			$("#sCustId").val("");
			$("#sDeptId").val("");
		});

		$("#searchYear").kendoDatePicker({
			start : "decade",
			depth : "decade",
			format : "yyyy",
			dateInput : true
		});

		var now = new Date(); // 현재 날짜 및 시간
		var sYear = now.getFullYear();
		var searchYear = $("#searchYear").data("kendoDatePicker");
		searchYear.value(String(sYear));

		function preventPost(e) {
			if (e.keyCode === 13) {
				goList();
			}
		}
		searchCustName.input.keydown(preventPost);

		goList();
	});
	
	var oGrid = null;   
	oGrid = new gridData("grid");
	oGrid.initGrid();
	oGrid.setSendUrl("/contents/analysis/data/transportDB.do");
	oGrid.setSelectable(true);
	oGrid.setExcelFile(headerTitle+"(" + new Date().yyyymmdd() + ").xlsx");

	function goList() {
		var colName = "";
		var titleNm = "";
		var data = "";
        console.log("jsson1:"+data)

	    searchYear = $("#searchYear").val();

	    var columns = [
	        { field: "bizName", title: "거래처", width: 150 },
	        { field: "BIZ_TOTAL", title: "거래처(거래건)", width: 90, attributes : {style : "text-align: right"}, template: "#=Util.formatNumber(BIZ_TOTAL)#" },
	        { field: "deptName", title: "부서", width: 100 },
	        { field: "TOTAL_CNT", title: "부서(거래건)", width: 80, attributes : {style : "text-align: right"}, template: "#=Util.formatNumber(TOTAL_CNT)#" },
	        { field: "PRE_CNT", title: "이전", width: 90, attributes : {style : "text-align: right"}, template: "#=Util.formatNumber(PRE_CNT)#" },
	        { field: "YY_CNT", title: "올해", width: 80, attributes : {style : "text-align: right"}, template: "#=Util.formatNumber(YY_CNT)#" },
	    ];
	    
	    for (var i = 1; i <= 12; i++) {
	        var str = "0" + i.toString();
	        str = str.substring(str.length, str.length - 2);
	        colName = "CNT_" + str;
	        titleNm = searchYear + "." + i.toString();
            console.log("jsson:"+titleNm);
	        data = {
	            field : colName,
	            title : titleNm,
	            width : 70,
	            attributes : {
	                style : "text-align: right"
	            },
	            template: "#=Util.formatNumber("+colName+")#"
	        };
            console.log("jsson2:"+data.title)
	        columns.push(data);
	    }
	    var grid = $("#grid").data("kendoGrid");
	    
	    oGrid.setSearchData($("#fSearch").serializeObject());
	    if(grid == null) {
	        oGrid.setGrid(columns);
	        grid = $("#grid").data("kendoGrid");
            console.log("jssona:");
	    } else {
            console.log("jssonb:");
            //oGrid.setGrid(columns);
            grid.setOptions({
                columns: columns
            });
	        grid.setDataSource(oGrid.gridOption.dataSource);
        }
	}	

	function changeSearchCust(e) {
		var dataItem = e.dataItem;
		if (dataItem != null) {
			$("#sCustId").val(dataItem.custId);
			$("#sDeptId").val(dataItem.deptId);
		} else {
			if (e.sender.selectedIndex != -1) {
				searchCustName.select(e.sender.selectedIndex);
				var data = e.sender.listView._view[e.sender.selectedIndex];
				$("#sCustId").val(data.item.custId);
				$("#sDeptId").val(data.item.deptId);
			}
		}
	}

	function searchCustSelectTrigger(e) {
		if (this.value() != "") {
			searchCustName.trigger("select");
		} else {
			$("#sCustId").val("");
			$("#sDeptId").val("");
		}
	}
	
	function goExcel() {
		$("#loading").show();
		var grid = $("#grid").data("kendoGrid");
		grid.saveAsExcel();
	}
</script>
<style>
.k-grid tr {
	pointer-events: none;
}

.k-grid-content-locked table tbody tr td {
	text-align: center;
	border-bottom: solid 1px #dbddde;
}

.loss {
	color: #ff0000 !important;
}
</style>