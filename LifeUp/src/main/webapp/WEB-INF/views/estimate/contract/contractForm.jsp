<%@ page language="java" contentType="text/html; charset=UTF-8"%>

<%@ taglib prefix="mvc" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<mvc:main>
<script type="text/javascript">
	$(document).ready(function() {
		// 선택 메뉴 마킹
		_Commn.fnMarkingLeftMenu($("#menuRequest"));
		
		$('#tbxSalesBenefit').focus();
	});	
	
	function fnSave() {
		
		$('.error').hide();
		
		if($('#tbxSalesBenefit').val().trim() == "") {
			$('#tbxSalesBenefit').after('<div class="error" style="padding-top: 13px;">견적을 입력하세요</div>');
			return;
		}

		_Async.post (
   			"/contract/registContract.do",
   			JSON.stringify( { request_id: $('#hdnRequestId').val(), salesman_benefit: $('#tbxSalesBenefit').val() } ),
   			function (data) {    
				if(data.message == 'success') {				
					_Commn.fnPageMove("/contract/writeform", $('#frm'));
				} else {
					alert(data.detail);
				}
   			} 
   		);
	}
	
	function fnMoveBack() {
		_Commn.fnPageMove("/request/detail", $('#frm'));		
	}
</script>	
<div class="ui-content jqm-content jqm-fullwidth" style="padding-top: 0px;">
<form id='frm' name='frm' method="post">
	<input type='hidden' id='hdnRequestId' name='request_id' value='${requestDetail.REQUEST_ID}' />
	<ul data-role="listview" data-inset="true">
	    <li data-role="list-divider">지역/차종<span class="ui-li-count">${requestDetail.STATUS_NM}</span></li>
	    <li>
		    <h1>${requestDetail.SIDO_NM} ${requestDetail.GUGUN_NM} > ${requestDetail.VENDOR_NM} > ${requestDetail.CAR_NM}</h1>
	    </li>
	    <li data-role="list-divider">차량옵션</li>
	    <li>
		    <h1>${requestDetail.CAR_OPTION}</h1>
	    </li>	
	    <li data-role="list-divider">${requestDetail.CUSTOMER_NM}님 요구사항 </li>
	    <li>
		    <h1>${requestDetail.CUSTOMER_REQ}</h1>
	    </li>
	    <li data-role="list-divider">구매예정일 </li>
	    <li>
		    <h1>${requestDetail.PURCHASE_PERIOD_CD}</h1>
	    </li>	    		    		    	    		    	    
	</ul>
	<c:if test="${requestDetail.STATUS != '0003'}">

			<div class="ui-field-contain">
				<label for="salesman_benefit">견적제안</label>
				<textarea data-mini="false" cols="40" rows="8" id='tbxSalesBenefit' name='salesman_benefit'><c:forEach items="${contractDetail}" var="detail" varStatus="status">${detail.SALESMAN_BENEFIT}</c:forEach></textarea>				
			</div>
			<div style="margin-right: -10px; text-align: right;">
				<a href="#" data-role="button" data-icon="plus" data-inline="true"  id="btnReply" onclick="fnSave();">등록</a>
				<a href="#" data-role="button" data-icon="back" data-inline="true"  id="btnReply" onclick="fnMoveBack();">이전</a>
			</div>

	</c:if>		
</form>
</div>		
</mvc:main>