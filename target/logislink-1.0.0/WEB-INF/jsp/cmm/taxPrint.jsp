<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="/js/jquery.min.js"></script>
<script type="text/javascript" src="/js/html2canvas.js"></script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/1.0.272/jspdf.debug.js"></script>
<title>전자세금계산서</title>
</head>
<body>
	<div id="VIEW" style="width:700px;"></div>
</body>

<script type="text/javascript">

var parser = new DOMParser();
//var xmlSerializer = new XMLSerializer();
//var signedXML =  
//		"<?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"yes\"?><TaxInvoice xmlns=\"urn:kr:or:kec:standard:Tax:ReusableAggregateBusinessInformationEntitySchemaModule:1:0\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xsi:schemaLocation=\"urn:kr:or:kec:standard:Tax:ReusableAggregateBusinessInformationEntitySchemaModule:1:0 http://www.kec.or.kr/standard/Tax/TaxInvoiceSchemaModule_1.0.xsd\">    <ExchangedDocument>        <IssueDateTime>20210827150921</IssueDateTime>    </ExchangedDocument><ds:Signature xmlns:ds=\"http://www.w3.org/2000/09/xmldsig#\">    <ds:SignedInfo>      <ds:CanonicalizationMethod Algorithm=\"http://www.w3.org/TR/2001/REC-xml-c14n-20010315\"/>      <ds:SignatureMethod Algorithm=\"http://www.w3.org/2001/04/xmldsig-more#rsa-sha256\"/>      <ds:Reference URI=\"\">        <ds:Transforms>          <ds:Transform Algorithm=\"http://www.w3.org/TR/2001/REC-xml-c14n-20010315\"/>  <ds:Transform Algorithm=\"http://www.w3.org/TR/1999/REC-xpath-19991116\">    <ds:XPath>not(self::*[name()='TaxInvoice'] | ancestor-or-self::*[name()='ExchangedDocument'] | ancestor-or-self::ds:Signature)</ds:XPath>          </ds:Transform>        </ds:Transforms>        <ds:DigestMethod Algorithm=\"http://www.w3.org/2001/04/xmlenc#sha256\"/>        <ds:DigestValue>CJiKMDJpHe6dwdEe8MhE3lZey9zKRPqbxMOTVlj2nFc=</ds:DigestValue>      </ds:Reference>    </ds:SignedInfo>    <ds:SignatureValue>Im7DOuRemzmwI+qS20foIpO4zteRBn0pD0Fq3WnVUkz4Vta2WKcC2Oe7P9cJ/bhRAwDTfqDxC4MZG2t0sjQQLr6auSfsW019sTuwBcyorfs/7R9sQZ10NjNLMgXvhh7poVdeq67Bp6XbtqfmcwArJXvifqQu06Ek/6lTuj6+HmexohjB437LNaftBxc0NRIarYvswp7K9YW1nsQijJ6kYbCkRVikqbVQTDPjJ3xIW9odps96Gk9UhcEZZwFTsKMlPsyix8F24nHzSqtKF48HN2mfs77sMYkJWm2EjW7FvVB+77uO15fdQpNZLHNISETNCTMUpgWhYqOneEFqbB2GTA==</ds:SignatureValue>    <ds:KeyInfo><ds:X509Data><ds:X509Certificate>MIIFsjCCBJqgAwIBAgIEBdn+PDANBgkqhkiG9w0BAQsFADBKMQswCQYDVQQGEwJLUjENMAsGA1UECgwES0lDQTEVMBMGA1UECwwMQWNjcmVkaXRlZENBMRUwEwYDVQQDDAxzaWduR0FURSBDQTUwHhcNMjEwNjE0MDQzMTEyWhcNMjIwNzA4MTQ1OTU5WjCBkjELMAkGA1UEBhMCS1IxDTALBgNVBAoMBEtJQ0ExEzARBgNVBAsMCmxpY2Vuc2VkQ0ExFTATBgNVBAsMDOuTseuhneq4sOq0gDEZMBcGA1UECwwQS0lDQeqzoOqwneyEvO2EsDERMA8GA1UECwwI7IS87YSwUkExGjAYBgNVBAMMEe2VnOygleyduCjrspXsnbgpMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAgUYjDDHrk1RZzXAM7n76W2LetT3+KiuzEouUory6jIru4kMB6Le3KfDxD48ht4jczfDOZk7VZOsXfDzTOEjKQ1x+Yvefg9r/iBSvEVTwF145AueOn4CeIxxs5QOz1wf7yhqC7VZP/tUfOE6TiCil36QVALbwK9dbIV2NNC9lR1KR1VHf9khpaoVhQfjOxSuH6GrVgORzwFcdxzrXAmgTaSQ5Meo/fEWU7j2idpuMnQZ9WLxYk8iHHxjWkqaG2dWwtp0R9IiwIb9XGgL0aFQOhRJGozBDHU3nE+XqdgtLl/hJAPH+0eP96b/2Y3I1G4ADpzSKB/JyFK8O9UJFj75TNQIDAQABo4ICVTCCAlEwgY8GA1UdIwSBhzCBhIAU2L467EWZxZ7jnOqBH9IdErA2PoihaKRmMGQxCzAJBgNVBAYTAktSMQ0wCwYDVQQKDARLSVNBMS4wLAYDVQQLDCVLb3JlYSBDZXJ0aWZpY2F0aW9uIEF1dGhvcml0eSBDZW50cmFsMRYwFAYDVQQDDA1LSVNBIFJvb3RDQSA0ggIQHTAdBgNVHQ4EFgQU9UIpNmZcB9MQ0PygQ3p3p4yogiwwDgYDVR0PAQH/BAQDAgbAMHUGA1UdIARuMGwwagYKKoMajJpEBQIBATBcMCwGCCsGAQUFBwIBFiBodHRwOi8vd3d3LnNpZ25nYXRlLmNvbS9jcHMuaHRtbDAsBggrBgEFBQcCAjAgHh7HdAAgx3jJncEcspQAIKz1s9nHeMmdwRzHhbLIsuQwcAYDVR0RBGkwZ6BlBgkqgxqMmkQKAQGgWDBWDBHtlZzsoJXsnbgo67KV7J24KTBBMD8GCiqDGoyaRAoBAQEwMTALBglghkgBZQMEAgGgIgQg1XQfxuih1KckNodNuB/bQIX0Qusxj8O5jJogWBY/IYswXwYDVR0fBFgwVjBUoFKgUIZObGRhcDovL2xkYXAuc2lnbmdhdGUuY29tOjM4OS9vdT1kcDdwMzExNzMsb3U9Y3JsZHAsb3U9QWNjcmVkaXRlZENBLG89S0lDQSxjPUtSMEQGCCsGAQUFBwEBBDgwNjA0BggrBgEFBQcwAYYoaHR0cDovL29jc3Auc2lnbmdhdGUuY29tOjkwMjAvT0NTUFNlcnZlcjANBgkqhkiG9w0BAQsFAAOCAQEAHd8GcbK3n3CF48S8qhwPvx2EQ56ew4dVdcOjluONtPQZ2+Ecy4LwscTjsFuVAsf7RvZUzDQDgfyMmHcXhbWMcI9pURaaOh7RP7AYL+UsMsASav7i/mMJEgrs4ZEirXQbHGXcah+m6t556k4w++ip4xQt6zhE1UPzqmW2xIO0P/CuivyhCXUPRZ5bixmovlRzJ09AY1HWdaqUW7HW6hNOgmidv9hoEA84bSGvDmTnZOIEOxWJzNuGawpt4gVA/fyvSAnKqvwAkit1tbQeXn8UUCnLS0IEX/8wd9xev1DKalPWxTuYXnGBREnUAINjMYpFPl+vvQKGI4+Ox0+I5GXjxA==</ds:X509Certificate></ds:X509Data>    </ds:KeyInfo></ds:Signature>    <TaxInvoiceDocument>        <IssueID>2021082741000008uwh00005</IssueID>        <TypeCode>0103</TypeCode>        <IssueDateTime>20210827</IssueDateTime>        <PurposeCode>02</PurposeCode>    </TaxInvoiceDocument>    <TaxInvoiceTradeSettlement>        <InvoicerParty>            <ID>1231212346</ID>            <TypeCode/>            <NameText>코리아로지스</NameText>            <ClassificationCode/>            <SpecifiedPerson>                <NameText>테스트</NameText>            </SpecifiedPerson>            <DefinedContact>                <DepartmentNameText/>                <PersonNameText>코리아로지스</PersonNameText>                <TelephoneCommunication>01073999372</TelephoneCommunication>                <URICommunication>test@test.com</URICommunication>            </DefinedContact>            <SpecifiedAddress>                <LineOneText>서울특별시 금천구 가산디지털1로 145(가산동) </LineOneText>            </SpecifiedAddress>        </InvoicerParty>        <InvoiceeParty>            <ID>1234455555</ID>            <TypeCode/>            <NameText>로지스운송</NameText>            <ClassificationCode/>            <SpecifiedOrganization>                <BusinessTypeCode>01</BusinessTypeCode>            </SpecifiedOrganization>            <SpecifiedPerson>                <NameText>대표자</NameText>            </SpecifiedPerson>            <PrimaryDefinedContact>                <DepartmentNameText/>                <PersonNameText>로지스</PersonNameText>                <TelephoneCommunication>01021114444</TelephoneCommunication>                <URICommunication>logis@test.com</URICommunication>            </PrimaryDefinedContact>            <SpecifiedAddress>                <LineOneText>서울특별시 금천구 가산디지털1로 145(가산동) </LineOneText>            </SpecifiedAddress>        </InvoiceeParty>        <BrokerParty>            <ID>1028141359</ID>            <TypeCode>운수,보관</TypeCode>            <NameText>한솔로지스틱스</NameText>            <ClassificationCode>복합운송주선업</ClassificationCode>            <SpecifiedPerson>                <NameText>황규호</NameText>            </SpecifiedPerson>            <DefinedContact>                <DepartmentNameText>시스템관리부서</DepartmentNameText>                <PersonNameText>관리자</PersonNameText>                <TelephoneCommunication>0200000000</TelephoneCommunication>                <URICommunication>test@test.com</URICommunication>            </DefinedContact>            <SpecifiedAddress>                <LineOneText>서울 금천구 가산디지털1로 145</LineOneText>            </SpecifiedAddress>        </BrokerParty>        <SpecifiedMonetarySummation>            <ChargeTotalAmount>0</ChargeTotalAmount>            <TaxTotalAmount>0</TaxTotalAmount>            <GrandTotalAmount>0</GrandTotalAmount>        </SpecifiedMonetarySummation>    </TaxInvoiceTradeSettlement>    <TaxInvoiceTradeLineItem>        <SequenceNumeric>1</SequenceNumeric>        <DescriptionText/>        <InvoiceAmount>0</InvoiceAmount>        <ChargeableUnitQuantity>1.0</ChargeableUnitQuantity>        <InformationText/>        <NameText>운송료</NameText>        <PurchaseExpiryDateTime>20210827</PurchaseExpiryDateTime>        <TotalTax>            <CalculatedAmount>0</CalculatedAmount>        </TotalTax>        <UnitPrice>            <UnitAmount>0</UnitAmount>        </UnitPrice>    </TaxInvoiceTradeLineItem></TaxInvoice>";
var signedXML = ""; 
//		"<?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"yes\"?><TaxInvoice xsi:schemaLocation=\"urn:kr:or:kec:standard:Tax:ReusableAggregateBusinessInformationEntitySchemaModule:1:0 http://www.kec.or.kr/standard/Tax/TaxInvoiceSchemaModule_1.0.xsd\" xmlns=\"urn:kr:or:kec:standard:Tax:ReusableAggregateBusinessInformationEntitySchemaModule:1:0\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\">    <ExchangedDocument>        <IssueDateTime>20210906171839</IssueDateTime>    </ExchangedDocument>    <TaxInvoiceDocument>        <IssueID>2021090641000008uwh00040</IssueID>        <TypeCode>0101</TypeCode>        <IssueDateTime>20210906</IssueDateTime>        <PurposeCode>01</PurposeCode>    </TaxInvoiceDocument>    <TaxInvoiceTradeSettlement>        <InvoicerParty>            <ID>1028141359</ID>            <TypeCode>운수,보관</TypeCode>            <NameText>한솔로지스틱스</NameText>            <ClassificationCode>복합운송주선업</ClassificationCode>            <SpecifiedPerson>                <NameText>황규호</NameText>            </SpecifiedPerson>            <DefinedContact>                <DepartmentNameText></DepartmentNameText>                <PersonNameText>관리자</PersonNameText>                <TelephoneCommunication>01011112222</TelephoneCommunication>                <URICommunication>kkhye72@gmail.com</URICommunication>            </DefinedContact>            <SpecifiedAddress>                <LineOneText>서울 금천구 가산디지털1로 145</LineOneText>            </SpecifiedAddress>        </InvoicerParty>        <InvoiceeParty>            <ID>0123456789</ID>            <TypeCode>업태</TypeCode>            <NameText>거래처명4</NameText>            <ClassificationCode>업종</ClassificationCode>            <SpecifiedOrganization>                <TaxRegistrationID>0004</TaxRegistrationID>                <BusinessTypeCode>01</BusinessTypeCode>            </SpecifiedOrganization>            <SpecifiedPerson>                <NameText>대표자명4</NameText>            </SpecifiedPerson>            <PrimaryDefinedContact>                <DepartmentNameText></DepartmentNameText>                <PersonNameText>담당자명4</PersonNameText>                <TelephoneCommunication>01077778888</TelephoneCommunication>                <URICommunication>hyeuu@korealogis.co.kr</URICommunication>            </PrimaryDefinedContact>            <SpecifiedAddress>                <LineOneText>인천광역시 미추홀구 주안로 11(도화동)</LineOneText>            </SpecifiedAddress>        </InvoiceeParty>        <SpecifiedMonetarySummation>            <ChargeTotalAmount>120000</ChargeTotalAmount>            <TaxTotalAmount>12000</TaxTotalAmount>            <GrandTotalAmount>132000</GrandTotalAmount>        </SpecifiedMonetarySummation>    </TaxInvoiceTradeSettlement>    <TaxInvoiceTradeLineItem>        <SequenceNumeric>1</SequenceNumeric>        <DescriptionText></DescriptionText>        <InvoiceAmount>110000</InvoiceAmount>        <ChargeableUnitQuantity>1.0</ChargeableUnitQuantity>        <InformationText></InformationText>        <NameText>운송비</NameText>        <PurchaseExpiryDateTime>20210906</PurchaseExpiryDateTime>        <TotalTax>            <CalculatedAmount>11000</CalculatedAmount>        </TotalTax>        <UnitPrice>            <UnitAmount>110000</UnitAmount>        </UnitPrice>    </TaxInvoiceTradeLineItem>    <TaxInvoiceTradeLineItem>        <SequenceNumeric>2</SequenceNumeric>        <DescriptionText></DescriptionText>        <InvoiceAmount>10000</InvoiceAmount>        <ChargeableUnitQuantity>1.0</ChargeableUnitQuantity>        <InformationText></InformationText>        <NameText>경유비</NameText>        <PurchaseExpiryDateTime>20210906</PurchaseExpiryDateTime>        <TotalTax>            <CalculatedAmount>1000</CalculatedAmount>        </TotalTax>        <UnitPrice>            <UnitAmount>10000</UnitAmount>        </UnitPrice>    </TaxInvoiceTradeLineItem></TaxInvoice>";
var xslForm = "";

var xsltProcessor = new XSLTProcessor();


$(document).ready(function() {

	 //init();
	  
});

function printPdf() {
	 html2canvas($('#VIEW')[0]).then(function(canvas) { //저장 영역 div id
			
		    // 캔버스를 이미지로 변환
		    var imgData = canvas.toDataURL('image/png');
			     
		    var imgWidth = 190; // 이미지 가로 길이(mm) / A4 기준 210mm
		    var pageHeight = imgWidth * 1.414;  // 출력 페이지 세로 길이 계산 A4 기준
		    var imgHeight = canvas.height * imgWidth / canvas.width;
		    var heightLeft = imgHeight;
		    var margin = 10; // 출력 페이지 여백설정
		    var doc = new jsPDF('p', 'mm');
		    var position = 15;
		       
		    // 첫 페이지 출력
		    doc.addImage(imgData, 'PNG', margin, position, imgWidth, imgHeight);
		    heightLeft -= pageHeight;
		         
		    // 한 페이지 이상일 경우 루프 돌면서 출력
		    while (heightLeft >= 20) {
		        position = heightLeft - imgHeight;
		        doc.addPage();
		        doc.addImage(imgData, 'PNG', 0, position, imgWidth, imgHeight);
		        heightLeft -= pageHeight;
		    }
		 
		    // 파일 저장
		    doc.save('세금계산서.pdf');
		    
		    $("#iframe", parent.document).hide();
	 });		    
}

function init(){

	var myXMLHTTPRequest = new XMLHttpRequest();
	myXMLHTTPRequest.open("GET", xslForm, false);
	myXMLHTTPRequest.send(null);
	
	
	
	xslStylesheet = myXMLHTTPRequest.responseXML;
	xsltProcessor.importStylesheet(xslStylesheet);
	
	var xmlDoc = parser.parseFromString(signedXML, "application/xml");
	var fragment = xsltProcessor.transformToFragment(xmlDoc, document);
	
	document.getElementById("VIEW").textContent = "";
	
	myDOM = fragment;
	document.getElementById("VIEW").append(fragment);
}
</script>
</html>