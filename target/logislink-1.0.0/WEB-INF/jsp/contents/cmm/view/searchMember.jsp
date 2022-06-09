<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!-- tab 1 -->
<div class="content">
	<div class="lookup_table">
		<!-- toolbar -->
		<div class="toolbar row">
			<div class="tool_form col">
				<div class="tool_group">
					<div class="form-group row">
                        <div class="input-group input-group-sm col middle-name">
                            <select class="custom-select form-control-sm col" id="s_search">
								<option value="s_mobile">--연락처--</option>
								<option value="s_bizName">--상호--</option>
								<option value="s_bizNum">--사업자번호--</option>
                            </select>
                        </div>
                        <div class="input-group input-group-sm col-9 middle-name">
                            <input type="text" class="form-control form-control-sm" name="s_value" id="s_value" onkeypress="if(event.which==13){goSearch();}">
                        </div>
                    </div>
				</div>
			</div>
			<div class="tool_btn col-auto" style="align-self: center;">
				<a href="#" class="form-control form-control-sm middle-button-dark" onclick="goSearch();"><i class="k-icon k-i-zoom"></i>조회</a>
			</div>
		</div><!-- /toolbar -->
		<!-- table -->
		<div id="grid" style="min-width:600px; height: 254px;">
		</div><!-- /table -->
	</div>
</div>

<script type="text/javascript">

var columns = [
	{ field: "number", title: "No", width: 50 },
	{ field: "id", title: "아이디", width: 100 },
	{ field: "bizName", title: "거래처상호", width: 100 },
	{ field: "custTypeCode", title: "거래처분류코드", hidden:true},
	{ field: "custTypeName", title: "거래처분류", width: 100 },
	{ field: "userName", title: "이름", width: 100 },
	{ field: "mobile", title: "연락처", width: 100 },
	/*{ field: "custId", title: "거래처ID", width: 100 },
	{ field: "bizName", title: "거래처상호", width: 100 },
	{ field: "custTypeName", title: "거래처분류", width: 100 },
	{ field: "ceo", title: "대표자명", width: 100 },
	{ field: "bizNum", title: "사업자번호", width: 100 },
	{ field: "bizCond", title: "업태", width: 100 },
	{ field: "bizKind", title: "업종", width: 100 },
	{ field: "bizPost", title: "우편번호", width: 100 },
	{ field: "bizAddr", title: "주소", width: 100 },
	{ field: "bizAddrDetail", title: "상세주소", width: 100 },*/
];

var oGrid = null;
oGrid = new gridData("grid");
oGrid.initGrid();
oGrid.setSendUrl("/contents/notice/data/searchPushUserList.do");
oGrid.setPageable(false);
oGrid.setSelectable(true);

$(document).ready(function(){

});


function goSearch(){ 
	if($("#s_value").val().length < 2) {
		alert("검색어를 2자 이상 입력하세요.");
		$("#s_value").focus();
		return;
	}
	var id = $("#s_search").val().split('_')[1];
	var data = $("#s_value").val();
	
	var searchData = {}
	searchData[id] = data;
	
	var grid = $("#grid").data("kendoGrid");
	
	oGrid.setSearchData(searchData);
	
	if(grid == null) {
		oGrid.setGrid(columns);
		grid = $("#grid").data("kendoGrid");
		grid.tbody.delegate('tr', 'dblclick', function(){
			var dataItem = grid.dataItem($(this));
			parent.setMember(dataItem);
			parent.Util.closePopup();
		})
	} else {
		grid.setDataSource(oGrid.gridOption.dataSource);	
	}
	
/* 조회한만큼 실행함(2번조회하면 값이 2번넘어감) */
// 	grid.tbody.delegate('tr', 'dblclick', function(){
// 		var dataItem = grid.dataItem($(this));
// 		parent.setMember(dataItem);
// 		parent.Util.closePopup();
// 	});
}

</script>