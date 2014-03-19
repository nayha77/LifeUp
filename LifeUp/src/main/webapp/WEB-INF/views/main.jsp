<%@ page language="java" contentType="text/html; charset=UTF-8"%>
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
	<link rel="stylesheet" href="http://code.jquery.com/ui/1.10.4/themes/smoothness/jquery-ui.css">
	<link href='<spring:url value="/resources/css/loginPanel.css"/>' rel='stylesheet'>	
    	
	<script src="http://code.jquery.com/jquery-1.10.2.min.js"></script>
	<script src="http://code.jquery.com/ui/1.10.4/jquery-ui.js"></script>
  	<script src="http://code.jquery.com/mobile/1.4.2/jquery.mobile-1.4.2.min.js"></script>
  	<script src='<spring:url value="http://ajax.aspnetcdn.com/ajax/jquery.validate/1.11.1/jquery.validate.js"/>'></script>			
	<script src='<spring:url value="/resources/js/webService.js"/>'></script>

    <script type="text/javascript">
		var _Commn = new webService.Web.ComnService();
		var _Async = new webService.Web.AsyncService(_Commn.fnBeforRun, _Commn.fnAfterRun);

		// 로그인/찾기 패널 토글  및 쿠키정보값 설정
		$(function(){
 		    $('a[href=#frmUserLogin]').click(function(){
		        var panel = $(this).attr('href');
		        $(panel).toggle();
		        
	        	$('#frmUserLogin').show();
	        	$('#frmFindUserInfo').hide();
	        	
		        return false;
		    });
 			
		    $('a[href=#right-panel]').click(function(){
				var userId = '${cookie.userId.value}';
	        	var userType = '${cookie.userType.value}';	   	        	        	
        		
	         	if(userId != "" && userType != "") {
	        		$('#txtUser').val(userId); 
	        		$('input:radio[name=userType]:input[value='+userType+']').attr("checked", true).checkboxradio("refresh");        
	        		$('#txtUserPwd').focus();
	        	} else {        	
	        		$('input:radio[name=userType]:input[value="1"]').attr("checked", true).checkboxradio("refresh");
	        		$('#txtUserID').focus();
	        	}
		    });		    
		});		
		
        // 사용자/비밀번호 찾기 Div Open
        function fnOpenFindUser(title) {
			if(title == 'U') {
        		title = '사용자찾기';
        	} else {
        		title = '비밀번호찾기';
        	}
        	
         	$('#spTitle').html(title); 
        	$('#txtFUserId').focus();
        	        	
        	$('#frmUserLogin').hide();
        	$('#frmFindUserInfo').show();        	
 		}
        
		// 로그인 엔터입력
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
    			JSON.stringify({ userId: $('#txtUser').val(), password: $('#txtUserPwd').val(), userType: $('input[name=userType]:checked').val() }),
    			function (data) {    
    				if(data.message == 'success' || data.message == 'duplicated') {
    					document.location.href='/main?saveYn=' + autoLogin;
    					sendUserInfoToApp($('#txtUser').val(), $('#txtUserPwd').val(), $('input[name=userType]:checked').val());
    				} else {
    					alert(data.message);    					
    				}
    			}
    		);
    	}
        
    	function sendUserInfoToApp(id, pwd, userType){
    		window.HybridApp.setMessage(id, pwd, userType);
    	}    	    
        
        // 사용자찾기
    	function fnFindUser() {
    		var url = "/account/findUser.do";
    		
    		if($("#spTitle").html() == "비밀번호찾기")
    			url = "/account/findPwd.do";
    			
    		_Async.post (
    			url,
    			JSON.stringify({ userId: $('#txtFUserId').val(), userType: $('input[name=fUserType]:checked').val() }),
    			function (data) {                
    				if(data.message =='success') {
    					$('#txtFUserId').val("");
    					$('input:radio[name=fUserType]:input[value="1"]').attr("checked", true).checkboxradio("refresh");
    				} else {
    					alert(data.message);
    				}    					    				    		
    			} 
    		);	    				    
    	}
    </script>    
</head>
<body>
	<div data-role="page" class="jqm-demos ui-responsive-panel" id="mainPage">

		<%@ include file="include/header.jsp" %>
		
		<div data-role="content" class="ui-content jqm-content jqm-fullwidth" style="padding-top: 0px;">		
	        <h4>좀더 개발자 스러운 <a href="http://demos.jquerymobile.com/1.4.2/">jQueryMobile</a> 적용 </h4>
		    <div data-demo-html="#panel-responsive-page1"></div><!--/demo-html -->
		       <div data-demo-html="#panel-responsive-page2"></div><!--/demo-html -->
		    <br>
		</div>		
	</div><!-- /page -->
</html>
