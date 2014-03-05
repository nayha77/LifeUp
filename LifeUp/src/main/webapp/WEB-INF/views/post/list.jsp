<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html> 
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>MAIN </title>
  <link rel="stylesheet" href="//code.jquery.com/mobile/1.4.2/jquery.mobile-1.4.2.min.css">
  <script src="//code.jquery.com/jquery-1.10.2.min.js"></script>
  <script src="//code.jquery.com/mobile/1.4.2/jquery.mobile-1.4.2.min.js"></script>
</head>
<body>   

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
    <tr onclick="document.location.href='<spring:url value="/${board.name}/post/${post.id}"/>';" style="cursor: pointer;">
        <td class="txt_c">${post.id}</td>
        <td>${post.title}</td>
        <td class="txt_c">${post.reg_id}</td>
    </tr>
    </c:forEach>
    </tbody>
    </table>
    
    <a href='<spring:url value="/${board.name}/post/new"/>' class='btn'>글쓰기</a>    

</body>

</html>