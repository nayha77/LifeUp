<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang='ko'>
<head>
<meta charset='utf-8'>
</head>
<body>
	<div data-role="page" class="jqm-demos ui-responsive-panel" id="requestDetailPage">

		<%@ include file="../../include/header.jsp" %>
		
		<div class="ui-content jqm-content jqm-fullwidth" style="padding-top: 0px;">
			<form id='frm' name="frm" method="post">
				<input type='hidden' id='hdnRequestId' name='request_id' value='${request.REQUEST_ID}' />
				<input type='hidden' id='hdnCurrentSeq' name='currentSeq' value='${param.currentSeq}' />
				<input type='hidden' id='hdnSidoCd' name='sidoCd' value='${param.sidoCd}' />
				<input type='hidden' id='hdnGugunCd' name='gugunCd' value='${param.gugunCd}' />
				<input type='hidden' id='hdnVendorCd' name='vendorCd' value='${param.vendorCd}' />
				<input type="hidden" id="hdnStatusCd" name="statusCd" value="${param.statusCd}" />
				<input type='hidden' id='hdnPageMove' name='pageMove' value='Y' /><!-- List로 이동시 더보기 실행방지 -->
				<input type='hidden' id='hdnSalesmanId' name='salesman_id' />	
			</form>
			
			<div class="ui-content jqm-content jqm-fullwidth" style="padding-top: 0px;">
				<ul data-role="listview" data-inset="true">
				    <li data-role="list-divider">지역/차종<span class="ui-li-count">${request.STATUS_NM}</span></li>
				    <li>
					    <h1>${request.SIDO_NM} ${request.GUGUN_NM} > ${request.VENDOR_NM} > ${request.CAR_NM}</h1>
				    </li>
				    <li data-role="list-divider">차량옵션</li>
				    <li>
					    <h1>${request.CAR_OPTION}</h1>
				    </li>	
				    <li data-role="list-divider">${request.CUSTOMER_NM}님 요구사항 </li>
				    <li>
					    <h1>${request.CUSTOMER_REQ}</h1>
				    </li>
				    <li data-role="list-divider">구매예정일 </li>
				    <li>
					    <h1>${request.PURCHASE_PERIOD_CD}</h1>
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
						    		<a href="#" data-icon="" onclick="fnContractDetail('${salesDoc.SALESMAN_ID}');">
						    			<img id='imgSalesmanIco' src='/resources/img/ico/member.png' class="ui-li-icon ui-corner-none">			    			
										<c:if test="${salesDoc.STATUS == '0003'}"><s></c:if>
											[${salesDoc.CREATE_DATE}] ${salesDoc.SALESMAN_NM}님 견적 ${salesDoc.STATUS_NM}
										<c:if test="${salesDoc.STATUS == '0003'}"></s></c:if> 								    			
						    		</a>
						    	</li>
					    	</c:when>
					    	<c:otherwise>
						    	<li>
					    			<img id='imgSalesmanIco' src='/resources/img/ico/member.png' class="ui-li-icon ui-corner-none">			    			
									<c:if test="${salesDoc.STATUS == '0003'}"><s></c:if>
										[${salesDoc.CREATE_DATE}] ${salesDoc.SALESMAN_NM}님 견적 ${salesDoc.STATUS_NM}
									<c:if test="${salesDoc.STATUS == '0003'}"></s></c:if>
						    	</li>	    		
					    	</c:otherwise>
				    	</c:choose>
				    </c:forEach>
				</ul>	
				
				<c:choose>
					<c:when test="${sessionScope._USER_INFO_.userType == '2'}">
						<div style="margin-bottom: -15px; margin-right: -10px; text-align: right;">
							<c:if test="${request.STATUS == '0001'}">
								<a href="#" data-role="button" data-icon="edit" data-inline="true" onclick="fnContractWrite(${sessionScope._USER_INFO_.userType});">견적남기기</a>					
							</c:if>
							<a href="#" data-role="button" data-icon="grid" data-inline="true" onClick="fnReqList();">목록</a>
						</div>
					</c:when>	
					<c:otherwise>
						<div style="margin-bottom: -15px; margin-right: -10px; text-align: right;">
							<a href="#" data-role="button" data-icon="grid" data-inline="true" onClick="fnReqList();">목록</a>
						</div>
					</c:otherwise>
				</c:choose>
			</div>	
		</div>	
	</div><!-- /page -->

</html>