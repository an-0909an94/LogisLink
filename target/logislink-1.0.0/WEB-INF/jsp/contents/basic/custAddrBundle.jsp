<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>

<div class="header">	
	<div class="summary p30">
		<div class="hdr-tit">
			<P class="headerTitle">주소지일괄등록</P>
		</div>
	</div>
	<div class="contents">
		<div id="group-list" class="cont-wrapper-page-grid">
			<form id="f" name="f" method="post" enctype="multipart/form-data">
			<div class="form-group row">
				<div class="col">
					<div class="input-group input-group-sm" style="padding:0px;">
						<div style="width: 100%;" class="filebox"> 
		        			<div class="option-area">
								<input style="width: 90%;" class="upload-name" value="파일을 선택해 주세요." disabled="disabled"> 
								<label for="uploadFile">파일등록</label> 
								<input type="file" id="uploadFile" name="uploadFile" class="upload-hidden"> 
								<button style="padding: .25rem .5rem;font-size: .875rem;line-height: 1.5;border-radius: .2rem;" class="btn btn-outline-secondary" type="button" onclick="fileUpload();">업로드</button>
							</div>
						</div>
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
											<a href="javascript:sampleDownload();" class="k-pager-refresh k-button"><b class="btn-x"><i class="k-icon k-i-file-excel"></i>양식 다운로드</b></a>
											<c:if test="${menuAuth.writeYn eq 'Y'}">
												<a href="javascript:insertData();" class="k-pager-refresh k-button"><b class="btn-h"><i class="k-icon k-i-plus"></i>저장</b></a>
											</c:if>
										</div>
									</div>
								</div>
							</div>
						</div><!-- /toolbar -->
						<div style="width:100%; height:calc(100vh - 320px);" id="grid"></div>
						<!-- /table -->
					</div>
				</div>
			</div>
			<!--  -->
		</div>
		<!-- group-list -->
	</div>
	<!--  -->
	<!-- content -->
</div>

<script type="text/javascript">
var validator = $("#grid").kendoValidator().data("kendoValidator");

var columns = [
	{ field: "addrName", title: "주소지명", width: 150},
	{ field: "addr", title: "주소지", width: 200},
	{ field: "addrDetail", title: "상세주소", width: 150},
	{ field: "staffName", title: "담당자명", width: 100},
	{ field: "staffTel", title: "연락처", width: 100},
	{ field: "memo", title: "메모", width: 100}
]

$(document).ready(function(){

	$("#grid").kendoGrid({
		columns : columns,
		//dataSource : dataSource,
		editable: true,
	 	noRecords: true,
	  	messages: {
			noRecords: "엑셀 데이터를 Import 해 주세요."
	  	}
	});
	
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
			setGridData(data.data);
		},
		complete: function() {
			$("#loading").hide();
		}
	});
}

function setGridData(data) {
	var tmpData = [];
	if(data.length > 1) {
		for(var i=1; i<data.length; i++){
			tmpData[i-1] = {
				"addrName"		: data[i][0]
		 	  , "addr"			: data[i][1]
			  , "addrDetail"	: data[i][2]
			  , "staffName"		: data[i][3]
			  , "staffTel"		: data[i][4]
			  , "memo"			: data[i][5]
			}
		}
	} 

	var dataSource = new kendo.data.DataSource({
		data: tmpData,
		schema: {
			model: {
				fields: {
					addrName: {type:"string", validation: {required: true, validationMessage: "주소지명 입력해 주세요."}},
					addr: {type:"string", validation: {required: true, validationMessage: "주소를 입력해 주세요."}},
					addrDetail: {type:"string"},
					staffName: {type:"string"},
					staffTel: {type:"string"},
					memo: {type:"string"}
				}
			}
		}
	});
	
	var grid = $("#grid").data("kendoGrid");
	grid.setDataSource(dataSource);

	// grid 에서 checkbox 선택 시, Data setting
	$("#grid .k-grid-content").on("click", "input.chkMixYn", function(e) {
		var grid = $("#grid").data("kendoGrid");
		var checked = $(this).is(":checked");
		var col = $(this).closest("td");
		
		dataItem = grid.dataItem($(e.target).closest("tr"));
		dataItem.mixYn= checked ? "Y" : "N";
	});

	$("#grid .k-grid-content").on("click", "input.chkReturnYn", function(e) {
		var grid = $("#grid").data("kendoGrid");
		var checked = $(this).is(":checked");
		var col = $(this).closest("td");
		
		dataItem = grid.dataItem($(e.target).closest("tr"));
		dataItem.returnYn = checked ? "Y" : "N";		
	});

}

function insertData(){
	var validator = $("#grid").kendoValidator().data("kendoValidator");
	if(validator.validate()) {
		var grid = $("#grid").data("kendoGrid");
		var gridData = JSON.stringify(grid.dataSource._data);
		
		if (grid.dataSource._data.length > 0) {
			$.ajax({
				url: "/contents/basic/data/custAddrBundleWrite.do",
				type: "POST",
				dataType: "json",
				data: "gridData=" + encodeURIComponent(gridData),
				beforeSend: function(xmlHttpRequest) {
					xmlHttpRequest.setRequestHeader("AJAX", "true");
					$("#loading").show();
				},
				success: function(data) {
					if(data.result) {
						alert(data.msg);
						location.reload();	
					} else {
						alert(data.msg);
						var errAddrListHeader = new Array
						errAddrListHeader = ['주소지명', '주소', '상세주소', '담당자명', '연락처', '메모'];
						data.errAddrList.unshift(errAddrListHeader);
						$("#grid").data("kendoGrid").dataSource.data([]);
						setGridData(data.errAddrList);
					}
				},
				complete: function() {
					$("#loading").hide();
				}
			});
		} else {
			alert("엑셀 파일을 업로드 해주세요.");
		}
	}
		
}

//공통코드 데이터 가져온다.
function getComCode(gCode){
	var item = [];
	$.ajax({
		url: "/cmm/codeList.do",
		type: "post",
		dataType: "json",
		data: "gCode=" + gCode,
		success: function(data) {
			item = data.data;
		}
	});
	
	return item;
}


function sampleDownload(){
	location.href = "/cmm/fileDownloadEtc.do?fileName=주소지업로드양식파일.xlsx";
}

</script>