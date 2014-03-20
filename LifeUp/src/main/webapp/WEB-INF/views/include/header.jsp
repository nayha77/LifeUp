<%@ page language="java" contentType="text/html; charset=UTF-8"%>

		<div data-role="header" style="padding-top:3px; padding-bottom :3px;">
			<h1>견적의신</h1>			
			<a href="#nav-panel" data-icon="bars" data-iconpos="notext" style="margin-top: 5px;">Menu</a>
			
			<c:if test="${empty sessionScope._USER_INFO_}">
				<a href="#right-panel" id="lnklogin" data-icon="user" data-iconpos="notext" style="margin-top: 5px;">로그인</a>				
			</c:if>
			<c:if test="${not empty sessionScope._USER_INFO_}">
				<a href="/account/logout" rel="external" data-icon="forward" data-iconpos="notext" style="margin-top: 5px;">로그아웃</a>
			</c:if>
		</div>	
		<div data-role="panel" data-display="overlay" data-theme="b" id="nav-panel" style="width:160px;">	
			<ul data-role="listview">
				<li data-icon="delete"><a href="#" data-rel="close" style="height:30px; padding-top: 18px;">닫기</a></li>
				<li><a href="#" onclick="_Commn.fnPageMove('<spring:url value="/main" />')" id="menuMain" class="leftMenu" style="height:30px; padding-top: 18px;">HOME</a></li>
				<c:if test="${not empty sessionScope._USER_INFO_}">
					<li><a href="/mypage/list" rel="external" id="menuMyInfo" class="leftMenu" style="height:30px; padding-top: 18px;">내정보</a></li>							
				</c:if>	 				
				<li><a href="/board/Notice" rel="external" id="menuNotice" class="leftMenu" style="height:30px; padding-top: 18px;">공지사항</a></li>
				<li><a href="/board/FAQ" rel="external" id="menuFAQ" class="leftMenu" style="height:30px; padding-top: 18px;">FAQ</a></li>
				<li><a href="/request/list" rel="external" id="menuRequest" class="leftMenu" style="height:30px; padding-top: 18px;">의뢰목록</a></li>
				<li><a href="/request/list" rel="external" id="menuRanking" class="leftMenu" style="height:30px; padding-top: 18px;">영업랭킹</a></li>																					
			</ul>	    
		</div>	
		<div data-role="panel" data-position="right" data-position-fixed="false" data-display="overlay" id="right-panel" data-theme="b">
			<form id="frmUserLogin" class="userform" style="padding-left: 5px; padding-right: 5px;">
				<h2>로그인</h2>
				<div class="switch">
				    <fieldset data-role="controlgroup" data-theme="b" data-type="horizontal">
				        <input type="radio" name="userType" id="radio-choice-t-4a" value="1" >
				        <label for="radio-choice-t-4a">일반</label>
				        <input type="radio" name="userType" id="radio-choice-t-4c" value="2">
				        <label for="radio-choice-t-4c">영업사원</label>
				    </fieldset>					
				</div>
				<label for="name">ID (Email)</label>
				<input type="text" name="userId" id="txtUser" data-mini="true" onKeypress="fnEnterKey('I');">						
				<label for="password">Password</label>
				<input type="password" name="password" id="txtUserPwd" data-clear-btn="true" autocomplete="off" data-mini="true" onKeypress="fnEnterKey('P');">				
				<label for="name" style="width:45px;">ID저장
					<input type="checkbox" name="autoLogin" id="chkAutoLogin" data-mini="true" checked="checked">
				</label>
				<div class="ui-grid-a">
					<div class="ui-block-a"><a href="#" rel="external" data-rel="close" data-role="button" data-theme="c" data-mini="true" onClick="fnLogin();">로그인</a></div>
				    <div class="ui-block-b"><a href="#" data-rel="close" data-role="button" data-theme="b" data-mini="true">취소</a></div>				    
				</div>							
				<div class="ui-grid-a">
					<label for="text"><a href="#" data-icon="plus" data-iconpos="notext" onclick="fnOpenFindUser('U');" style="text-decoration: none; font-size: 14px;">ID를 분실했나요?</a></label>
					<label for="text"><a href="#" data-icon="plus" data-iconpos="notext" onclick="fnOpenFindUser('P');" style="text-decoration: none; font-size: 14px;">비빌번호를 분실했나요?</a></label>
					<label for="name">						
						<a href="#" data-icon="plus" data-iconpos="notext" onclick="document.location.href='<spring:url value="/account/membership"/>';" style="text-decoration: none; font-size: 14px;">계정이 없으신가요?</a>				
					</label>
				</div>	
			</form>	
			<form id="frmFindUserInfo" class="userform" style="display: none;">
				<h2 id="spTitle">사용자찾기</h2>			
			    <fieldset data-role="controlgroup" data-theme="b" data-type="horizontal">
			        <input type="radio" name="fUserType" id="radio-choice-t-4a" value="1" checked="checked">
			        <label for="radio-choice-t-4a">일반</label>
			        <input type="radio" name="fUserType" id="radio-choice-t-4c" value="2">
			        <label for="radio-choice-t-4c">영업사원</label>
			    </fieldset>										
				<label for="name">ID (Email)</label>
				<input type="text" name="txtFUserId" id="txtFUserId" data-mini="true">
				<div class="ui-grid-a">
					<div class="ui-block-a"><a href="#" data-rel="close" data-role="button" data-theme="c" data-mini="true" onClick="fnFindUser();">찾기</a></div>
				    <div class="ui-block-b"><a href="#frmUserLogin" data-rel="close" data-role="button" data-theme="b" data-mini="true">취소</a></div>				    
				</div>								    			
			</form>				
		</div><!-- /panel -->					
