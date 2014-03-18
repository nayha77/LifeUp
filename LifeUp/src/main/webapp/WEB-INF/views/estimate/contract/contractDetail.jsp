<%@ page language="java" contentType="text/html; charset=UTF-8"%>

<%@ taglib prefix="mvc" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<mvc:main>
<script type="text/javascript">
	$(document).ready(function() {
		// 선택 메뉴 마킹
		_Commn.fnMarkingLeftMenu($("#menuRequest"));		
	});
	
	function fnSave() {
		if($('#tbxSalesBenefit').val().trim() == "") {
			alert('견적을 입력하세요');
			return;
		}

		_Async.post (
   			"/contract/registContract",
   			JSON.stringify( { request_id: $('#hdnRequestId').val(), salesman_benefit: $('#tbxSalesBenefit').val() } ),
   			function (data) {    
				if(data.message == 'success') {
					_Commn.fnPageMove("/contract/detail", $('#frm'));
				} else {
					alert(data.detail);
				}
   			} 
   		);
	}
	
	function fnConfirm() {
		_Async.post (
   			"/request/updateContractStatus",
   			JSON.stringify( { request_id: $('#hdnRequestId').val(), salesman_id : $('#hdnSalesman_id').val(), status : '0002' } ),
   			function (data) {    
				if(data.message == 'success') {
					$('#btnConfirm').hide();						
				} else {
					alert(data.message);
				}
   			} 
   		);	
	}
	
	function fnCancel() {
		_Async.post (
   			"/contract/contractCancel",
   			JSON.stringify( { request_id: $('#hdnRequestId').val(), status : '0003' } ),
   			function (data) {    
				if(data.message == 'success') {
					$('#btnCancel').hide();
				} else {
					alert(data.message);
				}
   			} 
   		);	
	}
	
	function fnReply() {
		if($('#tbxShortMsg').val().trim() == "") {
			alert('댓글 메세지를 입력하세요');
			return;
		}		
		
		_Async.post (
   			"/contract/registReply",
   			JSON.stringify( { request_id: $('#hdnRequestId').val(), salesman_id: $('#hdnSalesman_id').val(), message: $('#tbxShortMsg').val() } ),
   			function (data) {    
				if(data.message == 'success') {				
					$('#replyContainer').append("<li data-icon='false'><a href='#' style='cursor: default;'>${sessionScope._USER_INFO_.userNm} " + $('#tbxShortMsg').val().trim() + "<span class='ui-li-count'>오늘</span></a></li>");
					$('#replyContainer').listview("refresh");
					
					$('#replyContainer').show();
					$('#tbxShortMsg').val("");
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
	
	<c:forEach items="${contractDetail}" var="detail" varStatus="loop">
	   	<input type='hidden' id='hdnRequestId' name='request_id' value='${requestDetail.REQUEST_ID}' />    	   		   						   		   			
		<input type='hidden' id='hdnSalesman_id' name='salesman_id' value='${detail.SALESMAN_ID}' />	
		<c:choose>
			<c:when test="${detail.SALESMAN_ID == sessionScope._USER_INFO_.userId}">
				<ul data-role="listview" data-inset="true">
				    <li data-role="list-divider">견적내용</li>
				    <li>
					    <textarea data-mini="true" cols="40" rows="8" id='tbxSalesBenefit' name='salesman_benefit'>${detail.SALESMAN_BENEFIT}</textarea>
				    </li>				
				</ul>
			</c:when>		
			<c:when test="${requestDetail.CUSTOMER_ID == sessionScope._USER_INFO_.userId}">
				<ul data-role="listview" data-inset="true">
				    <li data-role="list-divider">영업사원<span class="ui-li-count">${detail.MOBILE}</span></li>
				    <li>
					    <h1>${detail.VENDOR_NM} > ${detail.LOCATION} > ${detail.SALESMAN_NM}</h1>
				    </li>
				    <li data-role="list-divider">견적내용<span class="ui-li-count">${detail.CREATE_DATE}</span> </li>
				    <li>
					    <h1>${detail.SALESMAN_BENEFIT}</h1>
				    </li>
				</ul>	
			</c:when>
		</c:choose>	

		<c:choose>
			<c:when test="${requestDetail.CUSTOMER_ID == sessionScope._USER_INFO_.userId}">
				<div style="margin-top: -11px; margin-right: -10px; text-align: right;">
					<c:if test="${requestDetail.STATUS == '0001'}">
						<a href="#" data-role="button" id="btnConfirm" data-icon="check" data-inline="true" onclick="fnConfirm();">거래확정</a>					
					</c:if>
					<a href="#" data-role="button" data-icon="back" data-inline="true" onclick="fnMoveBack();">이전</a>
				</div>
			</c:when>	
			<c:otherwise>
				<div style="margin-top: -11px; margin-right: -10px; text-align: right;">
					<c:if test="${detail.STATUS == '0001'}">
						<a href="#" data-role="button" data-icon="edit" data-inline="true" onclick="fnSave();">수정</a>
						<a href="#" id="btnCancel" data-role="button" data-icon="delete" data-inline="true" onclick="fnCancel();">등록취소</a>
					</c:if>
					<a href="#" data-role="button" data-icon="back" data-inline="true" onclick="fnMoveBack();">이전</a>
				</div>
			</c:otherwise>
		</c:choose>	    	       
	
		<ul id="replyContainer" data-role="listview" data-inset="true" style="display: none;">
			<c:forEach items="${contractReply}" var="reply" varStatus="loop">
			    <li data-icon="false"><a href="#" style='cursor: default;'>${reply.CREATE_USER_NM} ${reply.MESSAGE} <span class="ui-li-count">${reply.CREATE_DATE}</span></a></li>
		    </c:forEach>
		</ul>			
		<div style="padding-top: 8px;"></div>	
		<c:if test="${requestDetail.STATUS != '0003'}">
			<div class="ui-block-a" style="width:70%; margin-top: -11px;">
			    <input type="text" data-clear-btn="true" id='tbxShortMsg' name='message' style="margin-top: 8px;">
			</div>
			<div class="ui-block-b" style="width:30%; margin-top: -11px;">
				<a href="#" data-role="button" id="btnReply" onclick="fnReply();">댓글</a>
			</div>
		</c:if>	
	</c:forEach>		
</form>		
</div>	

<c:if test="${not empty contractReply}">
<script type="text/javascript">
	$('#replyContainer').show();
</script>	
</c:if>
</mvc:main>