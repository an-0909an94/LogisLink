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
                    <fieldset>
                        <legend style="text-align: center;">사업자검색</legend>
                        	<div class="form-group row">
                        	<div class="col input-group middle-name col-2">
							    <select class="custom-select searchSelectBox" id="sSelector" name="sSelector">
									<option value="BIZ_NUM" selected="selected">--사업자번호--</option>
									<option value="BIZ_NAME">--사업자상호--</option>
							    </select>
							</div>
                            <div class="col input-group middle-name">
                                 <input type="text" class="form-control form-control-sm searchInputBox searchValue" id="sValue" name="sValue" maxlength="13">
                            </div>
                            <div class="padding">
                                <a onclick="goList();" class="k-pager-refresh k-button"><b class="btn-b"><i class="k-icon k-i-zoom"></i>검색</b></a>
                            </div>
                        </div>
                    </fieldset>
	                <div id="splitter" style="min-height:544px; border: 0;">
	               		<div id="bizInfo_grid" style="min-width:968px;"></div>
	               	</div>
                    <!-- editor -->
                </div>
            </div><!-- content -->
        </div>
    </div><!-- wrap -->
</div>

<script type="text/javascript">
var columns = [
	{field: "bizName", title: "회사명"},
	{field: "bizNum", title: "사업자번호", width: 110, 
		template: "#=Util.formatBizNum(bizNum)#" 
	},
	{field: "bizAddr", title: "주소"},
	{field: "ceo", title: "대표자", width: 100},
	{field: "bizKind", title: "업종", width: 130},
	{field: "mainProduct", title: "주생산품"},
	{ template: "<a class='k-pager-refresh k-button noColorReadonly' style='width:\\\56px; height:\\\32px; background:\\\#fff; border:\\\none; box-shadow:\\\0px 0px 2px 0px;' onclick='selectBizInfo(this)'><b class='btn-b'><i class='k-icon k-i-check'></i></b></a>", title: "선택", width: 62 }
];


var oGrid = null;	
oGrid = new gridData("bizInfo_grid");
oGrid.initGrid();
oGrid.setSelectable(true);
oGrid.setPageable(true);
oGrid.setSendUrl("/contents/basic/data/searchBizinfo.do");

$(document).ready(function(){
	$("#splitter").kendoSplitter({
        orientation: "vertical",
        panes: [{resizable:true}, {resizable:true}]
    }); 
});

function goList(){
	if($("#sSelector option:selected").val() == "BIZ_NUM"){
		var param = {
			selector : $("#sSelector").val(),
			value : $("#sValue").val().replace(/\-/g, '')
		}; 		
	}else{
		var param = {
			selector : $("#sSelector").val(),
			value : $("#sValue").val()
		}; 
	}
	
	
	var grid = $("#bizInfo_grid").data("kendoGrid");
	
	oGrid.setSearchData(param);
	
	if(grid == null) {	//페이지를 처음 로딩한 경우, 그리드를 최초 1회 생성한다.
		oGrid.setGrid(columns);
		grid = $("#bizInfo_grid").data("kendoGrid");
	} else {			//그리드가 생성된 이후로는 dataSource만 세팅한다.
		grid.setDataSource(oGrid.gridOption.dataSource);
	}
}

function selectBizInfo(e){
	var grid = $("#bizInfo_grid").data("kendoGrid");
    var dataItem = grid.dataItem($(e).closest("tr"));
    
    var searchData = {
   		bizNum : Util.formatBizNum(dataItem.bizNum)
    }
	
	window.opener.setSearchBizInfo(searchData);
	window.close();
}

$(".searchValue").on("keypress", function (event){
	if(event.keyCode==13){
		goList();
	}
});

$("#sSelector").change(function(){
	if($(this).val() == "BIZ_NUM"){
		$("#sValue").attr("maxlength", "13");	
	}else{
		$("#sValue").removeAttr("maxlength");
	}
	$("#sValue").val("");
});

$('#sValue').on('input', function() {
	if($("#sSelector option:selected").val() == "BIZ_NUM"){
		var bizNum = $(this).val().replace(/[^\d]/g, '');
		var temp = bizNum.replace(/(\d{3})(\d{1,2})(\d{1,5})/, '$1-$2-$3');
		$(this).val(temp);
	}
});
</script>
<style>
<!--
span.k-pager-info.k-label {
    font-size: x-small;
}
-->
</style>
