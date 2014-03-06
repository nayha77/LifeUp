<%@ tag language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang='ko'>
<head>
<meta charset='utf-8'>
	<title>저기요</title>
	<meta name='viewport' content='width=device-width, initial-scale=1.0'>
	<meta name='description' content=''>
	<meta name='author' content=''>
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=IE8" />
	
	<link rel="stylesheet" href="http://code.jquery.com/mobile/1.4.2/jquery.mobile-1.4.2.min.css">
	<link href='<spring:url value="/resources/css/loginPanel.css"/>' rel='stylesheet'>	
    	
	<script src="http://code.jquery.com/jquery-1.10.2.min.js"></script>
  	<script src="http://code.jquery.com/mobile/1.4.2/jquery.mobile-1.4.2.min.js"></script>			
	<script src='<spring:url value="/resources/js/webService.js"/>'></script>

    <script type="text/javascript">
		var _Commn = new webService.Web.ComnService();
		var _Async = new webService.Web.AsyncService(_Commn.fnBeforRun, _Commn.fnAfterRun);
        
		$(document).ready(function() {
/*         	var userId = '${cookie.userId.value}';
        	var userType = '${cookie.userType.value}';
        	        
         	if(userId != "") {
        		$('#txtUserID').val(userId); 
        		$('input:radio[name=userType]:input[value='+userType+']').attr("checked", true);        		
        		$('#chkAutoLogin').attr('checked', true);
        		$('#txtUserPwd').focus();
        	} else {        	
        		$('#txtUserID').focus();
        	} */
        	
			fnLoad();
		});	
                
        function fnEnterKey(type) {
        	if(event.keyCode == 13) {
	        	if(type == "I") 
	        		$('#txtUserPwd').focus();
	        	else if(type == "P") 
	        		fnLogin();
        	}
        }
        
        // 로그인
    	function fnLogin() {    		    	
        	var autoLogin = 'N';
        	
        	if($('#chkAutoLogin').is(":checked"))
        		autoLogin = "Y";        	
        	
      	    _Async.post (
    			"/account/actionLogin.do",
    			JSON.stringify({ userId: $('#txtUser').val(), password: $('#txtUserPwd').val(), userType: $('#ddlUserType option:selected').val() }),
    			function (data) {    
    				if(data.message == 'success' || data.message == 'duplicated') {
    					document.location.href='/main?saveYn=' + autoLogin;
    					sendUserInfoToApp($('#txtUser').val(), $('#txtUserPwd').val(), $('#ddlUserType option:selected').val());
    				} else {
    					alert(data.message);
    				}
    			}
    		);
    	}
        
    	function sendUserInfoToApp(id, pwd, autoSaveYn){
    		window.HybridApp.setMessage(id, pwd);
    	}
    	
    	function fnLoginFromApp(id) {
    		location.href="http://www.naver.com?id=" + id;
    	}
        
        // 사용자찾기
    	function fnFindUser() {
    		var url = "/account/findUser.do";
    		
    		if($("#spTitle").html() == "비밀번호찾기")
    			url = "/account/findPwd.do";
    			
    		_Async.post (
    			url,
    			JSON.stringify({ userId: $('#txtFUserId').val(), userType: $('#findUserModal').find(':input[name=fUserType]:checked').val() }),
    			function (data) {                
    				if(data.message =='success') {
    					$('#txtFUserId').val("");
    					$('#findUserModal').find(':input[name=fUserType][value=1]').attr('checked', true);
    				} else {
    					alert(data.message);
    				}    					    				    		
    			} 
    		);	
    		
			alert('등록된 메일로 전송되었습니다');		    	
    	}        
    	
        // 내정보 
    	function fnMyInfo() {			
      	    _Async.post (
    			"/account/myInfo.do",
    			'',
    			function (data) {                
    				if(data.message == 'success') {
    					$('#myInfoModal').modal('show'); 
    					$("#txtIUserId").val(data.userInfo.userId);
    					$("#txtIUserNm").val(data.userInfo.userNm);    					
    					$("#txtIMobile").val(data.userInfo.mobile);
    					$('#txtIPrevPasswd').focus();
    				}
    			} 
    		);				
    	}  
        
        // 내정보 수정
    	function fnMyInfoUpdate() {

        	if( $('#txtIPasswd').val() == $('#txtIPrevPasswd').val() ) {
        		alert('신규 비밀번호와 이전 비밀번호가 일치합니다');
        		return;
        	} else if( $('#txtIPasswdConfirm').val() != $('#txtIPasswd').val() ) {
        		alert('신규 비밀번호를 확인하세요');
        		return;
        	}
        	
      	    _Async.post (
    			"/account/myInfoUpdate.do",
    			JSON.stringify({ userId: $('#txtIUserId').val(), mobile: $('#txtIMobile').val(), password: $('#txtIPasswd').val(), prevPassword: $('#txtIPrevPasswd').val() }),
    			function (data) {                
    				if(data.message == 'success') {
    					$('#myInfoModal').hide();
    					
    					$('#txtIPasswd').val("");
    					$('#txtIPrevPasswd').val("");
    					$('#txtIPasswdConfirm').val("");
    				} else {
    					alert(data.message);
    				}
    			} 
    		);		
    	}   
        
        // 사용자/비밀번호 찾기 Div Open
        function fnOpenFindUser(title) {
        	if(title == 'U')
        		title = '사용자찾기';
        	else
        		title = '비밀번호찾기';
        	        	       	
        	$('#findUserModal').show(); 
        	$('#spTitle').html(title); 
        	$('#txtFUserId').focus();
        }

    </script>    
</head>
<body>
	<div data-role="page" class="jqm-demos ui-responsive-panel" id="mainPage">
		<div data-role="header">
			<h1>견적의신</h1>			
			<a href="#nav-panel" data-icon="bars" data-iconpos="notext">Menu</a>
			
			<c:if test="${empty sessionScope._USER_INFO_}">
				<a href="#add-form" data-icon="info" data-iconpos="notext">로그인</a>
				<a href="#" data-icon="plus" data-iconpos="notext" onclick="document.location.href='<spring:url value="/account/membership"/>';">회원가입</a>
			</c:if>
			<c:if test="${not empty sessionScope._USER_INFO_}">
				<a href="/logout" data-icon="forward" data-iconpos="notext">로그아웃</a>
			</c:if>
		</div>	
		<div data-role="panel" data-display="push" data-theme="b" id="nav-panel">	
			<ul data-role="listview">
				<li data-icon="delete"><a href="#" data-rel="close">닫기</a></li>
				<li><a href='<spring:url value="/"/>'>HOME</a></li>
				<c:if test="${not empty sessionScope._USER_INFO_}">
					<li><a href='#' onclick="fnMyInfo();">내정보</a></li>							
					<li><a href='#' onclick="fnMyInfo();">내거래현황</a></li>
				</c:if>	 				
				<li><a href='<spring:url value="/notice/post"/>'>공지사항</a></li>
				<li><a href="#panel-responsive-page2">FAQ</a></li>
				<li><a href='<spring:url value="/notice/post"/>'>Q&A</a></li>
				<c:if test="${not empty sessionScope._USER_INFO_ && sessionScope._USER_INFO_.userType == '1'}">
					<li><a href='<spring:url value="/request/writeform"/>'>견적의뢰</a></li>
				</c:if>
				<li><a href='<spring:url value="/request/list"/>'>의뢰목록</a></li>
				<li><a href='<spring:url value="/request/list"/>'>영업랭킹</a></li>																					
				<c:if test="${not empty sessionScope._USER_INFO_ && sessionScope._USER_INFO_.userType == '1'}">
					<li><a href="#panel-responsive-page2">견적의뢰</a></li>
				</c:if>	                	                
			</ul>	    
		</div>	
		<div data-role="panel" data-position="right" data-position-fixed="false" data-display="overlay" id="add-form" data-theme="b">
			<form class="userform">
				<h2>로그인</h2>
				<label for="name">ID (Email)</label>
				<input type="text" name="userId" id="txtUser" data-mini="true" onKeypress="fnEnterKey('I');">
						
				<label for="password">Password</label>
				<input type="password" name="password" id="txtUserPwd" data-clear-btn="true" autocomplete="off" data-mini="true" onKeypress="fnEnterKey('P');">
			
				<div class="switch">
					<label for="status">영업사원 이신가요?</label>
					<select name="userType" id="ddlUserType" data-role="slider" data-mini="true">
					    <option value="1">아니오</option>
					    <option value="2">예</option>
					</select>
				</div>
						
				<label for="name">ID를 저장하시겠습니까?</label>
				<label for="name" style="width:45px;">ID저장
					<input type="checkbox" name="chkAutoLogin" id="chkAutoLogin" data-clear-btn="true" data-mini="true">
				</label>
				<div class="ui-grid-a">
				    <div class="ui-block-a"><a href="#" data-rel="close" data-role="button" data-theme="c" data-mini="true">취소</a></div>
				    <div class="ui-block-b"><a href="#" data-rel="close" data-role="button" data-theme="b" data-mini="true" onClick="fnLogin();">로그인</a></div>
				</div>
			</form>			
		</div><!-- /panel -->			
				
    <div id="findUserModal">
        <div>
			<div style="margin-left: 50px;">
			    <label >사용자</label>
			    <div>
					<input type='radio' id='rdoFUserType' name='fUserType' value='1' checked="checked" />일반사용자 
					<input type='radio' id='rdoFUserType' name='fUserType' value='2' />영업사원
				</div>                
			    <label >아이디(이메일)</label>
			    <div><input type='text' id='txtFUserId' /></div>                
			</div>			                   
        </div>
        <div class="modal-footer">
            <a href="#">취소</a>
            <a onclick="fnFindUser();">찾기</a>            
        </div>
    </div>       	
	<div id="myInfoModal">
	    <div>
			<div style="margin-left: 50px;">
			    <label >사용자 ID(Email)</label>
			    <div><input type="text" id="txtIUserId" readonly="readonly" /></div>
			    <label >성명</label>
			    <div><input type="text" id="txtIUserNm" readonly="readonly" /></div>
			    <label >이동전화</label>
			    <div><input type="text" id="txtIMobile" /></div>
				<label >이전 비밀번호</label>
			    <div><input type="password" id="txtIPrevPasswd" /></div>			    
			    <label >신규 비밀번호</label>
			    <div><input type="password" id="txtIPasswd" /></div>                		    
			    <label >신규 비밀번호 확인</label>
			    <div><input type="password" id="txtIPasswdConfirm" /></div>			    
			</div>
	    </div>
	    <div>
	        <a href="#">취소</a>
	        <a onclick="fnMyInfoUpdate();">수정</a>
	    </div>
	</div>
			
		
		
		<jsp:doBody/>	
	</div><!-- /page -->				
</html>