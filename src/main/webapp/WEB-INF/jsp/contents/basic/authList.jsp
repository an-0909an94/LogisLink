<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>

<div id="divAuthInsert" class="editor_wrap p-0">
	<form id="modal" name="modal" data-toggle="validator" role="form" autocomplete="off">
	<div class="modalEditor" id="authInsert">
		<div id="popGrid"></div>
		<div class="modalHeader">
			<div class="form-group row">
                <label class="col-form-label modal-big-name required">권한이름</label>
                <div class="input-group input-group-sm col middle-name form-group">
                    <input type="text" class="form-control form-control-sm" id="modalAuthName" name="modalAuthName" type="text" required>
                    <div style="position: absolute;" class="help-block with-errors"></div>
                </div>
            </div>
            <div class="form-group row">
                <label class="col-form-label modal-big-name required">권한코드</label>
                <div class="input-group input-group-sm col middle-name form-group">
                    <input type="text" class="form-control form-control-sm" id="modalAuthSeq" name="modalAuthSeq"
                    pattern="^[0-9]*$" data-pattern-error="숫자만 입력해 주세요." required>
                    <div style="position: absolute;" class="help-block with-errors"></div>
                </div>
            </div>
		</div>
		<div class="editor_btns">
			<div class="padding">
		        <button type="submit"  class="k-pager-refresh k-button"><b class="btn-b"><i class="k-icon k-i-check"></i><strong>저장</strong></b></button>
		        <a id="closeBtn" onclick="modalClose()" class="k-pager-refresh k-button"><b class="btn-g"><i class="k-icon k-i-cancel"></i>닫기</b></a>
	        </div>
	    </div>
	</div>
	</form>
</div>

<div class="header">
	
	<div class="summary p30">
		<div class="hdr-tit">
			<P id="headerTitle">권한관리</P>
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
													<button type="button" id="insert_btn" class="k-pager-refresh k-button"><b class="btn-b"><i class="k-icon k-i-copy"></i><strong>권한생성</strong></b></button> 
												</c:if>
												<c:if test="${menuAuth.editYn eq 'Y'}">
													<a href="javascript:fSubmit('E');" class="k-pager-refresh k-button"><b class="btn-b"><i class="k-icon k-i-check"></i>수정</b></a>
												</c:if>
												<c:if test="${menuAuth.deleteYn eq 'Y'}">
													<a href="javascript:fSubmit('D');" class="k-pager-refresh k-button"><b class="btn-b"><i class="k-icon k-i-cancel"></i>삭제</b></a>
												</c:if>
											</div>
										</div>
									</div>
								</div>
							</div>
							<div style="min-width: 500px;">
								<form id="f" name="f" method="post">
									<input type="hidden" id="gridData" name="gridData">
									<div>
										<div class="splitter" style="float:left; min-height:660px; float:left; width:20%; border: 0;">
											<div id="grid"></div>
										</div>
										<div class="splitter" style="float:right; min-height:660px; float:right; width:80%; border: 0;">
											<div id="subGrid"></div>
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
var userColumns = [
	{ field: "authSeq", title: "권한코드"},
	{ field: "authName", title: "권한명", width: 100 }
];

var menuColumns = [
	{field: "menuSeq", title: "menuSeq", hidden: true},
	{field: "authSeq", title: "authSeq", hidden: true},
	{field: "parentSeq", title: "parentSeq", hidden: true},
	{field: "parentName", title: "대메뉴명"},
	{field: "menuName", title: "메뉴명"},
	{ field: "readYn", title: "조회", width: 100, editable:function(e) {return false;}, 
	    headerTemplate: '<div class="auth-radio-or-checkBox">'
		 + 					'<input style="width: 13px;height: 13px;" type="checkbox" name="readAllCheck" id="readAllCheck" class="readAllCheck"/>'
	     + 					'<label style="display: inline;font-size: 14px;" for="readAllCheck">조회</label>'
	     + 				'</div>',
	    
		template: "#if(parentSeq==0){#<div class='auth-radio-or-checkBox'>"
				+ 						"<input style='width: 13px;height: 13px;' type='checkbox' name='readYn' id='readYn#=menuSeq#' #= (readYn == 'Y') ? checked ='checked' : ''# class='readYnAll'/>"
				+ 					 	"<label for='readYn#=menuSeq#'></label>"
				+ 					 "</div> #} "
				+ "else{#<div class='auth-radio-or-checkBox'>"
				+ 		 	"<input style='width: 13px;height: 13px;' type='checkbox' name='readYn#=parentSeq#' id='readSort#=sort#' #= (readYn == 'Y') ? checked ='checked' : '' # class='readYn'/>"
				+ 			"<label for='readSort#=sort#'></label>"
				+		"</div>#} # " 
	},
	{ field: "writeYn", title: "추가", width: 100, editable:function(e) {return false;}, 
		headerTemplate: '<div class="auth-radio-or-checkBox">'
		+ 					'<input style="width: 13px;height: 13px;" type="checkbox" name="writeAllCheck" id="writeAllCheck" class="writeAllCheck"/>'
	    + 					'<label style="display: inline;font-size: 14px;" for="writeAllCheck">추가</label>'
		+ 				'</div>',
		     
		template: "#if(parentSeq==0){#<div class='auth-radio-or-checkBox'>"
				+						 "<input style='width: 13px;height: 13px;' type='checkbox' name='writeYn' id='writeYn#=menuSeq#' #= (writeYn == 'Y') ? checked ='checked' : ''# class='writeYnAll'/>"
				+		 				 "<label for='writeYn#=menuSeq#'></label>"
				+					 "</div> #} "
				+ "else{#<div class='auth-radio-or-checkBox'>"
				+			"<input style='width: 13px;height: 13px;' type='checkbox' name='writeYn#=parentSeq#' id='writeSort#=sort#' #= (writeYn == 'Y') ? checked ='checked' : '' # class='writeYn'/>"
				+			"<label for='writeSort#=sort#'></label>"
				+		"</div>#} # " 
	},
	{ field: "editYn", title: "수정", width: 100, editable:function(e) {return false;},
		headerTemplate: '<div class="auth-radio-or-checkBox">'
			 + 				'<input style="width: 13px;height: 13px;" type="checkbox" name="editAllCheck" id="editAllCheck" class="editAllCheck"/>'
		     + 				'<label style="display: inline;font-size: 14px;" for="editAllCheck">수정</label>'
			 +			'</div>',
		     
		template: "#if(parentSeq==0){#<div class='auth-radio-or-checkBox'>"
				+ 					 	"<input style='width: 13px;height: 13px;' type='checkbox' name='editYn' id='editYn#=menuSeq#' #= (editYn == 'Y') ? checked = 'checked' : ''# class='editYnAll'/>"
				+						"<label for='editYn#=menuSeq#'></label>"
				+					 "</div> #} "
				+ "else{#<div class='auth-radio-or-checkBox'>"
				+	   	    "<input style='width: 13px;height: 13px;' type='checkbox' name='editYn#=parentSeq#' id='editSort#=sort#' #= (editYn == 'Y') ? checked ='checked' : '' # class='editYn'/>"
				+		    "<label for='editSort#=sort#'></label>"
				+	    "</div>#} # " 
	},
	{ field: "deleteYn", title: "삭제", width: 100, editable:function(e) {return false;}, 
		headerTemplate: '<div class="auth-radio-or-checkBox">'
			 +				'<input style="width: 13px;height: 13px;" type="checkbox" name="deleteAllCheck" id="deleteAllCheck" class="deleteAllCheck"/>'
		     +				'<label style="display: inline;font-size: 14px;" for="deleteAllCheck">삭제</label>'
			 +			'</div>',
		     
		template: "#if(parentSeq==0){#<div class='auth-radio-or-checkBox'>"
				+					 	"<input style='width: 13px;height: 13px;' type='checkbox' name='deleteYn' id='deleteYn#=menuSeq#' #= (deleteYn == 'Y') ? checked = 'checked' : ''# class='deleteYnAll'/>"
				+						"<label for='deleteYn#=menuSeq#'></label>"
				+					 "</div> #} "
				+ "else{#<div class='auth-radio-or-checkBox'>"
				+ 			"<input style='width: 13px;height: 13px;' type='checkbox' name='deleteYn#=parentSeq#' id='deleteSort#=sort#' #= (deleteYn == 'Y') ? checked ='checked' : '' # class='deleteYn'/>"
				+			"<label for='deleteSort#=sort#'></label>"
				+	    "</div>#} # " 
	},
	{ field: "printYn", title: "출력", width: 100, editable:function(e) {return false;},
		headerTemplate: '<div class="auth-radio-or-checkBox">'
			 +				'<input style="width: 13px;height: 13px;" type="checkbox" name="printAllCheck" id="printAllCheck" class="printAllCheck"/>'
		     +				'<label style="display: inline;font-size: 14px;" for="printAllCheck">출력</label>'
			 +			'</div>',
		     
		template: "#if(parentSeq==0){#<div class='auth-radio-or-checkBox'>"
				+ 					 	"<input style='width: 13px;height: 13px;' type='checkbox' name='printYn' id='printYn#=menuSeq#' #= (printYn == 'Y') ? checked = 'checked' : ''# class='printYnAll'/>"
				+						"<label for='printYn#=menuSeq#'></label>"
				+					 "</div> #} "
				+ "else{#<div class='auth-radio-or-checkBox'>"
				+			"<input style='width: 13px;height: 13px;' type='checkbox' name='printYn#=parentSeq#' id='printSort#=sort#' #= (printYn == 'Y') ? checked ='checked' : '' # class='printYn'/>"
				+			"<label for='printSort#=sort#'></label>"
				+	    "</div>#} # " 		
	}
];

var popColumns = [
	{ field: "authSeq", title: "<input id='checkAll' class='checkAll' type='checkbox' />", template: "<input type=\"checkbox\" name=\"authCheck\" class=\"authCheck\" id=\"authCheck#=authSeq#\" value='#= authSeq#'  />", width: 50},
	{ field: "rNum", title: "No", width: 50},
	{ field: "authName", title: "권한명", width: 100 }
]; 


var oGrid = null;
oGrid = new gridData("grid");
oGrid.initGrid();
oGrid.setSendUrl("/contents/basic/data/authUserList.do");
oGrid.setSelectable(true);
oGrid.setPageable(false);
oGrid.setGrid(userColumns);

var oSubGrid = null;
oSubGrid = new gridData("subGrid");
oSubGrid.initGrid();
oSubGrid.setSendUrl("/contents/basic/data/authList.do");
oSubGrid.setEditable(false);
oSubGrid.setSortable(false);
oSubGrid.setPageable(false);
oSubGrid.setGrid(menuColumns); 


$(document).ready(function(){
	$(".splitter").kendoSplitter({
        orientation: "vertical",
        panes: [{resizable:true}, {resizable:true}]
    }); 
	
	goList();
	
	//권한 생성 modal
	modal = $("#divAuthInsert");
	modalButton = $("#insert_btn");

	modalButton.click(function () {
	    modal.data("kendoDialog").open();
	});

	modal.kendoDialog({
		width: "446px",
		height: "280px",
		visible: false,
		title: "권한생성",
		closable: true,
		modal: false,
		close: function(){modalButton.fadeIn();}
	});
});


function goList() {
	var grid = $("#grid").data("kendoGrid");
	
	//datasource setting
	oGrid.setSearchData({});
	//oGrid.setDataSource();
	grid.setDataSource(oGrid.gridOption.dataSource);

	grid.bind("change", onChange);
	$("#subGrid").data("kendoGrid").setDataSource([]);
}

function onChange(e){
	var row = this.select();
	var data = this.dataItem(row);
	
	$("#authSeq").val(data.authSeq);
	viewAuth(data.authSeq);
}

function viewAuth(){	
	var searchData = {
			authSeq : arguments[0]
	}
	
	var subGrid = $("#subGrid").data("kendoGrid");
	oSubGrid.setSearchData(searchData);
	subGrid.setDataSource(oSubGrid.gridOption.dataSource);
	
	changeEvent("readYnAll");
	changeEvent("writeYnAll");
	changeEvent("editYnAll");
	changeEvent("deleteYnAll");
	changeEvent("printYnAll");
	
	changeEvent("readYn");
	changeEvent("writeYn");
	changeEvent("editYn");
	changeEvent("deleteYn");
	changeEvent("printYn");
	
	setTimeout(function() {
		allCheckChange("readAllCheck");
		allCheckChange("writeAllCheck");
		allCheckChange("editAllCheck");
		allCheckChange("deleteAllCheck");
		allCheckChange("printAllCheck");
	}, 100);
	
}

function fSubmit(mode){
	var grid = $("#grid").data("kendoGrid");
	var selectedItem = grid.dataItem(grid.select());
	
	if(selectedItem == null){
		alert("권한을 선택하세요.");
	} else{
		if(mode == "E"){
			var subGrid = $("#subGrid").data("kendoGrid");
		 	var gridData = JSON.stringify(subGrid.dataSource._data);
		 	$("#gridData").val(gridData);
		 	$.ajax({
				url: "/contents/basic/data/authWrite.do",
				type: "POST",
				dataType: "json",
				data: $("#f").serialize(),
				success: function(data){
					if(data.result) {
						alert(data.msg);
						goList();	
					} else {
						alert(data.msg);
					}
				}
			});	
		}else if(mode == "D"){
			$.ajax({
				url: "/contents/basic/data/authDelete.do",
				type: "POST",
				dataType: "json",
				data: "authSeq=" + selectedItem.authSeq,
				success: function(data){
					if(data.result) {
						alert(data.msg);
						goList();	
					} else {
						alert(data.msg);
					}
				}
			});	
		}
	}
}

$('#modal').validator().on('submit', function (e) {
	if (e.isDefaultPrevented()) {
		alert("항목을 입력해 주세요.")
	} else {
		// 이벤트 초기화 (submit 동작 중단)
		e.preventDefault();
		$.ajax({		
			url: "/contents/basic/data/authInsert.do",
			type: "POST",
			dataType: "json",
			data: "authSeq=" + $("#modalAuthSeq").val() + "&authName=" + $("#modalAuthName").val(),
			success: function(data){
				if (data.result) {
					alert(data.msg);
					goList();
					modalClose();
				} else {
					alert(data.msg);
				}
			}
		});
	}
});

function modalClose(){
	$("#modalAuthSeq").val("");
	$("#modalAuthName").val("");
	modal.data("kendoDialog").close();
	$(".list-unstyled").remove();
}

/*
 * grid checkbox click event
 */
function changeEvent(name){
	//checkbox change event가 발생할 때마다, grid 데이터를 Y/N 로 변경해준다.
	$("#subGrid .k-grid-content").on("change", "input." + name, function(e) {
		var subGrid = $("#subGrid").data("kendoGrid");
		var checked = $(this).is(":checked");
		var col = $(this).closest("td");
		
		dataItem = subGrid.dataItem($(e.target).closest("tr"));
		eval("dataItem." + name.replace("All", "") + "=checked ? 'Y' : 'N'; ");
		
		//전체선택 체크여부 확인
		if($("input:checkbox[class='" + name + "']").length != $("input:checkbox[class='" + name + "']:checked").length){
			$("input:checkbox[class='" + name.replace("Yn","") + "AllCheck']").prop("checked",false);
		}else{
			$("input:checkbox[class='" + name.replace("Yn","") + "AllCheck']").prop("checked",true);
		}
		
		//대메뉴의 클릭이벤트일 경우, 하위 메뉴도 적용한다.
		if(name.indexOf("All") > 0) {
			$("input[name=" + name.replace("All", "") + dataItem.menuSeq + "]").each(function(){				
				$(this).prop("checked", checked);
				$(this).trigger("change");
			});
		} else {
			//하위 메뉴의 클릭이벤트 값이 true 일 경우, 대메뉴에도 적용한다.
			if(checked) {
				$("#" + name + dataItem.parentSeq).prop("checked", true);
				dataItem = subGrid.dataItem($("#readYn" + dataItem.parentSeq).closest("tr"));
				eval("dataItem." + name + "=checked ? 'Y' : 'N'; ");
			}else{
				//하위 메뉴의 클릭이벤트 값이 0일 경우 대메뉴 체크 해제
				if($("input:checkbox[name='" + name + dataItem.parentSeq + "']:checked").length <= 0){
					$("#" + name + dataItem.parentSeq).prop("checked", false);
					dataItem = subGrid.dataItem($("#readYn" + dataItem.parentSeq).closest("tr"));
					eval("dataItem." + name + "=checked ? 'Y' : 'N'; ");
				}
			}
		}
	}); 
}

$("#readAllCheck").click(function(){
	allCheck("readAllCheck");
})
$("#writeAllCheck").click(function(){
	allCheck("writeAllCheck");
})
$("#editAllCheck").click(function(){
	allCheck("editAllCheck");
})
$("#deleteAllCheck").click(function(){
	allCheck("deleteAllCheck");
})
$("#printAllCheck").click(function(){
	allCheck("printAllCheck");
})

function allCheck(name){
	$("#subGrid").on("change", "input." + name , function(e) {
		type = name.replace("AllCheck", "");
		var subGrid = $("#subGrid").data("kendoGrid");
		var checked = $(this).is(":checked");
		var col = $(this).closest("td");
		
		dataItem = subGrid.dataItem($(e.target).closest("tr"));
		eval("dataItem." + name + "=checked ? 'Y' : 'N'; ");
		
		if(name.indexOf("All") > 0) {
			$("input[name=" + type +"Yn]").each(function(){				
				$(this).prop("checked", checked);
				$(this).trigger("change");
			});
		}
	});
}

function allCheckChange(name){
	check = name.replace("AllCheck", "Yn");
	
	if($("input:checkbox[class='" + check +"']").length != $("input:checkbox[class='" + check +"']:checked").length){
		$("input:checkbox[class='" + name +"']").prop("checked",false);
	}else{
		$("input:checkbox[class='" + name +"']").prop("checked",true);
	}
}

</script>