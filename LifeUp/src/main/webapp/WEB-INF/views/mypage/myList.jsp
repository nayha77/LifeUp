<%@ page language="java" contentType="text/html; charset=UTF-8"%>

<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang='ko'>
<head>
<meta charset='utf-8'>
	<title>Mypage</title>
	<meta name="viewport" content="user-scalable=no,   width=device-width,  target-densitydpi=device-mdpi">
	<meta name='description' content=''>
	<meta name='author' content=''>
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=IE8" />
	
	<link rel="stylesheet" href="http://code.jquery.com/mobile/1.4.2/jquery.mobile-1.4.2.min.css">
	<script src="http://code.jquery.com/jquery-1.10.2.min.js"></script>
	<script src="http://code.jquery.com/ui/1.10.4/jquery-ui.js"></script>
  	<script src="http://code.jquery.com/mobile/1.4.2/jquery.mobile-1.4.2.min.js"></script>

</head>
<body>

	<div data-role="page" class="jqm-demos ui-responsive-panel" id="mainPage">
		<div data-role="header">
			<h1>마이 페이지 </h1>			
			<a href="#nav-panel" data-icon="bars" data-iconpos="notext">Menu</a>
			
			<c:if test="${empty sessionScope._USER_INFO_}">
				<a href="#right-panel" id="lnklogin">로그인</a>				
			</c:if>
			<c:if test="${not empty sessionScope._USER_INFO_}">
				<a href="<spring:url value="/account/logout" />">로그아웃</a>
			</c:if>
		</div>
		<div data-role="panel" data-display="push" data-theme="b" id="nav-panel">	
			<ul data-role="listview">
				<li data-icon="delete"><a href="#" data-rel="close" style="height:30px; padding-top: 18px;">닫기</a></li>
				<li><a href="<spring:url value="/main" />" style="height:30px; padding-top: 18px;">HOME</a></li>
				<c:if test="${not empty sessionScope._USER_INFO_}">
					<li><a href='#' onclick="fnMyInfo();" style="height:30px; padding-top: 18px;">내정보</a></li>							
				</c:if>	 				
				<li><a href="/request/list" style="height:30px; padding-top: 18px;">의뢰목록</a></li>
				<li><a href="/request/list" style="height:30px; padding-top: 18px;">영업랭킹</a></li>																					
				<li><a href="/board/Notice" style="height:30px; padding-top: 18px;">공지사항</a></li>
				<li><a href="/board/FAQ" style="height:30px; padding-top: 18px;">FAQ</a></li>
			</ul>	    
		</div>		
		<!-- content Start -->		
		<div class="ui-content jqm-content jqm-fullwidth" style="padding-top: 0px;">
		
			<div data-role="tabs" id="tabs">
			  <div data-role="navbar">
			    <ul>
			      <li><a href="#one" data-ajax="false">내견적 리스트</a></li>
			      <li><a href="#two" data-ajax="false">내정보 수정</a></li>
			      <li><a href="ajax-content.html" data-ajax="false">알림 수정</a></li>
			    </ul>
			  </div>
			  <div id="one" >
			     <ul data-role="listview" data-inset="true">
					<c:forEach items="${mypageList}" var="list">			     
				        <li><a href="#">${list.customer_req}</a></li>
				    </c:forEach> 
		    	</ul>
			  </div>
			  <div id="two" class="ui-body-d ui-content">
					내정보 ...
			  </div>
		  
			</div>
		</div> <!-- end content -->
	</div> <!-- end Page -->
	
</body>
</html>