<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="mvc" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<mvc:main>
<script type="text/javascript">	
	function fnLoad() {		
		$("select[name=customer_region]").hide();
		$("select[name=car_id]").hide();
		
		_Commn.SetDatePickter();
		//$('#purchase_period_cd').val(_Commn.ConvertDate(new Date(), "-"));		
	}
	
	function fnSidoChange(obj){
		if(obj.value == '0')			
			return;
 		
 		$("select[name=customer_region]").find("option").remove().end().append("<option value=\"0\">선택</option>");
 
 		_Async.post (
   			"/regionSecondJson",
   			sido = obj.value,
   			function (data) {    
				var resultData = data.Sido2;  // vo 객체로 넘어와서 한번 감싸줘야함 
				$.each(resultData, function(index, row){	    		      		
					$("select[name=customer_region]").append("<option value='"+ row.region_cd +"'>" + row.gugun  + "</option>");	    		      		
				});

				$("select[name=customer_region]").show();
   			}    			
   		);   	         
	}	
	
	// 차량 종류 셀렉박스
	function fnVenderChange(obj){
		if(obj.value == '')
			return;
		
 		$("select[name=car_id]").find("option").remove().end().append("<option value=\"\">선택</option>");
 		
   	    _Async.post (
   			"/selectCarJson",
   			venderId = obj.value,
   			function (data) {    
   				var resultData = data.carCodeList;  
				$.each(resultData, function(index, row){
					$("select[name=car_id]").append("<option value='"+ row.car_id +"'>" + row.car_nm  + "</option>");    		        	  
				});
				
				$("select[name=car_id]").show();
   			} 
   		);   	       
	}	
	
	function fnSave() {
   	    _Async.post (
   			"/request/writing",
   			JSON.stringify({ region_cd: $('#ddlGugun').val(), 
   							 car_id: $('#ddlCar').val(), 
   							 car_trim: $('#carTrim').val(), 
   							 car_option: $('#carOption').val(),
   							 customer_region: $('#ddlGugun').val(),
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
<form id='frm' name='frm' method='post'>
<div class="row">
	<div class="span1">지역</div>
  	<div class="span11">
		<select name="ddlSido" id="ddlSido" class="input-xlarge" onchange="fnSidoChange(this);" >
			<option value="0">선택</option>
			<c:forEach items="${sidos}" var="sido">
				<option value="${sido.sido}">${sido.sido}</option>
			</c:forEach>
		</select>
		<select name="customer_region" id="ddlGugun" class='input-xlarge'>
			<option value=''>선택</option>
		</select>		
  	</div>
</div>
<div class="row">
	<div class="span1">차량</div>
  	<div class="span11">
		<select name="ddlVendor" id="ddlVendor" class="input-xlarge" onchange="fnVenderChange(this);" >
	    	<option value="0">선택</option>
	   		<c:forEach items="${venders}" var="vender">
	   			<option value="${vender.code}">${vender.value}</option>
	   		</c:forEach>
	   	</select>
		<select name="car_id" id="ddlCar" class='input-xlarge'>
			<option value=''>선택</option>
		</select>		   		
  	</div>
</div>
<div class="row">
	<div class="span1">트림</div>
  	<div class="span11">
		<input type="text" id="carTrim" name="car_trim" class="input-xlarge" />
  	</div>
</div>
<div class="row">
	<div class="span1">옵션</div>
  	<div class="span11">
		<input type="text" id="carOption" name="car_option" class="input-xlarge" />
  	</div>
</div>
<div class="row">
	<div class="span1">구매예정일</div>
  	<div class="span11">
		<input type="text" id="purchase_period_cd" name="purchase_period_cd" class="datePicker" style="width:80px;" readonly="readonly" />
  	</div>
</div>
<div class="row">
	<div class="span1">요구사항</div>
  	<div class="span11">  		
		<textarea id="customer_req" name="customer_req" rows="2" class="input-xlarge"></textarea>
  	</div>
</div>
<div class="info-inner" style='position:relative;'>
	<div style="position:relative;">    	    
		<div style='float: right;'>
			<input type='button' class="btn btn-primary" value='등록' onclick="fnSave();" />
			<input type='button' class="btn btn-primary" value='목록' onclick="location.href='/request/list'" />
		</div>
	</div>
</div>	
</form>
</mvc:main>