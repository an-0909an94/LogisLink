<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<input type="hidden" id="orderId" name="orderId" value="${orderId}">
<div id="imgList"></div>


<script type="text/javascript">
$(document).ready(function(){
	$.ajax({
		url: "/contents/calc/data/viewReceipt.do",
		type: "POST",
		dataType: "json",
		data: {
			orderId: "${orderId}"
		},
		success: function(data){
			var imgList = ""
			for(var i=0; i<data.data.length; i++){
				imgList += "<img src="+data.data[i].fPath+" style=\"width: 620px; height: 707px;\">"
			}
			$("#imgList").html(imgList);
		}
	});
});
</script>