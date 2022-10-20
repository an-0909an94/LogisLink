<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div class="pop-layer">
    <div class="editor_wrap pop-layer" id="layer1">
        <!-- wrap -->
        <div class="k-tabstrip-wrapper">
            <div id="editor_tabs" class="tabs_wrap k-widget k-tabstrip k-floatwrap k-tabstrip-top" data-role="tabstrip"
                tabindex="0" role="tablist" aria-activedescendant="editor_tabs_ts_active">
                <!-- content -->
                <div class="tab-content k-content k-state-active" id="editor_tabs-1" role="tabpanel"
                    aria-expanded="true" style="display: block;">
                    <fieldset>
                        <legend style="text-align: center;">사업자검색</legend>
                        
                        <div class="form-group row">
                            <!--
                        	<div class="col input-group middle-name col-2">
							    <select class="custom-select searchSelectBox" id="sSelector" name="sSelector">
									<option value="BIZ_NUM" selected="selected">--사업자번호--</option>
									<option value="BIZ_NAME">--사업자상호--</option>
							    </select>
							</div>
							-->
                            <div class="col input-group middle-name">
                                 <input type="text" class="form-control form-control-sm searchInputBox searchValue" id="sValue" name="sValue" maxlength="13">
                            </div>
                            <div class="padding">
                                <a onclick="goList();" class="k-pager-refresh k-button"><b class="btn-b"><i class="k-icon k-i-zoom"></i>검색</b></a>
                            </div>
                        </div>
                    </fieldset>
	                <div id="splitter" style="min-height:544px; border: 0;">
	               		<div id="bizInfo_grid" style="min-width:1350px;"></div>
	               	</div>
                    <!-- editor -->
                </div>
            </div><!-- content -->
        </div>
    </div><!-- wrap -->
</div>

<script type="text/javascript">

/*
* 결과 List 부분 확인 페이지 Backup
* Junghwan.Hwang - NICE_DNB - 2022-10-19
*/
/*
var columns = [
  {field: "bizName", title: "회사명"},
  {field: "bizNum", title: "사업자번호", width: 110,
    template: "#=Util.formatBizNum(bizNum)#"
  },
  {field: "bizAddr", title: "주소"},
  {field: "ceo", title: "대표자", width: 100},
  {field: "bizKind", title: "업종", width: 130},
  {field: "mainProduct", title: "주생산품"},
  { template: "<a class='k-pager-refresh k-button noColorReadonly' style='width:\\\56px; height:\\\32px; background:\\\#fff; border:\\\none; box-shadow:\\\0px 0px 2px 0px;' onclick='selectBizInfo(this)'><b class='btn-b'><i class='k-icon k-i-check'></i></b></a>", title: "선택", width: 62 }
];
*/

var columns = [
    { template: "<a class='k-pager-refresh k-button noColorReadonly' style='width:\\\36px; height:\\\32px; background:\\\#fff; border:\\\none; box-shadow:\\\0px 0px 2px 0px;' onclick='selectBizInfo(this)'><b class='btn-b'><i class='k-icon k-i-check'></i></b></a>", title: "선택", width: 30
    },
    {field: "cmpNm", title: "회사명", width: 90 ,attributes :
          { style : "text-align : left" }
    },
	{field: "bizNo", title: "사업자번호", width: 40,
		template: "#=Util.formatBizNum(bizNo)#"
	},
    {field: "zip", title: "우편번호", hidden:true ,attributes :
          { style : "text-align : left" }
    },
	{field: "adr", title: "주소" , hidden:true, attributes :
          { style : "text-align : left" }
    },
    {field: "dtlAdr", title: "상세주소", hidden:true ,attributes :
          { style : "text-align : left" }
    },
    {field: "address", title: "주소", width: 120
        ,template:kendo.template("#if (adr != null) {# <div>#=adr#</div> <div>#=dtlAdr#</div> #} #")
        ,attributes : { style : "text-align : left" }
    },
    {field: "ceoNm", title: "대표자", width: 60 ,attributes :
          { style : "text-align : left" }
    },
	{field: "cmpSclNm", title: "업종", hidden: true ,width: 100 ,attributes :
          { style : "text-align : left" }
    },
	{field: "indNm", title: "업태" ,width: 95, attributes :
          { style : "text-align : left" }
    },
    {field: "cmpTypNm", title: "영업유무" ,width: 35, attributes :
          { style : "text-align : left" }
    },
];

var oGrid = null;
//oGrid = new gridData("bizInfo_grid");
oGrid = new gridData("bizInfo_grid");
oGrid.initGrid();
oGrid.setSelectable(true);
oGrid.setPageable(true);
//oGrid.setSendUrl("/contents/basic/data/searchBizinfo.do");
oGrid.setSendUrl("/contents/basic/data/searchNiceinfo.do");

$(document).ready(function(){
	$("#splitter").kendoSplitter({
        orientation: "vertical",
        panes: [{resizable:true}, {resizable:true}]
    });
    goList();
});

document.getElementById('sValue').addEventListener('keydown',function (event) {
    if(event.code === "Enter"){
        event.preventDefault();
        goList();
    }
});

/*
// goList 빽업
function goList(){
	if($("#sSelector option:selected").val() == "BIZ_NUM"){
		var param = {
			selector : $("#sSelector").val(),
			value : $("#sValue").val().replace(/\-/g, '')
		}; 		
	}else{
		var param = {
			selector : $("#sSelector").val(),
			value : $("#sValue").val()
		}; 
	}

	var grid = $("#bizInfo_grid").data("kendoGrid");
	
	oGrid.setSearchData(param);
	
	if(grid == null) {	//페이지를 처음 로딩한 경우, 그리드를 최초 1회 생성한다.
		oGrid.setGrid(columns);
		grid = $("#bizInfo_grid").data("kendoGrid");
	} else {			//그리드가 생성된 이후로는 dataSource만 세팅한다.
		grid.setDataSource(oGrid.gridOption.dataSource);
	}
}
*/

// 한글 체크
function checkKor(str) {
  const regExp = /[ㄱ-ㅎㅏ-ㅣ가-힣]/g;
  if(regExp.test(str)){
    return true;
  }else{
    return false;
  }
}

// 숫자 체크
function checkNum(str){
  const regExp = /[0-9]/g;
  if(regExp.test(str)){
    return true;
  }else{
    return false;
  }
}

//특수문자 체크
function checkSpc(str){
  const regExp = /[~!@#$%^&*()_+|<>?:{}]/;
  if(regExp.test(str)){
    return true;
  }else{
    return false;
  }
}

function goList(){

    /*
    // 사업자 상호, 사업자 번호 내용 처리해 주는 모듈
    if($("#sSelector option:selected").val() == "BIZ_NUM"){
        var param = {
            selector : $("#sSelector").val(),
            value : $("#sValue").val().replace(/\-/g, '')
        };
    }else{
        var param = {
            selector : $("#sSelector").val(),
            value : $("#sValue").val()
        };
    }*/

    var url = new URL(window.location.href);
    var BizValue = url.searchParams.get("bizname");

    var BizCode = "CMP_NM";

    if($('#sValue').val() != null && $('#sValue').val()!=""){
        BizValue = $('#sValue').val().replace(/\-/g, '');
    }

    if(checkSpc(BizValue)){
        alert("특수문자가 입력되었습니다.");
        return;
    }

    if(checkKor(BizValue)) {
        BizCode = "CMP_NM";
    }

    if(checkNum(BizValue)) {
        BizCode = "BIZ_NO";
    }

    var param = {
        BizCode : BizCode,
        BizValue : BizValue
    }

    //var grid = $("#bizInfo_grid").data("kendoGrid");

    /*
    oGrid.setSearchData(param);

    if(grid == null) {	//페이지를 처음 로딩한 경우, 그리드를 최초 1회 생성한다.
        oGrid.setGrid(columns);
        grid = $("#bizInfo_grid").data("kendoGrid");
    } else {			//그리드가 생성된 이후로는 dataSource만 세팅한다.
        grid.setDataSource(oGrid.gridOption.dataSource);
    }
    */

    var grid = $("#bizInfo_grid").kendoGrid({
      dataSource: {
        transport: {
          read: {
            url: "/contents/basic/data/searchNiceinfo.do",
            type: "post",
            dataType: "json",
            data: param,
            beforeSend: function(req) {
              req.setRequestHeader("AJAX", true);
            }
          }
        },
        schema: {
          data: function(response) {
            return response.data;
          },
          total: function(response) {
            return response.total;
          },
        },
        //pageSize: 100,
        //serverPaging: true,
        //serverFiltering: true,
        //pageable: "all",
        error: function(e) {
          if (e.xhr.status == "400") {
            alert("세션값이 존재하지 않습니다. 로그인 페이지로 이동합니다.");
            location.href = "/";
          }
        }
      },
      excel: {
        fileName: "test.xlsx",
        proxyURL: "/cmm/saveGrid.do",
        filterable: false,
        allPages: true
      },
      excelExport: function(e) {
        if($("#loading").length > 0) $("#loading").hide();
      },
      navigatable: true,
      selectable: "cell",
      persistSelection: true,
      editable: false,
      columns: columns,
      noRecords: true,
      resizable: true,
      scrollable: {
        endless: true
      },
      sortable : true,
      pageable: false,
      //sort: onSortEnd,
      messages: {
        noRecords: "조회된 데이터가 없습니다."
      }
    }).data("kendoGrid");



}

// 선택 후 데이터 전달 하고 Window 꺼지는 Method
// JungHwan.Hwang - 기업 검색 - 2022-10-19
function selectBizInfo(e){
  var grid = $("#bizInfo_grid").data("kendoGrid");
  var dataItem = grid.dataItem($(e).closest("tr"));

  $.ajax({
    url: "/contents/basic/data/checkBizNum.do",
    type: "POST",
    dataType: "json",
    data: {
      bizNum : dataItem.bizNo
    },
    success: function(data) {

      var mode = "";
      var chkBizNum = {};
      if (data.result) {

        if (!confirm('이미 등록되어있는 사업자 입니다. \n계속 진행하시려면 "확인" 버튼을 클릭해주세요.')) {
          //chkUID = false;
          return false;
        }

        chkBizNum.bizNum = dataItem.bizNo;

        mode = "BE";

      } else {
        alert(data.msg.replace('\\n', '\n'));

        chkBizNum.cmpNm = dataItem.cmpNm;
        chkBizNum.bizNum = dataItem.bizNo;
        chkBizNum.adr = dataItem.adr;
        chkBizNum.dtlAdr = dataItem.dtlAdr;
        chkBizNum.ceoNm = dataItem.ceoNm;
        chkBizNum.cmpSclNm = dataItem.cmpSclNm;
        chkBizNum.indNm = dataItem.indNm;
        chkBizNum.zip	= dataItem.zip;
        chkBizNum.cmpTypNm = dataItem.cmpTypNm;

        mode = "N";
      }
      window.opener.setSearchBizInfo(mode,chkBizNum);
      window.close();
    },
  });
}

// Test 용 - Junghwan.hwang
function findBizInfo(bizNum){

  var mBizNum = bizNum;

  $.ajax({
    url: "/contents/basic/data/checkBizNum.do",
    type: "POST",
    dataType: "json",
    data: {
      bizNum : mBizNum
    },
    success: function(data) {

      var mode = "";
      var chkBizNum = {};
      if (data.result) {

        if (!confirm('이미 등록되어있는 사업자 입니다. \n계속 진행하시려면 "확인" 버튼을 클릭해주세요.')) {
          //chkUID = false;
          return false;
          window.close();
        }
        else
        {
          chkBizNum.bizNum = dataItem.bizNo;
          mode = "BE";
        }

      }
      window.opener.setSearchBizInfo(mode,chkBizNum);
      window.close();
    },
  });
}

/*
$(".searchValue").on("keypress", function (event){
	if(event.keyCode==13){
		goList();
	}
});
*/

$("#sSelector").change(function(){
	if($(this).val() == "BIZ_NUM"){
		$("#sValue").attr("maxlength", "13");
	}else{
		$("#sValue").removeAttr("maxlength");
	}
	$("#sValue").val("");
});

// 사업자번호 형태로 변환해 주는 Function
$('#sValue').on('input', function() {
	if($("#sSelector option:selected").val() == "BIZ_NUM"){
		var bizNum = $(this).val().replace(/[^\d]/g, '');
		var temp = bizNum.replace(/(\d{3})(\d{1,2})(\d{1,5})/, '$1-$2-$3');
		$(this).val(temp);
	}
});

</script>
<style>
<!--
span.k-pager-info.k-label {
    font-size: x-small;
}
-->
</style>
