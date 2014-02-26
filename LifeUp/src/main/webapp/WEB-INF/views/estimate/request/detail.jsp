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
	
	function fnContractWrite(userType) {
		if(userType != 2) {
			alert('일반 사용자는 사용할 수 없습니다');
			return;
		}
		frm.action = '/contract/writeform';
		frm.submit();
	}
	
	function fnContractDetail(salesman) {
		$('#hdnSalesmanId').val(salesman);
		frm.action = '/contract/detail';
		frm.submit();
	}
</script>
<form id='frm' method="post">
	<input type='hidden' id='hdnRequestId' name='requestId' value='${request.REQUEST_ID}' />
	<input type='hidden' id='hdnCurrentSeq' name='currentSeq' value='${param.currentSeq}' />
	<input type='hidden' id='hdnSalesmanId' name='salesman_id' />
	<div class="messages" style="margin-bottom: -10px;">
		<div id="contents" class="breadcrumb" style="margin-bottom: 7px; padding-right: 15px;">
			<div class="message-title" style='height: 8px; position:relative; padding-top: 10px;'>
				<div style="float: left;">
		    		<span class="label label-info">${request.STATUS_NM} > ${request.SIDO} ${request.GUGUN} > ${request.CAR_NM}</span>
		    	</div>
		    	<div style="float: right;">
		    		<span class="label">${request.CUSTOMER_NM}</span>
		    	</div>    				    				
			</div>
			<div class="info-inner" style='padding-top: 18px;'>
		       	<div class="label label-info">옵션</div>
		       	<div class="request-detail" style="height: 25px; padding-bottom: 0px;">${request.CAR_OPTION}</div>       	
		       	<div class="label label-info">요구사항</div>
		       	<div class="request-detail" style='height: 50px; overflow-y:auto;overflow-x:hidden;'>
		       		${request.CUSTOMER_REQ}
		       	</div>		
			</div>		
		</div>		
		<hr class="message-inner-separator" style="margin-top: 2px; margin-bottom: 7px;">
	    <div class="info-inner" style='position:relative;'>
	    	<div style="position:relative;">    	
		   		<input type='hidden' id='hdnRequestId' name='request_id' value='${request.REQUEST_ID}' />    
			    <div style='float: right;'>
			    	<input type='button' class="btn btn-primary" value='견적남기기' onclick="fnContractWrite(${sessionScope._USER_INFO_.userType});" />
			    	<input type='button' class="btn btn-primary" value='목록' onclick="fnList();" />
			    </div>
		    </div>
		    <div style="height: 30px;"></div>
	    </div>	     
	</div>
</form>
<div>
	<c:forEach items="${contract}" var="salesDoc" varStatus="status">
		<img id='imgSalesmanIco' src='/resources/img/ico/member.png' />
		<c:choose>
			<c:when test="${salesDoc.SALESMAN_ID == sessionScope._USER_INFO_.userId || 
						  request.CUSTOMER_ID == sessionScope._USER_INFO_.userId}">
				<span class="breadcrumb" onclick="fnContractDetail('${salesDoc.SALESMAN_ID}');" style="cursor:pointer;">
					<c:if test="${salesDoc.STATUS == '0003'}"><s></c:if>
					[${salesDoc.CREATE_DATE}] ${salesDoc.SALESMAN_NM}님 견적 등록
					<c:if test="${salesDoc.STATUS == '0003'}"></s></c:if> 
				</span>			
			</c:when>
			<c:otherwise>
				<span class="breadcrumb">
					<c:if test="${salesDoc.STATUS == '0003'}"><s></c:if>
					[${salesDoc.CREATE_DATE}] ${salesDoc.SALESMAN_NM}님 견적 등록
					<c:if test="${salesDoc.STATUS == '0003'}"></s></c:if> 
				</span>			
			</c:otherwise>
		</c:choose>
		<div style='height:7px;'></div>		
	</c:forEach>
</div>		
</mvc:main>