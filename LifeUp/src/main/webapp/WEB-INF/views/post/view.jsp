<%@ page language="java" contentType="text/html; charset=UTF-8"%>

<%@ taglib prefix="mvc" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<mvc:layout>
    <div class="page-header">
        <h1>번 - ${title}</h1>
    </div>
    
    <div class="row">
        <div class="span2">내용</div>
        <div class="span8">${content}</div>
        <div class="span2">&nbsp;</div>
    </div>
    <div class="row" style="margin-top: 10px; margin-bottom: 20px;">
        <div class="span2">작성자</div>
        <div class="span8">${reg_id}</div>
        <div class="span2">&nbsp;</div>
    </div>
	
	
</mvc:layout>