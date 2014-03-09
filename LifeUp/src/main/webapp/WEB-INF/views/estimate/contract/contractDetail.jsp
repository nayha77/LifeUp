<%@ page language="java" contentType="text/html; charset=UTF-8"%>

<%@ taglib prefix="mvc" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<mvc:main>
<script type="text/javascript">
	$(document).ready(function() {
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
					document.location.href='/request/detail?request_id=' + $('#hdnRequestId').val();
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
					$('#replyContainer').append("<li data-icon='delete'><a href='#'>${sessionScope._USER_INFO_.userNm} " + $('#tbxShortMsg').val().trim() + "<span class='ui-li-count'>오늘</span></a></li>");
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
		document.frm.action = "/request/detail";
		document.frm.submit();
	}
</script>

<div class="ui-content jqm-content jqm-fullwidth" style="padding-top: 0px;">
<form id='frm' name='frm' method="post">
	<ul data-role="listview" data-inset="true">
	    <li data-role="list-divider">지역/차종<span class="ui-li-count">${requestDetail.STATUS_NM}</span></li>
	    <li>
		    <h1>${requestDetail.SIDO} ${requestDetail.GUGUN} > ${requestDetail.VENDOR_NM} > ${requestDetail.CAR_NM}</h1>
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
	</c:forEach>	

	<c:choose>
		<c:when test="${requestDetail.CUSTOMER_ID == sessionScope._USER_INFO_.userId}">
			<div style="margin-bottom: -15px; margin-right: -10px; text-align: right;">
				<c:if test="${requestDetail.STATUS == '0001'}">
					<a href="#" data-role="button" id="btnConfirm" data-icon="write" data-inline="true" onclick="fnConfirm();">거래확정</a>					
				</c:if>
				<a href="#" data-role="button" data-icon="prev" data-inline="true" onclick="fnMoveBack();">이전</a>
			</div>
		</c:when>	
		<c:otherwise>
			<div style="margin-bottom: -15px; margin-right: -10px; text-align: right;">
				<c:if test="${detail.STATUS == '0001'}">
					<a href="#" data-role="button" data-icon="list" data-inline="true" onclick="fnSave();">수정</a>
					<a href="#" id="btnCancel" data-role="button" data-icon="list" data-inline="true" onclick="fnCancel();">등록취소</a>
				</c:if>
				<a href="#" data-role="button" data-icon="prev" data-inline="true" onclick="fnMoveBack();">이전</a>
			</div>
		</c:otherwise>
	</c:choose>	    	       

	<ul id="replyContainer" data-role="listview" data-inset="true" style="display: none;">
		<c:forEach items="${contractReply}" var="reply" varStatus="loop">
		    <li data-icon="delete"><a href="#">${reply.CREATE_USER_NM} ${reply.MESSAGE} <span class="ui-li-count">${reply.CREATE_DATE}</span></a></li>
	    </c:forEach>
	</ul>			
		
	<c:if test="${requestDetail.STATUS != '0003'}">
		<div class="ui-block-a" style="width:70%;">
		    <input type="text" data-clear-btn="true" id='tbxShortMsg' name='message' style="margin-top: 8px;">
		</div>
		<div class="ui-block-b" style="width:30%">
			<a href="#" data-role="button" id="btnReply" onclick="fnReply();">댓글</a>
		</div>
	</c:if>	
</form>		
</div>	

<%--    		      
	<div id="replyContainer" class="messages" style="display: none;">
		<div style="height:50px;"></div>	
		<div id="divReply" onclick="" class="breadcrumb" style="padding-right: 15px;">
			<c:forEach items="${contractReply}" var="reply" varStatus="loop">
			    <div class="message-title" style='height: 13px;'>
			    	<span class="replyMsg">
			    		<span>${reply.CREATE_USER_NM}</span>
				    	<span style="padding-left:9px;">${reply.MESSAGE}</span>
				    	<span style='float: right;'>${reply.CREATE_DATE}</span>
			    	</span>		    				    
			    </div>
			    <c:if test="${!loop.last}">
			    	<hr class="message-inner-separator" style='margin-bottom: 5px; margin-top: 9px;'>
			    </c:if>
		    </c:forEach>
		</div>
	</div>		        	
 --%>
<c:if test="${not empty contractReply}">
<script type="text/javascript">
	$('#replyContainer').show();
</script>	
</c:if>
</mvc:main>