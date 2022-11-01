/**
 * 오더 등록 관련 공통 함수 js
 */

var MultiColumnComboBox = {
		// 거래처 자동완성
		setCustName: function(gbn, sellBuySctn, deptId) {
			var custName =  $("#" + gbn + "CustName").kendoMultiColumnComboBox({
				dataTextField: "custName",
				dataValueField: "custId",
				filter: "contains",
				minLength: 2,
				autoBind: true,
				dataSource: {
					serverFiltering: true,
					transport: {
						read : {
							url: "/contents/basic/data/custList.do",
							dataType: "json",
							type: "post",
							data: {
								useYn : "Y",
								sellBuySctn : sellBuySctn,
								deptId: deptId
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
				
				columns: [
					{ field: "custName", title: "거래처명", width: 'auto' },
					{ field: "deptName", title: "부서명", width: 'auto' }
				]
			}).data("kendoMultiColumnComboBox");	
			
			return custName;
		},
		/**
		 * 거래처 검색 옵션에서 사용- 부서 미선택하여 검색시 distinct
		 */
		setSearchCustName: function(gbn, sellBuySctn, deptId) {
			var custName =  $("#" + gbn + "CustName").kendoMultiColumnComboBox({
				dataTextField: "custName",
				dataValueField: "custId",
				filter: "contains",
				minLength: 2,
				autoBind: true,
				dataSource: {
					serverFiltering: true,
					transport: {
						read : {
							url: "/contents/basic/data/custSearchList.do",
							dataType: "json",
							type: "post",
							data: {
								useYn : "Y",
								sellBuySctn : sellBuySctn,
								deptId: deptId
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
				columns: [
					{field: "custName", title: "거래처명", width: 'auto'},
					{field: "deptName", title: "부서명", width: 'auto'}
				]
			}).data("kendoMultiColumnComboBox");	
			
			return custName;
		},
		/*
		 * 22.07.05 이건욱 T1 > 거래처 조회시 부서명 제외하고 대표명으로 조회 (화주용)
		 */
		setCustNameWithCeoName: function(gbn, sellBuySctn, deptId) {
			var custName =  $("#" + gbn + "CustName").kendoMultiColumnComboBox({
				dataTextField: "custName",
				dataValueField: "custId",
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
								sellBuySctn: sellBuySctn,
								deptId: deptId
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
					{ field: "custName", title: "거래처명", width: 200 },
					{ field: "deptName", title: "부서명", width: 120 },
					{ field: "ceo", title: "대표자명", width: 80 }
				]
			}).data("kendoMultiColumnComboBox");	
			
			return custName;
		},
		setStaff: function(gbn) {
			var staff = $("#" + gbn + "Staff").kendoMultiColumnComboBox({
				dataTextField: "userName",
				dataValueField: "userName",
				cascadeFrom: gbn + "CustName",
				cascadeFromField: "deptId",
				cascadeFromParentField: "deptId",
				filter: "contains",
				autoBind: true,
				dataSource: {
					serverFiltering: true,
					transport: {
						read : {
							url: "/contents/basic/data/userNameList.do",
							dataType: "json",
							type: "post",
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
					var dataItem = e.dataItem;
					if(dataItem != null){
						$("#" + gbn + "StaffId").val(dataItem.userId);
						if (gbn == "sell") $("#reqTel").val(dataItem.mobile);
						if (gbn == "buy") $("#buyStaffTel").val(dataItem.mobile);
					}else{
						if(e.sender.selectedIndex != -1){
							staff.select(e.sender.selectedIndex);
							var data = e.sender.listView._view[e.sender.selectedIndex];
							$("#" + gbn + "StaffId").val(data.item.userId);
							if (gbn == "sell") $("#reqTel").val(data.item.mobile);
							if (gbn == "buy") $("#buyStaffTel").val(data.item.mobile);
						}
					}
				},
				change: function(e){
					if(this.value() != ""){
						staff.trigger("select");
					}else{
						if (gbn == "sell") $("#reqTel").val("");
						if (gbn == "buy") $("#buyStaffTel").val("");
						$("#" + gbn + "StaffId").val("");
					}
				},
				columns: [
					{field: "userName", title: "담당자명", width:100},
					{field: "mobile", title: "연락처", width:100},
					{field: "grade", title: "직급", width:100},
					
				]
			}).data("kendoMultiColumnComboBox");
			
			return staff;
		},
		//상,하차지 자동완성 (주소지)
		setComName: function(gbn, deptId) {
			var comName = $("#" + gbn + "ComName").kendoMultiColumnComboBox({
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
												deptId : deptId,
												pageSize : 50 
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
									var dataItem = e.dataItem;
									if(dataItem != null) {
										$("#" + gbn + "Sido").val(dataItem.sido);
										$("#" + gbn + "Gungu").val(dataItem.gungu);
										$("#" + gbn + "Dong").val(dataItem.dong);
										$("#" + gbn + "Addr").val(dataItem.addr);
										$("#" + gbn + "AddrDetail").val(dataItem.addrDetail);
										$("#" + gbn + "Staff").val(dataItem.staffName);
										$("#" + gbn + "Tel").val(Util.formatPhone(dataItem.staffTel));
										$("#" + gbn + "Lat").val(dataItem.lat);
										$("#" + gbn + "Lon").val(dataItem.lon);
										$("#" + gbn + "Memo").val(dataItem.orderMemo);
										getRoute();
									}else{

										if(e.sender.selectedIndex != -1){
											comName.select(e.sender.selectedIndex);
											var data = e.sender.listView._view[e.sender.selectedIndex];

											$("#" + gbn + "Sido").val(data.item.sido);
											$("#" + gbn + "Gungu").val(data.item.gungu);
											$("#" + gbn + "Dong").val(data.item.dong);
											$("#" + gbn + "Addr").val(data.item.addr);
											$("#" + gbn + "AddrDetail").val(data.item.addrDetail);
											$("#" + gbn + "Staff").val(data.item.staffName);
											$("#" + gbn + "Tel").val(Util.formatPhone(data.item.staffTel));
											$("#" + gbn + "Lat").val(data.item.lat);
											$("#" + gbn + "Lon").val(data.item.lon);
											$("#" + gbn + "Memo").val(data.item.orderMemo);
											var combobox = $("#" + gbn + "Addr").data("kendoMultiColumnComboBox");
											combobox.text(data.item.addr);

										}
									}
								},
								change: function(e){
									if(this.value() != ""){
										comName.trigger("select");
									}else{
										$("#" + gbn + "Sido").val("");
										$("#" + gbn + "Gungu").val("");
										$("#" + gbn + "Dong").val("");
										$("#" + gbn + "Addr").val("");
										$("#" + gbn + "AddrDetail").val("");
										$("#" + gbn + "Staff").val("");
										$("#" + gbn + "Tel").val("");
										$("#" + gbn + "Lat").val("");
										$("#" + gbn + "Lon").val("");
										$("#" + gbn + "Memo").val("");
									}
								},
								columns: [
									{field: "addrName", title: "주소지명", width:160},
									{field: "addr", title: "주소", width:100},
									{field: "addrDetail", title: "상세주소", width:100}
								]
						}).data("kendoMultiColumnComboBox");
			return comName;
		},
		//차량번호 자동완성
		setCarNum: function(id, deptId, carContractCode) {
			var carNum = $("#" + id).kendoMultiColumnComboBox({
							dataTextField: "carNum",
							dataValueField: "carNum",
							filter: "contains",
							minLength: 2,
							autoBind: true,
							dataSource: {
								serverFiltering: true,
								transport: {
									read : {
										url: "/contents/basic/data/carList.do",
										dataType: "json",
										type: "post",
										data: {
											useYn : "Y",
											//gbn: "search",
											deptId : deptId,
											carContractCode : carContractCode
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
							columns: [
								{field: "carNum", title: "차량번호", width:110},
								{field: "driverName", title: "차주명", width:80},
								{field: "mobile", title: "휴대전화", width:120}
								
							]
						}).data("kendoMultiColumnComboBox");
			
			return carNum;
		},
		//차량번호 자동완성
		setSearchCarNum: function(id, deptId, carContractCode) {
			var carNum = $("#" + id).kendoMultiColumnComboBox({
							dataTextField: "carNum",
							dataValueField: "carNum",
							filter: "contains",
							minLength: 2,
							autoBind: true,
							dataSource: {
								serverFiltering: true,
								transport: {
									read : {
										url: "/contents/basic/data/carSearchList.do",
										dataType: "json",
										type: "post",
										data: {
											deptId : deptId,
											carContractCode : carContractCode
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
							columns: [
								{field: "carNum", title: "차량번호", width:110},
								{field: "driverName", title: "차주명", width:80},
								{field: "mobile", title: "휴대전화", width:120}
								
							]
			}).data("kendoMultiColumnComboBox");
			
			return carNum;
		}
}

//화주거래처 선택 콜백함수
function changeSellCust(e){
	chkTEST= true;
	var dataItem = e.dataItem;
	if(dataItem != null) {
		$("#sellCustId").val(dataItem.custId);
		$("#sellDeptId").val(dataItem.deptId);
		$("#sellDeptName").val(dataItem.deptName);
		$("#reqAddr").val(dataItem.bizAddr);
		$("#reqAddrDetail").val(dataItem.bizAddrDetail);
		$("#reqMemo").val(dataItem.orderMemo);
		$("#itemCode").val(dataItem.itemCode);
		$("#custMngMemo").val(dataItem.custMngMemo);
		$("#custPayType").val(dataItem.payType);
		$("#reqBizNum").val(Util.formatBizNum(dataItem.bizNum));
		$("#reqBizName").val(dataItem.bizName);
		$("#reqCeo").val(dataItem.ceo);
		$("#reqBizAddr").val(dataItem.bizAddr);
		$("#reqTaxEmail").val(dataItem.taxEmail);
		$("#reqTaxStaffName").val(dataItem.taxStaffName);
		$("#reqTaxTelNum").val(Util.formatPhone(dataItem.taxTelNum));
		if(dataItem.custMngCode != '02'){
			$("#custMngCodeName").val("정상");
		}else{
			$("#custMngCodeName").val("블랙리스트");
		}
	}else{
		if(e.sender.selectedIndex != -1){
			sellCustName.select(e.sender.selectedIndex);
			var data = e.sender.listView._view[e.sender.selectedIndex];
			$("#sellCustId").val(data.item.custId);
			$("#sellDeptId").val(data.item.deptId);
			$("#sellDeptName").val(data.item.deptName);
			$("#reqAddr").val(data.item.bizAddr);
			$("#reqAddrDetail").val(data.item.bizAddrDetail);
			$("#reqMemo").val(data.item.orderMemo);
			$("#itemCode").val(data.item.itemCode);
			$("#custMngMemo").val(data.item.custMngMemo);
			$("#custPayType").val(data.item.payType);
			$("#reqBizNum").val(Util.formatBizNum(data.item.bizNum));
			$("#reqBizName").val(data.item.bizName);
			$("#reqCeo").val(data.item.ceo);
			$("#reqBizAddr").val(data.item.bizAddr);
			$("#reqTaxEmail").val(data.item.taxEmail);
			$("#reqTaxStaffName").val(data.item.taxStaffName);
			$("#reqTaxTelNum").val(Util.formatPhone(data.item.taxTelNum));
			if(data.item.custMngCode != '02'){
				$("#custMngCodeName").val("정상");
			}else{
				$("#custMngCodeName").val("블랙리스트");
			}
		}else{
			//$("#sellCustName").val("");
			chkTEST= false;
			alert("등록되지 않은 거래처명입니다.");
			return;
		}
	}

}

//운송사 선택 콜백함수
function changeBuyCust(e){
	var dataItem = e.dataItem;	
	if(dataItem != null) {
		$("#buyCustId").val(dataItem.custId);
		$("#buyDeptId").val(dataItem.deptId);
		$("#buyDeptName").val(dataItem.deptName);
	}else{
		if(e.sender.selectedIndex != -1){
			buyCustName.select(e.sender.selectedIndex);
			var data = e.sender.listView._view[e.sender.selectedIndex];
			$("#buyCustId").val(data.item.custId);
			$("#buyDeptId").val(data.item.deptId);
			$("#buyDeptName").val(data.item.deptName);
		}
	}
}

//차량 선택 콜백함수
function changeCarNum(e){
	var dataItem = e.dataItem;	
	if(dataItem != null) {
		$("#driverName").val(dataItem.driverName);
		$("#driverTel").val(dataItem.telNum);
		$("#vehicId").val(dataItem.vehicId);
		$("#driverId").val(dataItem.driverId);
	}	
}

function changeBuyCarNum(e){
	$("#buyVehicId").val("");
	$("#buyDriverId").val("");
	$("#payType").val("");
	var dataItem = e.dataItem;
	if(dataItem != null) {
		$("#buyDriverName").val(dataItem.driverName);
		$("#buyDriverTel").val(Util.formatPhone(dataItem.mobile));
		$("#buyVehicId").val(dataItem.vehicId);
		$("#buyDriverId").val(dataItem.driverId);
		$("#carSctnCode").val(dataItem.carSctnCode);
		$("#buyCarTypeCode").val(dataItem.carTypeCode);
		$("#buyCarTonCode").val(dataItem.carTonCode);
		$("#buyCargoBox").val(dataItem.cargoBox);
		$("#carMngCode").val(dataItem.carMngCode);
		$("#carMngMemo").val(dataItem.carMngMemo);
		$("#carPayType").val(dataItem.payType);
	}else{
		if(e.sender.selectedIndex != -1){
			buyCarNum.select(e.sender.selectedIndex);
			var data = e.sender.listView._view[e.sender.selectedIndex];
			$("#buyDriverName").val(data.item.driverName);
			$("#buyDriverTel").val(Util.formatPhone(data.item.mobile));
			$("#buyVehicId").val(data.item.vehicId);
			$("#buyDriverId").val(data.item.driverId);
			$("#carSctnCode").val(data.item.carSctnCode);
			$("#buyCarTypeCode").val(data.item.carTypeCode);
			$("#buyCarTonCode").val(data.item.carTonCode);
			$("#buyCargoBox").val(data.item.cargoBox);
			$("#carMngCode").val(data.item.carMngCode);
			$("#carMngMemo").val(data.item.carMngMemo);
			$("#carPayType").val(data.item.payType);
		}
	}
}

//거리/시간 
function getRoute(){
	var sLat = $("#sLat").val();
	var sLng = $("#sLon").val();
	var eLat = $("#eLat").val();
	var eLng = $("#eLon").val();
	if(sLat && sLng && eLat && eLng) {
		var param = "sLat=" + sLat + "&sLng=" + sLng + "&eLat=" + eLat + "&eLng=" + eLng;

		$.ajax({
			url: "/cmm/getRoute.do",
			type: "POST",
			dataType: "json",
			data: param,
			success: function(data){
				if(data.result){
					var time = data.data.Time;
					var timeTxt = "";
					$("#distance").val(data.data.Distance);
					$("#time").val(time);
					
					if(time > 60) {
						timeTxt = parseInt(time / 60) + "시간 " + (time%60) + "분"; 
					}else {
						timeTxt = time + "분";
					}
					$("#timeTxt").val(timeTxt);
				}
			}
		})
	} 
}

//유가
function getOpinet(sido, sigun){
	if(sido && sigun) {
		var param = "sido=" + sido + "&sigun=" + sigun;
		$.ajax({
			url: "/cmm/opinetInfo.do",
			type: "POST",
			dataType: "json",
			data: param,
			success: function(data){
				if(data.result){
					$.ajax({
						url: "/cmm/insertOpiInfo.do",
						type: "POST",
						dataType: "json",
						data: data.data
					})
				}
			}
		})
	} 
}

//날씨
function getWeather(lat, lon, orderId, allocState){
	if(lon && lat && orderId && allocId) {
		var param = "lat=" + lat + "&lon=" + lon + "&orderId=" + orderId + "&allocState=" + allocState;
		$.ajax({
			url: "/cmm/weatherInfo.do",
			type: "POST",
			dataType: "json",
			data: param,
			success: function(data){
				if(data.result){
					$.ajax({
						url: "/cmm/insertWeatherInfo.do",
						type: "POST",
						dataType: "json",
						data: data.data
					})
				}
			}
		})
	} 
}

/**
 * 계약 단가 세팅
 * @param mode
 * @returns
 */
function getCharge(mode) {
	var sGungu = $("#sGungu").val();
	var eGungu = $("#eGungu").val();
	
	if(sGungu != null && sGungu != "") sGungu = sGungu.split(" ")[0];
	if(eGungu != null && eGungu != "") eGungu = eGungu.split(" ")[0];
	
	$.ajax({
		url: "/contents/order/data/getCharge.do",
		type: "POST",
		dataType: "json",
		data: {
			mode: mode,
			sSido: $("#sSido").val(),
			sGungu: sGungu,
			eSido: $("#eSido").val(),
			eGungu: eGungu,
			sellCustId: $("#sellCustId").val(),
			sellDeptId: $("#sellDeptId").val(),
			buyCustId: $("#buyCustId").val(),
			buyDeptId: $("#buyDeptId").val(),
			carTonCode: $("#carTonCode").val()
		},
		success: function(data){
			if(data.result) {
				if(mode == "S") $("#sellCharge").val(Util.formatNumber(data.charge));
				else if(mode == "B") $("#buyCharge").val(Util.formatNumber(data.charge));
			}
		}
	});
}


/**
 * 수출입구분-운송유형-차종,톤수 세팅 함수
 * @param data - 코드 data
 * @param id - 태그 ID
 * @param filter 
 * @param dftVal
 * @returns
 */
function setFrtSelect(data, id, filter, dftVal){
	var s = "";
	s+= "<option value=\"\">선택하세요.</option>";
	for(var i=0, item; item=data[i]; i++) {
		if(item.filter1.indexOf(filter) >= 0) {
			s+= "<option value=\"" + item.code + "\""
			if (dftVal == item.code) s+= " selected";
			s+= ">" + item.cname + "</option>";
		}
	}
	
	$("#" + id).html(s);
}


function checkCustAddr(mode) {
	$.ajax({
		url: "/contents/basic/data/checkAddr.do",
		type: "POST",
		dataType: "json",
		data: {
			addrName : $("#"+mode+"ComName").val(), 
			addr : $("#"+mode+"Addr").val(),
			addrDetail : $("#"+mode+"AddrDetail").val(),
			lat : $("#"+mode+"Lat").val(),
			lon : $("#"+mode+"Lon").val(),
			sido : $("#"+mode+"Sido").val(),
			gungu : $("#"+mode+"Gungu").val(),
			dong : $("#"+mode+"Dong").val(),
			staffName : $("#"+mode+"Staff").val(),
			staffTel : $("#"+mode+"Tel").val(),
		},
		success: function(data){
		    $("#"+mode+"AreaSave").prop("disabled", false);
			if(data.result) {
				$("input:checkbox[id='"+mode+"AreaSave']").prop("checked", true);
				$("input:checkbox[id='"+mode+"AreaSave']").val("Y")
				$("#"+mode+"AreaSave").parent(".radio-or-checkBox").css("display", "contents");
			} else {
				$("input:checkbox[id='"+mode+"AreaSave']").prop("checked", false);
				$("input:checkbox[id='"+mode+"AreaSave']").val("N")
				$("#"+mode+"AreaSave").parent(".radio-or-checkBox").css("display", "none");
			}
		}
	});
}


function popOrderViewLocation(){
	if($("#locationSLat").val() == "0" || $("#locationSLon").val() == "0" || $("#locationELat").val() == "0" || $("#locationELon").val() == "0"){
		alert("더미 상/하차지가 포함된 오더는 조회 할 수 없습니다.");
		return
	}
	var selectedItem = chkSelectedOrder();
		
	if(selectedItem.isSelected){
		var orderId = selectedItem.item.orderId;
		viewLocation = $("#divViewLocation").data("kendoWindow");
		if(viewLocation == null) {
			viewLocation = $("#divViewLocation").kendoWindow({
				width: 850,
				height: 790,
				content: {
					url: "/contents/order/view/viewLocation.do?orderId=" + orderId
				},
				iframe: true,
				visible:false
			}).data("kendoWindow");	
		} else {
			viewLocation.refresh({url: "/contents/order/view/viewLocation.do?orderId=" + orderId});
		} 
		viewLocation.center().open();	
	}
}

function driverProposalView(){
	driverProposal = $("#driverProposalView").data("kendoWindow");
	if(driverProposal == null) {
		driverProposal = $("#driverProposalView").kendoWindow({
			width: 850,
			height: 486,
			content: {
				url: "/contents/order/view/driverOrderHistory.do"
			},
			iframe: true,
			visible:false
		}).data("kendoWindow");	
	} else {
		driverProposal.refresh({url: "/contents/order/view/driverOrderHistory.do"});
	} 
	driverProposal.center().open();	
}

function linkDriverView(){
	linkDriver = $("#linkDriverView").data("kendoWindow");
	if(linkDriver == null) {
		linkDriver = $("#linkDriverView").kendoWindow({
			width: 450,
			height: 341,
			content: {
				url: "/contents/order/view/linkDriverView.do"
			},
			iframe: true,
			visible:false
		}).data("kendoWindow");	
	} else {
		linkDriver.refresh({url: "/contents/order/view/linkDriverView.do"});
	} 
	linkDriver.center().open();	
}


function chkSelectedOrder() {
	var grid = $("#grid").data("kendoGrid");
	var selectedItem = grid.dataItem(grid.select());
	
	if(selectedItem == null) {
		alert("오더를 선택하세요.");
		return {
			isSelected: false,	
			item: null
		};
	}
	
	return {
		isSelected: true,
		item: selectedItem
	};
}

function orderHistory() {
	var selectedItem = chkSelectedOrder();
		
	if(selectedItem.isSelected){
		var orderId = selectedItem.item.orderId;
		viewLocation = $("#divOrderHistory").data("kendoWindow");
		if(viewLocation == null) {
			viewLocation = $("#divOrderHistory").kendoWindow({
				width: 850,
				height: 371,
				content: {
					url: "/contents/order/view/orderHistory.do?orderId=" + orderId
				},
				iframe: true,
				visible:false
			}).data("kendoWindow");	
		} else {
			viewLocation.refresh({url: "/contents/order/view/orderHistory.do?orderId=" + orderId});
		} 
		viewLocation.center().open();
	}
}
