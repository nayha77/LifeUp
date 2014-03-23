<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang='ko'>
<head>
<meta charset='utf-8'>
</head>
<body>
	<div data-role="page" class="jqm-demos ui-responsive-panel" id="loginPage">

		<%@ include file="../include/header.jsp" %>
		
		<div class="ui-content jqm-content jqm-fullwidth" style="padding-top: 0px;">			
			<div style="padding-top: 0px;">
				<form id="frmUserLogin" class="userform" style="padding-left: 5px; padding-right: 5px;">
					<input type="hidden" id="saveYn" name="saveYn" />				
					
					<div class="switch">
					    <fieldset data-role="controlgroup" data-theme="b" data-type="horizontal">
					        <input type="radio" name="userType" id="radio-choice-t-4a" value="1">
					        <label for="radio-choice-t-4a">일반</label>
					        <input type="radio" name="userType" id="radio-choice-t-4c" value="2">
					        <label for="radio-choice-t-4c">영업사원</label>
					    </fieldset>					
					</div>
					<label for="name">아이디 (이메일)</label>
					<input type="text" name="userId" id="txtUser" data-mini="true" onKeypress="fnEnterKey('I');">						
					<label for="password">비밀번호</label>
					<input type="password" name="password" id="txtUserPwd" data-clear-btn="true" autocomplete="off" data-mini="true" onKeypress="fnEnterKey('P');">				
					<div class="ui-grid-a" data-position="fixed">
						<div class="ui-block-a" style="width:30%">
							<label for="name" style="width:65px; padding-top: 10px;">아이디 저장
								<input type="checkbox" name="autoLogin" id="chkAutoLogin" data-mini="true" checked="checked">
							</label>																 
						</div>
						<div class="ui-block-b" style="width:20%"></div>
						<div class="ui-block-c" style="width:50%; text-align: right;">
							<a href="#" data-rel="close" data-inline="true" data-role="button" data-theme="c" data-mini="true" onClick="fnLogin();">로그인</a>
						</div>				    
					</div>							
					<div class="ui-field-contain" style="margin-top : 0px;">
						<div class="ui-block-a" style="width: 100%; text-align: right;">
							<a href="#" data-icon="plus" data-iconpos="notext" onclick="fnOpenFindUser('P');" style="text-decoration: none; font-size: 14px;">비밀번호 찾기</a> |
							<a href="#" data-icon="plus" data-iconpos="notext" onclick="fnOpenFindUser('U');" style="text-decoration: none; font-size: 14px;">사용자 찾기</a> | 
							<a href="#" data-icon="plus" data-iconpos="notext" onclick="_Commn.fnPageMove('<spring:url value="/account/membership" />');" style="text-decoration: none; font-size: 14px;">회원가입</a>
						</div>
					</div>	
				</form>	
				<form id="frmFindUserInfo" class="userform" style="display: none;">		
				    <fieldset data-role="controlgroup" data-theme="b" data-type="horizontal">
				        <input type="radio" name="fUserType" id="radio-choice-t-4a" value="1" checked="checked">
				        <label for="radio-choice-t-4a">일반</label>
				        <input type="radio" name="fUserType" id="radio-choice-t-4c" value="2">
				        <label for="radio-choice-t-4c">영업사원</label>
				    </fieldset>										
					<label for="name">아이디 (이메일)</label>
					<input type="text" name="txtFUserId" id="txtFUserId" data-mini="true">						
					<div class="ui-grid-a" data-position="fixed">
						<div class="ui-block-a" style="width:30%"></div>
						<div class="ui-block-b" style="width:70%; text-align: right;">
							<a href="#" data-rel="close" data-inline="true"data-role="button" data-theme="c" data-mini="true" onClick="fnFindUser();">사용자 찾기</a>
							<a href="#frmUserLogin" data-inline="true" data-rel="close" data-role="button" data-theme="b" data-mini="true">취소</a>
						</div>
				    </div>		    								    			
				</form>			
			</div>	
		</div>	
	</div><!-- /page -->

</html>