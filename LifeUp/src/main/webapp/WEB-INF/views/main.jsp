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
  <style>
  .panel-content {
    padding: 1em;
  }
  </style>
</head>
<body> 

	<div data-role="page" class="jqm-demos ui-responsive-panel" id="panel-responsive-page1"  >
	
			<div data-role="header">
				<h1>지유! 천하!</h1>
				<a href="#nav-panel" data-icon="bars" data-iconpos="notext">Menu</a>
			</div><!-- /header -->
		
		    <div role="main" class="ui-content jqm-content jqm-fullwidth">
		        <h1>불편한 CSS 걷어내기 </h1>
	   	        <h4>편할려고 만들었더만 발목잡네 ~~ </h4>
	   	        <h4>좀더 개발자 스러운 <a href="http://demos.jquerymobile.com/1.4.2/">jQueryMobile</a> 적용 </h4>
		        <div data-demo-html="#panel-responsive-page1"></div><!--/demo-html -->
	   	        <div data-demo-html="#panel-responsive-page2"></div><!--/demo-html -->
		        <br>
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
	
	</div><!-- /page -->
<!-- div 로 나누어도 되고 페이지로 나누어도 가능함 -->
	<div data-role="page" class="jqm-demos ui-responsive-panel" id="panel-responsive-page2"  >
	
		<div data-role="header">
			<h1>이동한 페이지</h1>
			<a href="#nav-panel" data-icon="bars" data-iconpos="notext">Menu</a>
		</div><!-- /header -->
		
			<ul data-role="listview" data-count-theme="b" data-inset="true">
			    <li><a href="#">견적1 <span class="ui-li-count">12</span></a></li>
			    <li><a href="#">견적2 <span class="ui-li-count">0</span></a></li>
			    <li><a href="#">견적3 <span class="ui-li-count">4</span></a></li>
			    <li><a href="#">견적4<span class="ui-li-count">328</span></a></li>
			    <li><a href="#">견적5 <span class="ui-li-count">62</span></a></li>
			</ul>		
		
	<a href="../" data-rel="back" data-ajax="false" class="ui-btn ui-shadow ui-corner-all ui-mini ui-btn-inline ui-icon-carat-l ui-btn-icon-left ui-alt-icon ui-nodisc-icon">Back</a>
	</div>

</body>
</html>