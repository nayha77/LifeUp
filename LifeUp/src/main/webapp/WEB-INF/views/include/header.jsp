<%@ page language="java" contentType="text/html; charset=UTF-8"%>

<div data-role="header" style="padding-top:3px; padding-bottom :3px;">
	<h1 id="pageTitle">견적의신</h1>						
	<a href="#" id="btnBack" data-icon="arrow-l" data-iconpos="notext" style="margin-top: 3px;">이전</a>
	<a href="#nav-panel" data-position="right" data-reveal="reveal" data-dismissible="true" data-icon="bars" data-iconpos="notext" style="margin-top: 3px;">Menu</a>
</div>	
<div data-role="panel" data-position-fixed="false" data-dismissible="true" class="ui-responsive-panel" data-display="overlay" data-theme="b" id="nav-panel" style="width:160px;">	
	<ul data-role="listview">
		<li>
			<c:if test="${empty sessionScope._USER_INFO_}">
				<a href="#" onclick="_Commn.fnPageMove('<spring:url value="/account/login" />')" id="menuLogin" data-icon="user" data-iconpos="notext" style="height:30px; padding-top: 18px; border-right-width: 0px;">로그인</a>				
			</c:if>
			<c:if test="${not empty sessionScope._USER_INFO_}">
				<a href="#" onclick="_Commn.fnPageMove('<spring:url value="/account/logout" />')" data-icon="forward" data-iconpos="notext" style="height:30px; padding-top: 18px; border-right-width: 0px;">로그아웃</a>
			</c:if>				
			
			<a href="#" data-rel="close" data-icon="delete" style="height:60px; border-left-width: 0px;"></a>
		</li>
		<li><a href="#" onclick="_Commn.fnPageMove('<spring:url value="/main" />')" id="menuMain" class="leftMenu" style="background-color:#38c; height:30px; padding-top: 18px;">HOME</a></li>
		<c:if test="${not empty sessionScope._USER_INFO_}">
			<li><a href="#" onclick="_Commn.fnPageMove('<spring:url value="/mypage/list" />')" id="menuMyInfo" class="leftMenu" style="height:30px; padding-top: 18px;">내정보</a></li>							
		</c:if>	 				
		<li><a href="#" onclick="_Commn.fnPageMove('<spring:url value="/board/Notice" />')" id="menuNotice" class="leftMenu" style="height:30px; padding-top: 18px;">공지사항</a></li>
		<li><a href="#" onclick="_Commn.fnPageMove('<spring:url value="/board/FAQ" />')" id="menuFAQ" class="leftMenu" style="height:30px; padding-top: 18px;">FAQ</a></li>
		<li><a href="#" onclick="_Commn.fnPageMove('<spring:url value="/request/list" />')" id="menuRequest" class="leftMenu" style="height:30px; padding-top: 18px;">의뢰목록</a></li>
		<li><a href="#" onclick="_Commn.fnPageMove('<spring:url value="/request/list" />')" id="menuRanking" class="leftMenu" style="height:30px; padding-top: 18px;">영업랭킹</a></li>																					
	</ul>	    
</div>		