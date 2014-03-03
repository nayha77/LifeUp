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
	<div class="messages">		
		<div id="contents" onclick="" class="breadcrumb" style="margin-bottom: 7px; padding-right: 15px;">
		    <div id="" class="message-title" style='height: 8px;'>
		    	<span class="text">
		    		<span class="label label-info">지역/차종</span>
		    		<span style="padding-left:5px;">${request.SIDO} ${request.GUGUN} > ${request.VENDOR_NM} > ${request.CAR_NM}</span>
		    	</span>			    				    
		    </div>
		    <hr class="message-inner-separator" style='margin-bottom: 5px;'>
		    <div class="info-inner" style='vertical-align: middle; height: 8px;'>
		    	<span class="text">
		    		<span class="label label-info">등록상태</span>
		    		<span style="padding-left:5px;">${request.STATUS_NM}</span>
		    		<span style='float: right;'>
			    		<span class="label label-info">요청자</span>
			    		<span style="padding-left:5px; margin-right:30px;">${request.CUSTOMER_NM}</span>
		    		</span>
		    	</span>
		    </div>		    
		    <hr class="message-inner-separator" style='margin-bottom: 5px;'>
		    <div class="info-inner" style='vertical-align: middle; height: 8px;'>
		    	<span class="text">
		    		<span class="label label-info">차량옵션</span>
		    		<span style="padding-left:5px;">${request.CAR_OPTION}</span>
		    		<span style='float: right;'>
			    		<span class="label label-info">구매예정일</span>
			    		<span style="padding-left:5px;">${request.PURCHASE_PERIOD_CD}</span>
		    		</span>
		    	</span>
		    </div>	
		    <hr class="message-inner-separator" style='margin-bottom: 5px;'>
		    <div class="info-inner" style='vertical-align: middle; height: 55px;'>
		    	<span class="text">
		    		<span class="label label-info">요구사항</span>
		    		<span style="padding-left:5px; height: 50px; overflow-y:auto;overflow-x:hidden;">${request.CUSTOMER_REQ}</span>
		    	</span>
		    </div>		    
		</div>
	</div>
   	<div>    	
   		<input type='hidden' id='hdnRequestId' name='request_id' value='${request.REQUEST_ID}' />    
	    <div style='float: right;'>
	    	<c:if test="${sessionScope._USER_INFO_.userType == '2'}">
	    		<input type='button' class="btn btn-primary" value='견적남기기' onclick="fnContractWrite(${sessionScope._USER_INFO_.userType});" />
	    	</c:if>
	    	<input type='button' class="btn btn-primary" value='목록' onclick="fnList();" />
	    </div>
    </div>
	<div style="height: 15px;"></div>
</form>
<div>
	<c:forEach items="${contract}" var="salesDoc" varStatus="status">
		<img id='imgSalesmanIco' src='/resources/img/ico/member.png' />
		<c:choose>
			<c:when test="${salesDoc.SALESMAN_ID == sessionScope._USER_INFO_.userId || 
						  request.CUSTOMER_ID == sessionScope._USER_INFO_.userId}">
				<span class="breadcrumb" onclick="fnContractDetail('${salesDoc.SALESMAN_ID}');" style="cursor:pointer;">
					<c:if test="${salesDoc.STATUS == '0002'}"><a href="#" class="icon-ok"></a></c:if>					
					<c:if test="${salesDoc.STATUS == '0003'}"><s></c:if>
					[${salesDoc.CREATE_DATE}] ${salesDoc.SALESMAN_NM}님 견적 ${salesDoc.STATUS_NM}
					<c:if test="${salesDoc.STATUS == '0003'}"></s></c:if> 
				</span>			
			</c:when>
			<c:otherwise>
				<span class="breadcrumb">
					<c:if test="${salesDoc.STATUS == '0002'}"><a href="#" class="icon-ok"></a></c:if>
					<c:if test="${salesDoc.STATUS == '0003'}"><s></c:if>
					[${salesDoc.CREATE_DATE}] ${salesDoc.SALESMAN_NM}님 견적 ${salesDoc.STATUS_NM}
					<c:if test="${salesDoc.STATUS == '0003'}"></s></c:if> 
				</span>			
			</c:otherwise>
		</c:choose>
		<div style='height:7px;'></div>		
	</c:forEach>
</div>		
</mvc:main>