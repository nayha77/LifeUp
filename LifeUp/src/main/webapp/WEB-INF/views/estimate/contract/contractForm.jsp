<%@ page language="java" contentType="text/html; charset=UTF-8"%>

<%@ taglib prefix="mvc" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<mvc:main>
<script type="text/javascript">
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
</script>		
<div class="message other alert pinned alert alert-success chrome-extension" style="padding-left: 25px;">
    <div class="message-title" style='height:30px; position:relative; padding-top: 10px;'>
		<div style="float: left;" >
	    	<span class="label label-warning">${requestDetail.STATUS_NM}</span><span><b> | </b></span> 
	    	<span class="label label-success">${requestDetail.SIDO} ${requestDetail.GUGUN}</span><span><b> | </b></span>
	    	<span class="label label-info">${requestDetail.CAR_NM}</span>
    	</div>
    	<div style="float: right;">
    		<span class="label">${requestDetail.CREATE_DATE} ${requestDetail.CUSTOMER_ID}</span>
    	</div>		    	
    </div>
    <div class="info-inner" style='position:relative;'>
       	<div class="label label-info">옵션</div>
       	<div class="request-detail" style='height: 40px;'>${requestDetail.CAR_OPTION}</div>       	
       	<div class="label label-info">요구사항</div>
       	<div class="request-detail" style='height: 80px; overflow-y:auto;overflow-x:hidden;'>
       		${requestDetail.CUSTOMER_REQ}
       	</div>
    </div>
    <hr class="message-inner-separator">
    <div class="info-inner" style='position:relative;'>
   		<input type='hidden' id='hdnRequestId' name='request_id' value='${requestDetail.REQUEST_ID}' />    
    	<span style='text-align: center; margin-left: 5px; margin-right: 5px;'>
    		<img class="media-object" src="/resources/img/ico/member.png" width="40px" height="40px" border="1">
    	</span>
	    <span style='width: 65%; text-align: right;'>    
	    	<textarea id='tbxSalesBenefit' name='salesman_benefit' rows="4"></textarea>
	    </span>
	    <span>
	    	<input type='submit' class="btn btn-primary" value='등록' onclick="fnSave();" />
	    </span>   
    </div>
</div>			

</mvc:main>