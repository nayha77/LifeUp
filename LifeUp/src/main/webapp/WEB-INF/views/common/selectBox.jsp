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
        $('.selectpicker').selectpicker({
            //'selectedText': '구로'
        });		
		viewAjaxList();
	}
	
	function viewAjaxList(){
		$.ajax({
			 type 	: 	"POST"
			,url	:	"/ROOT/selectBoxTestJson"
			,dataType	: "json"
			,data	: ""
			,success	: function(result){
				$.each(result,function(key){
					var list = result[key];
					
					var content =" <select class='selectpicker' data-live-search='true'>";
					
					for (i=0 ; i <list.length; i++){
						content +="<option>" +list[i].sido + "</option>";
					}
					content +="</select>";
					$(".bs-docs-example").html(content);
				});
			}
		});
	}
	viewAjaxList();
</script>

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
    
    <div class="bs-docs-example" ></div>
    
<!-- <div class="bs-docs-example">
  
  <select class="selectpicker" data-live-search="true">
  <option>서울시 용산구</option>
     <option>서울시 구로구</option>
      <option>경기도 군포시 산본동</option>
      <option>경기도 안양시 산본동</option>
  </select>

</div> -->
  
  
</mvc:test>