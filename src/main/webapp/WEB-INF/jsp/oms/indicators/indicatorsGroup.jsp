<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>

<div class="oms_header indicatorsGroup">
	<div class="summary p30">
		<div class="hdr-tit">
			<p id="headerTitle">지표관리</p>
		</div>
	</div>
	<div class="contents">
		<ul class="nav nav-tabs">
			<li class="nav-item">
				<a id="kpiDayLink" class="nav-link active" data-toggle="tab" href="#kpiDay">KPI(일)</a>
			</li>
			<li class="nav-item">
				<a id="kpiMonthLink" class="nav-link" data-toggle="tab" href="#kpiMonth">KPI(월)</a>
			</li>
			<li class="nav-item">
				<a id="chargeDayLink" class="nav-link" data-toggle="tab" href="#chargeDay">배차및운송비(일)</a>
			</li>
			<li class="nav-item">
				<a id="chargeMonthLink" class="nav-link" data-toggle="tab" href="#chargeMonth">배차및운송비(월)</a>
			</li>
		</ul>
		<div class="tab-content">
			<div class="tab-pane fade show active" id="kpiDay">
				<iframe id="iKpiDay" width="100%" height="799px" style="border: 0px;" src="/oms/indicators/kpiDay.do"></iframe>
		  	</div>
		  	<div class="tab-pane fade" id="kpiMonth">
				<iframe id="iKpiMonth" width="100%" height="799px" style="border: 0px;" src="/oms/indicators/kpiMonth.do"></iframe>
		 	</div>
		  	<div class="tab-pane fade" id="chargeDay">
		    	<iframe id="iChargeDay" width="100%" height="799px" style="border: 0px;" src="/oms/indicators/chargeDay.do"></iframe>
		  	</div>
		  	<div class="tab-pane fade" id="chargeMonth">
		    	<iframe id="iChargeMonth" width="100%" height="799px" style="border: 0px;" src="/oms/indicators/chargeMonth.do"></iframe>
		  	</div>
		</div>
	</div>
</div>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>
<script type="text/javascript">
$(document).ready(function(){
   	$("#iKpiDay").load(function () {
    	setTimeout(function() {
    		$("#iKpiDay")[0].contentWindow.goList();
   		}, 100);
   	});
   	
	$("#iKpiMonth").load(function () {
    	setTimeout(function() {
    		$("#iKpiMonth")[0].contentWindow.goList();
   		}, 100);
	});
	
   	$("#iChargeDay").load(function () {
    	setTimeout(function() {
    		$("#iChargeDay")[0].contentWindow.goList();
   		}, 100);
   	});
   	
   	$("#iChargeMonth").load(function () {
    	setTimeout(function() {
    		$("#iChargeMonth")[0].contentWindow.goList();
   		}, 100);
   	});
});

$(".nav-link").on("click", function(){
	var indicatorsId = $(this).attr('id');
	switch (indicatorsId) {
	case "kpiDayLink":
    	$('#iKpiDay').attr('src', "/oms/indicators/kpiDay.do");
        break;
    case "kpiMonthLink":
    	$('#iKpiMonth').attr('src', "/oms/indicators/kpiMonth.do");
        break;
    case "chargeDayLink":
    	$('#iChargeDay').attr('src', "/oms/indicators/chargeDay.do");
        break;
    case "chargeMonthLink":
    	$('#iChargeMonth').attr('src', "/oms/indicators/chargeMonth.do");
        break;
	}
}) 
 
</script>
<style>
<!--
.nav-link{
	color: #002b57;
}
-->
</style>