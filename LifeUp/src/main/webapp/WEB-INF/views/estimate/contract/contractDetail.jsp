<%@ page language="java" contentType="text/html; charset=UTF-8"%>

<%@ taglib prefix="mvc" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<mvc:main>
<script type="text/javascript">
	function fnLoad() {		
	}
	
	function fnSave() {
		if($('#tbxSalesBenefit').val().trim() == "") {
			alert('견적을 입력하세요');
			return;
		}

		_Async.post (
   			"/contract/registContract.do",
   			JSON.stringify( { request_id: $('#hdnRequestId').val(), salesman_benefit: $('#tbxSalesBenefit').val() } ),
   			function (data) {    
				if(data.message == 'success') {
					document.location.href='/request/detail?ID=' + $('#hdnRequestId').val();
				} else {
					alert(data.detail);
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
   			"/contract/registReply.do",
   			JSON.stringify( { request_id: $('#hdnRequestId').val(), salesman_id: $('#hdnSalesman_id').val(), message: $('#tbxShortMsg').val() } ),
   			function (data) {    
				if(data.message == 'success') {
					if($('.replyMsg').length > 0)
						$('#divReply').append("<hr class='message-inner-separator' style='margin-top: 8px; margin-bottom: 8px;'>");					
					
					$('#divReply').append("<div class='replyMsg'>");
					$('#divReply').append("<span style='padding-right: 10px;'>${sessionScope._USER_INFO_.userNm}</span>");
					$('#divReply').append("<span>" + $('#tbxShortMsg').val().trim() + "</span>");
					$('#divReply').append("</div>");
					
					$('#replyContainer').show();
					$('#tbxShortMsg').val("");
				} else {
					alert(data.detail);
				}
   			} 
   		);		
	}
</script>		
<div class="messages" style="margin-bottom: -10px;">
	<div id="contents" class="breadcrumb" style="margin-bottom: 7px; padding-right: 15px;">
		<div class="message-title" style='height: 8px; position:relative; padding-top: 10px;'>
			<div style="float: left;">
	    		<span class="label label-info">${requestDetail.STATUS_NM} > ${requestDetail.SIDO} ${requestDetail.GUGUN} > ${requestDetail.CAR_NM}</span>
	    	</div>
	    	<div style="float: right;">
	    		<span class="label">${requestDetail.CUSTOMER_NM}</span>
	    	</div>    				    				
		</div>
		<div class="info-inner" style='padding-top: 18px;'>
	       	<div class="label label-info">옵션</div>
	       	<div class="request-detail" style="height: 25px; padding-bottom: 0px;">${requestDetail.CAR_OPTION}</div>       	
	       	<div class="label label-info">요구사항</div>
	       	<div class="request-detail" style='height: 50px; overflow-y:auto;overflow-x:hidden;'>
	       		${requestDetail.CUSTOMER_REQ}
	       	</div>		
		</div>		
	</div>		
	<hr class="message-inner-separator" style="margin-top: 2px; margin-bottom: 7px;">
    <div class="info-inner" style='position:relative;'>
    	<input type='hidden' id='hdnRequestId' name='request_id' value='${requestDetail.REQUEST_ID}' />    	
    	<div style="position:relative;">    		   						   		   
			<c:forEach items="${contractDetail}" var="detail" varStatus="loop">
				<input type='hidden' id='hdnSalesman_id' name='salesman_id' value='${detail.SALESMAN_ID}' />
				<c:choose>
				<c:when test="${detail.SALESMAN_ID == sessionScope._USER_INFO_.userId}">
					<div>				    	    	
						<textarea id='tbxSalesBenefit' name='salesman_benefit' rows="4" class="input-xlarge">${detail.SALESMAN_BENEFIT}</textarea>				
					</div>
				    <div style='float: right;'>		    	
				    	<input type='submit' class="btn btn-primary" value='수정' onclick="fnSave();" />
				    	<input type='submit' class="btn btn-primary" value='이전으로' onclick="history.back(-1);" />
				    </div>
				</c:when>
				<c:otherwise>
					<div class="breadcrumb" style="margin-bottom: 8px;">
						<div>[${detail.CREATE_DATE}] ${detail.VENDOR_NM} > ${detail.LOCATION} > ${detail.SALESMAN_NM} - ${detail.MOBILE}</div>
						<hr class="message-inner-separator" style='margin-top: 8px; margin-bottom: 8px;'>
						<div>${detail.SALESMAN_BENEFIT}</div>
					</div>
				    <div style='float: right;'>		    	
				    	<input type='submit' class="btn btn-primary" value='이전으로' onclick="history.back(-1);" />
				    </div>					
				</c:otherwise>
				</c:choose>    		    			    
			</c:forEach>			    		    
	    </div>
	    <div style="height: 30px;"></div>
    </div>	   
    <div class="info-inner" style='position:relative;'>   	
    	<span style="float: left; width: 85%">
			<textarea id='tbxShortMsg' name='message' rows="2" class="input-xlarge"></textarea>
		</span>
		<span style="float: right; width: 13%; margin-left: 3px;">
			<input type="button" id="btnReply" value="댓글" class="input-xlarge" style="width: 43px; height: 43px;" onclick="fnReply();" />
		</span>
    </div>
    <div style="height: 50px;"></div>       	   
    <div id="replyContainer" class="info-inner" style='position:relative; height:100%; display: none;'>    	   	
		<div id="divReply" class="breadcrumb" style="margin-bottom: 8px;">
			<c:forEach items="${contractReply}" var="reply" varStatus="loop">
				<div class='replyMsg'>
					<span style='padding-right: 10px;'>${reply.CREATE_USER_NM}</span>
					<span>${reply.MESSAGE}</span>
					<span style='float: right;'>${reply.CREATE_DATE}</span>
				</div>
				<c:if test="${!loop.last}">
					<hr class="message-inner-separator" style='margin-top: 8px; margin-bottom: 8px;'>
				</c:if>
			</c:forEach>
		</div>
    </div>   
</div>
<c:if test="${not empty contractReply}">
<script type="text/javascript">
	$('#replyContainer').show();
</script>	
</c:if>
</mvc:main>