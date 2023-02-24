<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<style>
	#pushList .k-grid-content {max-height:calc(100vh)}
</style>
<div id="pushModal" class="editor-warp p-0">
	<div class="modalEditor" id="addPush">
		<form id="modalForm" name="modalForm">
			<div class="box mb15" style="width: 100%">
				<div style="float: left; width: 49%;padding-left:35px">
					<div class="form-group row gray_box">
						<div class="input-group input-group-sm col middle-name">
						<strong>제목</strong>
						    <input id="title" name="title" style="height: 40px;width: 100%;font-size: 16px;font-weight: 300;border: 1px solid #E8E9EB;border-radius: 5px;"/>
						</div>
					</div>
					
					<div class="form-group row gray_box">
						<div class="input-group input-group-sm col middle-name">
						<strong>내용</strong>
						    <textarea id="contents" name="contents" style="width: 100%;font-size: 16px;font-weight: 300;border: 1px solid #E8E9EB;border-radius: 5px;" rows="16" class="form-control textarea"></textarea>
						</div>
					</div>
				</div>
				<div style="float: right; width: 49%;padding-right:35px">
					<div class="mb20 gray_box">
						<div class="input-group input-group-sm col radio-or-checkBox ">
							<strong style="margin-left: 0em; padding-right: 1.5em;">회원구분</strong>
							<input id="driver" type="checkbox" name="custTypeCode" value="09">
							<label for="driver" class="label-margin">
								<span>차주</span>
							</label>
						</div>
						<div class="input-group input-group-sm col radio-or-checkBox ">
							<input id="owner" type="checkbox" name="custTypeCode" value="04">
							<label for="owner" class="label-margin">
								<span>화주</span>
							</label>
						</div>
						<div class="input-group input-group-sm col radio-or-checkBox ">
							<input id="carrier" type="checkbox" name="custTypeCode" value="01">
							<label for="carrier" class="label-margin">
								<span>주선사/운송사</span>
							</label>
						</div>
					</div>

					<div class="splitter" style="border: 0; max-width: 100%; min-height: 460px;">
						<div id="popGrid" style="border-radius: 5px;"></div>
					</div>
				</div>



			</div>
			<div class="padding" style="text-align: center;">
				<a style="width: 25.5%" href="#" class="k-pager-refresh k-button wd58" onclick="sendPush();" ><b class="btn-b">보내기</b></a>
				<a onclick="searchMember();" style="width: 25.5%" href="#" class="k-pager-refresh k-button wd58"><b class="btn-g">회원검색</b></a>
			</div>
		</form>
	</div>
</div>
<div class="header">
	<div class="summary p30">
		<div class="hdr-tit">
			<P id="headerTitle">푸시관리</P>
		</div>
	</div>
	<div class="contents">
		<div id="group-list" class="cont-wrapper-page-grid">
			<form id="fSearch" class="date-bnt" onSubmit="return false;">
				<div class="form-group row mt0" style="justify-content: space-between">
					<div>
						<div class="input-group input-group-sm wd90 middle-name">
							<input style="padding: 0;" type="text" id="fromDate" name="fromDate"
								   class="wd90">
						</div>
						<span>~</span>
						<div class="input-group input-group-sm wd90 middle-name div-min-col-1">
							<input style="padding: 0;" type="text" id="toDate" name="toDate"
								   class="wd90">
						</div>

						<div class="input-group input-group-sm wd90 radio-or-checkBox div-min-col-1">
							<input type="radio" name="dateChk" id="today" value="0" checked/>
							<label for="today" class="label-margin">
								<span>오늘</span>
							</label>
						</div>
						<div class="input-group input-group-sm wd90 radio-or-checkBox div-min-col-1">
							<input type="radio" name="dateChk" id="yesterday" value="1"/>
							<label for="yesterday" class="label-margin">
								<span>어제</span>
							</label>
						</div>
						<div class="input-group input-group-sm wd90 radio-or-checkBox div-min-col-1">
							<input type="radio" name="dateChk" id="weekly" value="7"/>
							<label for="weekly" class="label-margin">
								<span>7일</span>
							</label>
						</div>
						<div class="input-group input-group-sm wd90 radio-or-checkBox div-min-col-1">
							<input type="radio" name="dateChk" id="monthly" value="30"/>
							<label for="monthly" class="label-margin">
								<span>30일</span>
							</label>
						</div>

						<div class="input-group input-group-sm wd90 middle-name div-min-col-1">
							<select class="custom-select col-12" name="isDone" id="isDone">
								<option value="" selected="selected">--전송결과--</option>
								<option value="Y">성공</option>
								<option value="N">미전송</option>
								<option value="F">실패</option>
							</select>
						</div>
					</div>

					<div class="row">
						<div class="input-group-sm middle-name">
							<button onclick="goList()" type="button"
									class="form-control-sm btn_58 btn_b">검색
							</button>
						</div>
					</div>
				</div>
			</form>
			<!--  -->
			<div class="cont-body">
				<!-- f-wrap -->
				<div class="k-wrap content">
					<div class="lookup_table">
						<!-- table -->
						<div class="toolbar row">
							<div class="tool_form col">
								<div class="btn-row">
									<div class="tool_group">
										<div class="padding">
											<a href="#" class="k-pager-refresh k-button" onclick="goExcel();"><b class="btn-x">엑셀출력</b></a>
											<a id="btnAddPush" href="#" class="k-pager-refresh k-button"><b class="btn-h">push전송</b></a>
										</div>
									</div>
								</div>
							</div>
						</div><!-- /toolbar -->
						<div style="min-width: 500px;">
							<div style="height:calc(100vh - 344px)" id="pushList"></div>
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

<div id="divSearchMember"></div>
<script type="text/javascript">
$(document).ready(function(){
	$(".splitter").kendoSplitter({
        orientation: "vertical",
        panes: [{resizable:true}, {resizable:true}]
    }); 

	$("#fromDate").kendoDatePicker({format:"yyyy-MM-dd", value : new Date(), dateInput: true});
	$("#toDate").kendoDatePicker({format:"yyyy-MM-dd", value : new Date(), dateInput: true}); 
	Util.setSearchDateForm();
	
	modal = $("#pushModal");
	modalButton = $("#btnAddPush");

	modalButton.click(function() {
		popInit();
		modal.data("kendoDialog").open();
	});

	modal.kendoDialog({
		width: "1000px",
		height: "720px",
		visible: false,
		closable: true,
		title: "앱 푸시 전송",
		modal: false,
		close: function(){modalButton.fadeIn();}
	});
	
	$("#pushModal input:checkbox[name=custTypeCode]").change(function() {
		var grid = $("#popGrid").data("kendoGrid");
		grid.dataSource.data([]);
	})
	
	goList();
});

var columns = [
	{ field: "number", title: "No", width: 50 },
	{ field: "regDate", title: "등록일", width: 120 },
	{ field: "sendMobile", title: "수신번호", width: 100,
		template: "#=Util.formatPhone(sendMobile)#" },
	{ field: "isDone", title: "전송결과", width: 100 },
	{ field: "title", title: "제목", width: 100 },
	{ field: "contents", title: "내용", width: 120 },
	{ field: "sendDate", title: "전송시간", width: 120 },
	{ field: "sendUserId", title: "회원아이디", width: 100 },
	{ field: "regId", title: "등록자", width: 100 },
];

var userColumns = [
	{ field: "number", title: "No", width: 50 },
	{ field: "id", title: "아이디", width: 100 },
	{ field: "mobile", title: "연락처", width: 100 },
	{ field: "custTypeName", title: "분류", width: 100 },
	{ field: "custTypeCode", title: "분류코드", hidden:true },
];

var headerTitle = ($("#headerTitle").text());
var oGrid = null;	
oGrid = new gridData("pushList");
oGrid.initGrid();
oGrid.setSendUrl("/contents/notice/data/pushList.do");
oGrid.setSelectable(true);
oGrid.setExcelFile(headerTitle+"(" + new Date().yyyymmdd() + ").xlsx");

function goList() {
	var grid = $("#pushList").data("kendoGrid");
	
	oGrid.setSearchData($("#fSearch").serializeObject());
	if(grid == null) {
		oGrid.setGrid(columns);
		grid = $("#pushList").data("kendoGrid");
	} else {
		grid.setDataSource(oGrid.gridOption.dataSource);
	}
}

$("#popGrid").kendoGrid({
	sortable: false,
	reorderable: true,
	groupable: false,
	resizable: true,
	filterable: false,
	pageable: false,
	selectable: false,
	columnMenu: true,
	columns: userColumns,
	dataSource: {}
}); 

function searchMember(){
	var winHeight = ($(window).height()/2) - (302/2);
	var winWidth  = ($(window).width()/2) - (600/2);
	
	popupModal = $("#divSearchMember").kendoWindow({
		            width: "600px",
		            height:"349px",
		            title: "회원검색",
		            position: {
		                top: winHeight+"px", // or "100px"
		                left: winWidth+"px"
		            },
		            visible: false,
		            content: "/contents/cmm/view/searchMember.do",
		            iframe:true,
		            modal:true
		        }).data("kendoWindow");
	
	popupModal.open();
	
}

function setMember(data) {
	var grid = $("#popGrid").data("kendoGrid");
	data.number = grid.dataSource.view().length+1;
	
	grid.dataSource.add(data);
	
	$("#pushModal input:checkbox[name=custTypeCode]").prop("checked", false);
}

function sendPush() {
	var grid = $("#popGrid").data("kendoGrid");
	var searchUserList = JSON.stringify(grid.dataSource._data);
	var searchUserTotalLength = grid.dataSource._data.length;
	var custTypeCode = $("[name=custTypeCode]:checked");
    var custTypeCodeArray = new Array();

	if(!$("#title").val()) {
		alert("제목을 입력해주세요.");
		$("#title").focus();
		return;
	}
	
	if(!$("#contents").val()) {
		alert("내용을 입력해주세요.");
		$("#contents").focus();
		return;
	}

	if(searchUserTotalLength == 0 && $("input[name=custTypeCode]:checked").length == 0) {
		alert("앱 푸시를 전송할 회원을 추가해주세요.");
		return;
	}
	
	$("input[name='custTypeCode']:checked").each(function() { 
    	var value = $(this).val() 
    	custTypeCodeArray.push(value);
    });

	var param = $("#modalForm").serialize();
	
	param += "&searchUserList=" + searchUserList;
	param += "&searchUserTotalLength=" + searchUserTotalLength;
	param += "&custTypeCodeArray=" + custTypeCodeArray;
	
	$.ajax({
		url: "/contents/notice/data/sendPush.do",
		type: "POST",
		dataType: "json",
		data: param,
		success: function(data){
			if(data.result) {
				alert(data.msg);
				goList();
				$("#pushModal").data("kendoDialog").close();
				popInit();
			}
		}
	});
}

function popInit() {
	var popGrid = $("#popGrid").data("kendoGrid");
	$("#title").val("");
	$("#contents").val("");
	$("#modalForm")[0].reset();
	popGrid.removeRow($("#popGrid table tbody tr"));
}

//excel download
function goExcel(){
	var grid = $("#pushList").data("kendoGrid");
	grid.saveAsExcel();
}
</script>