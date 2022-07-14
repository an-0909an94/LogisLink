<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<div class="pop-layer">
    <div class="editor_wrap pop-layer" id="layer1">
        <!-- wrap -->
        <div class="k-tabstrip-wrapper">
            <div id="editor_tabs" class="tabs_wrap k-widget k-tabstrip k-floatwrap k-tabstrip-top" data-role="tabstrip" tabindex="0" role="tablist" aria-activedescendant="editor_tabs_ts_active">
                <!-- content -->
                <div class="tab-content k-content k-state-active" id="editor_tabs-1" role="tabpanel" aria-expanded="true" style="display: block;">
                    <div class="editor">
                        <div id="grid" style="min-width: 100%;"></div>
                    </div>
                    <!-- editor -->
                </div>
            </div>
            <!-- content -->
        </div>
    </div>
    <!-- wrap -->
</div>

<script type="text/javascript">
$(document).ready(function() {
	// 그리드 설정
	var columns = [
		{
			field: "rowNum",
			title: "번호",
			width: 80
		},
		{
			field: "colName",
			title: "열이름",
			width: 120,
			attributes : {
				style : "text-align: left"
			}
		},
		{
			field: "colValue",
			title: "열값",
			width: 240,
			attributes : {
				style : "text-align: left"
			}
		},
		{
			field: "message",
			title: "오류내용",
			width: "auto",
			attributes : {
				style : "text-align: left"
			}
		},
	];
	
	$("#grid").kendoGrid({
        sortable: false,
       	scrollable: true,
       	columns : columns
    });
	
	var dataSource = new kendo.data.DataSource({
		data: parent.validationErrorData
	});

	var grid = $("#grid").data("kendoGrid");
	grid.setDataSource(dataSource);
});
</script>