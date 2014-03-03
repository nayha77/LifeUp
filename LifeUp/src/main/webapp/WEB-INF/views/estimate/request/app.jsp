<%@ page language="java" contentType="text/html; charset=UTF-8"%>

<%@ taglib prefix="mvc" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<mvc:main>
<c:out value='${user_id}'></c:out>
<c:out value='${user_pw}'></c:out>
<c:out value='${user_hpid}'></c:out>
</mvc:main>