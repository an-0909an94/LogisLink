<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="text-center" id="loading" style="display:none;">
  <div class="spinner-border" role="status">
    <span class="sr-only">Loading...</span>
  </div>
</div>
<div class="editor_wrap">
<!-- 사용자 정보 form -->
	<div class="editor">
	<form id="f" name="f" method="post" enctype="multipart/form-data">
		<input type="hidden" name="custId" id="custId" value="${param.custId}">
		<input type="hidden" name="deptId" id="deptId" value="${param.deptId}">
		<input type="hidden" name="sellBuySctn" id="sellBuySctn" value="${param.sellBuySctn}">
		<div class="form-group row">
			<div class="col">
				<div class="input-group input-group-sm" style="padding:0px;">
					<div style="width: 100%;" class="filebox"> 
	        			<div class="option-area">
							<input style="width: 65%;" class="upload-name" value="파일을 선택해 주세요." disabled="disabled"> 
							<label for="uploadFile">파일등록</label> 
							<input type="file" id="uploadFile" name="uploadFile" class="upload-hidden"> 
							<button onclick="fileUpload();" type="button" class="k-pager-refresh k-button btn-s">업로드</button>
							<button onclick="sampleDownload();" type="button" class="k-pager-refresh k-button btn-s">양식 다운로드</button>
						</div>
					</div>
				</div>
			</div>
		</div>
		<!-- <p class="text-danger">&#8251; 엑셀 양식 다운로드 : sample.xlsx</p>  -->
	</form>
	</div>
	<!-- top pane -->
	<div class="top-pane">
		<div id="grid" style="height:100%;min-width:800px;"></div>
	</div><!-- /top pane -->
</div>	

<script type="text/x-kendo-template" id="template">
	<div class="toolbar row" >
		<button type="button" class="k-pager-refresh k-button btn-s" onClick="insertData()"><i class="k-icon k-i-check"></i>등록</button>
	</div>
</script>

<script type="text/javascript">
var validator = $("#grid").kendoValidator().data("kendoValidator");

var columns = [
	{field: "sSido", title: "출발지", width: 100},
	{field: "sGungu", title: "출발 시/군/구", width: 100},
	{field: "eSido", title: "도착 시/도", width: 100},
	{field: "eGungu", title: "도착 시/군/구", width: 100},
	{field: "carTonCode_0T5", title: "0.5톤", width: 100},
	{field: "carTonCode_1", title: "1톤", width: 100},
	{field: "carTonCode_1T4", title: "1.4톤", width: 100},
	{field: "carTonCode_2T5", title: "2.5톤", width: 100},
	{field: "carTonCode_3T5", title: "3.5톤", width: 100},
	{field: "carTonCode_5", title: "5톤", width: 100},
	{field: "carTonCode_5P", title: "5톤플러스", width: 100},
	{field: "carTonCode_5A", title: "5톤축", width: 100},
	{field: "carTonCode_8", title: "8톤", width: 100},
	{field: "carTonCode_9T5", title: "9.5톤", width: 100},
	{field: "carTonCode_11", title: "11톤", width: 100},
	{field: "carTonCode_11A", title: "11톤축", width: 100},
	{field: "carTonCode_14", title: "14톤", width: 100},
	{field: "carTonCode_14A", title: "14톤축", width: 100},
	{field: "carTonCode_16", title: "16톤", width: 100},
	{field: "carTonCode_16A", title: "16톤축", width: 100},
	{field: "carTonCode_18", title: "18톤", width: 100},
	{field: "carTonCode_18A", title: "18톤축", width: 100},
	{field: "carTonCode_22", title: "22톤", width: 100},
	{field: "carTonCode_25", title: "25톤", width: 100}
]

$(document).ready(function(){
	if("${menuAuth.editYn}" != "Y") {
		alert("접근 권한이 없습니다.");
	     window.close(); // 일반적인 현재 창 닫기
	     window.open('about:blank','_self').self.close();  // IE에서 묻지 않고 창 닫기
	}
	
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
});

function insertData() {
	var grid = $("#grid").data("kendoGrid");
	var gridData = JSON.stringify(grid.dataSource._data);
	var param = {
			gridData : gridData,
			custId : $("#custId").val(),
			deptId : $("#deptId").val(),
			sellBuySctn : $("#sellBuySctn").val()
	}
	
	if(validator.validate()) {
		$.ajax({
			url: "/contents/basic/data/insertFrtCost.do",
			type: "POST",
			dataType: "json",
			data: param,
			beforeSend: function(xmlHttpRequest) {
				xmlHttpRequest.setRequestHeader("AJAX", "true");
				$("#loading").show();
			},
			success: function(data) {
				if(data.result) {
					alert(data.msg);
					opener.parent.goList();
					window.close();	
				} else {
					alert(data.msg);
				}
			},
			complete: function() {
				$("#loading").hide();
			}
		});	
	}
}

function fileUpload() {
	if(!$("input[name=uploadFile]").val()){
		alert("엑셀 파일을 업로드해주세요.");
		return;
	}
	
	$("#f").ajaxForm({
		url: "/cmm/excelUpload.do",
		contentType: false,
		dataType: "json",
		success: function(data) {
			getExcelData(data.uploadFile);
		}
	});
	
	$("#f").submit();
}

function getExcelData() {
	var filename = arguments[0];
	
	$.ajax({
		url: "/cmm/excelToJson.do",
		type: "POST",
		dataType: "json",
		data: "fileName=" + filename,
		beforeSend: function(xmlHttpRequest) {
			xmlHttpRequest.setRequestHeader("AJAX", "true");
			$("#loading").show();
		},
		success: function(data) {
			//console.log("getExcelData : success");
			setGridData(data.data);
		},
		complete: function() {
			$("#loading").hide();
		}
	});
}

function setGridData(data) {
	//console.log("setGridData : start");
	var tmpData = [];
	//console.log("data.length : "+data.length);
	if(data.length > 1) {
		for(var i=1; i<data.length; i++){
			tmpData[i-1] = {
				"sSido"				: data[i][0]
		 	  , "sGungu"			: data[i][1]
			  , "eSido"				: data[i][2]
			  , "eGungu"			: data[i][3]
			  , "carTonCode_0T5"	: data[i][4]
			  , "carTonCode_1"		: data[i][5]
			  , "carTonCode_1T4"	: data[i][6]
			  , "carTonCode_2T5"	: data[i][7]
			  , "carTonCode_3T5"	: data[i][8]
			  , "carTonCode_5"		: data[i][9]
			  , "carTonCode_5P"		: data[i][10]
			  , "carTonCode_5A"		: data[i][11]
			  , "carTonCode_8"		: data[i][12]
			  , "carTonCode_9T5"	: data[i][13]
			  , "carTonCode_11"		: data[i][14]
			  , "carTonCode_11A"	: data[i][15]
			  , "carTonCode_14"		: data[i][16]
			  , "carTonCode_14A"	: data[i][17]
			  , "carTonCode_16"		: data[i][18]
			  , "carTonCode_16A"	: data[i][19]
			  , "carTonCode_18"		: data[i][20]
			  , "carTonCode_18A"	: data[i][21]
			  , "carTonCode_22"		: data[i][22]
			  , "carTonCode_25"		: data[i][23]
			}
		}
	} 

	var dataSource = new kendo.data.DataSource({
		data: tmpData,
		schema: {
			model: {
				fields: {
					sSido: {type:"string", validation: {required: true, validationMessage: "출발지를 입력해주세요."}},
					sGungu: {type:"string", validation: {required: true, validationMessage: "출발 시/군/구 를 입력해주세요."}},
					eSido: {type:"string", validation: {required: true, validationMessage: "도착지를 입력해주세요."}},
					eGungu: {type:"string", validation: {required: true, validationMessage: "도착 시/군/구 를 입력해주세요."}},
					carTonCode_0T5 : {type: "number"},
					carTonCode_1   : {type: "number"},
					carTonCode_1T4 : {type: "number"},
					carTonCode_2T5 : {type: "number"},
					carTonCode_3T5 : {type: "number"},
					carTonCode_5   : {type: "number"},
					carTonCode_5P  : {type: "number"},
					carTonCode_5A  : {type: "number"},
					carTonCode_8   : {type: "number"},
					carTonCode_9T5 : {type: "number"},
					carTonCode_11  : {type: "number"},
					carTonCode_11A : {type: "number"},
					carTonCode_14  : {type: "number"},
					carTonCode_14A : {type: "number"},
					carTonCode_16  : {type: "number"},
					carTonCode_16A : {type: "number"},
					carTonCode_18  : {type: "number"},
					carTonCode_18A : {type: "number"},
					carTonCode_22  : {type: "number"},
					carTonCode_25  : {type: "number"},
					
				}
			}
		}
	});
	
	$("#grid").kendoGrid({
		columns : columns,
		dataSource : dataSource,
		toolbar: kendo.template($("#template").html()),
		height: 450,
		editable: true,
	 	noRecords: true,
	  	messages: {
			noRecords: "엑셀 데이터를 Import 해 주세요."
	  	}
	});
	
}


function sampleDownload(){
	location.href = "/cmm/fileDownloadEtc.do?fileName=계약단가업로드양식파일.xlsx";
}


</script>