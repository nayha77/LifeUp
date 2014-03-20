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
			<div class="ui-field-contain">
				<label for="ddlSido">지역</label>
				<fieldset data-role="controlgroup" data-type="horizontal">
				    <select name="ddlSido" id="ddlSido" data-native-menu="false" onchange="fnSidoChange(this);">
						<option value=''>선택</option>
						<c:forEach items="${sidos}" var="sido">
							<option value="${sido.sido_cd}">${sido.sido_nm}</option>
						</c:forEach>
				    </select>
				    <select name="region_cd" id="ddlGugun" data-native-menu="false" onchange="fnChangeDDL(this);">
				    	<option value=''>선택</option>
				    </select>		    		        	 
				</fieldset>					
		    </div>   
		    <div class="ui-field-contain">
		        <label for="ddlVendor">차량</label>
				<fieldset data-role="controlgroup" data-type="horizontal">
				    <select name="ddlVendor" id="ddlVendor" data-native-menu="false" onchange="fnVenderChange(this);">
						<option value=''>선택</option>
				   		<c:forEach items="${venders}" var="vender">
				   			<option value="${vender.code}">${vender.value}</option>
				   		</c:forEach>
				    </select>
				    <select name="car_id" id="ddlCar" data-native-menu="false" onchange="fnChangeDDL(this);">
						<option value=''>선택</option>
				    </select>		    
				</fieldset>
		    </div>
		    <div class="ui-field-contain">    	 
		         <label for="car_trim">트림</label>
		         <input type="text" data-clear-btn="true" id="carTrim" name="car_trim" onchange="fnChangeTextValue(this);">
		    </div>
		    <div class="ui-field-contain">
		         <label for="car_option">옵션</label>
		         <input type="text" data-clear-btn="true" id="carOption" name="car_option" onchange="fnChangeTextValue(this);">
		    </div>
		    <div class="ui-field-contain">    	
		         <label for="purchase_period_cd">구매예정일</label>
		         <input type="text" data-clear-btn="true" id="purchase_period_cd" name="purchase_period_cd" class="datePicker" readonly="readonly" onchange="fnChangeTextValue(this);">
		    </div>    
		    <div class="ui-field-contain">
		        <label for="customer_req">요구사항</label>
		        <textarea data-mini="true" cols="40" rows="8" id="customer_req" name="customer_req" onchange="fnChangeTextValue(this);"></textarea>
		    </div>
			<div style="margin-right: -10px; text-align: right;">
				<a href="#" data-role="button" data-icon="plus" data-inline="true" onclick="fnWriteFrmSave();">등록</a>
				<a href="#" data-role="button" data-icon="grid" data-inline="true" onclick="fnWriteFrmList();">목록</a>
			</div>
		</div>	
	</div><!-- /page -->

</html>