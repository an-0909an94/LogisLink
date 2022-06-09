<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!-- tab 1 -->
<div class="content">
	<div class="lookup_table">
		<!-- toolbar -->
		<div class="toolbar row">
			<form id="fFile" name="fFile" method="post" enctype="multipart/form-data">
			<div class="tool_form col">
				<div class="row">
					<div class="tool_group">
						<input type="file" name="uploadFile" id="uploadFile"/>
					</div>
				</div>
			</div>
			</form>
			<div class="tool_form col">
				<div class="row">
					<div class="tool_group">
						<span>양식 다운로드 : sample-sms.xlsx</span>
					</div>
				</div>
			</div>
			<div class="tool_btn col-auto">
				<a href="javascript:excelUpload()" class="k-pager-refresh k-button"><i class="k-icon k-i-check"></i>등록</a>
				<a href="#" class="k-pager-refresh k-button"><i class="k-icon k-i-close"></i>닫기</a>
			</div>
		</div><!-- /toolbar -->
		<!-- table -->
	</div>
</div>

<script type="text/javascript">
$(document).ready(function(){

});

/**
 * 연락처 엑셀 업로드
 */
function excelUpload(){
	var uploadFile = "";
	
	$("#fFile").ajaxForm({
		type: "POST",
		url: "/cmm/excelUpload.do",
		enctype: "multipart/form-data",
		dataType: "json",
		success: function(res, status, xhr) {
			uploadFile = res.uploadFile;
			//$("#uploadFileName").val(uploadFile);
			loadExcelData(uploadFile);
		}
	});
	$("#fFile").submit();
}

/**
 * 업로드 된 엑셀 연락처 JSON 형식으로 불러오기
 */
function loadExcelData(fileName) {
		
	$.ajax({
		type: "POST",
		url: "/cmm/excelToJson.do",
		dataType: "json",
		data: "fileName=" + fileName,
		async: false,
		success: function(res, status, xhr){
			var excelJson = res.data;
			makeGridData(excelJson);
		}
	});
}

/**
 * 불러온 엑셀 데이터를 Grid에 setting.
 */
function makeGridData(data){
	var tempData = [];
	var phone = "";
	if(data.length > 1){
		alert(JSON.stringify(data));
		for(var i=1; i<data.length; i++) {
			phone = data[i][1];
			phone = phone.replace(/[^0-9]/g, "");	//연락처는 숫자만 추출.
			if(phone != "" && phone != null){
				tempData[i-1] = {
						"recvId"	: data[i][0]
					  , "trPhone"	: phone
				};
			}
		}
	}
	var grid = $("#telGrid").data("kendoGrid");
	
	grid.dataSource.data(tempData);
	Util.closeModal();
}

</script>