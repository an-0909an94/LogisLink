<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="header">
    <div class="summary p30">
        <div class="hdr-tit">
            <P id="headerTitle">배차운송현황(월)</P>
        </div>
    </div>
    <div class="contents">
        <div id="group-list" class="cont-wrapper-page-grid">
            <form id="fSearch" class="date-bnt" method="post">
                <input type="hidden" name="orderStates" id="orderStates">
                <div class="input-group input-group-sm col-1 middle-name">
                    <strong>오더접수월</strong>
                    <input style="width: 100%; padding: 0;" type="text" id="searchMonth" name="searchMonth">
                    <input type="hidden" id="fromDate" name="fromDate">
                    <input type="hidden" id="toDate" name="toDate">
                </div>
                <div class="input-group input-group-sm col-1 middle-name div-min-col-1">
                    <strong>담당부서</strong>
                    <select class="form-control" class="custom-select col-12" id="s_dept" name="deptId">
                        <option>--부서명--</option>
                    </select>
                </div>
                <div class="input-group input-group-sm col-1 middle-name div-min-col-1">
                    <strong>배차담당자</strong>
                    <select class="form-control" class="custom-select col-12" id="userId" name="userId">
                        <option>--담당자명--</option>
                    </select>
                </div>
                <div class="input-group input-group-sm col radio-or-checkBox">
                    <input type="checkbox" name="orderState" id="orderState05" value="05" />
                    <label for="orderState05" class="label-margin">
                        <span>도착</span>
                    </label>
                </div>
                <div class="input-group input-group-sm col radio-or-checkBox">
                    <input type="checkbox" name="orderState" id="orderState01" value="01" />
                    <label for="orderState01" class="label-margin">
                        <span>진행</span>
                    </label>
                </div>
                <div class="input-group input-group-sm col radio-or-checkBox">
                    <input type="checkbox" name="orderState" id="orderState00" value="00" />
                    <label for="orderState00" class="label-margin">
                        <span>접수</span>
                    </label>
                </div>
                <div class="input-group input-group-sm col radio-or-checkBox">
                    <input type="checkbox" name="orderState" id="orderState09" value="09" />
                    <label for="orderState09" class="label-margin">
                        <span>취소</span>
                    </label>
                </div>
                <div class="input-group input-group-sm col-1 middle-name div-min-col-1" style="max-width: 90px; min-width: 90px;">
                    <strong> </strong>
                    <button onclick="goList()" type="button" style="border-radius: 4px" class="form-control form-control-sm middle-button-dark">
                        <i class="k-icon k-i-search"></i>검색
                    </button>
                </div>
                <div class="toolbar row">
                    <div class="tool_form col">
                        <div style="width: 80px; float: left; margin-top: 30px;">(단위:건)</div>
                        <div class="btn-row">
                            <div class="tool_group">
                                <div class="padding">
                                    <a href="#" class="k-pager-refresh k-button" onClick="goExcel();">
                                        <b class="btn-x"><i class="k-icon k-i-file-excel"></i>엑셀출력</b>
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- /toolbar -->
                <div id="grid" style="height: calc(100vh - 346px)"></div>
            </form>
        </div>
    </div>
</div>

<script type="text/javascript">
// 22.07.04 이건욱 모니터링 > 배차운송 (월) 조회조건 변경 (배차 담당자 외 제외)
$(document).ready(function() {
	var custId = '${custId}';
	var deptId = '${deptId}';
	
	$("#searchMonth").kendoDatePicker({
		start: "year",
		depth: "year",
		format: "yyyy-MM",
		dateInput: true,
	});
	
	var monthPicker = $("#searchMonth").data("kendoDatePicker");
	monthPicker.value(new Date().yyyymm());
	
	/*
	 * 22.07.04 이건욱 모니터링 > 하위 모든 메뉴에서 로그인한 사용자의 권한에 따라 조회 조건 변경 반영해야 함.
	 */
	var sDeptParam = {
		custId: custId,
		deptId: deptId,
		useYn: 'Y'
	}
	Util.setSelectBox("/contents/basic/data/compDeptList.do", "s_dept", sDeptParam, "deptId", "deptName", deptId, "--부서명--");
	
	var sUserParam = {
		deptId: deptId
	}
	Util.setSelectBox("/contents/basic/data/userNameList.do", "userId", sUserParam, "userId", "userName", "", "--담당자명--");
	
	goList();
});

function goList() {
	var searchMonth = $("#searchMonth").val();
	var year = searchMonth.split("-")[0];
	var month = searchMonth.split("-")[1];
	var toDate = new Date(year, month, 0).yyyymmdd();

	var lastDay = toDate.split("-")[2];

	$("#fromDate").val(searchMonth + "-01");
	$("#toDate").val(toDate);

	var stateCategory = "";
	var orderState = "";
	$("#fSearch input[name=orderState]").each(function() {
		if ($(this).is(":checked")) {
			var value = $(this).val();
			orderState += value + ",";
			if (value == "05")
				stateCategory += "도착,";
			else if (value == "01")
				stateCategory += "진행,";
			else if (value == "00")
				stateCategory += "접수,";
			else
				stateCategory += "취소,";
		}
	});

	if (orderState != "") {
		stateCategory = "전체," + stateCategory;
		stateCategory += "입력지연";
		orderState = orderState.substring(0, orderState.length - 1);
	} else {
		stateCategory = "전체,도착,진행,접수,취소,입력지연";
	}
	$("#orderStates").val(orderState);
	
	var columns = [
		{ field: "type", title: "구분", width: 113, locked: true },
		{ field : "deptName", title : "부서", width : 80, locked : true },
		{ field : "userName", title : "담당자", width : 80, locked : true },
		{ field : "colSum", title : "소계", width : 100, locked : true,
			template : function(dataItem) {
				if (dataItem.colSum == "") {
					return "0";
				} else {
					return Util.formatNumber(dataItem.colSum);
				}
			}
		},
		{ field : "deptId", locked : true, hidden : true },
		{ field : "orderState",	locked : true, hidden : true }
	];

	for (var i = 1; i <= lastDay; i++) {
		var str = "0" + i.toString();
		var month = searchMonth.substring(5, 8);
		if (month.indexOf("0") == 0)
			month = month.substring(1, 2);
		str = str.substring(str.length, str.length - 2);
		
		var colName = "col" + str;
		var title = month + "." + i.toString();
		var data = {
			field : colName,
			title : title,
			width : 100
		};

		columns.push(data);
	}
	
	$("#grid").text("");
	$("#grid").kendoGrid({
		dataSource: {
			transport : {
				read : {
					url : "/contents/monitor/data/orderMonthly.do",
					type : "post",
					dataType : "json",
					data : $("#fSearch").serializeObject(),
					beforeSend : function(req) {
						req.setRequestHeader("AJAX", true);
					}
				}
			},
			schema : {
				data : function(response) {
					var data = {};
					var sumData = {};
					var totalList = [];
					var finishList = [];
					var allocList = [];
					var receiptList = [];
					var cancelList = [];
					var delayList = [];
					var dataList = [];
					var stateArr = stateCategory.split(",");
					var countSum = 0;
					var grid = $("#grid").data("kendoGrid");
					grid.bind("dataBound", gridDataBound);
					for (var h = 0; h < stateArr.length; h++) {
						for (var i = 0, item; item = response.user[i]; i++) {
							data = {
								"deptName" : item.deptName,
								"deptId" : item.deptId,
								"userName" : item.userName,
								"type" : stateArr[h],
								"orderState" : stateArr[h],
								"colSum" : "0"
							};
							countSum = 0;

							for (var k = 0; k < 32; k++) {
								var str = "0" + k.toString();
								str = str.substring(str.length, str.length - 2);
								data["col" + str] = "0";
							}

							for (var j = 0, item2; item2 = response.data[j]; j++) {
								if (item.userId == item2.userId && stateArr[h] == item2.orderState) {
									var day = item2.regDate.substring(10, 8);
									data["col" + day] = item2.orderCount;
									countSum += item2.orderCount;
								}
							}
							data["colSum"] = countSum;
							if (data["type"] == "전체")
								totalList.push(data);
							if (data["type"] == "도착")
								finishList.push(data);
							if (data["type"] == "진행")
								allocList.push(data);
							if (data["type"] == "접수")
								receiptList.push(data);
							if (data["type"] == "취소")
								cancelList.push(data);
							if (data["type"] == "입력지연")
								delayList.push(data);
						}

						sumData = {
							"deptName" : "합계",
							"userName" : "합계",
							"type" : stateArr[h],
							"orderState" : stateArr[h],
							"deptId" : "sum"
						}
						for (var k = 0; k < 32; k++) {
							var str = "0" + k.toString();
							str = str.substring(str.length, str.length - 2);
							sumData["col" + str] = "0";
						}
						countSum = 0;
						//상태별 합계 LIST 
						for (var i = 0, item; item = response.total[i]; i++) {
							var orderState = "";
							if (stateArr[h] == "전체")
								orderState = "100"
							if (stateArr[h] == "도착")
								orderState = "05"
							if (stateArr[h] == "진행")
								orderState = "01"
							if (stateArr[h] == "접수")
								orderState = "00"
							if (stateArr[h] == "취소")
								orderState = "09"
							if (stateArr[h] == "입력지연")
								orderState = "99"
							if (orderState == item.orderState) {
								var day = item.regDate.substring(10, 8);
								sumData["col" + day] = item.orderCount;
								countSum += item.orderCount;
							}
						}

						sumData["colSum"] = countSum;
						if (sumData["type"] == "전체") {
							totalList.unshift(sumData);
						}
						if (sumData["type"] == "도착") {
							finishList.unshift(sumData);
						}
						if (sumData["type"] == "진행") {
							allocList.unshift(sumData);
						}
						if (sumData["type"] == "접수") {
							receiptList.unshift(sumData);
						}
						if (sumData["type"] == "취소") {
							cancelList.unshift(sumData);
						}
						if (sumData["type"] == "입력지연") {
							delayList.unshift(sumData);
						}
					}
					
					dataList = totalList
								.concat(finishList)
								.concat(allocList)
								.concat(receiptList)
								.concat(cancelList)
								.concat(delayList);

					return dataList;
				}
			},
			serverPaging : false,
			serverFiltering : true,
			error : function(e) {
				if (e.xhr.status == "400") {
					alert("세션값이 존재하지 않습니다. 로그인 페이지로 이동합니다.");
					location.href = "/";
				}
			}
		},
		excel : {
			fileName : headerTitle + "(" + new Date().yyyymmdd() + ").xlsx",
			proxyURL : "/cmm/saveGrid.do",
			filterable : false,
			allPages : true
		},
		excelExport : function(e) {
			if ($("#loading").length > 0)
				$("#loading").hide();
		},
		navigatable : true,
		selectable : true,
		sortable : true,
		pageable : false,
		resizable : true,
		scrollable : true,
		editable : false,
		columns : columns,
		noRecords : true,
		messages : {
			noRecords : "조회된 데이터가 없습니다."
		}
	});
}

function gridDataBound(e) {
	var rows = e.sender.lockedTable[0].children[1].children
	var cells;
	var gridCellClassName;
	for (var i = 0; i < rows.length; i++) {
		var row = $(rows[i]);
		orderStateCells = row.children().eq(0)
		deptIdCells = row.children().eq(1)
		userNameCells = row.children().eq(2)
		if (userNameCells[0].innerText == '합계') {
			userNameCells.addClass(gridAddClass(userNameCells.prevObject[5].innerText + "-" + userNameCells.prevObject[4].innerText, 'colspan'));
		}
		orderStateCells.addClass(gridAddClass(orderStateCells.prevObject[5].innerText, "orderState"));
		deptIdCells.addClass(gridAddClass(deptIdCells.prevObject[5].innerText + "-" + deptIdCells.prevObject[4].innerText, "deptId"));
	}
}

function gridAddClass(className, mode) {
	if (mode != 'colspan') {
		rowSpan(className)
		return className;
	} else {
		colSpan(className)
		return className;
	}
}

function rowSpan(className) {
	setTimeout(function() {
		$("." + className).each(function() {
			var rows = $("." + className + ":contains('" + $(this).text() + "')");
			if (rows.length > 1) {
				$("." + className).parent("tr").css({
					"border" : "solid"
				});
				rows.not(":eq(0)").remove();
				rows.eq(0).attr("rowspan", rows.length);
				$("." + className).css({
					"box-shadow" : "rgb(213 213 213) 1px 0px 0px 0px"
				});
			}
		});
	}, 10);
}

function colSpan(className) {
	setTimeout(function() {
		$("." + className).each(function() {
			var rows = $("." + className + ":contains('" + $(this).text() + "')");
			if (rows.length > 1) {
				rows.not(":eq(0)").remove();
				rows.eq(0).attr("colspan", rows.length);
			}
		});
	}, 10);
}

function changeSearchCust(e) {
	var dataItem = e.dataItem;
	$("#custId").val(dataItem.custId);
}

function goExcel() {
	$("#loading").show();
	var grid = $("#grid").data("kendoGrid");
	grid.saveAsExcel();
}

// 22.07.04 이건욱 모니터링 > 배차운송 (월) 조회조건 변경 (배차 담당자 외 제외)
$("#s_dept").on("change", function(){
	Util.setSelectBox("/contents/basic/data/userNameList.do", "userId", { deptId: $(this).val() }, "userId", "userName", "", "--담당자명--");
});
</script>
<style>
.k-grid tr {
	pointer-events: none;
}

.k-grid-content-locked table tbody tr td {
	text-align: center;
	border-bottom: solid 1px #dbddde;
}
</style>