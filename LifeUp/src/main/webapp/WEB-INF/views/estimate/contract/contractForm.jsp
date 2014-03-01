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
					document.location.href='/request/detail?request_id=' + $('#hdnRequestId').val();
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
    	<div style="position:relative;">    	
	   		<input type='hidden' id='hdnRequestId' name='request_id' value='${requestDetail.REQUEST_ID}' />    
		    <div>		    	
				<textarea id='tbxSalesBenefit' name='salesman_benefit' rows="4" class="input-xlarge"><c:forEach items="${contractDetail}" var="detail" varStatus="status">${detail.SALESMAN_BENEFIT}</c:forEach></textarea>				
		    </div>
		    <div style='float: right;'>
		    	<input type='submit' class="btn btn-primary" value='등록' onclick="fnSave();" />
		    	<input type='submit' class="btn btn-primary" value='이전으로' onclick="history.back(-1);" />
		    </div>
	    </div>
	    <div style="height: 30px;"></div>
    </div>	     
</div>
</mvc:main>