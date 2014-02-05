<%@ page language="java" contentType="text/html; charset=UTF-8"%>

<%@ taglib prefix="mvc" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<mvc:test>
<link href='<spring:url value="/resources/css/bootstrap-select.css"/>' rel='stylesheet'>
<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.10.1/jquery.min.js"></script>    
<script src='<spring:url value="/resources/js/bootstrap-select.js"/>'></script>

<script type="text/javascript">
	
	function fnLoad() {
		viewAjaxList();
	}
	
	function viewAjaxList(){
	     var select = document.createElement("select");    //selectbox 생성
	     select.name = "bigname";                           //name지정
	     select.setAttribute("onchange", "LowList(this)");	// onchage 옵션 추가
	     select.setAttribute("id", "bigname");
	     //select.setAttribute("data-live-search", "true");
	     //select.setAttribute("class", "selectpicker");

	     //현재 분류 selectbox가 있는지 여부를 확인한다. 있다면 기존 selectbox remove
	     if(document.getElementById("first_test").innerHTML != ""){
	    	 $("#first_test").empty();
	     }
		$.ajax({
			 type 	: 	"POST"
			,url	:	"/ROOT/selectBoxTestJson"
			,dataType	: "json"
			,data	: ""
			,success	: function(result){
				var resultData = result.Sido;  // vo 객체로 넘어와서 한번 감싸줘야함 				
			   $.each(resultData, function(index, entry){
			         // alert(index);
		               var objOpt = document.createElement("option");     //option Element생성
		               objOpt.value = entry["sido"];               	 //entry는 호출된 data를 가지고 있다. 
		               objOpt.innerText = entry["sido"];
		               select.appendChild(objOpt);                        //생성된 select Element에 Option을 추가
		          });
			   /*
			   $.each(result, function(key){
 					var list = result[key];
					var content =" <select class='selectpicker' data-live-search='true' onChange='LowList(this);'>";
					content += "<option>----select----- </option>"
					for (i=0 ; i <list.length; i++){
						content +="<option>" +list[i].sido + "</option>";
					}
					content +="</select>";
					$(".bs-docs-example").html(content);  
				});
			   */
				}, 
				error : function(XHR, textStatus, errorThrown) { 

					alert("Error: " + textStatus); 
					alert("Error: " + errorThrown); 

					} 
		});
	    $("#first_test").append(select);     //생성된 select Element를 first_test Div태그에 추가
	    //$("#bigname > option:eq(0)").attr("selected", "selected");
	    //$("#bigname").val("서울").attr("selected", "selected");
	    $("#bigname").prepend("<option value='0'>지역 선택</option>");
	}
	
	function LowList(obj){
		//console.log(obj);	
		  $("#first_test").append('<div id="second_test"></div>'); // div 생성
	     var select = document.createElement("select");    //selectbox 생성
	     select.name = "soname";                           //name지정
	     select.setAttribute("id", "soname");
	     //현재 소분류 selectbox가 있는지 여부를 확인한다. 있다면 기존 selectbox remove
	     if(document.getElementById("second_test").innerHTML != ""){
	    	 //document.getElementById("second_test").removeChild(document.getElementById("soname"));
	    	 //$("#second_test").empty();
	    	 $("#second_test").remove();
	    	 //$("#soname").remove();
	     }
	     //대분류에 대한 소분류 json데이터를 얻기 위하여 getJSON으로 호출
	     //$.getJSON("/ROOT/selectBoxTestJson?sido="+obj.value, function(data){
		$.ajax({
			 type 	: 	"POST"
			,url	:	"/ROOT/selectBoxTestJson"
			,dataType	: "json"
			,data	: "sido="+obj.value
			,success	: function(data){
				//alert(data);
			var resultData = data.Sido2;  // vo 객체로 넘어와서 한번 감싸줘야함 
	          $.each(resultData, function(index, entry){
		          //alert(index);	        	  
	               var objOpt = document.createElement("option");     //option Element생성
	               objOpt.value = entry["gugun"];               	 //entry는 호출된 data를 가지고 있다. 
	               objOpt.innerText = entry["gugun"];
	               select.appendChild(objOpt);                        //생성된 select Element에 Option을 추가
	          });
          }
	     });
	     //document.getElementById("second_test").appendChild(select);     //생성된 select Element를 test Div태그에 추가
		$("#second_test").append(select);     
	}	     
	

</script>

    <div class="bs-docs-example" id="first_test" ></div>

<!--  세션에 해당 회원 지역 정보 불러오기 -->
<!--  해당 회원 지역 정보 있다면 매칭 -->



<%--   <c:forEach items="${Sido}" var="post">
    <tr>
        <td class="txt_c">${post.sido}</td>
    </tr>
   </c:forEach>  
 <form:form  >
    <form:select path="sidoone" id="country">
         <form:option value="" label="--Choose A Value--"></form:option>
         <form:options items="${Sido}" itemValue="id"   itemLabel="name"></form:options>
     </form:select>
</form:form> 
    --%>
<!-- <div class="bs-docs-example">
  
  <select class="selectpicker" data-live-search="true">
  <option>서울시 용산구</option>
     <option>서울시 구로구</option>
      <option>경기도 군포시 산본동</option>
      <option>경기도 안양시 산본동</option>
  </select>

</div> -->
  
</mvc:test>