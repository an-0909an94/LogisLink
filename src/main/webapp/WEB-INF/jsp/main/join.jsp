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
<body>
	<div style="background-color:#ffffff;padding:1.85em;text-align: center;">
	   	<div class="hdr-tit" style="display: inline-flex;">
		     <div style="word-break: keep-all;">
	            <b>로지스링크 이용신청</b>
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
		                		<span><b>이용약관 동의, 개인정보 처리방침에 모두 동의합니다.</b></span>
		                	</label>
		                </div>
                	</div>
                    <div class="input-group input-group-sm col middle-name form-group" style="margin-bottom: 1.375em;">
                    <div class="input-group input-group-sm col radio-or-checkBox ">
	                	<input id="serviceYn" name="btnChk" type="checkbox" value="N">
	                	<label for="serviceYn" class="label-margin">
	                		<span><b>이용약관 동의</b>(필수)</span>
	                	</label>
	                </div>
                    <span>&nbsp;</span>
                        <textarea rows="11" class="form-control form-control-sm noColorReadonly" readonly="readonly">
제1장. 총칙
제1조 (목적)
본 약관은 사용자가 이스턴물류㈜(이하"회사")에서 제공하는 “로지스링크”의 설치 및 이용과 관련하여 회사와 이용자간의 권리, 의무 및 책임사항 및 절차 등 기본적인 사항을 규정함을 목적으로 합니다.

제2조 (용어 정의)
본 약관에서 사용하는 용어의 정의는 다음과 같습니다.
1.로지스링크 : “ 로지스링크”란, 회사가 화물 및 차량정보를 사용자에게 제공하기 위하여 컴퓨터 등 정보통신설비를 이용하여, 화주와 주선사/운송사, 차주 간의 배차를 진행할 수 있도록 설정한 회사가 운영하는 웹사이트를 말합니다.
2.사용자(화주/주선사/운송사/차주 )란 본 약관에 동의하고 약관에 따라 회사가 제공하는 서비스를 이용하는 사용자(화주/주선사/운송사/차주)를 말합니다.
3.아이디(ID): 회사의 사용자로 가입한 자가 서비스를 이용하고자 할 경우에 대비하여 사용자의 동일성 확인을 위해 문자 또는 숫자의 조합으로 정한 사용자의 고유명칭을 말합니다.
4.비밀번호: 아이디를 이용한 서비스 이용신청 시 사용자의 동일성 확보를 위하여 사용자가 정하고 회사와 공유하는 문자 숫자의 조합정보를 의미합니다.
5.운영자: 회사에서 서비스의 전반적인 관리와 원활한 운영을 위하여 선정한 사람을 말합니다.
6.탈퇴: 사용자가 탈퇴의사를 운영자에게 전달하며, 서비스 이용계약을 종료하는 것을 말합니다.

본 약관에서 사용하는 용어 중 본 조 제1항에서 정의하는 것을 제외하고는 관계법령 및 서비스 별 안내 등에서 정하는 바에 따릅니다.

제3조 (약관의 공비 및 효력, 약관의 변경)
1. 이 약관의 내용은 다음 각호에 규정된 방법으로 사용자에게 공지함으로써 그 효력이 발생합니다.
(1) 모바일 프로그램을 통한 고지
2.회사는 합리적인 사유가 발생할 경우에는 사전 동의 없이 약관의 내용을 변경할 수 있으며, 변경된 약관은 제1항과 같은 방법으로 적용일자와 개정사유를 포함하여 그 내용을 공지함으로써 그 효력을 발생합니다.
3.회사가 약관을 개정할 경우, 적용일자 및 개정사유를 명시하여 현행약관과 함께 모바일 어플 초기화면에 그 적용일자 7일 이전부터 적용일자 전일까지 공지합니다.
4.본 약관의 개정과 관련하여 이의가 있는 사용자는 탈퇴를 할 수 있습니다. 단, 이의가 있음에도 불구하고 회사의 통지가 있은 후 30일 이내에 탈퇴를 하지 않은 사용자는 개정약관에 동의한 것으로 간주합니다.
5.약관 개정 이전에 가입한 이용자일지라도 개정약관 적용일부터는 개정된 약관의 적용을 받습니다.

제4조. 약관 외 준칙 
1.이 약관에 명시되지 아니한 사항에 대하여는 전기통신기본법, 전기통신사업법, 정보통신망 이용촉진 등에 관한 법률 및 기타 관계법령의 규정에 의합니다.
2.회사는 약관 이외에 개별 서비스에 대한 세부적인 사항을 정할 수 있으며, 그 내용은 해당 서비스의 이용안내를 통하여 공지합니다.

제5조 (이용계약의 성립)
1.“로지스링크” 이용계약은 “사용자”가 되고자 하는 자(이하 “사용신청자”)가 회사가 요구하는 항목들을 사실대로 기재하고 약관에 동의 버튼을 선택하여 동의 의사를 회사에 전자적 방식으로 전송하게 되면 본약관에 동의하고 회사에 서비스 이용을 신청한 것으로 간주됩니다.
2.“로지스링크”이용계약은 제5조 제1항의 약관 동의를 포함하는 서비스 이용신청에 대하여, 회사가 다음 각 호의 제반요건을 충족한 사용신청자에게 서비스 이용을 승낙함으로써 성립합니다.
(1)	사용신청자는 반드시 신청자 본의의 명의로 가입하여야 합니다. 
(2)	회사는 본인확인기관 등을 통한 “ 본인확인”을 요청합니다. 본인확인의 경우 개인정보보호 관계법령에 따라 본인확인기관 등이 제공하는 별도의 이용약관 동의에 의거하여 본인확인 절차를 진행하며, 회사는 본인확인절차를 취할 수 없는 이용신청에 대해 신청자에게 추가적으로 증빙자료를 요청할 수 있습니다.

제6조 (이용신청)
1.서비스의 이용을 원하는 사용자는 다음 각 호의 서류를 이메일 또는 우편으로 당사에  제출하여야 합니다. 

화주 : 사업자등록증
주선사 : 사업자등록증,주선사 면허
운송사 : 사업자등록증,운송허가증, 운송사 정보요청서
차주 : 사업자등록증,차량등록증

제7조 (개인정보 보호 정책) 
회사와 운영대행사는 관련법령이 정하는 바에 따라서 사용자의 위치정보를 보호하기 위하여 노력하며, 사용자의 위치정보보호에 관해서는 관련법령 및 회사가 별도로 마련한 개인위치정보약관에 따르며,위치정보보호 약관은 회사 웹사이트를 통해 공지하고 있습니다.

1.회사는 이용자의 정보수집 시 구매계약 이행에 필요한 최소한의 정보를 수집 합니다. 다음 사항을 필수사항으로 하며 그 외 사항은 선택사항으로 합니다. 
① 사업자번호 
② 회사명 
③ 희망ID 
④ 비밀번호 
⑤ 대표자명 
⑥ 주소 
⑦ 대표 연락처 
⑧ 담당자명 
⑨ 담당자 연락처(유선전화/핸드폰 ) 
⑩ 차량정보 (차량번호, 차종, 차량톤급) 
⑪ 기타 회사가 필요하다고 인정하는 사항 
2.“회사”는 이용자의 개인식별이 가능한 개인정보를 수집하는 때 에는 반드시 당해 이용자의 동의를 받습니다. 
3.제공된 개인정보는 당해 이용자의 동의 없이 목적 외의 이용이나 제3자에게 제공 할 수 없으며, 이에 대한 모든 책임은 회사가 집니다. ( 다만, 통계작성, 학술연구, 시장조사를 위하여 필요한 경우로서, 특정 개인을 식별할 수 없는 형태로 제공하는 경우에는 예외로 합니다.) 
4. 회사는 관계법령이 정하는 바에 따라 사용자 개인정보 보호/관리를 위해 필요한 조치를 취하고 회사의 개인정보 보호정책에 해당 내용을 게시하며 개인정보의 보호 및 사용에 대해서는 관련 법령 및 회사의 “개인정보보호정책 ”이 적용됩니다. 또한, 회사는 이용자의 귀책사유로 인하여 노출된 정보에 대해서는 책임을 지지 않습니다. 
5.이용자는 언제든지 “회사”가 가지고 있는 자신의 개인정보에 대해 열람 및 오류 정정을 요구할 수 있으며, “회사”는 이에 대해 지체 없이 필요한 조치를 취할 의무를 집니다. 이용자가 오류의 정정을 요구한 경우에는 “회사”는 그 오류를 정정할 때까지 당해 개인정보를 이용하지 않습니다.

제8조 (서비스 이용 신청의 승인) 
1. 다음 각 호에 해당하는 이용신청에 대하여는 가입을 거절하거나 취소할 수 있으며, 또한 실명으로 등록하지 않은 사용자는 일체의 권리를 주장할 수 없습니다. 
① 타인의 정보를 이용하여 신청한 때 
② 서비스 이용신청서의 내용이 허위인 때 
③ 본 서비스를 이용하면서 사회의 안녕, 질서, 미풍양속을 저해하는 행위를 한때 
④ 전기통신기본법, 전기통신사업법, 정보통신 윤리위원회 심의규정, 정보통신 윤리강령, 프로그램 보호법 및 기타 관련 법령과 약관이 금지하는 행위를 한 때 
⑤ 제 4호에 해당하는 사유로 형사처벌을 받거나 회사의 기타 서비스 제공회사로 부터 서비스 이용이 거절된 전력이 있는 때 
⑥ 기타 회사가 정한 이용신청서에 기재사항이 미비된 경우 
⑦ 영리 추구 혹은 부정한 용도로 본 서비스를 이용한 때 
⑧ 기타 규정한 제반 사항을 위반하며 신청하는 경우 
2. 회사는 다음 각 호에 해당하는 이용신청에 대하여는 그 사유가 해소될 때까지 승낙을 유보할 수 있습니다. 
① 서비스 관련 설비에 여유가 없는 경우 
② 기술상 지장이 있는 경우 

제 9조 [서비스의 내용]
회사는 사용자에게 다음과 같은 서비스를 제공합니다.
1.차주 : 
(1) 스마트폰을 통해 화물운송거래를 위한 화물정보, 배차정보, 정산 관리, 세금계산서 발행, 운송비 신청 서비스 등 제공
2.주선사/운송사 :  
(1) 웹사이트, 스마트폰을 통해 화물운송거래를 위한 화물등록 및 차량검색, 정산관리 등의 기능 시스템 제공 
(2) 기타 관련 부가 서비스 제공
3.화주  : 웹사이트를 통한 오더등록, 운송차량 위치정보 제공 
4.각각의 서비스는 전반적인 품질 향상을 위해 사전통보 없이 연기 또는 변경, 중단될 수 있습니다. 

제10조(화물운송계약)
본 서비스 이용을 희망하는 화주는 운송주선사 또는 차주사용자와 직접 화물운송계약을 체결할 수 있으며 이에 대한 모든 의무와 책임은 해당 사용자들이 부담하며, 회사 및 운영사는 이에 관여하지 않습니다. 

제10조(운임수불의 권리와 책임)
회사와 운영사는 본 서비스를 통해 사용자간 거래된 화물운송에 대한 정산 시스템을 제공할 뿐, 차주사용자가 지급받아야 할 운임의 수불에 대해서는 여하한 책임과 의무도 없습니다. 

제10조(화물운송사고)
사용자 간 화물운송 거래 도중 만약에 발생하는 화물의 도난, 파손, 분실, 과적은 물론 화물에 대한 어떤 손해에 대해서도 회사와 운영사는 일절 책임을 지지 않으며, 관계법령 등의 규정에 따릅니다. 

제11조 (서비스 이용 시간)
1.서비스의 이용은 전산시스템 장애 및 정기점검, 인터넷통신망장애, 천재지변 등 불가피한 경우를 제외하고는 연중무휴 1일 24시간 제공을 원칙으로 합니다.

제12조 [서비스 탈퇴, 이용계약의 해지]
1.사용자는 언제든지 회사의 영업시간에 서비스 탈퇴를 신청할 수 있으며, 회사는 해당 사용자와 잔여 업무의 종료 절차를 수행해 영업일 7일 이내에 이용계약을 해지합니다.
2.사용자가 다음 각 호의 사유에 해당할 경우, 회사는 예고 없이 해당 사용자를 탈퇴 또는 자격을 상실시킬 수 있으며, 일정기간 내 재가입을 승낙하지 않을 수 있습니다.
(1)	사용자가 본 서비스를 이용함에 있어 화물자동차운수사업법 등 제반 법령을 위반한 경우.
(2)	타인의 명의를 무단 도용하거나 부정한 방법으로 서비스에 가입하거나 이용한 경우.
(3)	선량한 상거래 도덕 및 미풍양속을 위반하여 본 웹사이트의 신뢰를 떨어뜨리는 경우
(4)	기타 본 약관을 준수하지 않거나 본 서비스에 현저한 지장을 초래한 사용자

제3장. 계약당사자의 의무 
제13조 (회사의 의무) 
회사는 법령과 이 약관이 금지하거나 공공의 미풍양속에 반하는 행위를 하지 않으며 
이 약관이 정하는 바에 따라 지속적이고, 안정적으로 서비스 하는 데 최선을 다하여 
야 합니다. 회사는 서비스에 관련된 설비를 항상 운용할 수 있는 상태로 유지/보수 
하고, 장애가 발생하는 경우 지체 없이 이를 수리/복구할 수 있도록 최선의 노력을 다하여야 합니다. 
회사는 사용자가 안전하게 서비스를 이용할 수 있도록 사용자의 개인정보보호를 위한보안 시스템을 갖추어야 합니다. 

제14조 (사용자의 의무) 
1.사용자는 관계법령, 본 약관의 규정, 이용안내 및 주의사항 등 회사가 통지하는 사항을 준수하여야 하며, 기타 회사의 업무에 방해되는 행위를 하여서는 안됩니다. 
2.사용자는 회사의 사전승낙 없이 서비스를 이용하여 어떠한 영리행위도 할 수 없습니다. 
3.사용자는 서비스를 이용하여 얻은 정보를 회사의 사전승낙 없이 복사, 복제, 변경, 번역, 출판/방송 기타의 방법으로 사용하거나 이를 타인에게 제공할 수 없습니다. 
4.사용자는 자기 신상정보의 변경사항 발생시 즉각 변경하여야 합니다. 정보를 수정 하지 않아 발생하는 모든 결과에 대한 책임은 사용자에게 있습니다. 
5.사용자는 서비스 이용과 관련하여 다음 각 호의 행위를 하지 않아야 하며, 다음 행위를 함으로 발생하는 모든 결과에 대한 책임은 회원에게 있습니다. 
1) 다른 사용자의 아이디(ID)를 부정하게 사용하는 행위 
2) 다른 사용자의 E-mail 주소를 취득하여 스팸메일을 발송하는 행위 
3) 범죄행위를 목적으로 하거나 기타 범죄행위와 관련된 행위 
4) 선량한 풍속, 기타 사회질서를 해하는 행위 
5) 회사 및 타인의 명예를 훼손하거나 모욕하는 행위 
6) 회사 및 타인의 지적재산권 등의 권리를 침해하는 행위 
7) 해킹행위 또는 컴퓨터 바이러스의 유포행위 
8) 타인의 의사에 반하는 광고성 정보 등 일정한 내용을 지속적으로 전송하는 행위 
9) 개인의 사생활을 당해 개인의 동의 없이 공개하거나 무단으로 노출시키는 행위 
10) 서비스의 안정적인 운영에 지장을 주거나 줄 우려가 있는 일체의 행위 
11) 회사가 제공하는 서비스의 내용을 변경하는 행위 
12) 기타 관계법령에 위배되는 행위

제15조 [권리 양도 금지]
1.사용자는 타인이 기타의 목적으로 사용할 수 없으며, 자신의 스마트단말기를 통해 제3자가 서비스를 이용하게 하여서는 아니 됩니다.
2.사용자가 서비스를 제공받는 권리는 양도하거나 증여, 처분 할 수 없습니다.

제16조 [게시물 관리]
회사와 운영대행사는 서비스의 게시물 또는 내용이 반사회적이거나 회사규정에 위반되는 경우 또는 본 서비스나 시스템에 지장을 초래하는 경우 회원의 사전 통지나 동의 없이 이를 삭제할 수 있습니다.

제4장. 손해배상 및 기타 사항 
제17조 (손해배상) 
1.회사는 무료 서비스의 이용과 관련하여 이용자에게 발생한 손해에 대해 어떠한 책임도 지지 않습니다. 
2.사용자가 본 서비스를 이용함에 있어 행한 불법행위로 인해 회사가 다른 사용자 또는 제3자로부터 손해배상청구를 비롯한 각종 이의제기를 받는 경우, 
사용자는 회사의 면책을 위해 노력해야 하며 만일 회사가 면책되지 못한 경우 사용자는 그로 인하여 회사에 발생한 모든 손해를 배상해야 합니다. 
3. 회사에 대한 손해배상의 청구는 회사에 청구사유, 청구금액 및 산출근거를 기재 하여 서면으로 해야 하며, 그 사유가 발생한 날로부터 3개월이 경과한 경우에는 이용자가 회사에 대해 손해배상을 청구할 수 있는 권리는 소멸됩니다.

제 18조 (면책) 
1.회사는 국가의 비상사태, 천재지변 또는 이에 준하는 불가항력으로 인해 서비스 를 제공할 수 없는 경우에는 서비스 제공에 대한 책임을 지지 않습니다. 
2.회사는 사용자의 귀책사유로 인한 서비스의 이용장애에 대해 책임을 지지 않습니다. 
3.회사는 사용자가 서비스를 이용하여 기대하는 수익을 상실한 것에 대한 책임을 지지 않으며, 그밖에 서비스를 통해 얻은 자료로 인한 손해 등에 대하여도 책임을 지지 않습니다. 
4.회사는 사용자가 사이트에 게재한 게시물의 신뢰도 및 정확성 등 내용에 대해 책임을 지지 않으며, 서비스에 게재된 어떠한 의견이나 정보에 대해 확인이나 대표할 의무가 없습니다. 아울러 회사는 사용자나 제3자에 의해 표출된 의견을 승인, 반대 또는 수정하지 않습니다. 
5.회사는 사용자 상호간 또는 사용자와 제3자 상호간에 서비스를 매개로 발생한 분쟁에 대해 가입할 의무가 없으며 이로 인한 손해를 배상할 책임을 지지 않습니다.

제 19조 (분쟁해결) 
1.서비스의 이용과 관련하여 회사와 이용자간에 분쟁이 발생한 경우, 우선 양자 간에 분쟁의 해결을 위해 성실히 협의해야 합니다. 
2.회사는 이용자가 제기하는 정당한 의견이나 불만을 반영하고 그 피해를 보상 처리하기 위해 피해보상처리기구를 설치/운영할 수 있습니다. 
3.회사는 이용자로부터 제출되는 불만사항 및 의견은 우선적으로 처리합니다. 단, 신속한 처리가 곤란한 경우 이용자에게 그 사유와 처리일정 등을 즉시 통보해 드립니다. 
4.회사와 사용자 간에 발생한 분쟁은 전자거래기본법 및 동 시행령에 의해 설치된 전자거래분쟁 조정 위원회의 조정에 따를 수 있습니다.

제20조 (재판권, 관할법원 및 준거법)
1.제19조의 협의에서도 분쟁이 해결되지 않을 경우, 양 당사자는 민사소송법상의 관할법원에 소를 제기할 수 있으며, 이때 관할법원은 회사 본점 소재지를 관할 하는 법원을 전속관할법원으로 합니다. 
2.회사와 사용자간에 제기된 소송에는 대한민국 법을 적용합니다.

부칙
본 약관은 2021년8월 1일부터 시행합니다.
                        </textarea>
                    </div>
                    <div class="input-group input-group-sm col middle-name form-group" style="margin-bottom: 1.375em;">
                    <div class="input-group input-group-sm col radio-or-checkBox ">
	                	<input id="privacyYn" name="btnChk" type="checkbox" value="N">
	                	<label for="privacyYn" class="label-margin">
	                		<span><b>개인정보 처리방침</b>(필수)</span>
	                	</label>
	                </div>
                    <span>&nbsp;</span>
                        <textarea rows="11" class="form-control form-control-sm noColorReadonly" readonly="readonly">
‘로지스링크 (이하 '회사)'는 고객님의 개인정보를 중요시하며, “정보통신망 이용촉진 및 정보보호”에 관한 법률을 준수하고 있습니다.회사는 개인정보취급방침을 통하여 고객님께서 제공하시는 개인정보가 어떠한 용도와 방식으로 이용되고 있으며,개인정보보호를 위해 어떠한 조치가 취해지고 있는지 알려드립니다.회사는 개인정보취급방침을 개정하는 경우 웹사이트 공지사항(또는 개별공지)을 통하여 공지할 것입니다. 본 방침은 2021년 8월 01일 부터 시행됩니다.

회사의 개인정보취급방침은 다음과 같은 내용을 담고 있습니다. 

1. 개인정보의 수집 및 이용목적
2. 수집하는 개인정보 항목 및 수집방법
3. 개인정보의 보유 및 이용 기간
4. 개인정보의 파기
5. 개인정보 제공
6. 수집한 개인정보의 위탁
7. 이용자 및 법정대리인의 권리와 그 행사 방법

1. 개인정보의 수집 및 이용목적
최초 회원가입 시 회원식별 및 최적화된 서비스 제공을 위해 개인 정보를 수집합니다.

2. 수집하는 개인정보 항목 및 수집 방법

1) 화주
	사업자명(상호)
		1.사업자등록번호
		2.법인등록번호
		3.대표 유선번호
		4.대표 팩스번호
		5.대표 휴대폰 번호
		
	담당자
		1.담당자이메일
		2.담당자전화번호

2) 주선사
	사업자명(상호)
		1.사업자등록번호
		2.법인등록번호
		3.주선허가증
		4.대표 유선번호
		5.대표 팩스번호
		6.대표 휴대폰 번호
		
	담당자
		1.담당자 이메일
		2.담당자 전화번호
	
3) 운송사
가.필수항목
		상호(법인명)
			1.사업자등록번호
			2.법인등록번호
			3.아이디/암호
			4.대표자명
			5.대표 유선번호
			6.대표 팩스번호
			7.대표 이메일주소
			8.우편번호
	
		담당자명
			1.담당자 이메일
			2.담당자 전화번호
			3.우편물 수령주소
			4.납부방법
			5.결제 은행
			6.결제 계좌번호
			7.예금주명
			8.예금주 생년월일
			9.운송허가증 상 정보
			10.운송사 정보 요청서 정보
4) 차주
		차주고객명
			1.주소(자택)
			2.차량구분(개별/소속)
			3.차량연식
			4.소속운송사
			5.톤급
			6.차고지
			7.최대 적재중량
			8.거래은행/카드사
			9.이메일
			10.카드번호
			11.예금주생년월일
			
		생년월일
			1.휴대폰번호1
			2.유선전화 번호
			3.어플로그인 비밀번호
			4.상호(사업자명)
			5.사업자등록번호
			6.주요 노선
			7.적재함 폭/길이
			8.계좌번호
			9.납부방법
			10.개인정보 제공 및 활용 동의서 서명
			11.차량구분
		
		자택전화번호
			1.휴대폰번호2
			2.차량번호
			3.차량소속
			4.차종
			5.적재물보험정보
			6.법인등록번호
			7.차량옵션
			8.예금주성명
			9.우편물 수령 주소
			10.개인위치정보 사용동의 확인서 서명
		
서비스 이용과정이나 사업 처리과정에서 아래와 같은 정보들이 생성되어 수집될 수 있습니다.
서비스 이용기록, 접속로그, 쿠키, 접속IP 정보, 결제기록, 불량이용 기록

(2) 수집방법
1) 시스템을 통한 회원가입, 회사 및 콜센터를 통한 수집
2) 제휴된 주선∙운송사를 통한 대리수집 
3) 회사 FAX를 통한 회원 정보가 담겨진 서류 사본수취를 통한 수집 
ㅍ
3. 개인정보의 보유 및 이용 기간
원칙적으로 개인정보 수집 및 이용목적이 달성된 후에는 해당 정보를 지체 없이 파기합니다. 단, 다음의 정보에 대해서는 아래의 이유로 명시한 기간 동안 보존합니다.

(1) 회원탈퇴 시 보존 개인정보
1)보존항목: 회원님께서 제공한 이름, 아이디, 이메일주소, 실명확인값 
2)보존근거: 불량 이용자의 재가입 방지, 명예훼손 등 권리침해 분쟁 및 수사협조
3)보존기간: 회원탈퇴 후 1년 

(2) 상거래 관련 보존 개인정보
1) 보존항목: 상거래이력
2) 보존근거: 상법, 전자상거래등에서의 소비자보호에 관한 법률
3) 보존기간: 계약 또는 청약철회 등에 관한 기록: 5년
대금결제 및 재화 등의 공급에 관한 기록: 5년
소비자의 불만 또는 분쟁처리에 관한 기록: 3년

(3) 로그기록 관련 보존 개인정보 
1) 보존항목: 접속기록
2) 보존근거: 통신비밀보호법
3) 보존기간: 3개월

4. 개인정보의 파기
회사는 원칙적으로 개인정보 수집 및 이용목적이 달성된 후에는 해당 정보를 지체없이 파기합니다. 파기절차 및 방법은 다음과 같습니다.

1) 파기절차 :회원님이 회원가입 등을 위해 입력하신 정보는 목적이 달성된 후 별도의 DB로 옮겨져(종이의 경우 별도의 서류함)내부 방침 및 기타 관련 법령에 의한 정보보호 사유에 따라(보유 및 이용기간 참조) 일정 기간 저장된 후 파기되어집니다.별도 DB로 옮겨진 개인정보는 법률에 의한 경우가 아니고서는 보유되어지는 이외의 다른목적으로 이용되지 않습니다.
2) 파기방법 :전자적 파일형태로 저장된 개인정보는 기록을 재생할 수 없는 기술적 방법을 사용하여삭제합니다.

개인정보 제공
1) 회사는 이용자의 개인정보를 원칙적으로 외부에 제공하지 않습니다. 다만, 아래의 경우에는 예외로 합니다.
2) 이용자들이 사전에 동의한 경우
3) 법령의 규정에 의거하거나, 수사 목적으로 법령에 정해진 절차와 방법에 따라 수사기관의 요구가 있는 경우

수집한 개인정보의 위탁
1) 당사는 전문적인 고객지원 및 서비스 제공을 위해 아래와 같이 개인정보 취급 업무를 외부 업체에 위탁하여 운영하고 있습니다.
2) 위탁계약 시 개인정보보호의 안전을 기하기 위하여 개인정보보호 관련 지시 엄수, 개인정보에 관한 유출금지 및 사고시의 책임부담 등을 명확히 규정하고 위탁계약 내용에 포함되어 있습니다.
3) [서비스 제공 위탁업체]
	업체명	
		1.코리아로지스
		
	위탁업무
		1.고객운영센터
		2.	로지스링크 운영
		
	비고
		1.운영대행사

이용자 및 법정 대리인의 권리와 그 행사방법
이용자가개인정보의 정정 혹은 파기를 위하여 개인정보관리담당부서에 서면, 또는 이메일로 연락하시면 지체없이 조치하겠습니다.
귀하가 개인정보의 오류에 대한 정정을 요청하신 경우에는 정정을 완료하기 전까지 당해 개인정보를 이용 또는 제공하지 않습니다. 또한 잘못된 개인정보를 제3자에게 이미 제공한 경우에는 정정 처리결과를제3자에게 지체 없이 통지하여 정정이 이루어지도록 하겠습니다.
회사는 이용자의 요청에 의해 해지 또는 삭제된 개인정보는 “회사가 수집하는 개인정보의 보유 및이용기간”에 명시된 바에 따라 처리하고 그 외의 용도로 열람 또는 이용할 수 없도록 처리하고 있습니다.

개인정보에 관한 민원 서비스
고객의 개인정보를 보호하고 개인정보와 관련한 불만을 처리하기 위하여 당사는 개인정보 관리책임자를 두고 있습니다.
고객의 개인정보와 관련한 문의사항이 있으시면 아래의 개인정보 관리책임자 또는 개인정보 관리담당자에게 연락 주시기 바랍니다.

개인정보 관리책임자 : 박지용 팀장
개인정보 관리담당자 : 이승환 차장
회사의 서비스를 이용하시며 발생하는 모든 개인정보보호 관련 민원을 개인정보관리책임자 혹은 담당부서로 신고하실 수 있습니다. 회사는 이용자들의 신고사항에 대해 신속하게 충분한 답변을 드릴 것입니다.
기타 개인정보침해에 대한 신고나 상담이 필요하신 경우에는 아래 기관에 문의하시기 바랍니다.

개인분쟁조정위원회 (www.1336.or.kr / 1336)
정보보호마크인증위원회 (www.eprivacy.or.kr / 02-580-0533~4)
대검찰 청인터넷범죄수사센터 (icic.sppo.go.kr / 02-3480-3600)
경찰청 사이버테러대응센터 (www.ctrc.go.kr / 02-392-0330
                        </textarea>
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
	
		<div id="group-list" class="cont-wrapper-page-grid signUp" style="display: none;">
			<div class="editor">
           		<form id="f" data-toggle="validator" role="form" autocomplete="off">
           			<input type="hidden" id="custId" name="custId" class="hiddenValue">
           			<input type="hidden" id="deptId" name="deptId" class="hiddenValue">
					<div class="pb25" style="text-align: center;">
						<img src="/images/user.png">
						<div>로지스링크 이용신청을 환영합니다.</div>
						<div>이용신청에 필요한 정보를 입력해 주세요.</div>
					</div>
	                <div class="form-group">
	                    <div class="input-group input-group-sm col middle-name form-group" style="margin-bottom: 0.375em;">
	                    <strong class="required">사업자번호</strong>
	                        <input type="text" class="form-control form-control-sm" name="bizNum" id="bizNum" maxlength="12" required>
                            <div class="help-block with-errors"></div>
	                    </div>
	                    <div class="input-group input-group-sm col middle-name form-group">
	                        <button type="button" id="bizNumCheck" class="btn btn-danger" style="display: block;width: 100%;height: 31px;font-size: smaller;"><i id="bizNumCheckIcon" class="bi bi-clipboard-x"></i>사업자번호 등록확인</button>
	                    </div>
	                </div>
	                
	                <div class="form-group">
	                    <div class="input-group input-group-sm col middle-name form-group">
	                    <strong class="required">상호</strong>
	                        <input type="text" class="form-control form-control-sm" name="bizName" id="bizName" required>
                            <div class="help-block with-errors"></div>
	                    </div>
	                    <div class="input-group input-group-sm col middle-name form-group">
	                    <strong class="required">분류</strong>
	                        <select class="form-control custom-select col" id="custTypeCode" name="custTypeCode" required></select>
                            <div class="help-block with-errors"></div>
	                    </div>
	                </div>
	                
	                <div class="form-group">
	                    <div class="input-group input-group-sm col middle-name form-group">
	                    <strong>업태</strong>
	                        <input type="text" class="form-control form-control-sm" name="bizCond" id="bizCond">
	                    </div>
	                    <div class="input-group input-group-sm col middle-name form-group">
	                    <strong>업종</strong>
	                        <input type="text" class="form-control form-control-sm" name="bizKind" id="bizKind">
	                    </div>
	                </div>
	                
	                <div class="form-group">
	                    <div class="input-group input-group-sm col middle-name form-group">
	                    <strong class="required">과세유형</strong>
	                        <select class="form-control custom-select col" id="bizTypeCode" name="bizTypeCode" required></select>
	                        <div class="help-block with-errors"></div>
	                    </div>
	                    <div class="input-group input-group-sm col middle-name form-group">
	                    <strong class="required">대표자명</strong>
	                        <input type="text" class="form-control form-control-sm" name="ceo" id="ceo" required>
	                        <div class="help-block with-errors"></div>
	                    </div>
	                </div>
	                
	                <div class="form-group">
	                    <div class="input-group input-group-sm col middle-name form-group">
	                    <strong>은행명</strong>
	                        <select class="form-control custom-select col" id="bankCode" name="bankCode"></select>
	                    </div>
	                    <div class="input-group input-group-sm col middle-name form-group">
	                    <strong>예금주</strong>
	                        <input type="text" class="form-control form-control-sm" name="bankCnnm" id="bankCnnm">
	                    </div>
	                </div>
	                
	                <div class="form-group">
	                    <div class="input-group input-group-sm col middle-name form-group">
	                    <strong>계좌번호</strong>
	                        <input type="text" class="form-control form-control-sm" name="bankAccount" id="bankAccount">
	                    </div>
	                    <div class="input-group input-group-sm col middle-name form-group" id="divDeptSelect">
	                    <strong class="required">부서명</strong>
	                        <input type="text" class="form-control form-control-sm" name="deptName" id="deptName" required>
	                        <div class="help-block with-errors"></div>
	                    </div>
	                </div>
	                
	                <div class="form-group">
	                    <div class="input-group input-group-sm col middle-name form-group" style="margin-bottom: 0.375em;">
	                    <strong class="required">아이디</strong>
	                        <input type="text" class="form-control form-control-sm" name="userId" id="userId" required>
                            <div class="help-block with-errors"></div>
	                    </div>
	                    <div class="input-group input-group-sm col middle-name form-group">
	                        <button type="button" id="userIdCheck" class="btn btn-danger" style="display: block;width: 100%;height: 31px;font-size: smaller;"><i id="userIdCheckIcon" class="bi bi-person-x"></i>아이디 중복확인</button>
	                    </div>
	                </div>
	                
	                <div class="form-group">
	                    <div class="input-group input-group-sm col middle-name form-group">
	                    <strong class="required">비밀번호</strong>
	                        <input type="password" class="form-control form-control-sm" id="passwd" name="passwd" pattern="^(?=.{4,265}$).*" data-pattern-error="4자리 이상 입력해 주세요.">
                            <div class="help-block with-errors"></div>
	                    </div>
	                    <div class="input-group input-group-sm col middle-name form-group" style="margin-bottom: 1rem;">
	                    <strong class="required">비밀번호 확인</strong>
	                        <input type="password" class="form-control form-control-sm" id="passwd_comfirm" name="passwd_comfirm" data-match="#passwd" data-match-error="비밀번호가 일치하지 않습니다.">
                            <div class="help-block with-errors"></div>
	                    </div>
	                </div>
	                
	                <div class="form-group">
	                    <div class="input-group input-group-sm col middle-name form-group">
	                    <strong class="required">성명</strong>
	                        <input type="text" class="form-control form-control-sm" name="userName" id="userName" required>
	                        <div class="help-block with-errors"></div>
	                    </div>
	                    <div class="input-group input-group-sm col middle-name form-group">
	                    <strong class="required">핸드폰번호</strong>
	                        <input type="text" class="form-control form-control-sm" name="mobile" id="mobile" maxlength="13" required>
                            <div class="help-block with-errors"></div>
	                    </div>
	                </div>
	                
	                <div class="form-group">
	                    <div class="input-group input-group-sm col middle-name form-group">
	                    <strong>이메일</strong>
	                        <input type="text" class="form-control form-control-sm" name="email" id="email">
	                    </div>
	                    <div class="input-group input-group-sm col middle-name form-group">
	                    	<button type="submit" class="btn btn-primary" style="display: block;width: 100%;height: 40px;font-size: large;"><i class="bi bi-truck"></i>이용신청</button>
	                    </div>
	                </div>
	                
                </form>
            </div>
		</div>
	</div>	
</body>

<script type="text/javascript">
var chkBiz = false;
var chkUid = false;
$(document).ready(function(){
	setCmmCode("select", "custTypeCode", "CUST_TYPE_CD", "", "--분류--");
	setCmmCode("select", "bizTypeCode", "BIZ_TYPE_CD", "", "--과세유형--");
	setCmmCode("select", "bankCode", "BANK_CD", "", "--은행명--");
});


function setCmmCode(type, id, groupCode, dftVal, dftTxt){
	$.ajax({
		url: "/codeList.do",
		type: "POST",
		dataType: "json",
		data: "gCode=" + groupCode,
		async: false,
		success: function(data){
			$("#" + id).empty();
			var s = "";
			if(type == "select"){
				if(dftTxt != "") {
					s += "<option value=\"\" >" + dftTxt + "</option>";
				}
				for(var i=0, item; item=data.data[i]; i++){
					s += "<option value=\"" + item.code + "\""
					if(dftVal == item.code)	s += " selected";
					s += ">" + item.cname + "</option>";
				}
				$("#" + id).append(s);
			} else{
				for(var i=0, item; item=data.data[i]; i++){
					s += "<div class=\"form-check form-check-inline\">";
					s += "<input id=\"" + id + "-" + item.code + "\" class=\"form-check-input\" type=\"" + type + "\" name=\"" + id + "\" value=\"" + item.code + "\" data-name=\"" + item.cname + "\" ";
					if(dftVal == item.code)	s += " checked";
					if(dftVal == "" && i == 0) s+= " checked";
					s += ">";
					s += "<label for=\"" + id + "-"  + item.code + "\" class=\"form-check-label\">"+ item.cname + "</label>";
					s += "</div>"
				}
				$("#" + id + "Div").html(s);
			}
		},
		error: function(data) {
		}
	});
}

function setDeptList(url, id, param, val, txt, dftVal, dftTxt){
	$.ajax({
		url: url,
		type: "POST",
		dataType: "json",
		data: param,
		async: false,
		success: function(data){
			$("#" + id).empty();
			var s = "";
			if (dftTxt != "") s += "<option value=\"\" >" + dftTxt + "</option>";
			for(var i=0, item; item=data.data[i]; i++){
				s += "<option value=\"" + item[val] + "\""
				if(dftVal == item[val])	s += " selected";
				s += ">" + item[txt] + "</option>";
			}
			$("#" + id).append(s);
		},
		error: function(data) {
		}
	});
}

$("#bizNumCheck").click(function(){
	var bizNum = $("#bizNum").val().replace(/\-/g, '');
	if(bizNum.length < 10) {
		alert("사업자번호는 하이픈(-)을 제외한 10자리 숫자로 입력해주세요.");
		return;
	}
	$.ajax({
		url: "/checkBizNum.do",
		type: "POST",
		dataType: "json",
		data: {
			bizNum: bizNum
		},
		success: function(data){
			if(data.result) {
				if(!confirm('계속 진행하시려면 "확인" 버튼을 클릭해주세요.')){
					chkBiz = false;
					return false;
				}else{
					chkBiz = true;
					$("#bizNumCheck").removeClass('btn-danger');
					$("#bizNumCheck").addClass('btn-success');
					$("#bizNumCheckIcon").removeClass('bi-clipboard-x');
					$("#bizNumCheckIcon").addClass('bi-clipboard-check');
					Util.setPageData(data.data);
					if(data.data.custId != null){
						setDeptSelectBox();
					}else{
						setDeptTextBox();
					}
				}
			}else{
				chkBiz = true;
				$("#bizNumCheck").removeClass('btn-danger');
				$("#bizNumCheck").addClass('btn-success');
				$("#bizNumCheckIcon").removeClass('bi-clipboard-x');
				$("#bizNumCheckIcon").addClass('bi-clipboard-check');
				alert(data.msg + '\n신규 거래처를 등록해주세요.');
				setDeptTextBox();
			}
		}
	});		
});

function setDeptSelectBox(){
	var str = "";
	str += 	"<strong class=\"required\">부서명</strong>" +
			"<select id=\"deptName\" name=\"deptName\" class=\"custom-select col-12\" required></select>" +
    		"<div class=\"help-block with-errors\"></div>";
	
	$("#divDeptSelect").html(str);
	$("#f").validator('update');
	
	setDeptList("/deptList.do", "deptName", {custId:$("#custId").val(), useYn:'Y'}, "deptId", "deptName", "", "--부서명--");
	
	$("#deptName").append('<option value="new">신규입력</option>');
}

function setDeptTextBox(){
	var str = "";
	str += 	"<strong class=\"required\">부서명</strong>" +
			"<input type=\"text\" id=\"deptName\" name=\"deptName\" class=\"form-control form-control-sm\" required>" +
    		"<div class=\"help-block with-errors\"></div>";
	
	$("#divDeptSelect").html(str);
	$("#f").validator('update');
}

$("#divDeptSelect").change(function() {
	value = $("#divDeptSelect option:selected").val();
	if(value == "new"){
		setDeptTextBox();
	}else{
		$("#deptId").val(value);
	}
});

$("#userIdCheck").click(function(e) {
	e.preventDefault();
	var userId = $("#userId").val();
	if(!userId) {
		alert("아이디를 입력해주세요");
		return;
	}

	$.ajax({
		url: "/checkUserId.do",
		type: "POST",
		dataType: "json",
		data: {
			userId: userId
		},
		success: function(data){
			if(data.result) {
				chkUid = true;
				$("#userIdCheck").removeClass('btn-danger');
				$("#userIdCheck").addClass('btn-success');
				$("#userIdCheckIcon").removeClass('bi-person-x');
				$("#userIdCheckIcon").addClass('bi-person-check');
				alert(data.msg);
			} else {
				chkUid = false;
				$("#userIdCheck").removeClass('btn-success');
				$("#userIdCheck").addClass('btn-danger');
				$("#userIdCheckIcon").removeClass('bi-person-check');
				$("#userIdCheckIcon").addClass('bi-person-x');
				alert(data.msg);
			}
		}
	});
});

$('#f').validator().on('submit', function (e) {
    if(!chkBiz) {
		e.preventDefault();
		alert("사업자번호 확인을 해주세요.");
		return;
    }
	if(!chkUid) {
		e.preventDefault();
		alert("이미 존재하는 아이디이거나 중복 확인을 하지 않은 아이디입니다.");
		return;
	}
	if (e.isDefaultPrevented()) {
	    alert("항목을 입력해 주세요.");
    } else {
  		$("#bizNum").val($("#bizNum").val().replace(/\-/g, ""));
	  	$("#mobile").val($("#mobile").val().replace(/\-/g, ""));
  		e.preventDefault();
  		$.ajax({
			url: "/signUp.do",
			type: "POST",
			dataType: "json",
			data: $("#f").serialize(),
			success: function(data){
				if(data.result) {
					alert(data.msg);
					location.href = "/";
				}
			}
		});
    }
})

$('#bizNum').on('input', function(e) {
	e.preventDefault();
	var bizNum = $(this).val().replace(/[^\d]/g, '');
	var temp = bizNum.replace(/(\d{3})(\d{1,2})(\d{1,5})/, '$1-$2-$3');
	$(this).val(temp);
	chkBiz = false;
	$("#bizNumCheck").removeClass('btn-success');
	$("#bizNumCheck").addClass('btn-danger');
	$("#bizNumCheckIcon").removeClass('bi-clipboard-check');
	$("#bizNumCheckIcon").addClass('bi-clipboard-x');
});


$('#userId').on('input', function() {
	$("#userIdCheck").removeClass('btn-success');
	$("#userIdCheck").addClass('btn-danger');
	$("#userIdCheckIcon").removeClass('bi-person-check');
	$("#userIdCheckIcon").addClass('bi-person-x');
});


$("#mobile").on("input", function(){
	$(this).val(Util.formatPhone($(this).val()));
});

function termsOfUseCancle(){
	location.href = "/";
}

function termsOfUseSuccess(){
	if($("#serviceYn").val() == "Y" && $("#privacyYn").val() == "Y"){
		$(".termsOfUse").hide();
		$(".signUp").show();
	}else{
		alert("이용약관과 개인정보 처리방침에 대한 안내 모두 동의해주세요");
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