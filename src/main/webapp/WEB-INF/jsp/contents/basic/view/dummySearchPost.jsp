<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div class="pop-layer">
    <div class="editor_wrap pop-layer" id="layer1">
        <!-- wrap -->
        <div class="k-tabstrip-wrapper">
            <div id="editor_tabs" class="tabs_wrap k-widget k-tabstrip k-floatwrap k-tabstrip-top" data-role="tabstrip"
                tabindex="0" role="tablist" aria-activedescendant="editor_tabs_ts_active">
                <!-- content -->
                <div class="tab-content k-content k-state-active" id="editor_tabs-1" role="tabpanel"
                    aria-expanded="true" style="display: block;">
	                <form id="fSearch">
	                    <fieldset>
	                        <legend style="text-align: center;">주소검색</legend>
	                        <!--  <div class="form-group row">
	                         	<div class="col input-group middle-name">
	                         		<div class="input-group input-group-sm col radio-or-checkBox">
	                          		<input id="addr" type="radio" name="radio" value="도로명">
	                          		<label for="addr" class="label-margin">
	                          			<span>도로명</span>
	                          		</label>
	                              	<input id="post" type="radio" name="radio" value="지번">
	                              	<label for="post" class="label-margin">
	                              		<span>지번</span>
	                              	</label>
	                             	</div>
	                             </div>
	                         </div> -->
	                        	<div class="form-group row">
	                             <div class="col input-group middle-name">
	                             	<input type="hidden" id="mode" name="mode" value="${mode}" readonly />
	                                 <input type="text" class="form-control form-control-sm searchInputBox" id="searchAddress">
	                             </div>
	                            <div class="padding">
	                                <a onclick="goList();" class="k-pager-refresh k-button"><b class="btn-b"><i class="k-icon k-i-zoom"></i>검색</b></a>
	                            </div>
	                        </div>
	                    </fieldset>
	                </form>
	                <div id="splitter" style="min-height:544px; border: 0;">
	               		<div id="address_grid" style="min-width:680px; "></div>
	               	</div>
					<div class="form-group row p30">
                    	<input type="hidden" name="orderStopData" id="orderStopData">
                        <label class="col-form-label big-name" style="width: 120px;color: #000000;">주소 불분명 시</label>
                        <div class="input-group input-group-sm col">
						    <select class="form-control" class="custom-select col-12" id="sido" name="sido"></select>
                        </div>
                        <div class="input-group input-group-sm col">
                        	<select id="gungu" name="gungu" class="form-control form-control-sm">
                        		<option selected="selected">군/구</option>
                        		<option>시/도 를 선택해 주세요.</option>
                        	</select>
                        </div>
                        <div class="col-1 input-group btn-name">
                        	<a style="background: #fff;border-radius: 4px;box-shadow: 0px 0px 2px 0px;color: #0A8DFF;font-weight: bolder;" onclick="dummyAddr();" class="k-pager-refresh k-button">선택</a>
                        </div>
                    </div>
					<div class="form-group row" style="text-align: center;">
						<label class="big-name" style="color: #ff0000;font-size: inherit;width: 100%;">※ 주소 불분명 시에는 자동출도착처리가 되지 않습니다. 가능한 주소검색을 이용하세요.</label>
					</div>
                    <!-- editor -->
                </div>
            </div><!-- content -->
        </div>
    </div><!-- wrap -->
</div>

<script type="text/javascript">
var columns = [
	{field: "zipNo", title: "zipNo", hidden: true},
	{field: "jibunAddr", title: "jibunAddr", hidden: true},
	{field: "roadAddr", title: "roadAddr", hidden: true},
	{ field: "searchResult", 
		template: "<span style='font-size:16px;color:\\\#fa4256;letter-spacing:0;float:left;'>#=zipNo#</span><div><span style='display: inline-block;float: left;width: 34px;height: 13px;margin-top: 2px;border: 1px solid \\\#d4e2ef;border-radius: 1px;font-size: 11px;line-height: 16px;color: \\\#008bd3;text-align: center;'>도로명</span><span style=''>#=roadAddr#</span></div><div><span style='display: inline-block;float: left;width: 34px;height: 13px;margin-top: 2px;border: 1px solid \\\#d4e2ef;border-radius: 1px;font-size: 11px;line-height: 16px;color: \\\#008bd3;text-align: center;'>지   번</span><span style=''>#=jibunAddr#</span></div>", title: "검색결과", width: 330 },
	{ template: "<a class='k-pager-refresh k-button' style='width:\\\56px; height:\\\32px; background:\\\#fff; border-radius:\\\4px; box-shadow:\\\0px 0px 2px 0px;' onclick='selectAddr(this)'><b class='btn-b'><i class='k-icon k-i-check'></i>선택</b></a>", title: "선택", width: 62 }
];

var oGrid = null;	
oGrid = new gridData("address_grid");
oGrid.initGrid();
oGrid.setSelectable(true);
oGrid.setPageable(true);
oGrid.setSendUrl("/contents/basic/data/searchAddress.do");

$(document).ready(function(){
    Util.setCmmCode("select", "sido", "SIDO", "", "시/도");
	//oGrid.setGrid(columns);
	$('#sido').on('change', function() {
		Util.setSelectBox("/cmm/getAreaCodeList.do", "gungu", {sido:$("#sido option:checked").text()}, "sigun", "sigun", "", "군/구");
	});
	$("#splitter").kendoSplitter({
        orientation: "vertical",
        panes: [{resizable:true}, {resizable:true}]
    }); 
});

function goList(){
	if (!checkSearchedWord($("#searchAddress"))) {
		return ;
	}	
	var param = {
		keyword : $("#searchAddress").val()
	}; 
	
	var grid = $("#address_grid").data("kendoGrid");
	
	oGrid.setSearchData(param);
	
	if(grid == null) {	//페이지를 처음 로딩한 경우, 그리드를 최초 1회 생성한다.
		oGrid.setGrid(columns);
		grid = $("#address_grid").data("kendoGrid");
	} else {			//그리드가 생성된 이후로는 dataSource만 세팅한다.
		grid.setDataSource(oGrid.gridOption.dataSource);
	}
	
}

function selectAddr(e) {
	var grid = $("#address_grid").data("kendoGrid");
    var dataItem = grid.dataItem($(e).closest("tr"));
	var modeValue = $("#mode").val();
	
	var searchData = {
		zipNo: dataItem.zipNo,
		jibunAddr: dataItem.jibunAddr,
		roadAddr: dataItem.roadAddr,
		siNm: dataItem.siNm,
		sggNm: dataItem.sggNm,
		emdNm: dataItem.emdNm,
		mode : modeValue
	}
	

	if(!modeValue.includes("default")){
		window.opener.setSearchAddressInfo(searchData);
	}else{
		window.opener.defaultAddressInfo(searchData);
	}
	
	window.close();
}

$("#searchAddress").on("keydown",function(e){
    if(e.keyCode==13) {
    	e.preventDefault();
    	goList();
        return false;
    }
});

/* function submitSearchAddress() {
	if (!checkSearchedWord($("#searchAddress"))) {
		return ;
	}
	
	$.ajax({
		url: "/contents/basic/data/searchAddress.do",
		type: "POST",
		dataType: "jsonp",
		data: {
			currentPage: 1,
			countPerPage: 10,
			keyword: $("#searchAddress").val()
		},
		success: function(jsonStr){
			var resJson = JSON.parse(jsonStr.data);
			var errCode = resJson.results.common.errorCode;
			var errDesc = resJson.results.common.errorMessage;
			if(errCode != "0"){
				alert(errCode+"="+errDesc);
			}else{
				if(jsonStr != null){
					var grid = $("#address_grid").data("kendoGrid");
					grid.setDataSource(resJson.results.juso);
				}
			}
		},
		error: function(xhr,status, error){
	    	alert("에러발생");
	    }
	});
} */

function checkSearchedWord(obj){
	if(obj.val().length > 0){
		//특수문자 제거
		var expText = /[%=><]/ ;
		if(expText.test(obj.val()) == true){
			alert("특수문자를 입력 할수 없습니다.") ;
			obj.val(obj.val().split(expText).join("")); 
			return false;
		}
		
		//특정문자열(sql예약어의 앞뒤공백포함) 제거
		var sqlArray = new Array(
			//sql 예약어
			"OR", "SELECT", "INSERT", "DELETE", "UPDATE", "CREATE", "DROP", "EXEC",
             		 "UNION",  "FETCH", "DECLARE", "TRUNCATE" 
		);
		
		var regex;
		for(var i=0; i<sqlArray.length; i++){
			regex = new RegExp( sqlArray[i] ,"gi") ;
			
			if (regex.test(obj.val()) ) {
			    alert("\"" + sqlArray[i]+"\"와(과) 같은 특정문자로 검색할 수 없습니다.");
				obj.val(obj.val().replace(regex, ""));
				return false;
			}
		}
	} else {
		alert("검색할 주소지를 입력해주세요.");
		$("#searchAddress").focus();
		return false;
	}
	return true ;
}

function dummyAddr(obj){
	var sido = $("#sido").val();
	var gungu = $("#gungu").val();
	var modeValue = $("#mode").val();
	if(sido == "" || gungu == ""){
		alert("시/도 , 군/구 를 입력해주세요.")
		return
	}
	
	var searchData = {
		sido: sido,
		gungu: gungu,
		mode : modeValue
	}
	
	if(!modeValue.includes("default")){
		window.opener.dummyAddressInfo(searchData);
	}else{
		window.opener.defaultDummyAddressInfo(searchData);
	}
	window.close();
}
</script>
<style>
<!--
span.k-pager-info.k-label {
    font-size: x-small;
}
-->
</style>
