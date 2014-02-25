<%@ page language="java" contentType="text/html; charset=UTF-8"%>

<%@ taglib prefix="mvc" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<mvc:test>

<script type="text/javascript">
	
	function fnLoad() {		     
	}
</script>

	<div class="page-header">
	    <h1>${result.REGION_CD} - ${result.CAR_MODEL}</h1>
	</div>
	<div class="row">
	    <div class="span2">내용</div>
	    <div class="span8">${result.CUSTOMER_REQ}</div>
	    <div class="span2">&nbsp;</div>
	</div>
	<div class="row" style="margin-top: 10px; margin-bottom: 20px;">
	    <div class="span2">작성자</div>
	    <div class="span8">${result.CUSTOMER_ID}</div>
	    <div class="span2">&nbsp;</div>
	</div>

	<a href='javascript:history.go(-1);' class='btn'>뒤로가기</a>
    <a href='<spring:url value="/request/edit/${result.REQUEST_ID}"/>' class='btn btn-info'>수정하기</a>                        
    <!-- <a href='javascript:$.form.delete("", ${result.REQUEST_ID})' class='btn btn-danger'>삭제하기</a>  -->
	 

</mvc:test>