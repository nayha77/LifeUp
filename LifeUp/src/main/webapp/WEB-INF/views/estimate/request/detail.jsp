<%@ page language="java" contentType="text/html; charset=UTF-8"%>

<%@ taglib prefix="mvc" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<mvc:main>
<script type="text/javascript">	
	$(document).ready(function() {
	});
	
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
</form>
<div class="ui-content jqm-content jqm-fullwidth" style="padding-top: 0px;">
	<ul data-role="listview" data-inset="true">
	    <li data-role="list-divider">지역/차종 </li>
	    <li>
		    <h1>${request.SIDO} ${request.GUGUN} > ${request.VENDOR_NM} > ${request.CAR_NM}</h1>
	    </li>
	    <li data-role="list-divider">등록상태 </li>
	    <li>
		    <h1>${request.STATUS_NM}</h1>
	    </li>
	    <li data-role="list-divider">요청자 </li>
	    <li>
		    <h1>${request.CUSTOMER_NM}</h1>
	    </li>
	    
	    <li data-role="list-divider">차량옵션</li>
	    <li>
		    <h1>${request.CAR_OPTION}</h1>
	    </li>	
	    <li data-role="list-divider">구매예정일 </li>
	    <li>
		    <h1>${request.PURCHASE_PERIOD_CD}</h1>
	    </li>
	    <li data-role="list-divider">요구사항 </li>
	    <li>
		    <h1>${request.CUSTOMER_REQ}</h1>
	    </li>		    		    	    		    	    
	</ul>	
	
	<ul data-role="listview" data-inset="true">		
		<li data-role="list-divider">견적제안</li>
		<c:if test="${empty contract}">
			<li>등록된 견적 제안이 없습니다</li>	
		</c:if>	
		<c:forEach items="${contract}" var="salesDoc" varStatus="loop">	
			<c:choose>
				<c:when test="${salesDoc.SALESMAN_ID == sessionScope._USER_INFO_.userId || request.CUSTOMER_ID == sessionScope._USER_INFO_.userId}">				
			    	<li>
			    		<a href="#" onclick="fnContractDetail('${salesDoc.SALESMAN_ID}');">
			    			<img id='imgSalesmanIco' src='/resources/img/ico/member.png' class="ui-li-icon ui-corner-none">			    			
							<c:if test="${salesDoc.STATUS == '0003'}"><s></c:if>
								[${salesDoc.CREATE_DATE}] ${salesDoc.SALESMAN_NM}님 견적 ${salesDoc.STATUS_NM}
							<c:if test="${salesDoc.STATUS == '0003'}"></s></c:if> 								    			
			    		</a>
			    	</li>
		    	</c:when>
		    	<c:otherwise>
			    	<li>
			    		<a href="#" onclick="return false;" style="cursor: default;">
			    			<img id='imgSalesmanIco' src='/resources/img/ico/member.png' class="ui-li-icon ui-corner-none">			    			
							<c:if test="${salesDoc.STATUS == '0003'}"><s></c:if>
								[${salesDoc.CREATE_DATE}] ${salesDoc.SALESMAN_NM}님 견적 ${salesDoc.STATUS_NM}
							<c:if test="${salesDoc.STATUS == '0003'}"></s></c:if>
						</a>
			    	</li>	    		
		    	</c:otherwise>
	    	</c:choose>
	    </c:forEach>
	</ul>	
	
	<c:choose>
		<c:when test="${sessionScope._USER_INFO_.userType == '2'}">
			<div style="margin-bottom: -15px; margin-right: -10px; text-align: right;">
				<a href="#" data-role="button" data-icon="write" data-inline="true" onclick="fnContractWrite(${sessionScope._USER_INFO_.userType});">견적남기기</a>
				<a href="#" data-role="button" data-icon="list" data-inline="true" onclick="fnList();">목록</a>
			</div>
		</c:when>	
		<c:otherwise>
			<div style="margin-bottom: -15px; margin-right: -10px; text-align: right;">
				<a href="#" data-role="button" data-icon="list" data-inline="true" onclick="fnList();">목록</a>
			</div>
		</c:otherwise>
	</c:choose>
	
</div>

<%-- 

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
 --%>	
</mvc:main>