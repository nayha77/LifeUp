<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang='ko'>
<head>
<meta charset='utf-8'>
	<title>저기요</title>
  	<meta name='viewport' content='width=device-width, initial-scale=1.0'>
	<meta name='description' content=''>
	<meta name='author' content=''>
 	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=IE8" />
	<script type="text/javascript">	
		$(document).ready(function() {
			// 선택 메뉴 마킹
			_Commn.fnMarkingLeftMenu($("#menuRequest"));
			
			_Commn.SetDatePickter();					
		});
		
		function fnList() {
			_Commn.fnPageMove("/request/list");
		}
		
		function fnSidoChange(obj){
			if(obj.value == '0')			
				return;
	 		
	 		$("#ddlGugun").find("option").remove().end().append("<option value=\"\">선택</option>");
	
	 		_Async.post (
	   			"/selectRegionJson",
	   			sido_cd = obj.value,
	   			function (data) {    
					var resultData = data.Sido2; 
					
					$.each(resultData, function(index, row){	    		      		
						$("#ddlGugun").append("<option value='"+ row.gugun_cd +"'>" + row.gugun_nm  + "</option>");	
					});
					
					$("#ddlGugun").show();
					$("#ddlGugun").selectmenu("refresh");
	   			}    			
	   		);   	         
		}	
		
		// 차량 종류 셀렉박스
		function fnVenderChange(obj){
			if(obj.value == '')
				return;
			
	 		$("#ddlCar").find("option").remove().end().append("<option value=\"\">선택</option>");
	 		
	   	    _Async.post (
	   			"/selectCarJson",
	   			venderId = obj.value,
	   			function (data) {    
	   				var resultData = data.carCodeList;  
					$.each(resultData, function(index, row){
						$("#ddlCar").append("<option value='"+ row.car_id +"'>" + row.car_nm  + "</option>");    		        	  
					});
					
					$("#ddlCar").show();
					$("#ddlCar").selectmenu("refresh");							
	   			} 
	   		);   	       
		}	
		
		function fnChangeDDL(obj) {
			$(obj).parent().parent().find(".error").hide();
		}
		
		function fnChangeTextValue(obj) {
			if(obj != "")
				$(obj).parent().parent().find(".error").hide();
		}
		
		function fnSave() {		
			var check = true;
			
			$('.error').hide();
			
			if($('#ddlSido').val() == "" || $('#ddlGugun').val() == "") {
				check = false;
				$('#ddlGugun').parent().after('<div class="error" style="padding-top: 13px;">거주지역을 선택하세요</div>');
			} else if($('#ddlVendor').val() == "" || $('#ddlCar').val() == "") {
				check = false;
				$('#ddlCar').parent().after('<div class="error" style="padding-top: 13px;">차량을 선택하세요</div>');
			} else if($('#carTrim').val() == "") {
				check = false;
				$('#carTrim').focus();
				$('#carTrim').parent().after('<div class="error" style="padding-top: 13px;">트림을 입력하세요</div>');
			} else if($('#carOption').val() == "") {
				check = false;
				$('#carOption').focus();
				$('#carOption').parent().after('<div class="error" style="padding-top: 13px;">옵션을 입력하세요</div>');			
			} else if($('#purchase_period_cd').val() == "") {
				check = false;
				$('#purchase_period_cd').parent().after('<div class="error" style="padding-top: 13px;">구매예정일을 입력하세요</div>');
			} else if($('#customer_req').val() == "") {
				check = false;
				$('#customer_req').focus();
				$('#customer_req').parent().after('<div class="error" style="padding-top: 13px;">요구사항을 입력하세요</div>');
			}				
			
			if(check == false)
				return;
			
	   	    _Async.post (
	   			"/request/writing",
	   			JSON.stringify({ region_cd: $('#ddlGugun').val(), 
	   							 car_id: $('#ddlCar').val(), 
	   							 car_trim: $('#carTrim').val(), 
	   							 car_option: $('#carOption').val(),
	   							 purchase_period_cd: $('#purchase_period_cd').val(),
	   							 customer_req: $('#customer_req').val()}),
	   			function (data) {    
					if(data.message == "success") {
						_Commn.fnPageMove("/request/list");
					} else {
						alert(data.message);
					}			
	   			} 
	   		);   
		}
	</script> 	
</head>
<body>
	<div data-role="page" class="jqm-demos ui-responsive-panel" id="faqPage">

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
				<a href="#" data-role="button" data-icon="plus" data-inline="true" onclick="fnSave();">등록</a>
				<a href="#" data-role="button" data-icon="grid" data-inline="true" onclick="fnList();">목록</a>
	</div>
		</div>	
	</div><!-- /page -->
</html>