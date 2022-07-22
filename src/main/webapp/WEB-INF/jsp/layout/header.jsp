<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<div class="text-center" id="loading" style="display:none;">
  <div class="spinner-border" role="status">
    <span class="sr-only">Loading...</span>
  </div>
</div>

<div class="privateRightPanel" style="display: none;">
	<div class="privateClosePanel">
		<button class="privateReset form-control-sm"><i class="k-icon k-i-reset-sm"></i>초기화</button>
		<button class="privateSave form-control-sm">저장</button>
		<button class="privateClose form-control-sm">닫기</button>
	</div>
	<table class="privateTbl" style="width: 100%;">
		<thead id="privateTHead">
		</thead>
		<tbody id="privateTbody">
		</tbody>
	</table>
</div>

<form id="privateForm" action="post">
    <input type="hidden" name="list" id="privateSaveDataHidden">
</form>