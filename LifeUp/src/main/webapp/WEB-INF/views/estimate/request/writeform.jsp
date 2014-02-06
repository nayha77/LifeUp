<%@ page language="java" contentType="text/html; charset=UTF-8"%>

<%@ taglib prefix="mvc" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<mvc:simple>
    
    <spring:url value="/" var="action"/>
    <form:form id="form"  comcssClass="form-horizontal" action=""  method="${method}" modelAttribute="sido">
				 	 
      <fieldset>
<!--       
  <c:forEach items="${sido}" var="post">
    <tr>
       <td>${post.sido}</td>
    </tr>
   </c:forEach>  
    -->
		<%--     <form:select path="regionCd" id="regionCd">
		         <form:option value="" label="--Choose A Value--"></form:option>
		         <form:options items="${sido}" itemValue="id"   itemLabel="name"></form:options>
		     </form:select>
  --%>
      <%-- 
        <div class="control-group">
        <div>차량옵션</div>
            <div class="controls">
                <form:input path="carOption" cssClass="input-xlarge"/>
                <form:errors path="carOption"><p class="help-block"></p></form:errors>
            </div>
        </div>
        <div class="control-group">
        <div>요구사항</div>
            <div class="controls">
                <form:textarea path="customerReq" rows="2" cssClass="input-xlarge"/>
                <form:errors path="customerReq"><p class="help-block"></p></form:errors>
            </div>
        </div>
        <div class="control-group">
        <div>작성자</div>        
            <div class="controls">
                <form:input path="customerId" cssClass="input-xlarge"/>
                <form:errors path="customerId"><p class="help-block"></p></form:errors>
            </div>
        </div>

        <div class="form-actions">
            <button class='btn btn-primary'>저장하기 </button>
            <a href='javascript:history.go(-1);' class='btn'>뒤로가기</a>           
        </div> --%>
    </fieldset>
    
	</form:form>
	
	
</mvc:simple>