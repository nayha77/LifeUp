<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang='ko'>
<head>
<meta charset='utf-8'>
</head>
<body>
	<div data-role="page" class="jqm-demos ui-responsive-panel" id="requestListPage">

		<%@ include file="../../include/header.jsp" %>
		
		<div class="ui-content jqm-content jqm-fullwidth" style="padding-top: 0px;">
			<form id='frm' name='frm' method='post'>
				<input type="hidden" id="hdnCurrentSeq" name='currentSeq' value='${param.currentSeq == null || param.currentSeq == "" ? 7 : param.currentSeq}'>
				<input type='hidden' id='hdnRequestId' name='request_id'/>
				<input type="hidden" id="hdnReqVendor" name="vendorCd" value='${param.vendorCd}' />
				<input type="hidden" id="hdnReqSido" name="sidoCd" value='${param.sidoCd}' />
				<input type="hidden" id="hdnReqGugun" name="gugunCd" value='${param.gugunCd}' />
				<input type="hidden" id="hdnReqStatus" name="statusCd" value='${param.statusCd}' />			
						
				<div class="ui-grid-a" style="border-top: 0px; margin-top: 0px; padding-top: 0px;">
					<div class="ui-block-a" style="width:70%;">
			
			
			<%--
			  			<div class="ui-block-a">
							<fieldset data-role="controlgroup" data-type="horizontal" data-mini="true">
							    <label for="ddlSido">시(도)</label>
							    <select name="ddlSido" id="ddlSido" onchange="fnSidoChange('', 'N');">
							    	<option value="">시(도)</option>
									<c:forEach items="${sidos}" var="sido">
										<option value="${sido.sido_cd}">${sido.sido_nm}</option>
									</c:forEach>
							    </select>	
							    <label for="region_cd">구(군)</label>
							    <select name="region_cd" id="ddlGugun" onchange="fnDDLChanage();">
							    	<option value="">구(군)</option>				   		
							    </select>				    		       
							</fieldset>
							
							<fieldset data-role="controlgroup" data-type="horizontal" data-mini="true">
							    <label for="ddlStatus">거래상태</label>
							    <select name="status_cd" id="ddlStatus" onchange="fnDDLChanage();">
							    	<option value="">거래상태</option>
							    	<option value="0001">진행중</option>
							    	<option value="0002">종료</option>
							    </select>			       
							</fieldset>					
						</div>
						<div class="ui-block-b" style="padding-left: 3px;">
							<fieldset data-role="controlgroup" data-type="horizontal" data-mini="true">
							    <label for="ddlVendor">제조업체</label>
							    <select name="ddlVendor" id="ddlVendor"  onchange="fnDDLChanage();">
							    	<option value="">제조업체</option>
							   		<c:forEach items="${venders}" var="vender">
							   			<option value="${vender.code}">${vender.value}</option>
							   		</c:forEach>
							    </select>			       
							</fieldset>
						</div> 
			 --%>
			
			 		    <div class="ui-block-c">
					    	<a href="#popupDialog" data-rel='popup' data-position-to="window" data-role="button" data-icon="search" data-inline="true" data-mini="true" onclick="fnSetCtrlVal();">검색</a>
					        <div data-role='popup' id='popupDialog' data-overlay-theme='a' data-theme='a' data-dismissible='false' style='max-width:400px;'>
					            <div data-role='header' data-theme='b'>
					                <h1>조건 검색</h1>
					            </div>
					            <div role='main' class='ui-content'>
									<fieldset data-role="controlgroup" data-type="horizontal" data-mini="true">
									    <label for="ddlSido">시(도)</label>
									    <select name="ddlSido" id="ddlSido" onchange="fnSidoChange('', 'N');">
									    	<option value="">시(도)</option>
											<c:forEach items="${sidos}" var="sido">
												<option value="${sido.sido_cd}">${sido.sido_nm}</option>
											</c:forEach>
									    </select>	
									    <label for="region_cd">구(군)</label>
									    <select name="region_cd" id="ddlGugun" onchange="fnDDLChanage();">
									    	<option value="">구(군)</option>				   		
									    </select>				    		       
									</fieldset>
									<fieldset data-role="controlgroup" data-type="horizontal" data-mini="true">
									    <label for="ddlVendor">제조업체</label>
									    <select name="ddlVendor" id="ddlVendor" onchange="fnDDLChanage();">
									    	<option value="">제조업체</option>
									   		<c:forEach items="${venders}" var="vender">
									   			<option value="${vender.code}">${vender.value}</option>
									   		</c:forEach>
									    </select>			       
									</fieldset>	
									<fieldset data-role="controlgroup" data-type="horizontal" data-mini="true">
									    <label for="ddlStatus">거래상태</label>
									    <select name="status_cd" id="ddlStatus" onchange="fnDDLChanage();">
									    	<option value="">거래상태</option>
									    	<option value="0001">진행중</option>
									    	<option value="0002">종료</option>
									    </select>			       
									</fieldset>																		
					                <a href='#' data-role="button" data-icon="forward" data-mini="true" data-rel='back' onclick="fnGetCtrlVal();">닫기</a>
					            </div>
					        </div>
					    </div>
					    
					    								
					</div>		
					<div class="ui-block-b" style="width:30%; text-align: right;">
						<a href="#" data-role="button" data-icon="plus" data-inline="true" data-mini="true" onclick="fnReqWrite(${sessionScope._USER_INFO_.userType});">견적의뢰</a>
					</div>
				</div>	
				<ul data-role="listview" data-inset="true" id="rowData" style="margin-top: 0px;">
					<c:forEach items="${estimateRegList}" var="estimateReg" varStatus="status">
					    <li data-role="list-divider" style="height:20px; padding-top: 10px;">
					    	${estimateReg.REGION_NM} > ${estimateReg.VENDOR_NM} > ${estimateReg.CAR_NM}
					    	<span class="ui-li-count">${estimateReg.HIT_CNT}</span>
					    </li>
					    <li>
					    	<a href="#" onclick="fnReqDetail('${estimateReg.REQUEST_ID}');" style="height:55px;">
						    	<p>${estimateReg.CUSTOMER_REQ}</p>
					        </a>
					    </li>
					</c:forEach>
				</ul>
				<input type="button" data-icon="plus" value="더보기" id="moreView" onclick="fnMoreView();">
			</form>
		</div>	
	</div><!-- /page -->

</html>