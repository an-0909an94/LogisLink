<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<div class="text-center" id="loading" style="display:none;">
  <div class="spinner-border" role="status">
    <span class="sr-only">Loading...</span>
  </div>
</div>

<!-- 22.07.15 이건욱 그리드 개인화 설정 -> 개인화 컬럼세팅 레이어 (id 및 클래스명 변경 금지) -->
<div class="privateRightPanel" style="display: none;">
    <div class="privateClosePanel">
        <button class="privateReset form-control-sm"><i class="k-icon k-i-reset-sm"></i>초기화</button>
        <button class="privateSave form-control-sm">저장</button>
        <button class="privateClose form-control-sm">닫기</button>
    </div>
    <table class="privateTbl">
        <thead id="privateTHead">
        </thead>
        <tbody id="privateTbody">
        </tbody>
    </table>
</div>

<form id="privateForm" action="post">
    <input type="hidden" name="list" id="privateSaveDataHidden">
</form>