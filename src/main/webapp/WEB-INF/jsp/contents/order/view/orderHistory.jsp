<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<link rel="stylesheet" type="text/css" href="/css/style_V2.css">
<div class="pop-layer">
    <div class="editor_wrap pop-layer" id="layer1">
        <!-- wrap -->
        <div class="k-popup-wrapper">
            <div id="editor_tabs" class="tabs_wrap k-widget k-tabstrip k-floatwrap k-tabstrip-top" data-role="tabstrip"
                tabindex="0" role="tablist" aria-activedescendant="editor_tabs_ts_active">
                <!-- content -->
                <div class="tab-content k-content k-state-active" id="editor_tabs-1" role="tabpanel"
                    aria-expanded="true" style="display: block;">
                    <div class="editor">
                       	<input type="hidden" name="orderId" id="orderId" value="${param.orderId}">
                        <fieldset>
                            <legend style="text-align: center;">오더 수정이력</legend>
                            <div id="historyGrid" style="min-width: 100%; height: 265px;"></div>
                        </fieldset>
                    </div>
                    <!-- editor -->
                </div>
            </div><!-- content -->
        </div>
    </div><!-- wrap -->
</div>

<script type="text/javascript">
var columns = [
	{ field: "modDate", title: "변경일시",width: 130 },
	{ field: "modDesc", title: "변경내역", width: 400},
	{ field: "modId", title: "변경자", width: 100},
];

var oGrid = null;
oGrid = new gridData("historyGrid");
oGrid.initGrid();
oGrid.setEditable(false);
oGrid.setSortable(false);
oGrid.setPageable(true);
oGrid.setSelectable(false);
oGrid.setSendUrl("/contents/order/data/orderHistory.do");
$(document).ready(function(){ 	
 	goList();
 	
 	$("#historyGrid").kendoTooltip({
		filter: "td:nth-child(2)",
		content: function(e) {return e.target.html();},
		width: 750,
		animation: {
        	open: {
        		effects: "zoom",
        		duration: 250
        	}
        },
		content: function(e){
			return e.target.context.innerText;
		}
	});
});

function goList() {
	var grid = $("#historyGrid").data("kendoGrid");
	
	var param = {
		orderId : $("#orderId").val()
	};
	
	oGrid.setSearchData(param);
	if(grid == null) {
		oGrid.setGrid(columns);
		grid = $("#historyGrid").data("kendoGrid");
	} else {
		grid.setDataSource(oGrid.gridOption.dataSource);
	}
}
</script>