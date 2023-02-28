<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="header">
    <div class="summary p30">
        <div class="hdr-tit">
            <P id="headerTitle">거래처손익현황(월)</P>
        </div>
    </div>
    <div class="contents">
        <div id="group-list" class="cont-wrapper-page-grid">
            <form id="fSearch" class="date-bnt" method="post">
                <div class="form-group row mt0" style="justify-content: space-between">
                    <div class="row">
                        <div class="input-group input-group-sm wd90 middle-name div-min-col-1">
                            <input style="width: 100%; padding: 0;" type="text" id="searchMonth"
                                   name="searchMonth">
                            <input type="hidden" id="fromDate" name="fromDate">
                            <input type="hidden" id="toDate" name="toDate">
                        </div>
                        <div class="input-group input-group-sm wd90 middle-name div-min-col-1">
                            <select class="form-control" class="custom-select wd90" id="s_dept"
                                    name="deptId">
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
                        <div class="input-group-sm middle-name mr10">
                            <button onclick="goList();" type="button" class="form-control-sm middle-button btn_58 btn_b">검색</button>
                        </div>
                        <div class="input-group-sm middle-name">
                            <button onclick="goExcel();" type="button" class="form-control-sm middle-button btn_27h btn_g">엑셀출력</button>
                        </div>
                    </div>
                </div>
                <div class="toolbar row">
                    <div class="tool_form col">
                        <div style="width: 80px; float: left; margin-top: 30px;">(단위:원)</div>
                        <!--
                        <div class="btn-row">
                            <div class="tool_group">
                                <div class="padding">
                                    <a href="#" class="k-pager-refresh k-button"
                                       onClick="goExcel();">
                                        <b class="btn-x"><i
                                                class="k-icon k-i-file-excel"></i>엑셀출력</b>
                                    </a>
                                </div>
                            </div>
                        </div>
                        -->
                    </div>
                </div>
                <!-- /toolbar -->
                <div id="grid" style="height: calc(100vh - 240px);"></div>
            </form>
        </div>
    </div>
</div>

<script type="text/javascript">
	var headerTitle = ($("#headerTitle").text());
	var columns;
	var searchMonth = "";

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

		$("#searchMonth").kendoDatePicker({
			start : "year",
			depth : "year",
			format : "yyyy-MM",
			dateInput : true
		});
		var sMonth = new Date().yyyymm();
		var monthPicker = $("#searchMonth").data("kendoDatePicker");
		monthPicker.value(sMonth);

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

		searchMonth = $("#searchMonth").val();
		var year = searchMonth.split("-")[0];
		var month = searchMonth.split("-")[1];
		var toDate = new Date(year, month, 0).yyyymmdd();

		var lastDay = toDate.split("-")[2];

		$("#fromDate").val(searchMonth + "-01");
		$("#toDate").val(toDate);

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

		for (var i = 1; i <= lastDay; i++) {
			var str = "0" + i.toString();
			str = str.substring(str.length, str.length - 2);
			colName = "col" + str;
			title = searchMonth.substring(5, 8) + "." + i.toString();
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
										url : "/contents/monitor/data/profitCustMonth.do",
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

											for (var k = 0; k < 32; k++) {
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
													var day = item2.allocDate
															.substring(10, 8);
													sellData["col" + day] = Util
															.nvl(
																	Util
																			.formatNumber(item2.sellAmt),
																	"0");
													buyData["col" + day] = Util
															.nvl(
																	Util
																			.formatNumber(item2.buyAmt),
																	"0");
													profData["col" + day] = Util
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
													percData["col" + day] = perData
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
							sortable : false,
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