<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="Author" content="">
  <meta name="Keywords" content="">
  <meta name="Description" content="">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <title>logslink-join</title>
  <link rel="preconnect" href="https://fonts.gstatic.com">
  <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;300;400;500;700;900&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.1/font/bootstrap-icons.css">
  <link rel="stylesheet" type="text/css" href="<c:url value='/css/kendo.common.min.css'/>">
  <link rel="stylesheet" type="text/css" href="<c:url value='/css/kendo.default-v2.min.css'/>">
  <link rel="stylesheet" type="text/css" href="<c:url value='/css/kendo.default.min.css'/>">
  <link rel="stylesheet" type="text/css" href="<c:url value='/css/kendo.default.mobile.min.css'/>">
  <link rel="stylesheet" type="text/css" href="<c:url value='/css/bootstrap.min.css'/>">
  <link rel="stylesheet" type="text/css" href="<c:url value='/css/common.css?v=2'/>">
  <link rel="stylesheet" type="text/css" href="<c:url value='/css/style.css?v=6'/>">
  <link rel="stylesheet" type="text/css" href="<c:url value='/css/left.css?v=1'/>">
  <script type="text/javascript" src="<c:url value='/js/jquery.min.js'/>"></script>
  <script type="text/javascript" src="<c:url value='/js/jquery.form.js'/>"></script>
  <script type="text/javascript" src="<c:url value='/js/util.js?v=5'/>"></script>
  <script src="/js/validator.min.js"></script>
</head>
<style>
  #group-list {
    display: flex;
    justify-content: center;
  }

  .with-errors{
    position: absolute;
    width: 100%;
  }


  textarea {
    resize: none;
  }
</style>
<script>
  $.ajax({
    url:"/terms/content.do",
    data:"",
    success:function (data) {

      $('#agree tr:gt(0)').remove();
      $('#privacy tr:gt(0)').remove();
      $('#privateInfo tr:gt(0)').remove();
      $('#dataSource tr:gt(0)').remove();
      $('#marketing tr:gt(0)').remove();

      let str1 = data.tResult[5].detail;
      $("#agree").append(str1);

      let str2 = data.tResult[6].detail;
      $("#privacy").append(str2);

      let str3 = data.tResult[7].detail;
      $("#privateInfo").append(str3);

      let str4 = data.tResult[8].detail;
      $("#dataSource").append(str4);

      let str5 = data.tResult[9].detail;
      $("#marketing").append(str5);

    },
    dataType:"json"
  });
</script>

<body>
  <div style="background-color:#ffffff;padding:1.85em;text-align: center;">
    <div class="hdr-tit" style="display: inline-flex;">
      <div style="word-break: keep-all;">
        <b>로지스링크 약관 신청</b>
      </div>
    </div>
  </div>
  <div class="contents" style="height: auto;">

    <div id="group-list" class="cont-wrapper-page-grid termsOfUse">
      <div class="editor">
        <div class="form-group">
          <div class="input-group input-group-sm col middle-name form-group" style="margin-bottom: 1.375em;">
            <div class="input-group input-group-sm col radio-or-checkBox ">
              <input id="allCheck" name="btnAllChk" type="checkbox">
              <label for="allCheck" class="label-margin">
                <span><b>이용약관, 이하 사항 모두 동의합니다.</b></span>
              </label>
            </div>
          </div>

          <div class="input-group input-group-sm col middle-name form-group" style="margin-bottom: 1.375em;">
            <div class="input-group input-group-sm col radio-or-checkBox ">
              <input id="agreeYn" name="btnChk" type="checkbox" value="N">
              <label for="agreeYn" class="label-margin">
                <span><b>이용약관</b>(필수)</span>
              </label>
            </div>
            <span>&nbsp;</span>
            <textarea rows="11" class="form-control form-control-sm noColorReadonly" readonly="readonly" id="agree"></textarea>
          </div>

          <div class="input-group input-group-sm col middle-name form-group" style="margin-bottom: 1.375em;">
            <div class="input-group input-group-sm col radio-or-checkBox ">
              <input id="privacyYn" name="btnChk" type="checkbox" value="N">
              <label for="privacyYn" class="label-margin">
                <span><b>개인정보수집이용동의</b>(필수)</span>
              </label>
            </div>
            <span>&nbsp;</span>
            <textarea rows="11" class="form-control form-control-sm noColorReadonly" readonly="readonly" id="privacy"></textarea>
          </div>

          <div class="input-group input-group-sm col middle-name form-group" style="margin-bottom: 1.375em;">
            <div class="input-group input-group-sm col radio-or-checkBox ">
              <input id="privateInfoYn" name="btnChk" type="checkbox" value="N">
              <label for="privateInfoYn" class="label-margin">
                <span><b>개인정보처리방침</b>(필수)</span>
              </label>
            </div>
            <span>&nbsp;</span>
            <textarea rows="11" class="form-control form-control-sm noColorReadonly" readonly="readonly" id="privateInfo"></textarea>
          </div>

          <div class="input-group input-group-sm col middle-name form-group" style="margin-bottom: 1.375em;">
            <div class="input-group input-group-sm col radio-or-checkBox ">
              <input id="dataSecureYn" name="btnChk" type="checkbox" value="N">
              <label for="dataSecureYn" class="label-margin">
                <span><b>데이터보안서약</b>(필수)</span>
              </label>
            </div>
            <span>&nbsp;</span>
            <textarea rows="11" class="form-control form-control-sm noColorReadonly" readonly="readonly" id="dataSource"></textarea>
          </div>

          <div class="input-group input-group-sm col middle-name form-group" style="margin-bottom: 1.375em;">
            <div class="input-group input-group-sm col radio-or-checkBox ">
              <input id="marketingYn" name="btnChk" type="checkbox" value="N">
              <label for="marketingYn" class="label-margin">
                <span><b>마케팅정보수신동의</b>(선택)</span>
              </label>
            </div>
            <span>&nbsp;</span>
            <textarea rows="11" class="form-control form-control-sm noColorReadonly" readonly="readonly" id="marketing"></textarea>
          </div>

        </div>
        <div class="form-group">
          <div class="input-group input-group-sm col middle-name form-group" style="display: inline-flex;justify-content: space-between;">
            <button type="button" onclick="termsOfUseCancle();" id="termsOfUseCancle" class="btn btn-danger" style="display: inline;width: 48%;height: 31px;font-size: smaller;"><i class="bi bi-clipboard-x"></i>취소</button>
            <button type="button" onclick="termsOfUseSuccess();" id="termsOfUseSuccess" class="btn btn-success" style="display: inline;width: 48%;height: 31px;font-size: smaller;"><i class="bi bi-clipboard-check"></i>확인</button>
          </div>
        </div>
      </div>
    </div>
  </div>
</body>

<script type="text/javascript">
function InsertAgreeData(userName,mobile,necessary,selective,version){

  $.ajax({
        url:"/terms/insertTermsAgree.do",
        type: "POST",
        data : {
            userId:userName,
            tel:mobile,
            necessary:necessary,
            selective:selective,
            version:version
        },
        dataType: "json",
        success:function(data){
            alert("갱신 되었습니다");
        }
    });
}

function termsOfUseCancle(){
    location.href = "/";
    localStorage.clear();
}

var userName;
var mobile;
var authSeq;
var userMainPage;

function termsOfUseSuccess(){

    var necessary;
    var selective;
    var termsVersion;
    //var userMainPage;
    var defaultPage;
    var result;

// 선택항목 약관 동의 외 필수 항목 약관 동의에 관한 내용 Filter 수정
    if($("#agreeYn").val() == "Y" && $("#privacyYn").val() == "Y" && $("#privateInfoYn").val()=="Y" && $("#dataSecureYn").val()=="Y"){

        if($("#marketingYn").val()=="N") {
            selective = "N";
        }
        else{
            selective = "Y";
        }

        userName ='${sessionScope.userInfo.userId}';
        mobile = '${sessionScope.userInfo.mobile}';
        authSeq = '${sessionScope.userInfo.authSeq}';
        userMainPage = '${sessionScope.userInfo.userMainPage}';

        necessary = "Y";
        termsVersion = "1.0";

        InsertAgreeData(userName,mobile,necessary,selective,termsVersion);

        if(authSeq == "210"){
            defaultPage = "/oms/order/omsOrderList.do";
        } else{
            defaultPage = "/contents/order/orderList.do";
        }

        if(userMainPage == null || userMainPage == "") {
            result = defaultPage;
        } else {
            result = userMainPage;
        }

        location.href = result;

    }else{

        let str ='';
        if($("#agreeYn").val()=="N"){
            str +='"이용약관" ';
        }

        if($("#privacyYn").val()=="N") {
            str +='"개인정보수집이용동의" ';
        }

        if($("#privateInfoYn").val()=="N") {
            str +='"개인정보처리방침" ';
        }

        if($("#dataSecureYn").val()=="N") {
            str +='"데이터보안서약" ';
        }
        alert(str+"에 대한 필수항목에 동의해주세요");
    }

}

$("#allCheck").click(function() {
    if($("#allCheck").is(":checked")){
        $("input[name=btnChk]").prop("checked", true);
        $("input[name=btnChk]").val("Y");
    }else{
        $("input[name=btnChk]").prop("checked", false);
        $("input[name=btnChk]").val("N");
    }
});

$("input[name=btnChk]").click(function() {
    var total = $("input[name=btnChk]").length;
    var totalChecked = $("input[name=btnChk]:checked").length;
    var id = $(this).context.id;
    var checked = $(this).context.checked;

    if(checked == true){
        $("#"+id).val("Y")
    }else{
        $("#"+id).val("N")
    }

    if(total != totalChecked){
        $("#allCheck").prop("checked", false);
    }else{
        $("#allCheck").prop("checked", true);
    }
});
</script>
</html>