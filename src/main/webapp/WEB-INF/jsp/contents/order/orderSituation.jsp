<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>

<div class="header orderSituation">
	<div style="justify-content: space-between; display: flex;" class="summary p30">
		<div class="hdr-tit">
			<P id="headerTitle">상황실</P>
		</div>
	</div>
	<div class="contents">
		<div id="group-list" class="cont-wrapper-page-grid">
			<form id="fSearch" class="date-bnt">
			<input type="hidden" id="hoverText">
			<div class="tool_form row mt0" style="justify-content: space-between">
				<div class="row">
					<div class="input-group input-group-sm wd90 middle-name div-min-col-1">
						<select class="form-control" class="custom-select wd90" id="deptId" name="deptId">
							<option>부서명</option>
						</select>
					</div>
					<div class="input-group input-group-sm wd100 middle-name div-min-col-1">
						<select class="form-control custom-select wd100" id="userId" name="userId">
						</select>
					</div>
					<div class="input-group input-group-sm wd90 radio-or-checkBox div-min-col-1">
						<input type="checkbox" name="carSctnCodes" id="carSctnCodeNo0" value="01" checked/>
						<label for="carSctnCodeNo0" class="label-margin">
							<span>직영차</span>
						</label>
					</div>
					<div class="input-group input-group-sm wd90 radio-or-checkBox div-min-col-1">
						<input type="checkbox" name="carSctnCodes" id="carSctnCodeNo12" value="12" checked/>
						<label for="carSctnCodeNo12" class="label-margin">
							<span>장기용차</span>
						</label>
					</div>
					<div class="input-group input-group-sm wd90 radio-or-checkBox div-min-col-1">
						<input type="checkbox" name="carSctnCodes" id="carSctnCodeNo09" value="09"/>
						<label for="carSctnCodeNo09" class="label-margin">
							<span>협력사차량</span>
						</label>
					</div>
					<div class="input-group input-group-sm wd90 radio-or-checkBox div-min-col-1">
						<input type="checkbox" name="carSctnCodes" id="carSctnCodeNo11" value="11"/>
						<label for="carSctnCodeNo11" class="label-margin">
							<span>외부용차</span>
						</label>
					</div>
					<div class="input-group input-group-sm wd90 radio-or-checkBox div-min-col-1">
						<input type="checkbox" name="carSctnCodes" id="carSctnCodeNo13" value="13"/>
						<label for="carSctnCodeNo13" class="label-margin">
							<span>차주Pool</span>
						</label>
					</div>
				</div>
				<div class="input-group-sm middle-name">
				    <button onclick="goList()" type="button" class="form-control-sm btn_58 btn_b">검색</button>
				</div>
			</div>
			</form>                
			<!--  -->
			<div class="cont-body">
				<!-- f-wrap -->
				<div class="k-wrap content">
					<div class="lookup_table">
						<div class="toolbar row">
							<div class="tool_form col">
								<div class="btn-row" style="float: right;">
									<div class="tool_group" style="font-size: 12px">
										자동새로고침
										<input type="checkbox" id="autoRefresh" name="autoRefresh" class="input_on-off">
										<label for="autoRefresh" class="label_on-off" style="vertical-align:middle;">
											<span class="marble"></span>
											<span class="on">ON</span>
											<span class="off">OFF</span>
										</label>
									</div>
								</div>
							</div>
						</div>
						<div class="row">
							<div style="height:calc(100vh - 240px)" id="grid"></div>
							<!-- /table -->
						</div>
					</div>
				</div>
			</div>
			<!--  -->
		</div>
		<!-- group-list -->
	</div>
	<!-- content -->
</div>

<script type="text/javascript">
var oGrid = null;	
oGrid = new gridData("grid");
oGrid.initGrid();
oGrid.setSendUrl("/contents/order/data/orderSituation.do");
oGrid.setSelectable("multiple");
oGrid.setPageable(false);
var autoRefresh;

var date = new Date();
var year = date.getFullYear();
var month = ("0" + (1 + date.getMonth())).slice(-2);
var day = ("0" + date.getDate()).slice(-2);
var toDay = year + month + day;

$(document).ready(function(){

	$(window).bind("resize", function() {
		$("#grid").css("height", "calc(100vh - 240px)");

		$("#grid").data("kendoGrid").resize();
	});

	Util.setSelectBox("/contents/basic/data/compDeptList.do", "deptId", {custId:'${custId}', deptId:'${sessionScope.userInfo.deptId}', useYn :'Y'}, "deptId", "deptName", '${sessionScope.userInfo.deptId}', "전체부서");
	Util.setSelectBox("/contents/basic/data/userNameList.do", "userId", {deptId:$(this).val()}, "userId", "userName", "${sessionScope.userInfo.userId}", "전체");
	$("#deptId").on("change", function(){ 
		Util.setSelectBox("/contents/basic/data/userNameList.do", "userId", {deptId:$(this).val()}, "userId", "userName", "", "전체");
	});
	
 	goList();

 	//자동 새로고침 기본 10초	
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
	
	//자동 새로고침 기능 on/off
	$("#autoRefresh").on("click", function(){
		if($(this).is(":checked")) {
			$.cookie("autoRefresh", 30000, {expires:9999,path:"/"});
			startInterval();
		} else {
			$.cookie("autoRefresh", 0, {expires:9999,path:"/"});
			stopInterval();
		}
	});
	
	$("#grid").kendoTooltip({
		filter: "i",
		width: 450,
		position: "top",
		animation: {
        	open: {
        		effects: "zoom",
        		duration: 250
        	}
        },
		content: function(e){
			var orderInfo = e.target.context.offsetParent.classList.value;
			if (orderInfo != null) {
				var orderArr = orderInfo.split("--"); 
				var orderId = orderArr[3];
				var orderState = orderInfo.substring(12,14);
				var comName = e.target.context.className
				
				if(orderState == '01')
				orderState = '배차'
				if(orderState == '04')
				orderState = '출발'	
				if(orderState == '05')
				orderState = '도착'
				if(orderState == '12')
				orderState = '입차'
				
				return "["+orderState+"]"+" "+comName; 
			}
		}
	});
})

var columns = [
	{ field: "number", title: "No", width: 50,
		headerAttributes: {style: "vertical-align: middle"}
	},
	{ field: "carNum", title: "차량번호", width: 120, 
		headerAttributes: {style: "vertical-align: middle"}
	},
	{ field: "driverName", title: "차주명", width: 100,
		headerAttributes: {style: "vertical-align: middle"}
	},
	{	
		title: '오전',
		columns: [
			{ title: "~8시", width: 70, colSpan: 1},
			{ title: "9시", width: 70, colSpan: 1 },
			{ title: "10시", width: 70, colSpan: 1 },
			{ title: "11시", width: 70, colSpan: 1 },
			{ title: "12시", width: 70, colSpan: 1 },
		]
	},
	{
		title: '오후',
		columns: [
			{ title: "1시", width: 70, colSpan: 1 },
			{ title: "2시", width: 70, colSpan: 1 },
			{ title: "3시", width: 70, colSpan: 1 },
			{ title: "4시", width: 70, colSpan: 1 },
			{ title: "5시", width: 70, colSpan: 1 },
			{ title: "6시", width: 70, colSpan: 1 },
			{ title: "7시", width: 70, colSpan: 1 },
			{ title: "8시~", width: 70, colSpan: 1 },
		]
	},
/* 	{
		title: '매출액',
		columns: [
			{ field: "monthPerformance", title: "당월실적", width: 100 },
			{ field: "monthGoal", title: "월목표액", width: 100 },
		]
	},
	{
		title: '달성율',
		columns: [
			{ field: "goalCriteria", title: "목표기준", width: 100 },
			{ field: "lastMonthCompared", title: "전월대비", width: 100 },
		]
	}, */
	{
		title: '차주정보',
		columns: [
			{ field: "driverTel", title: "휴대전화", width: 120,
				template: function(dataItem) {
					return Util.formatPhone(dataItem.driverTel);
				}
			},
			{ field: "carSctnName", title: "차량구분", width: 100 },
			{ field: "carTonName", title: "톤수", width: 70 },
			{ field: "carTypeName", title: "차종", width: 70 },
		]
	},
	{ field: "orderInfo", hidden:true}
/* 	{
		title: '담당정보',
		columns: [
			{ field: "buyDeptName", title: "담당부서", width: 100 },
			{ field: "buyStaff", title: "담당자", width: 100 },
		]
	} */
];	

function goList() {
	var grid = $("#grid").data("kendoGrid");
	
	var checkCarSctnCodes = "";
	$('input:checkbox[name="carSctnCodes"]:checked').each(function(){
		var carSctnCode = $(this).val();
		checkCarSctnCodes += carSctnCode + ",";
	})
	
	var param = {};
	param["deptId"] = $("#deptId").val();
	param["userId"] = $("#userId").val();
	param["checkCarSctnCodes"] = checkCarSctnCodes;
	
	oGrid.setSearchData(param);
	if(grid == null) {
		oGrid.setGrid(columns);
		grid = $("#grid").data("kendoGrid");
	} else {
		grid.setDataSource(oGrid.gridOption.dataSource);
	}
	
	grid.bind("dataBound", grid_dataBound);
}

function grid_dataBound(e) {
	var columns = e.sender.columns;
  	var rows = e.sender.tbody.children();
  	for (var i = 0; i < rows.length; i++) {
    	var row = $(rows[i]);
    	var dataItem = e.sender.dataItem(row);
    	var orderInfo = Util.nvl(dataItem.orderInfo, '');
  		var cells;
  		var gridCellClassName;  	
  		var sSidoGungu, eSidoGungu, custName, sDay, sTime, eDay, eTime, orderState, custName, orderId, dateChk, returnChk, linkName;
  		
  		if(orderInfo != '') {
  			var orderArr = orderInfo.split("!@");
  			
  			for(var j=0; j<orderArr.length; j++) {
  				var orderItem = orderArr[j].split("|");
  				sSidoGungu = orderItem[0];
  				eSidoGungu = orderItem[1];
  				custName = orderItem[2];
  				sDay = orderItem[3];
  				sTime = orderItem[4];
  				eDay = orderItem[5];
  				eTime = orderItem[6];
  				orderState = orderItem[7];
  				custName = orderItem[8];
  				orderId = orderItem[9];
  				dateChk = orderItem[10];
  				returnChk = orderItem[11];
  				linkName = orderItem[12];
  				if(linkName != ""){
  					linkName = " | "+linkName	
  				}else{
  					linkName =""
  				}
  				
  				if(sTime.indexOf('0') == 0) sTime = sTime.substring(1);
  				if(eTime.indexOf('0') == 0) eTime = eTime.substring(1);
  				
  				sTime = parseInt(sTime, 0);
  				eTime = parseInt(eTime, 0);
  				
  				/* 상/하차일이 같음(당일 상/하차) */
  		  		if(sDay == eDay){
  				    if(sTime < '9'){
  				  		sTime = '3';
  				  	}else if(sTime > '20'){
  				  		sTime = '15';
  				  	}else{
  				  		sTime = sTime - 5;
  				  	}
  				
  				  	if(eTime < '9'){
  				  		eTime = '3';
  				  	}else if(eTime > '20'){
  				  		eTime = '15';
  				  	}else{
  				  		eTime = eTime - 5;
  				  	}
  		  		}else{
  		  		/* 상/하차일이 같지않은 오더 */
  		  			if(sDay.replace(/\-/g, "") != toDay){
  		  			/* 하차일이 오늘 */
  		  				if(eDay.replace(/\-/g, "") == toDay.replace(/\-/g, "")){
	  		  				if(eTime < '9'){
	  	  				  		eTime = '3';
	  	  				  	}else if(eTime > '20'){
	  	  				  		eTime = '15';
	  	  				  	}else{
	  	  				  		eTime = eTime - 5;
	  	  				  	}
  		  					sTime = '3'
  		  				}
  		  			}else if(eDay.replace(/\-/g, "") != toDay){
  		  			/* 상차일이 오늘 */
  			  			if(sDay.replace(/\-/g, "") == toDay.replace(/\-/g, "")){
  			  			    if(sTime < '9'){
  			  			  		sTime = '3';
  			  			  	}else if(sTime > '20'){
  			  			  		sTime = '15';
  			  			  	}else{
  			  			  		sTime = sTime - 5;
  			  			  	}
  					  		eTime = '15';
  			  			}
  		  			}
  		  		}
  			    
  			  	for(var k = sTime; k <= eTime; k++){
  			    	cells = row.children().eq(k);
  			    	cells.addClass(gridAddClass(orderState, sDay, sTime, eDay, eTime, orderId, custName));
  			    	gridCellClassName = cells.context.children[sTime].className;
  			  	}
				genCowspan(gridCellClassName, sSidoGungu, eSidoGungu, custName, dateChk, returnChk, eDay, linkName);
  			}
  		}	    
	}
}
 
function gridAddClass(orderState, sDateDay, sDateTime, eDateDay, eDateTime, orderId, custName) {
	/* 오더상태-상차일-상차시-하차일-하차시-오더아이디 */
	//return "orderStateNo"+orderState+"-"+sDateDay+"-"+eDateDay+"-"+custName+"-"+orderId;
   	return "orderStateNo"+orderState+"--"+sDateDay+"--"+eDateDay+"--"+custName.replace(/[,()]/gim, "")+"--"+orderId;
}

function genCowspan(className, sSidoGungu, eSidoGungu, custName, dateChk, returnChk, eDay, linkName){
	setTimeout(function() {
	    $("." + className).each(function() {
	        var rows = $("." + className + ":contains('" + $(this).text() + "')");
	        if (rows.length > 1) {
	        	rows.not(":eq(0)").remove(); 
	            rows.eq(0).attr("colspan", rows.length);
	        }
			var	text = ""
 			/* [배차상태] 상차지명 | 왕복여부 | 당일 출/도착 여부 | (YY.MM.DD) 하차지명 | 정보망이름*/
			/* text = "<div style=\"border-radius: 20px;\"><i style=\"display: block; overflow:hidden; text-overflow:ellipsis;\" class=\"" + sComName+" | "+ returnChk + " | "+ dateChk + " (" + eDay.substring(2,10).replace(/\-/g, '.') + ") " + eComName + linkName + "\">" + sSidoGungu + " → " + eSidoGungu + "</i></div>" */
 			/* [배차상태] 상차지명 | 왕복여부 | 당일 출/도착 여부 | (YY.MM.DD) | 정보망이름*/
			text = "<div style=\"border-radius: 20px;\"><i style=\"display: block; overflow:hidden; text-overflow:ellipsis;\" class=\"" + custName +" | "+ returnChk + " | "+ dateChk + " (" + eDay.substring(2,10).replace(/\-/g, '.') + ") " + linkName + "\">" + sSidoGungu + " → " + eSidoGungu + "</i></div>"
            rows.eq(0).html(text)
    	    if(className.indexOf("orderStateNo01") != -1) {
    		    $("." + className).find("div").css("background","#ffff00");
    		}else if(className.indexOf("orderStateNo12") != -1) {
    			$("." + className).find("div").css("background","#00ff89");
    		}else if(className.indexOf("orderStateNo04") != -1) {
    			$("." + className).find("div").css("background","#00f3ff");
    		}else if(className.indexOf("orderStateNo05") != -1) {
    			$("." + className).find("div").css("background","#d3d3d3");
    		}
	    });
	}, 10);
}

function startInterval() {
	refresh_timer = 20;
	autoRefresh = setInterval(function(){
		refresh_timer --;
		if(refresh_timer < 2) {
			refresh_timer = 20;
			goList();
		}
	}, 1000);
}

function stopInterval() {
	clearInterval(autoRefresh);
}
</script>
<style>
.k-draghandle.k-state-selected:hover, .k-state-selected{
	background-color: #ff7c0a !important; 
	background-image: none;
}
.k-grid td.k-state-selected:hover, .k-grid tr.k-state-selected:hover{
	background-color: #ff7c0a;
	background-image: none;
}
.k-alt k-master-row k-state-selected{
	background-color: #ff7c0a;
	background-image: none;
}
</style>