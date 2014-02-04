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
	    var nation = $('#nationcode option:selected');
	    $('#state').html($('<option></option>').val('').html('----------------------'));
		$.ajax({
			 type 	: 	"POST"
			,url	:	"/ROOT/selectBoxTestJson"
			,dataType	: "json"
			,data	: ""
			,success	: function(result){
				if( result.length > 0 ){
		            $('#state').html('');
		            $('#state').append($('<option></option>').val('').html('-- Choose from list --'));					
				}
				$.each(result,function(key){
/* 					var list = result[key];
					var content =" <select class='selectpicker' data-live-search='true' id='nationcode'>";
					content += "<option>----select----- </option>"
					for (i=0 ; i <list.length; i++){
						content +="<option>" +list[i].sido + "</option>";
					}
					content +="</select>";
					$(".bs-docs-example").html(content); */
		            if($('#province').val() == this.name){
		                $('#state').append($('<option></option>').val(this.name).html(this.name).attr('selected', true));
		            }else{
		                $('#state').append($('<option></option>').val(this.name).html(this.name));
		            }					
				});
				}, 
				error : function(XHR, textStatus, errorThrown) { 

					alert("Error: " + textStatus); 
					alert("Error: " + errorThrown); 

					} 
		});
	}
/*     $('.selectpicker').selectpicker({
        'selectedText': '대전'
    }); */		

</script>

    <div class="bs-docs-example" ></div>
    <div class="bs-docs-example" id="state" ></div>

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