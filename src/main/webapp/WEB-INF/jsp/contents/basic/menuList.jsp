<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<!-- modal -->
<div id="divAddGuide" class="editor-warp p-0">
	<div class="modalEditor" id="addGuide">
		<div id="popGrid"></div>
		<div class="modalHeader">
		<form id="fGuide" name="fGuide" method="post" enctype="multipart/form-data">
			<input type="hidden" name="menuSeq" id="mMenuSeq">
			<c:forEach var="idx" begin="1" end="3">
				<div class="form-group mt0">
	                <label class="col-form-label modal-big-name">매뉴얼유형</label>
	                <div class="input-group input-group-sm wd190 middle-name">
						<div class="input-group input-group-sm col radio-or-checkBox">
	                    	<input id="manual${idx}TypeL" type="radio" name="manual${idx}Type" value="L" onClick="changeType(this);" checked>
	                    	<label for="manual${idx}TypeL" class="label-margin">
	                    	<span>url</span>
	                    	</label>
	                    </div>
	                    <div class="input-group input-group-sm wd90 radio-or-checkBox">
	                    	<input id="manual${idx}TypeF" type="radio" name="manual${idx}Type" value="F" onClick="changeType(this);" >
	                    	<label for="manual${idx}TypeF" class="label-margin">
	                    	<span>파일</span>
	                    	</label>
	                    </div>
	                </div>
	                <label class="col-form-label modal-big-name">매뉴얼${idx}</label>
	                <div class="input-group input-group-sm wd190 middle-name">
	                    <input type="text" class="form-control form-control-sm" style="width:100%" id="manual${idx}Url" name="manual${idx}Url" placeholder="http(s)://">
	                </div>
	            </div>
				<div class="form-group row attachedFiles" id="manualAttachedFile${idx}" style="display:none;" >
	            </div>
			</c:forEach>
 			
			<c:forEach var="idx" begin="1" end="3">
				<div class="form-group form-group-sm">
	                <label class="col-form-label modal-big-name">튜토리얼유형</label>
	                <div class="input-group input-group-sm wd190 middle-name">
						<div class="input-group input-group-sm wd90 radio-or-checkBox">
	                    	<input id="tutorial${idx}TypeL" type="radio" name="tutorial${idx}Type" value="L" onClick="changeType(this);" checked>
	                    	<label for="tutorial${idx}TypeL" class="label-margin">
	                    	<span>url</span>
	                    	</label>
	                    </div>
	                    <div class="input-group input-group-sm wd90 radio-or-checkBox">
	                    	<input id="tutorial${idx}TypeF" type="radio" name="tutorial${idx}Type" value="F" onClick="changeType(this);" >
	                    	<label for="tutorial${idx}TypeF" class="label-margin">
	                    	<span>파일</span>
	                    	</label>
	                    </div>
	                </div>
	                <label class="col-form-label modal-big-name">튜토리얼${idx}</label>
	                <div class="input-group input-group-sm wd190 middle-name">
	                    <input type="text" class="form-control form-control-sm" style="width:100%" id="tutorial${idx}Url" name="tutorial${idx}Url" placeholder="http(s)://">
	                </div>
	            </div>
				<div class="form-group row attachedFiles" id="tutorialAttachedFile${idx}" style="display:none;" >	
	            </div>
			</c:forEach>
		</form>	
		</div>
		<div class="editor_btns">
			<div class="padding">
		        <a onclick="modalSubmit()" class="k-pager-refresh k-button btn_b"><b>저장</b></a>
		        <a id="closeBtn" onclick="modalClose()" class="k-pager-refresh k-button"><b class="btn-g">닫기</b></a>
	        </div>
	    </div>
	</div>	
</div>
<div class="header">
	<div class="summary p30">
		<div class="hdr-tit">
			<P id="headerTitle">메뉴관리</P>
		</div>
	</div>
	<div class="contents">
		<div class="box" style="width: 100%;">
			<div class="toolbar row">
				<div class="tool_form col">
					<div class="btn-row">
						<div class="tool_group">
							<div class="padding" style="margin-bottom: 10px">
								<c:if test="${menuAuth.writeYn eq 'Y'}">
									<!--
									<a class="k-pager-refresh k-button" onClick="viewGuide();"
									id="btnEdit"><b class="btn-b"><i class="k-icon k-i-info"></i>도움말관리</b></a>
									-->

									<button onclick="viewGuide();" type="button"
											class="form-control-sm middle-button btn_75 btn_b div-min-col-1">
										<strong>도움말관리</strong>
									</button>
								</c:if>
								<c:if test="${menuAuth.writeYn eq 'Y'}">
									<!--
									<a class="k-button k-i-plus" onClick="fSubmit('N');"
									id="btnAdd"><b class="btn-b"><i class="k-icon k-i-plus"></i>추가</b></a>
									-->

									<button onclick="fSubmit('N');" type="button"
											class="form-control-sm middle-button btn_75 btn_b div-min-col-1">
										<strong>추가</strong>
									</button>

								</c:if>
								<c:if test="${menuAuth.editYn eq 'Y'}">
									<!--
									<a class="k-pager-refresh k-button" onClick="fSubmit('E');"
									id="btnEdit"><b class="btn-b"><i
									class="k-icon k-i-check"></i>수정</b></a>
									-->

									<button onclick="fSubmit('E');" type="button"
											class="form-control-sm middle-button btn_75 btn_b div-min-col-1">
										<strong>수정</strong>
									</button>
								</c:if>
								<c:if test="${menuAuth.deleteYn eq 'Y'}">
									<!--
									<a class="k-pager-refresh k-button" onClick="fSubmit('D')"
									id="btnDel"><b class="btn-b"><i
									class="k-icon k-i-cancel"></i>삭제</b></a>
									-->

									<button onclick="fSubmit('D');" type="button"
											class="form-control-sm middle-button btn_75 btn_black div-min-col-1">
										<strong>삭제</strong>
									</button>

								</c:if>
								<c:if test="${menuAuth.writeYn eq 'Y'}">
									<!--
									<a class="k-pager-refresh k-button" onClick="fSubmit('R')"><b
									class="btn-b"><i class="k-icon k-i-refresh"></i>초기화</b></a>
									-->

									<button onclick="fSubmit('D');" type="button"
											class="form-control-sm middle-button btn_75 btn_black div-min-col-1">
										<strong>초기화</strong>
									</button>
								</c:if>
								<c:if test="${menuAuth.printYn eq 'Y'}">
									<!--
									<a class="k-button k-i-file-excel" onClick="goExcel();"><b
									class="btn-x"><i class="k-icon k-i-file-excel"></i>엑셀출력</b></a>
									-->
									<button onclick="goExcel();" type="button" class="form-control-sm middle-button btn_75 btn_green">엑셀출력</button>
								</c:if>
							</div>
						</div>
					</div>
				</div>
			</div><!-- /toolbar -->
			<div>
				<div style="float:left;width:40%;">
					<form id="f" name="f" method="post">
						<div class="cont-b-head">
							<h4>메뉴정보</h4>
						</div>
						<div style="margin-right: 27px;" class="gray_box">
							<div class="form-group row">
								<div class="input-group input-group-sm wd228 middle-name div-min-col-1">
									<strong>메뉴구분</strong>
									<div class="input-group input-group-sm">
										<div class="input-group input-group-sm wd90 radio-or-checkBox">
											<input id="depth1" type="radio" name="depth" value="1"
												   checked>
											<label for="depth1" class="label-margin">
												<span>대메뉴</span>
											</label>
										</div>
										<div class="input-group input-group-sm wd90 radio-or-checkBox">
											<input id="depth2" type="radio" name="depth" value="2">
											<label for="depth2" class="label-margin">
												<span>중메뉴</span>
											</label>
										</div>
									</div>
								</div>
								<div class="input-group input-group-sm wd228 middle-name">
									<strong>대메뉴</strong>
									<select name="parentSeq" id="parentSeq"></select>
								</div>
							</div>
							<div class="form-group row">
								<div class="input-group input-group-sm wd228 middle-name div-min-col-1">
									<strong>메뉴코드</strong>
									<input name="menuCode" id="menuCode"/>
								</div>
								<div class="input-group input-group-sm wd228 middle-name">
									<strong>메뉴명</strong>
									<input name="menuName" id="menuName"/>
								</div>
							</div>

							<div class="form-group row">
								<div class="input-group input-group-sm wd228 middle-name div-min-col-1">
									<strong>메뉴권한</strong>
									<input type="text" name="authType" id="authType"
										   value="R,W,E,D,P"/>
								</div>
								<div class="input-group input-group-sm wd228 middle-name">
									<strong>URL</strong>
									<input type="text" name="pageUrl" id="pageUrl" required/>
								</div>
							</div>

							<div class="form-group row">
								<div class="input-group input-group-sm wd228 middle-name">
									<strong>메뉴번호</strong>
									<input type="text" name="menuSeq" id="menuSeq" required/>
								</div>
								<div class="input-group input-group-sm wd228 middle-name"></div>
							</div>
						</div>
					</form>
				</div>
				<div id="splitter" style="min-height:calc(100vh - 180px); float:right; width:60%; border: 0;">
					<div id="grid"></div>
				</div>
			</div>
		</div>
		<!--  -->
	</div>
	<!-- content -->
</div>

<script type="text/javascript">
var columns = [
	{field: "menuSeq", title: "seq", hidden: true},
	{field: "menuCode", title: "메뉴코드", width: 70},
	{field: "parentName", title: "대메뉴명", width: 80},
	{field: "menuName", title: "메뉴명", width: 80},
	{field: "authType", title: "메뉴권한", width: 70},
	{field: "pageUrl", title: "URL", width: 180},
	{field: "regdate", title: "등록일", width: 80},
	{field: "manual1Type", title: "manual1Type", hidden: true},
	{field: "manual1Url", title: "manual1Url", hidden: true},
	{field: "manual2Type", title: "manual2Type", hidden: true},
	{field: "manual2Url", title: "manual2Url", hidden: true},
	{field: "manual3Type", title: "manual3Type", hidden: true},
	{field: "manual3Url", title: "manual3Url", hidden: true},
	{field: "tutorial1Type", title: "tutorial1Type", hidden: true},
	{field: "tutorial1Url", title: "tutorial1Url", hidden: true},
	{field: "tutorial2Type", title: "tutorial2Type", hidden: true},
	{field: "tutorial2Url", title: "tutorial2Url", hidden: true},
	{field: "tutorial3Type", title: "tutorial3Type", hidden: true},
	{field: "tutorial3Url", title: "tutorial3Url", hidden: true},
	{template: "<a class=\"k-button\" href=\"javascript:editSort(#=menuSeq#, '#=parentSeq#', 'up')\"><i class='k-icon k-i-arrow-chevron-up'></i></a><a class=\"k-button\" href=\"javascript:editSort(#=menuSeq#, '#=parentSeq#', 'down')\"><i class='k-icon k-i-arrow-chevron-down'></i></a>", title: "정렬", width: 80 }  
];

var headerTitle = ($("#headerTitle").text());
var oGrid = null;	
oGrid = new gridData("grid");
oGrid.initGrid();
oGrid.setSortable(false);
oGrid.setSendUrl("/contents/basic/data/menuList.do");
oGrid.setExcelFile(headerTitle+"(" + new Date().yyyymmdd() + ").xlsx");
oGrid.setPageable(false);
oGrid.setSelectable(true);

$(document).ready(function(){
	$("#splitter").kendoSplitter({
        orientation: "vertical",
        panes: [{resizable:true}, {resizable:true}]
    }); 
	

	GuideModal = $("#divAddGuide");

	GuideModal.kendoDialog({
		width: "680px",
		height: "350px",
		visible: false,
		title: "도움말관리",
		closable: true,
		modal: false,
		close: function(){}
	})


	if("${menuAuth.editYn}" == "Y") $("#btnEdit").hide();
	if("${menuAuth.deleteYn}" == "Y")	$("#btnDel").hide();
	
	$("input:radio[name='depth']").prop('checked',false);
	var depth = 1;
	 	$.ajax({
		url: "/contents/basic/data/menuList.do",
		type: "POST",
		dataType: "json",
		data: "depth=" + depth,
		success: function(data){
			var s = "";
			s += "<option value='0' selected>" + "대메뉴" + "</option>";
			for(var i=0, item; item=data.data[i]; i++){
				s += "<option value=\"" + item.menuSeq + "\""
				s += ">" + item.menuName + "</option>";
			}
			$("#parentSeq").append(s);
		}
	}); 
	goList();
}); 

function viewGuide() {

	var grid = $("#grid").data("kendoGrid");
	var selectedItem = grid.dataItem(grid.select());
	$("#fGuide")[0].reset();
	$("#mMenuSeq").val(selectedItem.menuSeq);
	//Util.setPageData(selectedItem);
	$("#manual1Type" + selectedItem.manual1Type).prop("checked", true);
	$("#manual2Type" + selectedItem.manual2Type).prop("checked", true);
	$("#manual3Type" + selectedItem.manual3Type).prop("checked", true);
	$("#tutorial1Type" + selectedItem.tutorial1Type).prop("checked", true);
	$("#tutorial2Type" + selectedItem.tutorial2Type).prop("checked", true);
	$("#tutorial3Type" + selectedItem.tutorial3Type).prop("checked", true);
	$(".attachedFiles").hide();

	for(var i=1; i<=3; i++) {
		var fileinfo = "<div style=\"width:100%;text-align:right;\">* 첨부된 파일 : ";
		if($("#fGuide input[name=manual" + i + "Type]:checked").val() == "F") {
			$("#manual" + i + "Url").attr("type", "file");
			var fileName = eval("selectedItem.manual" + i + "Url");
			fileinfo += "<a href=\"/cmm/guideDownload.do?fileName=" + escape(fileName) + "\">"
			fileinfo += eval("selectedItem.manual" + i + "Url");
			fileinfo += "</a>"
			fileinfo += "</div>";
			$("#manualAttachedFile" + i).html(fileinfo);
			$("#manualAttachedFile" + i).show();
		} else {
			$("#manual" + i + "Url").attr("type", "text");
			$("#manual" + i + "Url").val(eval("selectedItem.manual" + i + "Url"));
		}

		var fileinfo = "<div style=\"width:100%;text-align:right;\">* 첨부된 파일 : ";
		if($("#fGuide input[name=tutorial" + i + "Type]:checked").val() == "F") {
			$("#tutorial" + i + "Url").attr("type", "file");
			var fileName = eval("selectedItem.tutorial" + i + "Url");
			fileinfo += "<a href=\"/cmm/guideDownload.do?fileName=" + escape(fileName) + "\">"
			fileinfo += eval("selectedItem.tutorial" + i + "Url");
			fileinfo += "</a>"
			fileinfo += "</div>";
			$("#tutorialAttachedFile" + i).html(fileinfo);
			$("#tutorialAttachedFile" + i).show();
		} else {
			$("#tutorial" + i + "Url").attr("type", "text");
			$("#tutorial" + i + "Url").val(eval("selectedItem.tutorial" + i + "Url"));
		}
	}
	
	
	
	GuideModal.data("kendoDialog").open();
}

function modalClose(){
	GuideModal.data("kendoDialog").close();
}

function editSort(){
	var param = {
			menuSeq : arguments[0],
			parentSeq: arguments[1],
			gbn: arguments[2]
	
	};
	 $.ajax({
		url: "/contents/basic/data/menuSortEdit.do",
		type: "POST",
		dataType: "json",
		data: param,
		success: function(data){
			if(data.result) {
				goList();	
			} else {
				alert(data.msg);
			}
		}
	}); 
}


function goList() {
	var grid = $("#grid").data("kendoGrid");

	oGrid.setSearchData({});
	
	if(grid == null) {
		oGrid.setGrid(columns);
		grid = $("#grid").data("kendoGrid");
		grid.bind("change", onChange);
	} else {
		grid.setDataSource(oGrid.gridOption.dataSource);
	}
	//var data = grid.dataSource.data();
}
 
function onChange(e){
	var row = this.select();
	var data = this.dataItem(row);
	if(data != null) {
		Util.setPageData(data);
		$("#menuCode").prop("readonly", true);
		$("#menuSeq").prop("readonly", true);


		if("${menuAuth.writeYn}" == "Y")	$("#btnAdd").hide();
		if("${menuAuth.editYn}" == "Y")	$("#btnEdit").show();
		if("${menuAuth.deleteYn}" == "Y")	$("#btnDel").show();
		//radio button 별도 세팅
		$("#f input[name=depth]:input[value=" + data.depth + "]").prop("checked", true);
		if($('input:radio[id=depth1]').is(':checked')){
			$('#parentSeq').attr('disabled', true);
			$('#parentSeq').val("0");
			unlock(data.menuSeq, data.parentSeq);
		}
		if($('input:radio[id=depth2]').is(':checked')){
			$('#parentSeq').attr('disabled', false);
			$("select option[value='0']").prop('disabled',true);
			$("input[id=payment_01]:radio").removeAttr("disabled");
			unlock(data.menuSeq, data.parentSeq);
		}
	}
	
}


function unlock(menuSeq, parentSeq){
	$("[name='parentSeq'] option").not("[value='0']").removeAttr("disabled");
	$("input[id='depth1']").attr('disabled',true);
	$("input[id='depth2']").removeAttr("disabled");
	if(parentSeq == 0){
		$("select option[value="+ menuSeq +"]").prop('disabled',true);
		$("input[id='depth2']").attr('disabled',true);
		$("input[id='depth1']").removeAttr("disabled");
	}
}

$("input:radio[name=depth]").click(function(){
	if($('input:radio[id=depth1]').is(':checked')){
		$('#parentSeq').attr('disabled', true);
		$('#parentSeq').val("0");
	}
	if($('input:radio[id=depth2]').is(':checked')){
		$('#parentSeq').attr('disabled', false);
		$("select option[value='0']").prop('disabled',true);
	}
});

function fSubmit(mode) {
	var regexp = /^[0-9]*$/
	if((mode == "N") || (mode == "E") || (mode == "D")){
		var menuSeq = $("#menuSeq").val();
		var menuCode = $("#menuCode").val();
		var menuName = $("#menuName").val();
		var authType = $("#authType").val();
	
		if(!menuSeq) {
			alert("메뉴번호를 확인해 주세요.");
			return
		}
		if(!menuCode) {
			alert("메뉴코드를 확인해 주세요.");
			return
		}
		if(!menuName) {
			alert("메뉴명을 확인해 주세요.");
			return
		}
		if(!authType) {
			alert("메뉴권한을 확인해 주세요.");
			return
		}
		if(!regexp.test(menuSeq)){
			alert("메뉴번호 항목에 숫자만 입력해 주세요.");
			return 
		}
		
	}
	
	if(mode != "R"){
		if(mode == 'N'){
			if($('input:radio[name=depth]').is(':checked') == false){
				alert("메뉴구분을 선택해 주세요.");
				return;
			}
			
			if($("input:radio[name='depth']:checked"). val() == "2"){
				if($("#parentSeq").val() == null){
					alert("대메뉴를 선택해 주세요.")
					return;
				}
			}
		}
		$.ajax({
			url: "/contents/basic/data/menuWrite.do",
			type: "POST",
			dataType: "json",
			data: $("#f").serialize() + '&mode=' + mode,
			success: function(data){
				if (data.result) {
					alert(data.msg);
					location.reload();
				} else {
					alert(data.msg);
				}
			}
		});
	}
	if(mode == "R"){
		$("#f")[0].reset();
		$("input:radio[name='depth']").prop('checked',false);
		$("input[name='depth']").removeAttr("disabled");
		$("[name='parentSeq'] option").not("[value='0']").removeAttr("disabled");
		$('#parentSeq').attr('disabled', false);
		if($("#menuSeq").val() != '0'){
			$("#menuSeq").val('');
		}
		$("#menuCode").prop("readonly", false);
		$("#menuSeq").prop("readonly", false);

		if("${menuAuth.writeYn}" == "Y")	$("#btnAdd").show();
		if("${menuAuth.editYn}" == "Y")		$("#btnEdit").hide();
		if("${menuAuth.deleteYn}" == "Y")	$("#btnDel").hide();
		//grid 선택 해제
		var grid = $("#grid").data("kendoGrid");
		grid.clearSelection();		
	}
}

function modalSubmit() {
	$("#fGuide").ajaxForm({
		url: "/contents/basic/data/menuGuideEdit.do",
		contentType: false,
		dataType: "json",
		data: $("#fGuide").serialize(),
		success: function(data) {
			alert(data.msg);
			location.reload();
		}
	});

	$("#fGuide").submit();
}

function changeType() {
	var name = $(arguments[0]).attr("name");
	name = name.replace("Type", "") + "Url";
	
	if($(arguments[0]).val() == "F") {
		$("#" + name).attr("type", "file");
	} else {
		$("#" + name).attr("type", "text");
	}
}

//excel download
function goExcel(){
	$("#loading").show();
	var grid = $("#grid").data("kendoGrid");
	grid.saveAsExcel();
}
</script>