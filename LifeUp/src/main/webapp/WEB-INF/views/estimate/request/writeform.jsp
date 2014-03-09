<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="mvc" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<mvc:main>
<script type="text/javascript">	
	$(document).ready(function() {		
		//$("#ddlGugun").hide();
		//$("#ddlCar").hide();
		
		_Commn.SetDatePickter();
		//$('#purchase_period_cd').val(_Commn.ConvertDate(new Date(), "-"));					
	});	

	function fnSidoChange(obj){
		if(obj.value == '0')			
			return;
 		
 		$("#ddlGugun").find("option").remove().end().append("<option value=\"0\">선택</option>");

 		_Async.post (
   			"/regionSecondJson",
   			sido = obj.value,
   			function (data) {    
				var resultData = data.Sido2; 
				$.each(resultData, function(index, row){	    		      		
					$("#ddlGugun").append("<option value='"+ row.region_cd +"'>" + row.gugun  + "</option>");	
				});
				 $("#ddlGugun").listview("refresh");
				//$("#ddlGugun").show();
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
					$("#ddlCar-button").append("<option value='"+ row.car_id +"'>" + row.car_nm  + "</option>");    		        	  
				});
				
				//$("#ddlCar").show();
   			} 
   		);   	       
	}	
	
	function fnSave() {		
		var check = true;
		
		$('.error').hide();
		
		if($('#ddlSido').val() == "" || $('#ddlGugun').val() == "0") {
			check = false;
			$('#ddlGugun').after('<label class="error">거주지역을 선택하세요</label>');
		} else if($('#ddlVendor').val() == "" || $('#ddlCar').val() == "") {
			check = false;
			$('#ddlCar').after('<label class="error">차량을 선택하세요</label>');
		} else if($('#carTrim').val() == "") {
			check = false;
			$('#carTrim').focus();
			$('#carTrim').after('<label class="error">트림을 입력하세요</label>');
		} else if($('#carOption').val() == "") {
			check = false;
			$('#carOption').focus();
			$('#carOption').after('<label class="error">옵션을 입력하세요</label>');			
		} else if($('#purchase_period_cd').val() == "") {
			check = false;
			$('.ui-datepicker-trigger').after('<label class="error">예상구매일을 입력 하세요</label>');
		} else if($('#customer_req').val() == "") {
			check = false;
			$('#customer_req').focus();
			$('#customer_req').after('<label class="error">요구사항을 입력 하세요</label>');
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
					location.href="/request/list";
				} else {
					alert(data.message);
				}			
   			} 
   		);   
	}
</script>
<div class="ui-content jqm-content jqm-fullwidth" style="padding-top: 0px;">
	<div class="ui-field-contain">
		<label for="ddlSido">지역</label>
		<fieldset data-role="controlgroup" data-type="horizontal">
		    <select name="ddlSido" id="ddlSido" data-native-menu="false" onchange="fnSidoChange(this);">
				<option value=''>선택</option>
				<c:forEach items="${sidos}" var="sido">
					<option value="${sido.sido}">${sido.sido}</option>
				</c:forEach>
		    </select>
		    <select name="region_cd" id="ddlGugun" data-native-menu="false">
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
		    <select name="car_id" id="ddlCar" data-native-menu="false">
				<option value=''>선택</option>
		    </select>
		</fieldset>
    </div>
    <div class="ui-field-contain">    	 
         <label for="car_trim">트림</label>
         <input type="text" data-clear-btn="true" id="carTrim" name="car_trim">
    </div>
    <div class="ui-field-contain">
         <label for="car_option">옵션</label>
         <input type="text" data-clear-btn="true" id="carOption" name="car_option">
    </div>
    <div class="ui-field-contain">    	
         <label for="purchase_period_cd">구매예정일</label>
         <input type="text" data-clear-btn="true" id="purchase_period_cd" name="purchase_period_cd" class="datePicker" readonly="readonly">         
    </div>    
    <div class="ui-field-contain">
        <label for="customer_req">요구사항</label>
        <textarea data-mini="true" cols="40" rows="8" id="customer_req" name="customer_req"></textarea>
    </div>
	<div style="margin-right: -10px; text-align: right;">
		<a href="#" data-role="button" data-icon="plus" data-inline="true" onclick="fnSave();">등록</a>
		<a href="#" data-role="button" data-icon="list" data-inline="true" onclick="location.href='/request/list';">목록</a>
	</div>    
</div>
</mvc:main>