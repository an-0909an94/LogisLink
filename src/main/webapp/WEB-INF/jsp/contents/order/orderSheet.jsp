<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>

<div class="header">
    <div style="justify-content: space-between; display: flex;" class="summary p30">
        <div class="hdr-tit">
            <P id="headerTitle">배차시트</P>
        </div>
    </div>
    
    <div class="contents">
		<div class="box" style="width: 100%;">
			<div id="group-list" class="cont-wrapper">
				<div class="cont-body">
					<div class="content">
						<div class="lookup_table">
							<div class="toolbar row">
								<div class="tool_form col">
									<div class="btn-row">
										<div class="tool_group">
											<div class="padding">
<!--                                                 <a href="#" class="k-pager-refresh k-button" onClick="addRow()"> -->
<!--                                                     <b class="btn-b"> <i class="k-icon k-i-paste-plain-text"> </i>로우추가 -->
<!--                                                     </b> -->
<!--                                                 </a> -->
												<button type="button" id="save_btn" class="k-pager-refresh k-button" disabled><b class="btn-b"><i class="k-icon k-i-copy"></i><strong>저장</strong></b></button>
                                                <button type="button" id="excel_export_btn" class="k-pager-refresh k-button" disabled><b class="btn-b"><i class="k-icon k-i-file-excel"></i><strong>엑셀출력</strong></b></button>
                                                <button type="button" id="excel_import_btn" class="k-pager-refresh k-button" disabled><b class="btn-b"><i class="k-icon k-i-file-excel"></i><strong>엑셀업로드</strong></b></button>
											</div>
										</div>
									</div>
								</div>
							</div>
							<div style="min-width: 500px;">
								<div id="grid"></div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

<script type="text/javascript">
	var loginCustId = "${sessionScope.userInfo.custId}";
	var loginDeptId = "${sessionScope.userInfo.deptId}";

	var headerTitle = ($("#headerTitle").text());
	
	var excelGrid;
	var selectedRow;
	var selectedCol;

    $(document).ready(function() {
    	createGridRow(20);
    	createSheet();
    });
    
    function createSheet() {
    	excelGrid = $("#grid").kendoGrid({
    		dataSource: {
    			data: gridData,
    			// true: 새로고침
    			autoSync: false,
    			batch: true,
    			schema: {
    				model: {
    					id: "number",
    					fields: {
    					}
    				}
    			}
    		},
    		columns: columns,
    		selectable: "cell",
    		editable: true,
    		noRecords: false,
    		// 키입력 탐색
    		navigatable: true,
    		scrollable: {
                endless: true
            },
            change: function(e) {
            	var cell = this.select();
                var cellIndex = cell.index();
                var colName = this.options.columns[cellIndex].field;
                // 상차지명과 하차지명이 변경될 경우 주소지 정보 자동 채움 
                if (colName == "sComName" || colName == "eComName") {
                	selectedRow = this.select().closest("tr");
                	selectedCol = colName;
                }
            }
    	}).data("kendoGrid");
    }
    
    var gridData = [
//     	{ number: "1", custName: "", sComName: "", sComDate: "", sComAddr: "", sComDtlAddr: "", eComName: "", eComDate: "", eComAddr: "", eComDtlAddr: "", carType: "", carTon: "", goodsName: "", inOutSctn: "", truckType: "", sWayType: "", eWayType: "", sellCharge: "" },
//     	{ number: "2", custName: "", sComName: "", sComDate: "", sComAddr: "", sComDtlAddr: "", eComName: "", eComDate: "", eComAddr: "", eComDtlAddr: "", carType: "", carTon: "", goodsName: "", inOutSctn: "", truckType: "", sWayType: "", eWayType: "", sellCharge: "" },
//     	{ number: "3", custName: "", sComName: "", sComDate: "", sComAddr: "", sComDtlAddr: "", eComName: "", eComDate: "", eComAddr: "", eComDtlAddr: "", carType: "", carTon: "", goodsName: "", inOutSctn: "", truckType: "", sWayType: "", eWayType: "", sellCharge: "" },
    ]
    
    function createGridRow(rowNum) {
    	for (var i = 0; i < rowNum; i++) {
    		
    		var data = new Object();
    		data.number = i + 1;
    		data.custName = "";
    		data.sComName = "";
    		data.sComDate = "";
    		data.sComAddr = "";
    		data.sComDtlAddr = "";
    		data.eComName = "";
    		data.eComDate = "";
    		data.eComAddr = "";
    		data.eComDtlAddr = "";
    		data.carType = "";
    		data.carTon = "";
    		data.goodsName = "";
    		data.inOutSctn = "";
    		data.truckType = "";
    		data.sWayType = "";
    		data.eWayType = "";
    		data.sellCharge = "";
    		
    		gridData.push(data);
    	}
    }
    
    var columns = [
    	{ field: "number", title: "번호", width: 80, editable: function (dataItem){} },
    	{ field: "custName", title: "거래처명", width: 120, editor: cellCustNameComboBox },
    	{ field: "sComName", title: "상차지명", width: 140, editor: cellComNameComboBox },
    	{ field: "sComDate", title: "상차일시", width: 120, format: "{0:yyyy-MM-dd HH:mm}", editor: cellDateTimeComboBox },
    	{ field: "sComAddr", title: "주소", width: 180 },
    	{ field: "sComDtlAddr", title: "주소상세", width: 180 },
    	{ field: "eComName", title: "하차지명", width: 140, editor: cellComNameComboBox },
    	{ field: "eComDate", title: "하차일시", width: 120, format: "{0:yyyy-MM-dd HH:mm}", editor: cellDateTimeComboBox },
    	{ field: "eComAddr", title: "주소", width: 180 },
    	{ field: "eComDtlAddr", title: "주소상세", width: 180 },
    	{ field: "carType", title: "요청차종", width: 120, editor: cellCarTypeDropdown },
    	{ field: "carTon", title: "요청톤수", width: 120, editor: cellCarTonDropdown },
    	{ field: "goodsName", title: "화물정보", width: 150 },
    	{ field: "inOutSctn", title: "수출입구분", width: 120, editor: cellInOutSctn },
    	{ field: "truckType", title: "운송유형", width: 120, editor: cellTruckType },
    	{ field: "sWayType", title: "상차방법", width: 120, editor: cellsWay },
    	{ field: "eWayType", title: "하차방법", width: 120, editor: celleWay },
    	{ field: "sellCharge", title: "기본운임(청구)", width: 120, format: "{0:#,##}" },
    ]
    
    // 거래처명 Combo
    function cellCustNameComboBox(container, options) {
		$('<input type="text" data-bind="value:' + options.field + '" />')
        	.appendTo(container)
        	.kendoMultiColumnComboBox({
                dataTextField: "custName",
                dataValueField: "custName",
                filter: "contains",
                minLength: 2,
                autoBind: true,
                dataSource: {
                    serverFiltering: true,
                    transport: {
                        read: {
                            url: "/contents/basic/data/custList.do",
                            dataType: "json",
                            type: "post",
                            data: {
                            	useYn: "Y",
								sellBuySctn: "01",
								deptId: loginDeptId
                            },
                            beforeSend: function(req) {
                                req.setRequestHeader("AJAX", true);
                            }
                        }
                    },
                    schema: {
                        data: function(response) {
                            return response.data;
                        },
                        total: function(response) {
                            return response.total;
                        }
                    }
                },
                columns: [
                    { field: "custName", title: "거래처명", width: "auto" },
                    { field: "deptName", title: "부서명", width: "auto" }
                ]
            }).data("kendoMultiColumnComboBox");
    }
    
    // 상하차지 Combo
    function cellComNameComboBox(container, options) {
    	$('<input type="text" data-bind="value:' + options.field + '" />')
    		.appendTo(container)
        	.kendoMultiColumnComboBox({
        		dataTextField: "addrName",
				dataValueField: "addrName",
				filter: "contains",
				minLength: 2,
				autoBind: true,
				dataSource: {
					serverFiltering: true,
					transport: {
						read : {
							url: "/contents/basic/data/custAddrList.do",
							dataType: "json",
							type: "post",
							data: {
								useYn : "Y",
								deptId : loginDeptId
							},
							beforeSend: function(req) {
								req.setRequestHeader("AJAX", true);
							}
						}
					},
					schema : {
						data : function(response) {
							return response.data;
						},
						total : function(response) {
							return response.total;
						}
					}
				},
				select: function(e) {
					if (e.dataItem.addr != "") {
						if (selectedRow != null && selectedRow != 'undefined') {
							var dataItem = excelGrid.dataItem(selectedRow);
							if (selectedCol == "sComName") {
								dataItem.set("sComAddr", e.dataItem.addr);
								dataItem.set("sComDtlAddr", e.dataItem.addrDetail);
							} else {
								dataItem.set("eComAddr", e.dataItem.addr);
								dataItem.set("eComDtlAddr", e.dataItem.addrDetail);
							}
						}
					}
				},
				change: function(e) {
					
				},
				columns: [
					{ field: "addrName", title: "주소지명", width: "auto" },
					{ field: "addr", title: "주소", width: "auto" },
					{ field: "addrDetail", title: "상세주소", width: "auto" }
                ]
        	}).data("kendoMultiColumnComboBox");
    }
    
    // 일시 Combo
    function cellDateTimeComboBox(container, options) {
		$('<input type="text" data-bind="value:' + options.field + '" data-format="' + options.format + '" />')
    		.appendTo(container)
    		.kendoDatePicker();
    }
    
    // 요청차종 Combo
    function cellCarTypeDropdown(container, options) {
    	$('<input name="' + options.field + '"/>')
    		.appendTo(container)
    		.kendoComboBox({
                dataTextField: "cname",
                dataValueField: "cname",
                filter: "contains",
                suggest: true,
                dataSource: {
                    transport: {
                    	read: {
                    		url: "/cmm/codeList.do",
                    		dataType: "json",
                    		type: "post",
                    		data: {
                    			gCode: "CAR_TYPE_CD"
                    		},
                    		beforeSend: function(req) {
                    			req.setRequestHeader("AJAX", true);
                    		}
                    	}
                    },
        			schema : {
        				data : function(response) {
            				return response.data;
            			}
            		}
                }
    		});

    }
    
    // 요청톤수 Combo
    function cellCarTonDropdown(container, options) {
    	$('<input name="' + options.field + '"/>')
    		.appendTo(container)
    		.kendoDropDownList({
                dataTextField: "cname",
                dataValueField: "cname",
                filter: "contains",
                suggest: true,
                dataSource: {
                    transport: {
                    	read: {
                    		url: "/cmm/codeList.do",
                    		dataType: "json",
                    		type: "post",
                    		data: {
                    			gCode: "CAR_TON_CD"
                    		},
                    		beforeSend: function(req) {
                    			req.setRequestHeader("AJAX", true);
                    		}
                    	}
                    },
        			schema : {
        				data : function(response) {
            				return response.data;
            			}
            		}
                }
    		});
    }
    
    // 수출입구분 Dropdown
    function cellInOutSctn(container, options) {
    	$('<input name="' + options.field + '"/>')
    		.appendTo(container)
    		.kendoDropDownList({
                dataTextField: "cname",
                dataValueField: "cname",
                autoBind: true,
                dataSource: {
                    transport: {
                    	read: {
                    		url: "/cmm/codeList.do",
                    		dataType: "json",
                    		type: "post",
                    		data: {
                    			gCode: "IN_OUT_SCTN"
                    		},
                    		beforeSend: function(req) {
                    			req.setRequestHeader("AJAX", true);
                    		}
                    	}
                    },
        			schema : {
        				data : function(response) {
            				return response.data;
            			}
            		}
                }
    		});
    }
    
    // 운송유형 Dropdown
    function cellTruckType(container, options) {
    	$('<input name="' + options.field + '"/>')
    		.appendTo(container)
    		.kendoDropDownList({
                dataTextField: "cname",
                dataValueField: "cname",
                autoBind: true,
                dataSource: {
                    transport: {
                    	read: {
                    		url: "/cmm/codeList.do",
                    		dataType: "json",
                    		type: "post",
                    		data: {
                    			gCode: "TRUCK_TYPE_CD"
                    		},
                    		beforeSend: function(req) {
                    			req.setRequestHeader("AJAX", true);
                    		}
                    	}
                    },
        			schema : {
        				data : function(response) {
            				return response.data;
            			}
            		}
                }
    		});
    }
    
    // 상차방법 Dropdown
    function cellsWay(container, options) {
    	$('<input name="' + options.field + '"/>')
    		.appendTo(container)
    		.kendoDropDownList({
                dataTextField: "cname",
                dataValueField: "cname",
                autoBind: true,
                dataSource: {
                    transport: {
                    	read: {
                    		url: "/cmm/codeList.do",
                    		dataType: "json",
                    		type: "post",
                    		data: {
                    			gCode: "WAY_TYPE_CD"
                    		},
                    		beforeSend: function(req) {
                    			req.setRequestHeader("AJAX", true);
                    		}
                    	}
                    },
        			schema : {
        				data : function(response) {
            				return response.data;
            			}
            		}
                }
    		});
    }
    
    // 하차방법 Dropdown
    function celleWay(container, options) {
    	$('<input name="' + options.field + '"/>')
    		.appendTo(container)
    		.kendoDropDownList({
                dataTextField: "cname",
                dataValueField: "cname",
                autoBind: true,
                dataSource: {
                    transport: {
                    	read: {
                    		url: "/cmm/codeList.do",
                    		dataType: "json",
                    		type: "post",
                    		data: {
                    			gCode: "WAY_TYPE_CD"
                    		},
                    		beforeSend: function(req) {
                    			req.setRequestHeader("AJAX", true);
                    		}
                    	}
                    },
        			schema : {
        				data : function(response) {
            				return response.data;
            			}
            		}
                }
    		});
    }
    
    function addRow() {
    	excelGrid.addRow();
    }

</script>