<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>

<div id="divCodeGroupInsert" class="editor_wrap p-0">
	<form id="modal" name="modal" action="post">
		<div class="modalEditor" id="codeGroupInsert">
			<div class="modalHeader">
				<div class="form-group row mt0">
					<label class="col-form-label modal-big-name">그룹코드</label>
					<div class="input-group input-group-sm wd290 middle-name pb05">
						<input type="text" class="form-control form-control-sm" style="width: 100%" id="modalGCode"
							   name="modalGCode" type="text">
					</div>
				</div>
				<div class="form-group row">
					<label class="col-form-label modal-big-name">그룹코드명</label>
					<div class="input-group input-group-sm wd290 middle-name pb05">
						<input type="text" class="form-control form-control-sm" style="width: 100%" id="modalGName"
							   name="modalGName" type="text">
					</div>
				</div>
				<div class="form-group row">
					<label class="col-form-label modal-big-name">메모</label>
					<div class="input-group input-group-sm wd290 middle-name pb05">
						<input type="text" class="form-control form-control-sm" style="width: 100%" id="modalMemo"
							   name="modalMemo" type="text">
					</div>
				</div>
				<!--
                <div>
                    <strong>그룹코드</strong>
                    <input style="width: 303px;" id="modalGCode" type="text">
                </div>
                <div>
                    <strong>그룹코드명</strong>
                    <input style="width: 303px;" id="modalGName" type="text">
                </div>
                <div>
                    <strong>메모</strong>
                    <input style="width: 303px;" id="modalMemo" type="text">
                </div>
                 -->
			</div>
			<div class="editor_btns">
				<div class="padding">
					<a id="groupSubmit" onclick="modalSubmit()" class="k-pager-refresh k-button"><b
							id="groupBtnSave" class="btn-b">저장</b></a>
					<a id="closeBtn" onclick="modalClose()" class="k-pager-refresh k-button"><b
							class="btn-g">닫기</b></a>
				</div>
			</div>
		</div>
	</form>
</div>

<div id="divCodeInsert" class="editor_wrap">
	<form id="modal" name="modal" action="post">
	<div class="modalEditor" id="codeInsert">
		<div class="modalHeader">
			<div class="form-group row pb05">
                <label class="col-form-label modal-big-name">그룹코드</label>
                <div class="input-group input-group-sm wd120 middle-name">
                    <select class="form-control form-control-sm" id="modalCodeGroup" name="modalCodeGroup" style="width: 100%"></select>
                </div>
            </div>
			<div class="form-group row pb05">
                <label class="col-form-label modal-big-name">공통코드</label>
                <div class="input-group input-group-sm wd120 middle-name mr40">
                    <input type="text" class="form-control form-control-sm" id="modalCode" name="modalCode" style="width: 100%">
                </div>
                <label class="col-form-label modal-big-name">공통코드명</label>
                <div class="input-group input-group-sm wd120 middle-name">
                    <input type="text" class="form-control form-control-sm" id="modalCName" name="modalCName" style="width: 100%">
                </div>
            </div>
            <div class="form-group row pb05">
                <label class="col-form-label modal-big-name">상위분류코드</label>
                <div class="input-group input-group-sm wd120 middle-name mr40">
                    <input type="text" class="form-control form-control-sm" id="modalPcCode" name="modalPcCode" style="width: 100%">
                </div>
                <label class="col-form-label modal-big-name">상위공통코드</label>
                <div class="input-group input-group-sm wd120 middle-name">
                    <input type="text" class="form-control form-control-sm" id="modalPsCode" name="modalPsCode" style="width: 100%">
                </div>
            </div>
            <div class="form-group row pb05">
                <label class="col-form-label modal-big-name">메모</label>
                <div class="input-group input-group-sm wd120 middle-name">
                    <input type="text" class="form-control form-control-sm" id="modalCodeMemo" name="modalCodeMemo" style="width: 100%">
                </div>
            </div>
            <div class="form-group row pb05">
                <label class="col-form-label modal-big-name">필터1</label>
                <div class="input-group input-group-sm wd120 middle-name">
                    <input type="text" class="form-control form-control-sm" id="modalFilter1" name="modalFilter1" style="width: 100%">
                </div>
            </div>
            <div class="form-group row pb05">
                <label class="col-form-label modal-big-name">필터2</label>
                <div class="input-group input-group-sm wd120 middle-name">
                    <input type="text" class="form-control form-control-sm" id="modalFilter2" name="modalFilter2" style="width: 100%">
                </div>
            </div>
            <div class="form-group row pb05">
                <label class="col-form-label modal-big-name">필터3</label>
                <div class="input-group input-group-sm wd120 middle-name">
                    <input type="text" class="form-control form-control-sm" id="modalFilter3" name="modalFilter3" style="width: 100%">
                </div>
            </div>
            
			<!-- 
			<div>
				<strong>그룹코드</strong>
				<select id="modalCodeGroup" style="width: 303px;"></select> 
			</div>
			<div>
				<strong>공통코드</strong>
				<input style="width: 303px;" id="modalCode" type="text">
			</div>
			<div>
				<strong>공통코드명</strong>
				<input style="width: 303px;" id="modalCName" type="text">
			</div>
			<div>
				<strong>상위분류코드</strong>
				<input style="width: 303px;" id="modalPcCode" type="text">
			</div>
			<div>
				<strong>상위공통코드</strong>
				<input style="width: 303px;" id="modalPsCode" type="text">
			</div>
			<div>
				<strong>메모</strong>
				<input style="width: 303px;" id="modalCodeMemo" type="text">
			</div>
			<div>
				<strong>필터1</strong>
				<input style="width: 303px;" id="modalFilter1" type="text">
			</div>
			<div>
				<strong>필터2</strong>
				<input style="width: 303px;" id="modalFilter2" type="text">
			</div>
			<div>
				<strong>필터3</strong>
				<input style="width: 303px;" id="modalFilter3" type="text">
			</div>
			 -->
		</div>
		<div class="editor_btns">
			<div class="padding">
		        <a id="codeSubmit" onclick="codeModalSubmit()" class="k-pager-refresh k-button"><b id="codeBtnSave" class="btn-b">저장</b></a>
		        <a id="closeBtn" onclick="codeModalClose()" class="k-pager-refresh k-button"><b class="btn-g">닫기</b></a>
	        </div>
	    </div>
	</div>
	</form>
</div>

<div class="header">

	<div class="summary p30">
		<div class="hdr-tit">
			<P id="headerTitle">코드관리</P>
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

												<c:if test="${menuAuth.writeYn eq 'Y'}">
													<!--
													<button type="button" id="insertCodeGroup_btn" class="k-pager-refresh k-button"><b class="btn-b"><i class="k-icon k-i-copy"></i><strong>코드그룹생성</strong></b></button>
													-->
													<button type="button" id="insertCodeGroup_btn"
															class="form-control-sm middle-button btn_95 btn_black_13">
														<strong>코드그룹생성</strong></button>

												</c:if>
												<c:if test="${menuAuth.writeYn eq 'Y'}">
													<!--
													<button type="button" id="insertCode_btn"
															class="k-pager-refresh k-button"><b
															class="btn-b"><i
															class="k-icon k-i-copy"></i><strong>코드생성</strong></b>
													</button>
													-->
													<button type="button" id="insertCode_btn"
															class="form-control-sm middle-button btn_95 btn_black_13">
														<strong>코드생성</strong></button>
													<!-- <a href="javascript:fSubmit();" class="k-pager-refresh k-button"><i class="k-icon k-i-check"></i>수정</a>-->
												</c:if>
											</div>
										</div>
									</div>
								</div>
							</div>
							<div style="min-width: 500px;">
								<form id="f" name="f" method="post">
									<input type="hidden" id="gridData" name="gridData">
									<div id="splitter"
										 style="min-width: 500px; max-width: 100vw; min-height:calc(100vh - 280px);">
										<div class="top-pane">
											<div style="height: 100%;" id="grid"></div>
										</div>
										<div class="bottom-pane">
											<div style="height: 100%;" id="subGrid"></div>
										</div>
									</div>
								</form>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

<script type="text/javascript">
var groupColumns = [
	{ field: "number", title: "No."},
	{ field: "gCode", title: "그룹코드"},
	{ field: "gName", title: "그룹코드명"},
	{ field: "memo", title: "메모"},
	{ field: "useYn", title: "사용여부"},
	{ field: "codeSeq", title: "codeSeq", hidden:true}
];

var codeColumns = [
	{ field: "number", title: "No."},
	{ field: "gCode", title: "그룹코드"},
	{ field: "code", title: "공통코드"},
	{ field: "cname", title: "공통코드명"},
	{ field: "pcCode", title: "상위분류코드"},
	{ field: "psCode", title: "상위공통코드"},
	{ field: "useYn", title: "사용여부"},
	{ field: "memo", title: "메모"},
	{ field: "filter1", title: "필터1"},
	{ field: "filter2", title: "필터2"},
	{ field: "filter3", title: "필터3"},
	{ field: "codeSeq", title: "codeSeq", hidden:true}
];

var oGrid = null;
oGrid = new gridData("grid");
oGrid.initGrid();
oGrid.setSortable(false);
oGrid.setSendUrl("/contents/basic/data/codeGroupList.do");
oGrid.setSelectable(true);
oGrid.setPageable(false);
oGrid.setGrid(groupColumns);


var oSubGrid = null;
oSubGrid = new gridData("subGrid");
oSubGrid.initGrid();
oSubGrid.setSendUrl("/contents/basic/data/codeList.do");
oSubGrid.setEditable(false);
oSubGrid.setSelectable(true);
oSubGrid.setSortable(false);
oSubGrid.setPageable(false);
oSubGrid.setGrid(codeColumns); 


$(document).ready(function(){
	var mode = ""
	$("#splitter").kendoSplitter({
        orientation: "vertical",
        panes: [{resizable:true}, {resizable:true}]
    }); 
	
	goList();
	
	//권한 생성 modal
	codeGroupModal = $("#divCodeGroupInsert");
	codeModal = $("#divCodeInsert");
	codeGroupModalButton = $("#insertCodeGroup_btn");
	codeModalButton = $("#insertCode_btn");

	codeGroupModalButton.click(function () {
		modalClose();
		codeGroupModal.data("kendoDialog").open();
		$("#groupBtnSave").html($("#groupBtnSave").html().replace('수정', '저장'));
		$("#divCodeGroupInsert").parents("div").find(".k-window-title").html("코드그룹생성");
		$("#groupSubmit").removeAttr("onclick");
		$("#groupSubmit").attr("onclick", "modalSubmit('N')");
	});
	
	codeModalButton.click(function () {
		codeModalClose();
		codeModal.data("kendoDialog").open();
		Util.setSelectBox("/contents/basic/data/codeGroupList.do", "modalCodeGroup", {}, "gCode", "gName", "", "선택하세요");
		$("#codeBtnSave").html($("#codeBtnSave").html().replace('수정', '저장'));
		$("#divCodeInsert").parents("div").find(".k-window-title").html("코드생성");
		$("#codeSubmit").removeAttr("onclick");
		$("#codeSubmit").attr("onclick", "codeModalSubmit('N')");
	})

	codeGroupModal.kendoDialog({
		width: "446px",
		height: "280px",
		visible: false,
		title: "코드그룹생성",
		closable: true,
		modal: false,
		close: function(){codeGroupModalButton.fadeIn();}
	});
	
	codeModal.kendoDialog({
		width: "550px",
		height: "440px",
		visible: false,
		title: "코드생성",
		closable: true,
		modal: false,
		close: function(){codeModalButton.fadeIn();}
	})
});


function goList() {
	var grid = $("#grid").data("kendoGrid");
	var subGrid = $("#subGrid").data("kendoGrid");
	
	//datasource setting
	oGrid.setSearchData({});
	//oGrid.setDataSource();
	grid.setDataSource(oGrid.gridOption.dataSource);

	grid.bind("change", onChange);
	$("#subGrid").data("kendoGrid").setDataSource([]);
	
	grid.tbody.delegate('tr', 'dblclick', function(){
		modalClose();
		var dataItem = grid.dataItem($(this));
		codeGroupModal.data("kendoDialog").open();
		Util.setPageData(dataItem);
		$("#modalGCode").val(dataItem.gCode);
		$("#modalGName").val(dataItem.gName);
		$("#modalMemo").val(dataItem.memo);
		$("#groupBtnSave").html($("#groupBtnSave").html().replace('저장', '수정'));
		$("#divCodeGroupInsert").parents("div").find(".k-window-title").html("코드그룹수정");
		$("#groupSubmit").removeAttr("onclick");
		$("#groupSubmit").attr("onclick", "modalSubmit('E', '"+dataItem.codeSeq+"');");
	});
	
	subGrid.tbody.delegate('tr', 'dblclick', function(){
		codeModalClose();
		var dataItem = subGrid.dataItem($(this));
		codeModal.data("kendoDialog").open();
		Util.setSelectBox("/contents/basic/data/codeGroupList.do", "modalCodeGroup", {}, "gCode", "gName", "", "선택하세요");
		Util.setPageData(dataItem);
		$("#modalCodeGroup").val(dataItem.gCode);
		$("#modalCode").val(dataItem.code)
		$("#modalCName").val(dataItem.cname)
		$("#modalPcCode").val(dataItem.pcCode)
		$("#modalPsCode").val(dataItem.psCode)
		$("#modalCodeMemo").val(dataItem.memo)
		$("#modalFilter1").val(dataItem.filter1)
		$("#modalFilter2").val(dataItem.filter2)
		$("#modalFilter3").val(dataItem.filter3)
		$("#codeBtnSave").html($("#codeBtnSave").html().replace('저장', '수정'));
		$("#divCodeInsert").parents("div").find(".k-window-title").html("코드수정");
		$("#codeSubmit").removeAttr("onclick");
		$("#codeSubmit").attr("onclick", "codeModalSubmit('E', '"+dataItem.codeSeq+"');");
	});
}

function onChange(e){
	var row = this.select();
	var data = this.dataItem(row);
	
	/* $("#gCode").val(data.gCode); */
	viewCode(data.gCode);
}

function viewCode(){	
	var searchData = {
			gCode : arguments[0]
	}
	
	var subGrid = $("#subGrid").data("kendoGrid");
	oSubGrid.setSearchData(searchData);
	subGrid.setDataSource(oSubGrid.gridOption.dataSource);	
}

function modalSubmit(mode, codeSeq){
	$.ajax({
		url: "/contents/basic/data/codeGroupInsert.do",
		type: "POST",
		dataType: "json",
		data: {
			gCode: $("#modalGCode").val(),
			gName: $("#modalGName").val(),
			memo: $("#modalMemo").val(),
			codeSeq : codeSeq,
			mode : mode
		},
		success: function(data){
			if (data.result) {
				alert(data.msg);
				goList();
			} else {
				alert(data.msg);
			}
			modalClose();
		}
	});
}

function codeModalSubmit(mode, codeSeq){
	$.ajax({
		url: "/contents/basic/data/codeInsert.do",
		type: "POST",
		dataType: "json",
		data: {
			gCode: $("#modalCodeGroup").val(),
			code: $("#modalCode").val(),
			cname: $("#modalCName").val(),
			pcCode: $("#modalPcCode").val(),
			psCode: $("#modalPsCode").val(),
			memo: $("#modalCodeMemo").val(),
			filter1: $("#modalFilter1").val(),
			filter2: $("#modalFilter2").val(),
			filter3: $("#modalFilter3").val(),
			codeSeq : codeSeq,
			mode : mode
		},
		success: function(data){
			if (data.result) {
				alert(data.msg);
				goList();
			} else {
				alert(data.msg);
			}
			codeModalClose();
		}
	});
}

function modalClose(){
	$("#modalGCode").val("");
	$("#modalGName").val("");
	$("#modalMemo").val("");
	codeGroupModal.data("kendoDialog").close();
}

function codeModalClose() {
	$("#modalCodeGroup").val("");
	$("#modalCode").val("");
	$("#modalCName").val("");
	$("#modalPcCode").val("");
	$("#modalPsCode").val("");
	$("#modalCodeMemo").val("");
	$("#modalFilter1").val("");
	$("#modalFilter2").val("");
	$("#modalFilter3").val("");
	codeModal.data("kendoDialog").close();
}

</script>