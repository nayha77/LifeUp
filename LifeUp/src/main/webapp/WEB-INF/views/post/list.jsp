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

<div data-role="page" class="jqm-demos ui-responsive-panel" id="panel-responsive-page1"  >

	<div data-role="header">
		<h1>지유! 천하!</h1>
		<a href="#nav-panel" data-icon="bars" data-iconpos="notext">Menu</a>
	</div><!-- /header -->
	
	<div role="main" class="ui-content jqm-content jqm-fullwidth">
	
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
	        
	</div><!-- /content -->
		    
	<div data-role="panel" data-display="push" data-theme="b" id="nav-panel">

		<ul data-role="listview">
            <li data-icon="delete"><a href="#" data-rel="close">메뉴 닫기</a></li>
	            
                <!-- <li><a href="#panel-responsive-page2">Q&A</a></li> -->
                <li><a href='<spring:url value="/notice/post"/>'>공지사항</a></li>
                <li><a href="#panel-responsive-page2">FAQ</a></li>
                <li><a href="#panel-responsive-page2">의뢰목록</a></li>
			  	<c:if test="${not empty sessionScope._USER_INFO_ && sessionScope._USER_INFO_.userType == '1'}">
		  		<li><a href="#panel-responsive-page2">견적의뢰</a></li>
			  	</c:if>
                <li><a href="#panel-responsive-page2">영업랭킹</a></li>	                	                
        </ul>
    </div><!-- /panel -->

</div>

</body>

</html>