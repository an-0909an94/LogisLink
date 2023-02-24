<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>

<style>
.help-block.with-errors {
	position: absolute;
	left: 0%;
	right: 0%;
}

.form-group {
	margin: 0.1rem;
}
</style>

<div id="divManualGroupModal" class="editor_wrap p-0">
	<form id="groupModal" name="groupModal" action="post" data-toggle="validator">
	<input type="hidden" id="hiddenGroupManualMode" name="groupManualMode">
	<div class="modalEditor">
		<div class="modalHeader">
			<div class="form-group mb15">
                <label class="col-form-label modal-big-name required">구분</label>
                <div class="input-group input-group-sm wd190 middle-name">
                    <select class="custom-select wd190" id="groupAppKind" name="groupAppKind" required>
                    	<option value="">선택하세요.</option>
                    	<option value="A">주선사</option>
                    	<option value="O">화주</option>
                    	<option value="D">차주</option>
                    </select>
                    <div class="help-block with-errors wd190" style="width: 100%"></div>
                </div>
            </div>
            <div class="form-group mb15">
                <label class="col-form-label modal-big-name required">그룹코드명</label>
                <div class="input-group input-group-sm wd190 middle-name">
                    <input type="text" class="form-control form-control-sm wd190" id="groupManualCode" name="groupManualCode" type="text" required>
                    <div class="help-block with-errors wd190" style="width: 100%"></div>
                </div>
            </div>
            <div class="form-group mb15">
                <label class="col-form-label modal-big-name required">매뉴얼명</label>
                <div class="input-group input-group-sm wd190 middle-name">
                    <input type="text" class="form-control form-control-sm wd190" id="groupManualName" name="groupManualName" type="text" required>
                    <div class="help-block with-errors wd190" style="width: 100%"></div>
                </div>
            </div>
			<div class="form-group">
	            <label class="col-form-label modal-big-name required">사용여부</label>
	            <div class="input-group input-group-sm wd190 middle-name">
	                <select class="custom-select wd190" id="groupManualUseYn" name="groupManualUseYn" required>
	             	<option value="Y" selected="selected" >Y</option>
	             	<option value="N">N</option>
	             </select>
	             <div class="help-block with-errors wd190" style="width: 100%"></div>
	            </div>
	        </div>
		</div>
		<div class="editor_btns">
			<div class="padding">
		        <button type="submit" class="k-pager-refresh k-button"><strong><b id="groupBtnSave" class="btn-b">저장</b></strong></button>
		        <a id="groupcloseBtn" onclick="groupModalClose()" class="k-pager-refresh k-button"><b class="btn-g">닫기</b></a>
	        </div>
	    </div>
	</div>
	</form>
</div>

<div id="divManualModal" class="editor_wrap p-0">
	<form id="manualModal" name="manualModal" action="post" data-toggle="validator">
	<input type="hidden" id="hiddenManualSeq" name="manualSeq">
	<input type="hidden" id="hiddenManualMode" name="manualMode">
	<div class="modalEditor">
		<div class="modalHeader">
			<div class="form-group mb15 mt0">
                <label class="col-form-label modal-big-name required">구분</label>
                <div class="input-group input-group-sm wd220 middle-name">
                    <select class="custom-select wd220" style="width: 100%" id="manualAppKind" name="manualAppKind" required>
                    	<option value="">선택하세요.</option>
                    	<option value="A">주선사</option>
                    	<option value="O">화주</option>
                    	<option value="D">차주</option>
                    </select>
                    <div class="help-block with-errors"></div>
                </div>
            </div>
			<div class="form-group mb15">
                <label class="col-form-label modal-big-name required">매뉴얼명</label>
                <div class="input-group input-group-sm wd220 middle-name">
                    <select class="custom-select wd220" id="manualName" name="manualName" required>
                    	<option value="">구분을 선택해주세요.</option>
                    </select>
                    <div class="help-block with-errors"></div>
                </div>
            </div>
            <div class="form-group mb15">
                <label class="col-form-label modal-big-name required">제목</label>
                <div class="input-group input-group-sm wd220 middle-name">
                    <input type="text" class="form-control form-control-sm wd220" id="manualTitle" name="manualTitle" required>
                    <div class="help-block with-errors"></div>
                </div>
            </div>
            <div class="form-group mb15">
                <label class="col-form-label modal-big-name required">매뉴얼타입</label>
                <div class="input-group input-group-sm wd220 middle-name">
					<div class="input-group input-group-sm wd220 radio-or-checkBox">
                    	<input id="manualTypeL" type="radio" name="manualType" value="L" onclick="changeType(this);" checked="checked">
                    	<label for="manualTypeL" class="label-margin">
                    	<span>url</span>
                    	</label>
                    </div>
                    <div class="input-group input-group-sm wd220 radio-or-checkBox">
                    	<input id="manualTypeF" type="radio" name="manualType" value="F" onclick="changeType(this);">
                    	<label for="manualTypeF" class="label-margin">
                    	<span>파일</span>
                    	</label>
                    </div>
                </div>
            </div>
            <div class="form-group mb15">
                <label class="col-form-label modal-big-name required">버전</label>
                <div class="input-group input-group-sm wd220 middle-name">
                    <input type="text" class="form-control form-control-sm wd220" id="manualVersion" name="manualVersion" required>
                    <div class="help-block with-errors"></div>
                </div>
            </div>
            
            <div class="form-group mb15" id="manualUrlL">
                <label class="col-form-label modal-big-name required">매뉴얼</label>
                <div class="input-group input-group-sm wd220 middle-name">
                    <input type="text" class="form-control form-control-sm wd220" id="manualUrlLink" name="manualUrl" required>
                    <div class="help-block with-errors"></div>
                </div>
        	</div>
        	
            <div class="form-group mb15" id="manualUrlF">
                <label class="col-form-label modal-big-name required">매뉴얼</label>
				<div class="input-group input-group-sm col wd220 filebox" style="padding:0px; align-self: center;display: block;">
					<input style="width: 100%;border: 1px solid #ced4da;" class="upload-name wd140 mr10" value="파일을 선택해 주세요." disabled>
					<label for="manualUrlFile" style="padding: 3.5px 0.75em;height:26px;">파일등록</label>
					<input type="file" id="manualUrlFile" name="manualUrl" class="upload-hidden" required="required">
				</div>
				<div class="help-block with-errors"></div>
        	</div>

			<div class="form-group mb15">
                <label class="col-form-label modal-big-name required">사용여부</label>
                <div class="input-group input-group-sm wd220 middle-name">
                    <select class="custom-select wd220" id="manualUseYn" name="manualUseYn" required>
	                	<option value="Y" selected="selected">Y</option>
	                	<option value="N">N</option>
	                </select>
                    <div class="help-block with-errors"></div>
                </div>
            </div>
		</div>
		
		<div class="editor_btns">
			<div class="padding">
		        <button type="submit" class="btn_b k-pager-refresh k-button btn-b"><strong><b id="manualBtnSave">저장</b></strong></button>
		        <a id="manualCloseBtn" onclick="manualModalClose()" class="k-pager-refresh k-button"><b>닫기</b></a>
	        </div>
	    </div>
	</div>
	</form>
</div>

<div class="header">
	<div class="summary p30">
		<div class="hdr-tit">
			<P class="">매뉴얼관리</P>
		</div>
	</div>
	<div class="contents">
		<div class="box" style="width: 100%;">
			<div id="group-list" class="cont-wrapper">
				<div class="form-group row" style="justify-content: space-between">
					<div>
						<div class="input-group input-group-sm wd90 middle-name div-min-col-1">
							<select class="custom-select wd90" id="appKind" name="appKind">
								<option value="A" selected="selected">주선사</option>
								<option value="O">화주</option>
								<option value="D">차주</option>
							</select>
						</div>
						<div class="input-group input-group-sm wd90 middle-name div-min-col-1">
							<select class="custom-select wd90" id="useYn" name="useYn">
								<option value="" selected="selected">사용여부.</option>
								<option value="Y">Y</option>
								<option value="N">N</option>
							</select>
						</div>
					</div>
					<div class="input-group-sm middle-name">
						<!--
					    <button onclick="goList()" type="button" style="border-radius:4px" class="form-control form-control-sm middle-button-dark">검색</button>
					    -->
						<button onclick="goList()" type="button" class="form-control-sm btn_58 btn_b">검색</button>
					</div>
				</div>	
				<div class="cont-body">
					<div class="content">
						<div class="lookup_table">
							<div class="toolbar row">
								<div class="tool_form col">
									<div class="btn-row">
										<div class="tool_group">
											<div class="padding" style="margin-top: 20px">

												<button type="button" id="insertManualGroup_btn" class="form-control-sm middle-button btn_100 btn_black_13"><strong>매뉴얼그룹생성</strong></button>
												<button type="button" id="insertManual_btn" class="form-control-sm middle-button btn_100 btn_black_13"><strong>매뉴얼생성</strong></button>
												<!--
												<button type="button" id="insertManualGroup_btn" class="k-pager-refresh k-button"><b class="btn-b"><i class="k-icon k-i-copy"></i><strong>매뉴얼그룹생성</strong></b></button>
												<button type="button" id="insertManual_btn" class="k-pager-refresh k-button"><b class="btn-b"><i class="k-icon k-i-copy"></i><strong>매뉴얼생성</strong></b></button>
												-->
											</div>
										</div>
									</div>
								</div>
							</div>
							<div style="min-width: 500px;">
								<form id="f" name="f" method="post">
									<input type="hidden" id="gridData" name="gridData">
									<!--
									<div id="splitter" style="min-width: 500px; max-width: 100vw; min-height:calc(100vh - 341px);">
									-->
									<div id="splitter" style="min-width: 500px; max-width: 100vw; min-height:500px;">
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
	{ field: "number", title: "No"},
	{ field: "manualCode", title: "그룹코드명"},
	{ field: "manualName", title: "매뉴얼명"},
	{ field: "useYn", title: "사용여부"},
	{ field: "manualCode", title: "manualCode", hidden:true}
];

var codeColumns = [
	{ field: "number", title: "No", width: 70},
	{ field: "manualCode", title: "매뉴얼코드", width: 100},
	{ field: "manualTitle", title: "제목", width: 200},
	{ field: "manualUrl", title: "URL", width: 300,
		template: '#if(manualType == "F") {# <a style="color: blue;" href="/cmm/manualDownload.do?fileName=#: manualUrl #">#: manualUrl #</a> #} else {# <a style="color: blue;" href="#: manualUrl #" target="_blank">#: manualUrl #</a> #} #',
	},
	{ field: "manualVersion", title: "버전", width: 100},
	{ field: "useYn", title: "사용여부", width: 70},
	{ field: "manualSeq", title: "manualSeq", hidden:true}
];

var oGrid = null;
oGrid = new gridData("grid");
oGrid.initGrid();
oGrid.setSendUrl("/contents/basic/data/manualGroupList.do");
oGrid.setSelectable(true);
oGrid.setPageable(false);
oGrid.setGrid(groupColumns);

var oSubGrid = null;
oSubGrid = new gridData("subGrid");
oSubGrid.initGrid();
oSubGrid.setSendUrl("/contents/basic/data/manualList.do");
oSubGrid.setEditable(false);
oSubGrid.setSelectable(true);
oSubGrid.setSortable(false);
oSubGrid.setPageable(false);
oSubGrid.setGrid(codeColumns); 


$(document).ready(function(){
	var fileTarget = $('.filebox .upload-hidden'); 
	fileTarget.on('change', function(){ // 값이 변경되면
		if(fileTarget.val() != ""){
			if(window.FileReader){ // modern browser 
				var filename = $(this)[0].files[0].name; 
			} else { // old IE 
				var filename = $(this).val().split('/').pop().split('\\').pop(); // 파일명만 추출 
			} 
		}else {
			filename = "파일을 선택해 주세요."
		}
		// 추출한 파일명 삽입
		$(this).siblings('.upload-name').val(filename); 
	});
	
	$("#manualAppKind").on("change", function(){ 
		if($(this).val() != ""){
			Util.setSelectBox("/contents/basic/data/manualGroupList.do", "manualName", {appKind:$(this).val()}, "manualCode", "manualName", "", "선택하세요.");
		}else{
			$("#manualName option").remove();
			$("#manualName").append("<option value=''>구분을 선택해주세요.</option>");
		}
	});
	var mode = ""
	$("#splitter").kendoSplitter({
        orientation: "vertical",
        panes: [{resizable:true}, {resizable:true}]
    }); 
	
	goList();
	
	manualGroupModal = $("#divManualGroupModal");
	manualGroupModalButton = $("#insertManualGroup_btn");
	
	manualGroupModalButton.click(function (){
		groupModalClose();
		$("#groupBtnSave").html($("#groupBtnSave").html().replace('수정', '저장'));
		$("#divManualGroupModal").parents("div").find(".k-window-title").html("매뉴얼그룹생성");
		$("#hiddenGroupManualMode").val("N");
		manualGroupModal.data("kendoDialog").open();
	});

	manualGroupModal.kendoDialog({
		width: "440px",
		height: "320px",
		visible: false,
		title: "매뉴얼그룹생성",
		closable: true,
		modal: false,
		close: function(){manualGroupModalButton.fadeIn();}
	});

	manualModal = $("#divManualModal");
	manualModalButton = $("#insertManual_btn");
	
	manualModalButton.click(function (){
		manualModalClose();
		$("#manualBtnSave").html($("#manualBtnSave").html().replace('수정', '저장'));
		$("#divManualModal").parents("div").find(".k-window-title").html("매뉴얼생성");
		$("#hiddenManualMode").val("N");
		manualModal.data("kendoDialog").open();
	});

	manualModal.kendoDialog({
		width: "440px",
		height: "470px",
		visible: false,
		title: "매뉴얼생성",
		closable: true,
		modal: false,
		close: function(){manualModalButton.fadeIn();}
	});
});


function goList() {
	var param = {};
	param['appKind'] = $("#appKind").val();
	param['useYn'] = $("#useYn").val();
	var grid = $("#grid").data("kendoGrid");
	var subGrid = $("#subGrid").data("kendoGrid");
	
	oGrid.setSearchData(param);
	grid.setDataSource(oGrid.gridOption.dataSource);

	grid.bind("change", onChange);
	$("#subGrid").data("kendoGrid").setDataSource([]);

	grid.tbody.delegate('tr', 'dblclick', function(){
		groupModalClose();
		var dataItem = grid.dataItem($(this));
		$("#groupAppKind").val(dataItem.appKind);
		$("#groupManualCode").val(dataItem.manualCode);
		$("#groupManualName").val(dataItem.manualName);
		$("#groupManualUseYn").val(dataItem.useYn);
		$("#groupBtnSave").html($("#groupBtnSave").html().replace('저장', '수정'));
		$("#divManualGroupModal").parents("div").find(".k-window-title").html("매뉴얼그룹수정");
		$("#hiddenGroupManualMode").val("E");
		$("#groupManualCode").attr("disabled", true);
		manualGroupModal.data("kendoDialog").open();
	});
	
	subGrid.tbody.delegate('tr', 'dblclick', function(){
		manualModalClose();
		var dataItem = subGrid.dataItem($(this));
		var appKind = dataItem.manualCode.substr(0, 1);
		$("#manualAppKind").val(appKind);
		Util.setSelectBox("/contents/basic/data/manualGroupList.do", "manualName", {appKind:appKind}, "manualCode", "manualName", dataItem.manualCode, "선택하세요.");
		$("input[name=manualType]:input[value=" + dataItem.manualType + "]").prop("checked", true);
		$("#manualTitle").val(dataItem.manualTitle);
		$("#manualVersion").val(dataItem.manualVersion);
		$("#manualUseYn").val(dataItem.useYn);
		$("#hiddenManualSeq").val(dataItem.manualSeq);
		if(dataItem.manualType == 'F'){
			if(Util.nvl(dataItem.manualUrl,"") != ""){
				$(".upload-name").val(dataItem.manualUrl.replace("/NAS/upload/manual/",""));
			}
			changeType($("#manualTypeF"));
		}else{
			changeType($("#manualTypeL"));
			$("#manualUrlLink").val(dataItem.manualUrl);
		}
		
		$("#manualBtnSave").html($("#manualBtnSave").html().replace('저장', '수정'));
		$("#divManualModal").parents("div").find(".k-window-title").html("매뉴얼수정");
		$("#hiddenManualMode").val("E");
		manualModal.data("kendoDialog").open();
	});
}

function onChange(e){
	var row = this.select();
	var data = this.dataItem(row);
	
	viewCode(data.manualCode);
}

function viewCode(manualCode){	
	var param = {};
	param['manualCode'] = manualCode;
	param['useYn'] = $("#useYn").val();
	var subGrid = $("#subGrid").data("kendoGrid");
	
	oSubGrid.setSearchData(param);
	subGrid.setDataSource(oSubGrid.gridOption.dataSource);	
}


$('#groupModal').validator().on('submit', function (e) {
	if (e.isDefaultPrevented()) {
		alert("항목을 입력해 주세요.");
	} else {
		var param = {
			appKind: $("#groupAppKind").val(),
			manualName: $("#groupManualName").val(),
			manualCode: $("#groupManualCode").val(),
			useYn: $("#groupManualUseYn").val(),
			mode: $("#hiddenGroupManualMode").val(),
		}
  		e.preventDefault();
		$.ajax({
			url: "/contents/basic/data/manualGroupInsert.do",
			type: "POST",
			dataType: "json",
			data: param,
			success: function(data){
				if (data.result) {
					alert(data.msg);
					goList();
				} else {
					alert(data.msg);
				}
				groupModalClose();
			}
		});
	}
});


$('#manualModal').validator().on('submit', function (e) {
	if (e.isDefaultPrevented()) {
		alert("항목을 입력해 주세요.");
	} else {
		var param = {
			manualName: $("#manualName").val(),
			manualTitle: $("#manualTitle").val(),
			manualType: $('input[name="manualType"]:checked').val(),
			manualUrl: $('input[name="manualUrl"]').val(),
			manualVersion: $("#manualVersion").val(),
			manualSeq: $("#hiddenManualSeq").val(),
			manualUseYn: $("#manualUseYn").val(),
			mode: $("#hiddenManualMode").val(),
		}
  		e.preventDefault();
		$.ajax({
			url: "/contents/basic/data/manualInsert.do",
			type: "POST",
			dataType: "json",
			data: param,
			success: function(data){
				if (data.result) {
					if(param.manualType == "F" && $("#manualUrlFile").val() != ""){
						if($("#hiddenManualSeq").val() == ""){
							$("#hiddenManualSeq").val(data.outManualSeq);
						}
						manualFileInsert();
					}
					alert(data.msg);
					goList();
				} else {
					alert(data.msg);
				}
				manualModalClose();
			}
		});
	}
});

function manualFileInsert(manualSeq) {
	var form = jQuery("#manualModal")[0];
    var formData = new FormData(form);
    formData.append("file", jQuery("#manualUrlFile")[0].files[0]);
    jQuery.ajax({
          url : "/contents/basic/data/manualFileInsert.do"
        , type : "POST"
        , processData : false
        , contentType : false
        , data : formData
    });
}


function changeType() {
	var name = $(arguments[0]).attr("name");
	name = name.replace("Type", "") + "Url";
	
	if($(arguments[0]).val() == "F") {
		$("#manualUrlL").css("display", "none");
		$("#manualUrlLink").val("");
		$("#manualUrlLink").attr("disabled", true);
		$("#manualUrlLink").removeAttr("required");
		
		if($(".upload-name").val() != '파일을 선택해 주세요.'){
			$("#manualUrlFile").attr("validate",false);
			$("#manualUrlFile").removeAttr("required");
		}else{
			$("#manualUrlFile").attr("validate",true);
			$("#manualUrlFile").attr("required", true);
		}
		$("#manualUrlFile").attr("disabled", false);
		$("#manualUrlF").css("display", "flex");
	}else{
		$("#manualUrlF").css("display", "none");
		$("#manualUrlFile").val("");
		$("#manualUrlFile").attr("disabled", true);
		$("#manualUrlFile").removeAttr("required");
		
		$("#manualUrlLink").attr("disabled", false);
		$("#manualUrlLink").attr("required", true);
		$("#manualUrlL").css("display", "block");
	}
	$("#manualModal").validator('update');
}

function groupModalClose(){
	$("#groupAppKind").val("");
	$("#groupManualName").val("");
	$("#groupManualCode").val("");
	$("#groupManualUseYn").val("Y");
	$("#hiddenGroupManualCode").val("");
	$("#hiddenGroupManualMode").val("");
	$("#groupManualCode").attr("disabled", false);
	manualGroupModal.data("kendoDialog").close();
}

function manualModalClose(){
	$("#manualAppKind").val("");
	$("#manualTitle").val("");
	$("#manualUrlFile").val("");
	$("#manualUrlLink").val("");
	$(".upload-name").val("파일을 선택해 주세요.");
	$("input[name=manualType]:input[value='L']").prop("checked", true);
	changeType($("#manualTypeL"));
	$("#manualName option").remove();
	$("#manualName").append("<option value=''>구분을 선택해주세요.</option>");
	$("#manualVersion").val("");
	$("#manualUseYn").val("Y");
	$("#hiddenManualSeq").val("");
	$("#hiddenManualMode").val("");
	manualModal.data("kendoDialog").close();
}
</script>