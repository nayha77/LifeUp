<%@ page language="java" contentType="text/html; charset=UTF-8"%>
			<div data-role="header">
				<h1>지유! 천하!</h1>
				<a href="#nav-panel" data-icon="bars" data-iconpos="notext">Menu</a>
			</div><!-- /header -->
			
			<div data-role="panel" data-display="push" data-theme="b" id="nav-panel">
	
				<ul data-role="listview">
		            <li data-icon="delete"><a href="#" data-rel="close">메뉴 닫기</a></li>
		            <li><a href='<spring:url value="/"/>'>HOME</a></li>
	                <li><a href='<spring:url value="/notice/post"/>'>공지사항</a></li>
	                <li><a href="#panel-responsive-page2">FAQ</a></li>
	                <li><a href="#panel-responsive-page2">의뢰목록</a></li>
				  	<c:if test="${not empty sessionScope._USER_INFO_ && sessionScope._USER_INFO_.userType == '1'}">
				  		<li><a href="#panel-responsive-page2">견적의뢰</a></li>
				  	</c:if>
	                <li><a href="#panel-responsive-page2">영업랭킹</a></li>	                	                
		        </ul>
		        
		    </div><!-- /panel -->