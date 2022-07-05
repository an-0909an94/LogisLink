<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="header">
    <div class="summary p30">
        <div class="hdr-tit">
            <P id="headerTitle">거래처손익현황(년)</P>
        </div>
    </div>
    <div class="contents">
        <div id="group-list" class="cont-wrapper-page-grid">
            <form id="fSearch" class="date-bnt" method="post">
                <div class="input-group input-group-sm col-1 middle-name">
                    <strong>배차년</strong>
                    <input style="width: 100%; padding: 0px" id="searchYear" name="searchYear" data-role="datepicker" data-start="decade" data-depth="decade" data-format="yyyy" />
                    <input type="hidden" id="fromDate" name="fromDate">
                    <input type="hidden" id="toDate" name="toDate">
                </div>
                <div class="input-group input-group-sm col-1 middle-name div-min-col-1">
                    <strong>담당부서</strong>
                    <select class="form-control" class="custom-select col-12" id="s_dept" name="deptId">
                        <option>--부서명--</option>
                    </select>
                </div>
                <div class="input-group input-group-sm col-3 middle-name">
                    <strong>거래처명</strong>
                    <input type="hidden" id="sCustId" name="sCustId">
                    <input type="hidden" id="sDeptId" name="sDeptId">
                    <input type="text" id="sCustName" name="sCustName" style="width: 100%;">
                </div>
                <div class="input-group input-group-sm col-1 middle-name div-min-col-1" style="max-width: 90px; min-width: 90px;">
                    <strong> </strong>
                    <button onclick="goList()" type="button" style="border-radius: 4px" class="form-control form-control-sm middle-button-dark">
                        <i class="k-icon k-i-search"></i>검색
                    </button>
                </div>
                <div class="toolbar row">
                    <div class="tool_form col">
                        <div style="width: 80px; float: left; margin-top: 30px;">(단위:원)</div>
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
                <div id="grid" style="height: calc(100vh - 346px);"></div>
            </form>
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
		}, "deptId", "deptName", "${sessionScope.userInfo.deptId}", "--부서명--");

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

	function goList() {
		var colName, title, data;

		searchYear = $("#searchYear").val();

		$("#fromDate").val(searchYear + "-01-01");
		$("#toDate").val(searchYear + "-12-31");

		columns = [ {
			field : "custName",
			title : "거래처",
			width : 173.5,
			locked : true
		}, {
			field : "type",
			title : "구분",
			width : 100,
			locked : true
		}, {
			field : "colSum",
			title : "소계",
			width : 100,
			locked : true,
			attributes : {
				style : "text-align: right"
			}
		}, {
			field : "custId",
			title : "custId",
			locked : true,
			hidden : true
		}, {
			field : "deptId",
			title : "deptId",
			locked : true,
			hidden : true
		} ];

		for (var i = 1; i <= 12; i++) {
			var str = "0" + i.toString();
			str = str.substring(str.length, str.length - 2);
			colName = "col" + str;
			title = searchYear + "." + i.toString();
			data = {
				field : colName,
				title : title,
				width : 100,
				attributes : {
					style : "text-align: right"
				}
			};

			columns.push(data);
		}

		$("#grid").text("");
		$("#grid")
				.kendoGrid(
						{
							dataSource : {
								transport : {
									read : {
										url : "/contents/monitor/data/profitCustYear.do",
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
										var sellData = {};
										var buyData = {};
										var profData = {};
										var percData = {};
										var dataList = [];
										var sellSum = 0;
										var buySum = 0;
										var grid = $("#grid").data("kendoGrid");
										grid.bind("dataBound", grid_dataBound);
										for (var i = 0, item; item = response.cust[i]; i++) {
											sellData = {
												"custName" : item.custName,
												"type" : "매출",
												"custId" : item.custId,
												"deptId" : item.deptId
											};
											buyData = {
												"custName" : item.custName,
												"type" : "매입",
												"custId" : item.custId,
												"deptId" : item.deptId
											};
											profData = {
												"custName" : item.custName,
												"type" : "이익",
												"custId" : item.custId,
												"deptId" : item.deptId
											};
											percData = {
												"custName" : item.custName,
												"type" : "%",
												"custId" : item.custId,
												"deptId" : item.deptId
											};
											sellSum = 0;
											buySum = 0;

											for (var k = 0; k < 13; k++) {
												var str = "0" + k.toString();
												str = str.substring(str.length,
														str.length - 2);
												sellData["col" + str] = "0";
												buyData["col" + str] = "0";
												profData["col" + str] = "0";
												percData["col" + str] = "0.0%";
											}

											for (var j = 0, item2; item2 = response.data[j]; j++) {
												if (item.custId == item2.custId
														&& item.deptId == item2.deptId) {
													var month = item2.allocDate
															.substring(7, 5);
													sellData["col" + month] = Util
															.nvl(
																	Util
																			.formatNumber(item2.sellAmt),
																	"0");
													buyData["col" + month] = Util
															.nvl(
																	Util
																			.formatNumber(item2.buyAmt),
																	"0");
													profData["col" + month] = Util
															.nvl(
																	Util
																			.formatNumber(item2.sellAmt
																					- item2.buyAmt),
																	"0");
													var perData = 0;
													if (item2.sellAmt != item2.buyAmt
															&& item2.sellAmt != 0)
														perData = (item2.sellAmt - item2.buyAmt)
																/ item2.sellAmt
																* 100;
													percData["col" + month] = perData
															.toFixed(1)
															+ "%";
													sellSum += item2.sellAmt;
													buySum += item2.buyAmt;
												}
											}
											sellData["colSum"] = Util
													.nvl(
															Util
																	.formatNumber(sellSum),
															"0");
											buyData["colSum"] = Util.nvl(Util
													.formatNumber(buySum), "0");
											profData["colSum"] = Util.nvl(Util
													.formatNumber(sellSum
															- buySum), "0");
											if (sellSum != buySum
													&& sellSum != 0) {
												percData["colSum"] = (sellSum - buySum)
														/ sellSum * 100;
											} else {
												percData["colSum"] = 0
											}
											percData["colSum"] = percData["colSum"]
													.toFixed(1)
													+ "%";
											dataList.push(sellData);
											dataList.push(buyData);
											dataList.push(profData);
											dataList.push(percData);
										}

										return dataList;
									},

									total : function(response) {
										return response.total;
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
								fileName : headerTitle + "("
										+ new Date().yyyymmdd() + ").xlsx",
								proxyURL : "/cmm/saveGrid.do",
								filterable : false,
								allPages : true
							},
							excelExport : function(e) {
								if ($("#loading").length > 0)
									$("#loading").hide();
							},
							navigatable : true,
							selectable : false,
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

	function grid_dataBound(e) {
		var rows = e.sender.lockedTable[0].children[1].children
		var rows2 = e.sender.tbody.children();
		var cells;
		var gridCellClassName;
		for (var i = 0; i < rows.length; i++) {
			var row = $(rows[i]);
			var row2 = $(rows2[i]);
			cells = row.children().eq(0)
			cells.addClass(gridAddClass(cells.prevObject[3].innerText + "-"
					+ cells.prevObject[4].innerText));
			var dataItem = e.sender.dataItem(row);
			if (dataItem.type == "이익") {
				var cells = row2.children();
				cells.each(function(i) {
					if (cells.eq(i)[0].innerText < "0") {
						var lossRow = cells.eq(i);
						lossRow.addClass("loss")
					}
				})
				var lossSum = row.children().eq(2);
				if (lossSum[0].innerText < "0") {
					lossSum.addClass("loss");
				}
			}
		}
	}

	function gridAddClass(custName) {
		genCowspan(custName);
		return custName;
	}

	function genCowspan(className) {
		setTimeout(
				function() {
					$("." + className)
							.each(
									function() {
										var rows = $("." + className
												+ ":contains('"
												+ $(this).text() + "')");
										if (rows.length > 1) {
											$("." + className).parent("tr")
													.css({
														"border" : "solid"
													})
											rows.not(":eq(0)").remove();
											rows.eq(0).attr("rowspan",
													rows.length);
											$("." + className)
													.css(
															{
																"box-shadow" : "rgb(213 213 213) 1px 0px 0px 0px"
															});
										}
									});
				}, 10);
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