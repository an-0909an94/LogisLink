<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>

<div class="oms_header">
	<div class="summary p30">
		<div class="hdr-tit">
			<p id="headerTitle">통계관리</p>
		</div>
	</div>
	<div class="contents">
	<ul class="nav nav-tabs">
		<li class="nav-item">
			<a id="dispatchCountLink" class="nav-link active" data-toggle="tab" href="#dispatchCount">배차대수</a>
		</li>
		<li class="nav-item">
			<a id="statAllocationLink" class="nav-link" data-toggle="tab" href="#statAllocation">배차완성률</a>
		</li>
		<li class="nav-item">
			<a id="statUrgentLink" class="nav-link" data-toggle="tab" href="#statUrgent">긴급대응</a>
		</li>
		<li class="nav-item">
			<a id="statEnterLink" class="nav-link" data-toggle="tab" href="#statEnter">입차준수율</a>
		</li>
		<li class="nav-item">
			<a id="statArrivalLink" class="nav-link" data-toggle="tab" href="#statArrival">도착준수율</a>
		</li>
		<li class="nav-item">
			<a id="statLoadLink" class="nav-link" data-toggle="tab" href="#statLoad">적재율</a>
		</li>
		<li class="nav-item">
			<a id="statChargeLink" class="nav-link" data-toggle="tab" href="#statCharge">운송비</a>
		</li>
		<li class="nav-item">
			<a id="statTonChargeLink" class="nav-link" data-toggle="tab" href="#statTonCharge">톤당 운송비</a>
		</li>
	</ul>
	<div class="tab-content">
		<div class="tab-pane fade show active" id="dispatchCount">
			<iframe id="iDispatchCount" width="100%" height="799px" style="border: 0px;" src="/oms/statistics/dispatchCount.do"></iframe>
	  	</div>
	  	<div class="tab-pane fade" id="statAllocation">
			<iframe id="iStatAllocation" width="100%" height="799px" style="border: 0px;" src="/oms/statistics/statAllocation.do"></iframe>
	 	</div>
	  	<div class="tab-pane fade" id="statUrgent">
	    	<iframe id="iStatUrgent" width="100%" height="799px" style="border: 0px;" src="/oms/statistics/statUrgent.do"></iframe>
	  	</div>
	  	<div class="tab-pane fade" id="statEnter">
	    	<iframe id="iStatEnter" width="100%" height="799px" style="border: 0px;" src="/oms/statistics/statEnter.do"></iframe>
	  	</div>
	  	<div class="tab-pane fade" id="statArrival">
	    	<iframe id="iStatArrival" width="100%" height="799px" style="border: 0px;" src="/oms/statistics/statArrival.do"></iframe>
	  	</div>
	  	<div class="tab-pane fade" id="statLoad">
	    	<iframe id="iStatLoad" width="100%" height="799px" style="border: 0px;" src="/oms/statistics/statLoad.do"></iframe>
	  	</div>
	  	<div class="tab-pane fade" id="statCharge">
	    	<iframe id="iStatCharge" width="100%" height="799px" style="border: 0px;" src="/oms/statistics/statCharge.do"></iframe>
	  	</div>
	  	<div class="tab-pane fade" id="statTonCharge">
	    	<iframe id="iStatTonCharge" width="100%" height="799px" style="border: 0px;" src="/oms/statistics/statTonCharge.do"></iframe>
	  	</div>
	</div>
	</div>
</div>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>
<script type="text/javascript">
$(document).ready(function(){
   	$("#iDispatchCount").load(function () {
    	setTimeout(function() {
    		$("#iDispatchCount")[0].contentWindow.getSearch();
   		}, 100);
   	});
   	
	$("#iStatAllocation").load(function () {
    	setTimeout(function() {
    		$("#iStatAllocation")[0].contentWindow.getSearch();
   		}, 100);
	});
	
   	$("#iStatUrgent").load(function () {
    	setTimeout(function() {
    		$("#iStatUrgent")[0].contentWindow.getSearch();
   		}, 100);
   	});
   	
   	$("#iStatEnter").load(function () {
    	setTimeout(function() {
    		$("#iStatEnter")[0].contentWindow.getSearch();
   		}, 100);
   	});
   	
   	$("#iStatArrival").load(function () {
    	setTimeout(function() {
    		$("#iStatArrival")[0].contentWindow.getSearch();
   		}, 100);
   	});
   	
   	$("#iStatLoad").load(function () {
    	setTimeout(function() {
    		$("#iStatLoad")[0].contentWindow.getSearch();
   		}, 100);
   	});
   	
   	$("#iStatCharge").load(function () {
    	setTimeout(function() {
    		$("#iStatCharge")[0].contentWindow.getSearch();
   		}, 100);
   	});
   	
   	$("#iStatTonCharge").load(function () {
    	setTimeout(function() {
    		$("#iStatTonCharge")[0].contentWindow.getSearch();
   		}, 100);
   	});
});

$(".nav-link").on("click", function(){
	var statId = $(this).attr('id');
	switch (statId) {
	case "dispatchCountLink":
    	$('#iDispatchCount').attr('src', "/oms/statistics/dispatchCount.do");
        break;
    case "statAllocationLink":
    	$('#iStatAllocation').attr('src', "/oms/statistics/statAllocation.do");
        break;
    case "statUrgentLink":
    	$('#iStatUrgent').attr('src', "/oms/statistics/statUrgent.do");
        break;
    case "statEnterLink":
    	$('#iStatEnter').attr('src', "/oms/statistics/statEnter.do");
        break;
    case "statArrivalLink":
    	$('#iStatArrival').attr('src', "/oms/statistics/statArrival.do");
        break;
    case "statLoadLink":
    	$('#iStatLoad').attr('src', "/oms/statistics/statLoad.do");
        break;
    case "statChargeLink":
    	$('#iStatCharge').attr('src', "/oms/statistics/statCharge.do");
        break;
    case "statTonChargeLink":
    	$('#iStatTonCharge').attr('src', "/oms/statistics/statTonCharge.do");
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