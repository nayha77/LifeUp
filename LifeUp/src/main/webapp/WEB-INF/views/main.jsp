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
 	<meta http-equiv="Cache-Control" content="no-cache"/> 
	<meta http-equiv="Expires" content="0"/> 
	<meta http-equiv="Pragma" content="no-cache"/>
	
	<link rel="stylesheet" href="http://code.jquery.com/mobile/1.4.2/jquery.mobile-1.4.2.min.css">
	<link rel="stylesheet" href="http://code.jquery.com/ui/1.10.4/themes/smoothness/jquery-ui.css">
	<link href='<spring:url value="/resources/css/loginPanel.css"/>' rel='stylesheet'>	  	
    	
	<script src="http://code.jquery.com/jquery-1.10.2.min.js"></script>		
	<script src="http://code.jquery.com/ui/1.10.4/jquery-ui.js"></script>
  	<script src="http://code.jquery.com/mobile/1.4.2/jquery.mobile-1.4.2.min.js"></script>
  	<script src='<spring:url value="http://ajax.aspnetcdn.com/ajax/jquery.validate/1.11.1/jquery.validate.js"/>'></script>			
	
	<script src="<spring:url value="/resources/js/jquery.cookies.js"/>"></script>
	<script src='<spring:url value="/resources/js/webService.js"/>'></script>
	
    <script type="text/javascript">
		var _Commn = new webService.Web.ComnService();
		var _Async = new webService.Web.AsyncService(_Commn.fnBeforRun, _Commn.fnAfterRun);					
        
		$(document).on('pageinit', '#mainPage', function() {    			
    		_Commn.fnMarkingLeftMenu($("#mainPage").find("a[id='menuMain']"));			
    	}); 
		
    	function sendUserInfoToApp(id, pwd, userType){
    		if(typeof window.HybridApp != 'undefined')
    			window.HybridApp.setMessage(id, pwd, userType);
    	}   
    	
    	$(function() {    		
    		var userId   = '${cookie.userId.value}'; 
    		var userType = '${cookie.userType.value}';

    		$.removeCookie("userId");
			$.removeCookie("userType");
    		
    		if('${cookie.userId.value}' != '') {    		
				$.cookie("userId", userId, { path: '/', expires: 365 });
				$.cookie("userType", userType, { path: '/', expires: 365 });
    		}    		
    	});    	
    </script>    
    
	<script src='<spring:url value="/resources/js/login.js"/>'></script>	
	<script src='<spring:url value="/resources/js/membership.js"/>'></script>
	<script src='<spring:url value="/resources/js/myPageList.js"/>'></script>
	<script src='<spring:url value="/resources/js/requestList.js"/>'></script>
	<script src='<spring:url value="/resources/js/requestDetail.js"/>'></script>
	<script src='<spring:url value="/resources/js/requestWriteFrm.js"/>'></script>	
	<script src='<spring:url value="/resources/js/contractDetail.js"/>'></script>
	<script src='<spring:url value="/resources/js/contractFrm.js"/>'></script>
	<script src='<spring:url value="/resources/js/noticeList.js"/>'></script>
	<script src='<spring:url value="/resources/js/faqList.js"/>'></script>    
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
