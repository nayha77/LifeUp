<%@ page language="java" contentType="text/html; charset=UTF-8"%>

<%@ taglib prefix="mvc" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<mvc:simple>

<script type="text/javascript">
	
	function fnLoad() {		     
	}
	
	function LowList(obj){
		//console.log(obj);	
		  $("#region").append('<div id="region_second"></div>'); // div 생성
	     var select = document.createElement("select");    //selectbox 생성
	     select.name = "region_soname";                           //name지정
	     select.setAttribute("id", "region_soname");
	     //현재 소분류 selectbox가 있는지 여부를 확인한다. 있다면 기존 selectbox remove
	     if(document.getElementById("region_second").innerHTML != ""){
	    	 $("#region_second").remove();
	     }
   	    _Async.post (
    			"/regionSecondJson",
    			sido = obj.value,
    			function (data) {    
    				var resultData = data.Sido2;  // vo 객체로 넘어와서 한번 감싸줘야함 
    		          $.each(resultData, function(index, entry){
    			          //alert(entry);	        	  
    		               var objOpt = document.createElement("option");     //option Element생성
    		               objOpt.value = entry["region_cd"];               	 //entry는 호출된 data를 가지고 있다. 
    		               objOpt.innerText = entry["gugun"];
    		               select.appendChild(objOpt);                        //생성된 select Element에 Option을 추가
    		          });
    			} 
    		);
   	    
		$("#region_second").append(select);     
	}	
	
	// 차량 종류 셀렉박스
	function venderLowList(obj){
		  $("#vender").append('<div id="vender_second"></div>'); 
	     var select = document.createElement("select");    
	     select.name = "vender_soname";                     
	     select.setAttribute("id", "vender_soname");
	     if(document.getElementById("vender_second").innerHTML != ""){
	    	 $("#vender_second").remove();
	     }
   	    _Async.post (
    			"/selectCarJson",
    			sido = obj.value,
    			function (data) {    
    				var resultData = data.carCodeList;  
    		          $.each(resultData, function(index, entry){
    		               var objOpt = document.createElement("option");   
    		               objOpt.value = entry["car_id"];               	
    		               objOpt.innerText = entry["car_nm"];
    		               select.appendChild(objOpt);
    		          });
    			} 
    		);
   	    
		$("#vender_second").append(select);     
	}	
</script>
<form id='estimateReq' name='estimateReq' method='post' action='/estimate/reg'>

		<div id="region">
		   <select name="bigname"  id="bigname"  onchange="LowList(this);" >
		    <option value="0">==지역선택==</option>
		   <c:forEach items="${sidos}" var="sido">
		   	<option value="${sido.sido}">${sido.sido}</option>
		   </c:forEach>
		   </select>
		</div>
		
		<div id="vender">
		   <select name="venderBigname"  id="venderBigname"  onchange="venderLowList(this);" >
		    <option value="0">==제조선택==</option>
		   <c:forEach items="${venders}" var="vender">
		   	<option value="${vender.code}">${vender.value}</option>
		   </c:forEach>
		   </select>
		</div>
		<div>
		<textarea name="customer_req" rows="2" ></textarea>
		</div>
		<div>
		<input type='text' id='customer_id' name='customer_id' />
		</div>
</form>
</mvc:simple>