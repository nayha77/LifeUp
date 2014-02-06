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
		  $("#first_test").append('<div id="second_test"></div>'); // div 생성
	     var select = document.createElement("select");    //selectbox 생성
	     select.name = "soname";                           //name지정
	     select.setAttribute("id", "soname");
	     //현재 소분류 selectbox가 있는지 여부를 확인한다. 있다면 기존 selectbox remove
	     if(document.getElementById("second_test").innerHTML != ""){
	    	 $("#second_test").remove();
	     }
   	    _Async.post (
    			"/selectBoxTestJson.do",
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
   	    
		$("#second_test").append(select);     
	}		
</script>
<div>
		<div id="first_test">

		   <select name="bigname"  id="bigname"  onchange="LowList(this);" >
		   
		   <c:forEach items="${sidos}" var="sido">
		   	<option value="${sido.sido}">${sido.sido}</option>
		   </c:forEach>
		   
		   </select>
		</div>
	
	</div>
</mvc:simple>