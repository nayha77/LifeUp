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
	<script type="text/javascript">	
		$(document).on("pagebeforeshow", function() {	
			// 선택 메뉴 마킹
			_Commn.fnMarkingLeftMenu($("#menuFAQ"));
		});				
	</script> 	
</head>
<body>
	<div data-role="page" class="jqm-demos ui-responsive-panel" id="faqPage">

		<%@ include file="../include/header.jsp" %>
		
		<div class="ui-content jqm-content jqm-fullwidth" style="padding-top: 0px;">
			<div data-role="collapsibleset" data-theme="a" data-content-theme="b">
			    <div data-role="collapsible">
			    <h2>핸드폰 앱으로도 지원이 되나요?</h2>
			        <ul data-role="listview" data-theme="a" data-divider-theme="b">
			            <li><p><strong>구글 마켓에서 앱을 다운받아 서비스를 이용하실 수 있습니다</strong></p></li>
			        </ul>
			    </div>		    	
			    <div data-role="collapsible">
			    <h2>사용자(일반/영업사원)는 어떻게 구분하나요?</h2>
			        <ul data-role="listview" data-theme="a" data-divider-theme="b">
			            <li><p><strong>일반사용자는 견적을 의뢰하고 영업사원은 해당 견적에 대한 견적을 제시합니다</strong></p></li>
			        </ul>
			    </div>	
			    <div data-role="collapsible">
			    <h2>견적의뢰 등록을 했는데 영업사원이 견적을 제안 한 것을 어떻게 알 수 있나요?</h2>
			        <ul data-role="listview" data-theme="a" data-divider-theme="b">
			            <li><p><strong>웹사이트에서 확인이 가능하고, 앱을 설치한 사용자의 경우 문자 알림으로 알 수 있습니다</strong></p></li>
			        </ul>
			    </div>
			    <div data-role="collapsible">
			    <h2>서비스 사용 중 오류가 발생한 경우 어떻게 하나요?</h2>
			        <ul data-role="listview" data-theme="a" data-divider-theme="b">
			            <li><p><strong>xxx@gmail.com으로 해당 내용을 남겨주세요</strong></p></li>
			        </ul>
			    </div>		    
			</div>
		</div>	
	</div><!-- /page -->
</html>