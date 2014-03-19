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
		$(document).ready(function() {
			_Commn.fnMarkingLeftMenu($("#menuNotice"));
		});	
	</script> 	
</head>
<body>
	<div data-role="page" class="jqm-demos ui-responsive-panel" id="faqPage">

		<%@ include file="../include/header.jsp" %>
		
		<div class="ui-content jqm-content jqm-fullwidth" style="padding-top: 0px;">
			<div data-role="collapsibleset" data-theme="a" data-content-theme="b">
				<c:forEach items="${noticeList}" var="notice" varStatus="status">
			    	<div data-role="collapsible">	    
					    <h2>${notice.TITLE}</h2>
				        <ul data-role="listview" data-theme="a" data-divider-theme="b">
				            <li><p><strong>${notice.CONTENT}</strong></p></li>
				        </ul>				       
				    </div>
				</c:forEach>		
			</div>
		</div>	
	</div><!-- /page -->
</html>