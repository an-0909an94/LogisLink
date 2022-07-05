<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="header">
    <div class="summary p30">
        <div class="hdr-tit">
            <P id="headerTitle">부서별손익현황(년)</P>
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
                <div id="grid" style="height: calc(100vh - 346px)"></div>
            </form>
        </div>
    </div>
</div>

<script type="text/javascript">
	var headerTitle = ($("#headerTitle").text());
	var searchYear = "";
	var columns;

	$(document).ready(
			function() {

				Util.setSelectBox("/contents/basic/data/compDeptList.do",
						"s_dept", {
							custId : '${custId}',
							deptId : '${sessionScope.userInfo.deptId}',
							useYn : 'Y'
						}, "deptId", "deptName",
						"${sessionScope.userInfo.deptId}", "--부서명--");
				Util.setSelectBox("/contents/basic/data/userNameList.do",
						"userId", {
							deptId : '${sessionScope.userInfo.deptId}'
						}, "userId", "userName", "", "선택하세요");
				$("#s_dept").on(
						"change",
						function() {
							Util.setSelectBox(
									"/contents/basic/data/userNameList.do",
									"userId", {
										deptId : $(this).val()
									}, "userId", "userName", "", "선택하세요");
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

				goList();
			});

	function goList() {
		var colName, title, data;

		searchYear = $("#searchYear").val();

		$("#fromDate").val(searchYear + "-01-01");
		$("#toDate").val(searchYear + "-12-31");

		var stateCategory = "매출액,매입액,한계이익,한계이익율";

		columns = [ {
			field : "type",
			title : "구분",
			width : 113,
			locked : true
		}, {
			field : "deptName",
			title : "부서",
			width : 80,
			locked : true
		}, {
			field : "userName",
			title : "담당자",
			width : 80,
			locked : true
		}, {
			field : "colSum",
			title : "소계",
			width : 100,
			locked : true,
			template : function(dataItem) {
				if (dataItem.colSum == "") {
					return "0";
				} else {
					return Util.formatNumber(dataItem.colSum);
				}
			},
			attributes : {
				style : "text-align: right"
			}
		}, {
			field : "deptId",
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
										url : "/contents/monitor/data/profitDeptYear.do",
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
										var sumData2 = {};
										var sumData3 = {};
										var sumData4 = {};
										var dataList = [];
										var buyList = [];
										var sellList = [];
										var profitList = [];
										var profitPercentageList = [];
										var stateArr = stateCategory.split(",");
										var countSum = 0;
										var countSum2 = 0;
										var countSum3 = 0;
										var countSum4 = 0;
										var sellCharge, buyCharge, profitCharge;
										var grid = $("#grid").data("kendoGrid");
										grid.bind("dataBound", grid_dataBound);
										for (var h = 0; h < stateArr.length; h++) {
											for (var i = 0, item; item = response.dept[i]; i++) {
												data = {
													"deptName" : item.deptName,
													"deptId" : item.deptId,
													"userName" : item.userName,
													"type" : stateArr[h],
													"colSum" : "0"
												};
												countSum = 0;
												countSum2 = 0;
												countSum3 = 0;
												countSum4 = 0;

												for (var k = 0; k < 13; k++) {
													var str = "0"
															+ k.toString();
													str = str.substring(
															str.length,
															str.length - 2);
													data["col" + str] = "0";
													if (data["type"] == "한계이익율" == true) {
														data["col" + str] = "0.0%";
													}
												}

												var sellAmt = 0;
												var buyAmt = 0;
												var profitAmt = 0;
												for (var j = 0, item2; item2 = response.data[j]; j++) {
													profitCharge = 0;
													if (item.userId == item2.userId
															&& item.deptId == item2.deptId) {
														var month = item2.allocDate
																.substring(7, 5);
														sellAmt += item2.sellCharge;
														buyAmt += item2.buyCharge;
														profitCharge = parseInt(
																item2.sellCharge,
																0)
																- parseInt(
																		item2.buyCharge,
																		0);
														profitAmt += profitCharge;
														if (data["type"] == "매출액")
															data["col" + month] = Util
																	.nvl(
																			Util
																					.formatNumber(item2.sellCharge),
																			"0");
														if (data["type"] == "매입액")
															data["col" + month] = Util
																	.nvl(
																			Util
																					.formatNumber(item2.buyCharge),
																			"0");
														if (data["type"] == "한계이익")
															data["col" + month] = Util
																	.nvl(
																			Util
																					.formatNumber(profitCharge),
																			"0");
														if (data["type"] == "한계이익율"
																&& profitCharge != 0)
															data["col" + month] = (profitCharge
																	/ item2.sellCharge * 100)
																	.toFixed(1)
																	+ "%";
													}
												}

												if (data["type"] == "매출액") {
													data["colSum"] = sellAmt;
													sellList.push(data);
												}
												if (data["type"] == "매입액") {
													data["colSum"] = buyAmt;
													buyList.push(data);
												}
												if (data["type"] == "한계이익") {
													data["colSum"] = profitAmt;
													profitList.push(data);
												}
												if (data["type"] == "한계이익율") {
													if (isNaN((profitAmt
															/ sellAmt * 100)
															.toFixed(1)) == false) {
														data["colSum"] = (profitAmt
																/ sellAmt * 100)
																.toFixed(1)
																+ "%";
													} else {
														data["colSum"] = "0.0%";
													}
													profitPercentageList
															.push(data);
												}
											}

										}

										sumData = {
											"deptName" : "합계",
											"userName" : "합계",
											"type" : "매출액",
											"colSum" : "0",
											"deptId" : "sum"
										}
										sumData2 = {
											"deptName" : "합계",
											"userName" : "합계",
											"type" : "매입액",
											"colSum" : "0",
											"deptId" : "sum"
										}
										sumData3 = {
											"deptName" : "합계",
											"userName" : "합계",
											"type" : "한계이익",
											"colSum" : "0",
											"deptId" : "sum"
										}
										sumData4 = {
											"deptName" : "합계",
											"userName" : "합계",
											"type" : "한계이익율",
											"colSum" : "0",
											"deptId" : "sum"
										}
										for (var k = 0; k < 13; k++) {
											var str = "0" + k.toString();
											str = str.substring(str.length,
													str.length - 2);
											sumData["col" + str] = "0";
											sumData2["col" + str] = "0";
											sumData3["col" + str] = "0";
											sumData4["col" + str] = "0.0%";
										}

										for (var i = 0, item; item = response.total[i]; i++) {
											var month = item.allocDate
													.substring(7, 5);
											var profitCharge = parseInt(
													item.sellCharge, 0)
													- parseInt(item.buyCharge,
															0);
											sumData["col" + month] = Util
													.nvl(
															Util
																	.formatNumber(item.sellCharge),
															"0");
											sumData2["col" + month] = Util
													.nvl(
															Util
																	.formatNumber(item.buyCharge),
															"0");
											sumData3["col" + month] = Util
													.nvl(
															Util
																	.formatNumber(profitCharge),
															"0");
											if (isNaN((profitCharge
													/ item.sellCharge * 100)
													.toFixed(1)) == false) {
												sumData4["col" + month] = (profitCharge
														/ item.sellCharge * 100)
														.toFixed(1)
														+ "%";
											} else {
												sumData4["col" + month] = "0.0%"
											}
											countSum += item.sellCharge;
											countSum2 += item.buyCharge;
											countSum3 += profitCharge;
										}
										sumData["colSum"] = countSum;
										sumData2["colSum"] = countSum2;
										sumData3["colSum"] = countSum3;
										if (isNaN((sumData3["colSum"]
												/ sumData["colSum"] * 100)
												.toFixed(1)) == false) {
											sumData4["colSum"] = (sumData3["colSum"]
													/ sumData["colSum"] * 100)
													.toFixed(1)
													+ "%";
											;
										} else {
											sumData4["colSum"] = "0.0%"
										}
										sellList.unshift(sumData);
										buyList.unshift(sumData2);
										profitList.unshift(sumData3);
										profitPercentageList.unshift(sumData4);

										dataList = dataList.concat(sellList)
												.concat(buyList).concat(
														profitList).concat(
														profitPercentageList);

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

	function grid_dataBound(e) {
		var rows = e.sender.lockedTable[0].children[1].children
		var rows2 = e.sender.tbody.children();
		var cells;
		var gridCellClassName;
		for (var i = 0; i < rows.length; i++) {
			var row = $(rows[i]);
			var row2 = $(rows2[i]);
			stateCells = row.children().eq(0)
			deptIdCells = row.children().eq(1)
			userNameCells = row.children().eq(2)
			if (userNameCells[0].innerText == '합계') {
				userNameCells.addClass(gridAddClass(
						userNameCells.prevObject[0].innerText + "-"
								+ userNameCells.prevObject[4].innerText,
						'colspan'))
			}
			stateCells.addClass(gridAddClass(stateCells[0].innerText,
					"stateCells"));
			deptIdCells.addClass(gridAddClass(
					deptIdCells.prevObject[0].innerText + "-"
							+ deptIdCells.prevObject[4].innerText, "deptId"));
			var dataItem = e.sender.dataItem(row);
			if (dataItem.type == "한계이익") {
				var cells = row2.children();
				cells.each(function(i) {
					if (cells.eq(i)[0].innerText < "0") {
						var lossRow = cells.eq(i);
						lossRow.addClass("loss")
					}
				})
				var lossSum = row.children().eq(3);
				if (lossSum[0].innerText < "0") {
					lossSum.addClass("loss");
				}
			}
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

	function colSpan(className) {
		setTimeout(function() {
			$("." + className).each(
					function() {
						var rows = $("." + className + ":contains('"
								+ $(this).text() + "')");
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