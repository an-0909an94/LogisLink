<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="pop-layer">
    <div class="editor_wrap pop-layer" id="layer1">
        <!-- wrap -->
        <div class="k-tabstrip-wrapper">
            <div id="editor_tabs" class="tabs_wrap k-widget k-tabstrip k-floatwrap k-tabstrip-top" data-role="tabstrip"
                tabindex="0" role="tablist" aria-activedescendant="editor_tabs_ts_active">
                <!-- content -->
                <div class="tab-content k-content k-state-active" id="editor_tabs-1" role="tabpanel"
                    aria-expanded="true" style="display: block;">
                    <div class="editor">
                       	<div id="errReqGrid" style="min-width: 100%;"></div>
                    </div>
                    <!-- editor -->
                </div>
            </div><!-- content -->
        </div>
    </div><!-- wrap -->
</div>

<script type="text/javascript">
var columns = [
	{ field: "custName", title: "거래처명"},
	{ field: "deptName", title: "담당부서"},
];
$(document).ready(function(){
	$("#errReqGrid").kendoGrid({
        sortable: false,
       	scrollable: false,
       	columns : columns
    });
	
	var dataSource = new kendo.data.DataSource({
		data: parent.errReqData
	});

	var grid = $("#errReqGrid").data("kendoGrid");
	grid.setDataSource(dataSource);
})
</script>