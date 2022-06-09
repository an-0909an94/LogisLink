<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>

<div class="pop-layer">
    <div class="editor_wrap pop-layer" id="layer1">
	    <div class="insertClose">
	    	<a class="insertCloseButton k-icon k-i-close" onclick="init_popup_close();"></a>
	    </div>
        <!-- wrap -->
        <div class="k-tabstrip-wrapper">
            <div id="editor_tabs" class="tabs_wrap k-widget k-tabstrip k-floatwrap k-tabstrip-top" data-role="tabstrip"
                tabindex="0" role="tablist" aria-activedescendant="editor_tabs_ts_active">
                <!-- content -->
                <div class="tab-content k-content k-state-active" id="editor_tabs-1" role="tabpanel"
                    aria-expanded="true" style="display: block;">
                    <div class="editor">
                        <fieldset>
		                    <legend id="board_legend">공지사항 등록</legend>
	                   		<form method="post" name="f" id="f" data-toggle="validator" role="form" autocomplete="off">
		                       <input type="hidden" name="boardSeq" id="boardSeq">
		                       <input type="hidden" name="boardTarget" id="boardTarget">
		                       <input type="hidden" name="custId" id="custId">
	                               <div class="form-group row">
	                                   <label class="col-form-label big-name">등록정보</label>
	                                   <div class="input-group input-group-sm col middle-name form-group">
	                                   <strong>등록자</strong>
	                                       <input type="text" class="form-control form-control-sm" name="userName" id="userName" readonly>
	                                   </div>
	                                   <div class="input-group input-group-sm col middle-name form-group">
	                                   <strong>등록일자</strong>
	                                       <input type="text" class="form-control form-control-sm" name="regdate" id="regdate" readonly>
	                                   </div>
	                                   <div class="input-group input-group-sm col middle-name form-group">
	                                   <strong>조회수</strong>
	                                       <input type="text" class="form-control form-control-sm" name="readCnt" id="readCnt" readonly>
	                                   </div>
	                               </div>
	                               
	                               <div class="form-group row">
	                                   	<label class="col-form-label big-name required">게시기간</label>	                                   
	                                   	<div class="input-group input-group-sm col middle-name form-group">
	                              			<input type="text"name="popSdate" id="popSdate" style="width: 100%" required>                             			
	                                   	</div>
										<span style="margin-top:10px">~</span>           
	                                   	<div class="input-group px;ut-group-sm col middle-name form-group">
	                                  		<input type="text" name="popEdate" id="popEdate" style="width: 100%" required>
	                                  	</div>	
	                               </div>    
	                               
	                               <div class="form-group row">	                               
	                                   	<label class="col-form-label big-name">게시대상</label>
	                                   	
										<div class="input-group input-group-sm col radio-or-checkBox ">										
						                   	<input id="chkBoardTarget09" type="checkbox" name="chkBoardTarget" value="09">
						                   	<label style="padding-right: 1.5em;" for="chkBoardTarget09" class="label-margin">
						                   		<span>차주</span>
						                   	</label>
						                   </div>
						                <div class="input-group input-group-sm col radio-or-checkBox ">
						                   	<input id="chkBoardTarget04" type="checkbox" name="chkBoardTarget" value="04">
						                   	<label style="padding-right: 1.5em;" for="chkBoardTarget04" class="label-margin">
						                   		<span>화주</span>
						                   	</label>
						                   </div>
						                <div class="input-group input-group-sm col radio-or-checkBox ">
						                   	<input id="chkBoardTarget03" type="checkbox" name="chkBoardTarget" value="03">
						                   	<label style="padding-right: 1.5em;" for="chkBoardTarget03" class="label-margin">
						                   		<span>운송사</span>
						                   	</label>
						                   </div>
						                <div class="input-group input-group-sm col radio-or-checkBox ">
						                   	<input id="chkBoardTarget02" type="checkbox" name="chkBoardTarget" value="02">
						                   	<label style="padding-right: 1.5em;" for="chkBoardTarget02" class="label-margin">
						                   		<span>주선사</span>
						                   	</label>
						                </div>   
	                               </div>
	                               
	                               <div class="form-group row">
	                                   <label class="col-form-label modal-big-name required">제목</label>
	                                   <div class="input-group input-group-sm col middle-name form-group">
	                                       <input type="text" class="form-control form-control-sm" name="title" id="title" required>
	                                       <div class="help-block with-errors"></div>
	                                   </div>
	                               </div>
	                               
	                               <div class="form-group row">
	                                   <label class="col-form-label modal-big-name required">내용</label>
	                                   <div class="input-group input-group-sm col middle-name form-group">
	                                       <textarea rows="22" class="form-control form-control-sm textarea" name="content" id="content" required></textarea>
	                                       <div class="help-block with-errors"></div>
	                                   </div>
	                               </div>
	                        	<button id="detailSubmit" type="submit"></button>
	                        </form>
	                        <form id="fileForm" name="fileForm" method="post" enctype="multipart/form-data">
	                           <input name="fileBoardSeq" id="fileBoardSeq" type="hidden">
	                           <div id="fileList"></div>
	                           <div class="editor_btns" style="text-align:center;">
			                       <div class="padding">
			                       	   <c:if test="${menuAuth.deleteYn eq 'Y'}">
			                       	   <a onclick="boardDelete();" class="k-pager-refresh k-button"><b class="btn-b"><i class="k-icon k-i-cancel"></i>삭제</b></a>
			                       	   </c:if>
			                       	   <c:if test="${menuAuth.writeYn eq 'Y'}">
									   <a onclick="detailForm();" class="k-pager-refresh k-button" id="btnSave"><b class="btn-b" id="btn_save"><i class="k-icon k-i-check"></i>저장</b></a>
									   </c:if>
			                       	   <c:if test="${menuAuth.editYn eq 'Y'}">
									   <a onclick="detailForm();" class="k-pager-refresh k-button" id="btnEdit"><b class="btn-b" id="btn_edit"><i class="k-icon k-i-check"></i>수정</b></a>
									   </c:if>
									   <a onclick="init_popup_close();" class="k-pager-refresh k-button"><b class="btn-g"><i class="k-icon k-i-cancel"></i>닫기</b></a>
							       </div>
						       </div>
							</form>
                        </fieldset>
                    </div>
				</div>
			</div>
		</div>
	</div>
</div>
<script type="text/javascript">
var g_mode = "";

$(document).ready(function(){

	$("#popSdate, #popEdate").kendoDatePicker({format:"yyyy-MM-dd"});
});

function fileName(fNo) {
	var fileTarget = $('.filebox .upload-hidden'+fNo); 
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
	$(this).siblings('#upload-name'+fNo).val(filename); 
	}); 
}

function init_pop(mode, data) {
	g_mode = mode;
	init();
	
	if(mode == "N"){
		$("#board_legend").text("공지사항 등록")
		$("#btnSave").show();
		$("#btnEdit").hide();
		$("#userName").val("${sessionScope.userInfo.userName}");
		$("#custId").val("${sessionScope.userInfo.custId}");
		$("#oldBoardSeq").val("");
		fileList('');
		$("#f input[name=chkBoardTarget]").each(function(){
			$(this).prop("checked", true);
		}); 
	}else if(mode == "E"){
		if("${menuAuth.writeYn}" == 'Y'){
			$("#board_legend").text("공지사항 수정")
		}else{
			$("#board_legend").text("공지사항")
			$("#content").attr("readonly", true);
			$("#content").addClass("noColorReadonly");
			$("#title").attr("readonly", true);
			$("#title").addClass("noColorReadonly");
		}
		
		$("#btnSave").hide();
		$("#btnEdit").show();
		fileList(data.data.boardSeq);
		Util.setPageData(data.data);
		var arrTarget = data.data.boardTarget.split(",");
		for(var i=0; i<arrTarget.length; i++) {
			if($("#chkBoardTarget" + arrTarget[i]).length > 0) {
				$("#chkBoardTarget" + arrTarget[i]).prop("checked", true);
			}
		}
	}
}

function init_popup_close() {
	$("#oldBoardSeq").val('');
	form_popup_close();
	init();
}

function init(){
	Util.formReset("", [".editor input",".editor select", ".editor textarea"],{});
	$(".list-unstyled").remove();
}

function fileList(boardSeq){
	var s = "";
		
	$.ajax({
		url: "/contents/notice/data/fileList.do",
		type: "POST",
		dataType: "json",
		data: "boardSeq=" + boardSeq, 
		success: function(data){
			if(data.result) {
				var item, i=0;
				for (i=0; item = data.data[i]; i++){
					s += "<div class=\"form-group row\">";
					s += "<label class=\"col-form-label modal-big-name\">첨부파일</label>";
					s += "<div class=\"input-group input-group-sm col middle-name form-group\">";
					if(item.fileName == null){
					s += "<div class=\"filebox\">";
					s += "<input id=\"upload-name" + item.files + "\" class=\"upload-name col-9\" value=\"파일을 선택해 주세요.\" disabled=\"disabled\">";
					if("${menuAuth.writeYn}" == "Y"){
						s += "<label onclick=\"fileName("+ item.files +")\" for=\"ex_filename" + item.files + "\">파일등록</label>";
					}
					s += "<input type=\"file\" id=\"ex_filename" + item.files + "\" name=\"uploadFile" + item.files + "\" class=\"upload-hidden" + item.files + "\">";
					s += "</div>";
					}
					if(item.fileName != null){
						s += "<div class=\"filebox\">";
						s += "<input type=\"button\" onclick=\"location.href=\'/contents/notice/data/fileDownload.do?fileSeq=" + item.fileSeq + "\'\" class=\"upload-name col-9\" value="+ item.fileRealName +">";
						if("${menuAuth.deleteYn}" == "Y"){
							s += "<label onclick=\"javascript:fileDelete('" + item.fileSeq + "')\">파일삭제</label>";
						}
						s += "</div>";
					}
					s += "	</div>";
					s += "</div>";
				}
			}
			$("#fileList").html(s);
		}
	});
}
function detailForm(){
	$("#detailSubmit").trigger("click");
}

$('#f').validator().on('submit', function (e) {
	if (e.isDefaultPrevented()) {
		alert("항목을 입력해 주세요.")
	} else {
		 // 이벤트 초기화 (submit 동작 중단)
		 var boardTarget = "";
		 $("#f input[name=chkBoardTarget]").each(function(){
			 if($(this).is(":checked")) {
				 boardTarget += $(this).val() + ",";
			 }
		 });
		 if(boardTarget != "") {
			 boardTarget = boardTarget.substring(0, boardTarget.length-1);
		 }
		 
		 $("#boardTarget").val(boardTarget);
		 e.preventDefault();
		 $.ajax({
			url: "/contents/notice/data/boardWrite.do",
			type: "POST",
			dataType: "json",
			data: $("#f").serialize() + "&mode=" + g_mode,				
			success: function(data){
				if(data.result) {
					if(g_mode = "N"){
						$("#boardSeq").val(data.data.boardSeq); 
					}
					fileUpload(data);	
				} else {
					alert(data.msg);
				}
			}
		})
	}
});

// 첨부 파일 등록
function fileUpload(writeData){
	var boardSeq = $("#boardSeq").val();
	$("#fileBoardSeq").val(boardSeq);
	$("#fileForm").ajaxForm({
		url: "/contents/notice/data/fileWrite.do", 
        contentType: false,
		dataType: "json",
		data: $("#fileForm").serialize(),				
		success: function(data){
			init_popup_close();
			alert(writeData.msg);
			goList();
		}
	});
	$("#fileForm").submit();
}

//첩부 파일 삭제
function fileDelete(){
	if(confirm("파일을 삭제하시겠습니까?")){
		$.ajax({
			url: "/contents/notice/data/fileDelete.do",
			type: "POST",
			dataType: "json",
			data: "fileSeq=" + arguments[0],
			success: function(data){
				fileList(data.data.boardSeq);
			}
		});
	}
}

function boardDelete(){
	if(confirm("공지사항을 삭제하시겠습니까?")){
		$.ajax({
			url: "/contents/notice/data/boardDelete.do",
			type: "POST",
			dataType: "json",
			data: "boardSeq=" + $("#boardSeq").val(),
			success: function(data){
				alert(data.msg);
				init_popup_close();
				goList();
			}
		});
	}
}
</script>