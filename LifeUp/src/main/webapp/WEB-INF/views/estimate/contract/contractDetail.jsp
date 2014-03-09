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
					if($('.replyMsg').length > 0)
						$('#divReply').append("<hr class='message-inner-separator' style='margin-bottom: 5px; margin-top: 9px;'>");
					
					$('#divReply').append("<div class='message-title' style='height: 13px;'>");
					$('#divReply').append("<span class='replyMsg'>");
					$('#divReply').append("<span>${sessionScope._USER_INFO_.userNm}</span>");
					$('#divReply').append("<span style='padding-left:9px;'>" + $('#tbxShortMsg').val().trim() + "</span>");
					$('#divReply').append("</span>");
					$('#divReply').append("</div>");
					
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
</div>	



<form id='frm' name='frm' method="post">
	
	<c:forEach items="${contractDetail}" var="detail" varStatus="loop">
		<div class="messages">		
		    <div id="contents" onclick="" class="breadcrumb" style="margin-bottom: 7px;">
		    	<input type='hidden' id='hdnRequestId' name='request_id' value='${requestDetail.REQUEST_ID}' />    	   		   						   		   			
				<input type='hidden' id='hdnSalesman_id' name='salesman_id' value='${detail.SALESMAN_ID}' />
				<c:choose>
					<c:when test="${detail.SALESMAN_ID == sessionScope._USER_INFO_.userId}">					
						<div class="info-inner" style='vertical-align: middle; height: 80px; margin-top: 3px;'>
							<span class="label label-info">견적내용</span>
							<span>				    	    	
								<textarea id='tbxSalesBenefit' name='salesman_benefit' rows="3" class="input-xlarge">${detail.SALESMAN_BENEFIT}</textarea>
							</span>				
						</div>
					</c:when>
					<c:when test="${requestDetail.CUSTOMER_ID == sessionScope._USER_INFO_.userId}">				
					    <div class="info-inner" style='vertical-align: middle; height: 8px;'>
					    	<span class="text">
					    		<span class="label label-info">제안일자</span>
					    		<span style="padding-left:5px;">${detail.CREATE_DATE}</span>
					    	</span>
					    </div>						
						<hr class="message-inner-separator" style='margin-bottom: 5px;'>
					    <div class="info-inner" style='vertical-align: middle; height: 8px;'>
					    	<span class="text">
					    		<span class="label label-info">영업사원</span>
					    		<span style="padding-left:5px;">${detail.VENDOR_NM} > ${detail.LOCATION} > ${detail.SALESMAN_NM}</span>
					    	</span>
					    </div>						
						<hr class="message-inner-separator" style='margin-bottom: 5px;'>					
					    <div class="info-inner" style='vertical-align: middle; height: 8px;'>
					    	<span class="text">
					    		<span class="label label-info">핸드폰번호</span>
					    		<span style="padding-left:5px;">${detail.MOBILE}</span>
					    	</span>
					    </div>	
					    <hr class="message-inner-separator" style='margin-bottom: 5px;'>
					    <div class="info-inner" style='vertical-align: middle; height: 55px;'>
					    	<span class="text">
					    		<span class="label label-info">견적내용</span>
					    		<span style="padding-left:5px; height: 50px; overflow-y:auto;overflow-x:hidden;">${detail.SALESMAN_BENEFIT}</span>
					    	</span>
					    </div>
					</c:when>
				</c:choose>    		    			    						    		   
		    </div>
		</div>
	    <div class="messages">		
		    <div id="contents">			    
				<c:choose>
				    <c:when test="${requestDetail.CUSTOMER_ID == sessionScope._USER_INFO_.userId}">
					    <div style='float: right; padding-bottom:5px;'>
					    	<c:if test="${requestDetail.STATUS == '0001'}">				    	
								<input type='button' id="btnConfirm" class="btn btn-warning" value='거래확정' onclick="fnConfirm();" />
							</c:if>
					    	<input type='button' class="btn" value='이전' onclick="fnMoveBack();" />
					    </div>					
				   	</c:when>	
					<c:otherwise>	    
					    <div class="info-inner" style='float: right; margin-top: 0px;'>					    					    
					    	<c:if test="${detail.STATUS == '0001'}">
					    		<input type='button' class="btn btn-warning" value='수정' onclick="fnSave();" />
					    		<input type='button' id="btnCancel" class="btn btn-info" value='등록취소' onclick="fnCancel();" />
					    	</c:if>				    												    	
					    	<input type='button' class="btn" value='이전' onclick="fnMoveBack();" />
					    </div>						
					</c:otherwise>	    
	   			</c:choose>
	   		</div>
	   	</div>   	
   	</c:forEach>
    <c:if test="${requestDetail.STATUS != '0003'}">
    <div class="messages" style="padding-top: 32px;">		
	    <div id="contents">
		    <div class="info-inner" style='position:relative;'>   	
		    	<span style="float: left; width: 85%">
					<textarea id='tbxShortMsg' name='message' rows="2" class="input-xlarge"></textarea>
				</span>
				<span style="float: right; width: 13%; margin-left: 3px;">
					<input type="button" id="btnReply" value="댓글" class="btn btn-warning" style="width: 43px; height: 43px;" onclick="fnReply();" />
				</span>
		    </div>
	    </div>
	</div>
    </c:if>    		      
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
</form>	
<c:if test="${not empty contractReply}">
<script type="text/javascript">
	$('#replyContainer').show();
</script>	
</c:if>
</mvc:main>