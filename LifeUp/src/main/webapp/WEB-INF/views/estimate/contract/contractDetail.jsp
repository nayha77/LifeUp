<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang='ko'>
<head>
<meta charset='utf-8'>
</head>
<body>
	<div data-role="page" class="jqm-demos ui-responsive-panel" id="contractDetailPage">

		<%@ include file="../../include/header.jsp" %>
		
		<div class="ui-content jqm-content jqm-fullwidth" style="padding-top: 0px;">
			<form id='frm' name='frm' method="post">
				<ul data-role="listview" data-inset="true">
				    <li data-role="list-divider">지역/차종<span class="ui-li-count">${requestDetail.STATUS_NM}</span></li>
				    <li>
					    <h1>${requestDetail.SIDO_NM} ${requestDetail.GUGUN_NM} > ${requestDetail.VENDOR_NM} > ${requestDetail.CAR_NM}</h1>
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
					
					<div class="ui-field-contain" style="padding-top :0px; padding-bottom: 0px;">	
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
					</div>
					
					<div class="ui-field-contain" style="padding-top :0px; padding-bottom: 5px;">
						<c:choose>
							<c:when test="${requestDetail.CUSTOMER_ID == sessionScope._USER_INFO_.userId}">
								<div style="margin-top: 5px; margin-right: -10px; text-align: right;">
									<c:if test="${requestDetail.STATUS == '0001'}">
										<a href="#" data-role="button" id="btnConfirm" data-icon="check" data-inline="true" onclick="fnContractConfirm();">거래확정</a>					
									</c:if>
									<a href="#" data-role="button" data-icon="back" data-inline="true" onclick="fnContractMoveBack();">이전</a>
								</div>
							</c:when>	
							<c:otherwise>
								<div style="margin-top: 5px; margin-right: -10px; text-align: right;">
									<c:if test="${detail.STATUS == '0001'}">
										<a href="#" data-role="button" data-icon="edit" data-inline="true" onclick="fnContractSave();">수정</a>
										<a href="#" id="btnCancel" data-role="button" data-icon="delete" data-inline="true" onclick="fnContractCancel();">등록취소</a>
									</c:if>
									<a href="#" data-role="button" data-icon="back" data-inline="true" onclick="fnContractMoveBack();">이전</a>
								</div>
							</c:otherwise>
						</c:choose>	    	       
					</div>
					
					<ul id="replyContainer" data-role="listview" data-inset="true" style="display: none;">
						<c:forEach items="${contractReply}" var="reply" varStatus="loop">
						    <li data-icon="false"><a href="#" style='cursor: default;'>${reply.CREATE_USER_NM} ${reply.MESSAGE} <span class="ui-li-count">${reply.CREATE_DATE}</span></a></li>
					    </c:forEach>
					</ul>			
					<div style="padding-top: 5px;"></div>	
					<c:if test="${requestDetail.STATUS != '0003'}">
						<div class="ui-block-a" style="width:78%; margin-top: -3px;">
						    <input type="text" data-clear-btn="true" id='tbxShortMsg' name='message' style="margin-top: 8px;">
						</div>
						<div class="ui-block-b" style="width:22%; margin-top: -3px;">
							<a href="#" data-role="button" id="btnReply" data-icon="plus" data-inline="true" onclick="fnContractReply();">댓글</a>
						</div>
					</c:if>	
				</c:forEach>		
			</form>
		</div>	
	</div><!-- /page -->
	<c:if test="${not empty contractReply}">
		<script type="text/javascript">
			$('#replyContainer').show();
		</script>	
	</c:if>
</html>