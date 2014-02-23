<%@ page language="java" contentType="text/html; charset=UTF-8"%>

<%@ taglib prefix="mvc" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<mvc:main>

<script type="text/javascript">	
	function fnLoad() {
	}
	
	function fnList() {
		frm.action = '/request/list';
		frm.submit();
	}
	
	function fnCallContractForm() {
		frm.action = '/contract/writeform';
		frm.submit();
	}
</script>
<form id='frm' method="post">
	<input type='hidden' id='hdnRequestId' name='requestId' value='${request.REQUEST_ID}' />
	<input type='hidden' id='hdnCurrentSeq' name='currentSeq' value='${param.currentSeq}' />
	<div class="messages" style="margin-bottom: -10px;">
		<div id="contents" class="message other alert pinned alert alert-success chrome-extension" style="margin-bottom: 7px; padding-right: 15px;">
			<div class="message-title" style='height: 8px; position:relative; padding-top: 10px;'>
				<div style="float: left;">
		    		<span class="label label-info">${request.STATUS_NM} > ${request.SIDO} ${request.GUGUN} > ${request.CAR_NM}</span>
		    	</div>
		    	<div style="float: right;">
		    		<span class="label">${request.CUSTOMER_ID}</span>
		    	</div>    				    				
			</div>
			<div class="info-inner" style='padding-top: 18px;'>
		       	<div class="label label-info">옵션</div>
		       	<div class="request-detail" style="height: 40px; padding-bottom: 0px;">${request.CAR_OPTION}</div>       	
		       	<div class="label label-info">요구사항</div>
		       	<div class="request-detail" style='height: 80px; overflow-y:auto;overflow-x:hidden;'>
		       		${request.CUSTOMER_REQ}
		       	</div>		
			</div>		
		</div>		
		<hr class="message-inner-separator" style="margin-top: 2px; margin-bottom: 7px;">
	    <div class="info-inner" style='position:relative;'>
	    	<div style="position:relative;">    	
		   		<input type='hidden' id='hdnRequestId' name='request_id' value='${request.REQUEST_ID}' />    
			    <div style='float: right;'>
			    	<input type='submit' class="btn btn-primary" value='견적남기기' onclick="fnCallContractForm();" />
			    	<input type='submit' class="btn btn-primary" value='목록' onclick="fnList();" />
			    </div>
		    </div>
		    <div style="height: 30px;"></div>
	    </div>	     
	</div>
</form>
<div>
	<c:forEach items="${contract}" var="salesDoc" varStatus="status">
		<span class="breadcrumb">${salesDoc.SALESMAN_NM}(${salesDoc.SALESMAN_ID})의 견적이 등록[${salesDoc.STATUS_NM}]되어 있습니다</span>
	</c:forEach>
</div>		
</mvc:main>