<%@ page language="java" contentType="text/html; charset=UTF-8"%>

<%@ taglib prefix="mvc" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<mvc:layout>
    <table class="table table-striped">
    <colgroup>
        <col style="width: 60px;">
        <col>
        <col style="width: 80px;">
    </colgroup>
    <thead>
    <tr>
        <th>글번호</th>
        <th>제목</th>
        <th>작성자</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach items="${posts}" var="post">
    <tr onclick="document.location.href='<spring:url value="/${board.name}/post/${post.title}"/>';" style="cursor: pointer;">
        <td class="txt_c">${post.title}</td>
        <td>${post.content}</td>
        <td class="txt_c">${post.title}</td>
    </tr>
    </c:forEach>
    </tbody>
    </table>
    
    <a href='<spring:url value="/${board.name}/post/new"/>' class='btn'>글쓰기</a>    

</mvc:layout>