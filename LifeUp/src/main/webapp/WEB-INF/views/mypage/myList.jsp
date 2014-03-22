<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang='ko'>
<head>
<meta charset='utf-8'>
</head>
<body>
	<div data-role="page" class="jqm-demos ui-responsive-panel" id="myPageList">
		
		<%@ include file="../include/header.jsp" %>
		
		<!-- content Start -->		
		<div data-role="content">
			<div data-role="navbar">
			    <ul>
			    	<li><a href="#one" data-tab-class="tab1" data-ajax="true">내견적 리스트</a></li>
			      	<li><a href="#two" class="ui-btn-active" data-tab-class="tab2" data-ajax="true">내정보 수정</a></li>
			      	<li><a href="ajax-content.html" data-tab-class="tab3" data-ajax="true">알림 수정</a></li>
			    </ul>
			</div>		
							
			<div class="tab-content" id="tabs">
				<div id="one" >
					<form id='frm' name='frm' method='post'>
						<input type='hidden' id='hdnRequestId' name='request_id'/>
					</form>			  
				    <ul data-role="listview" data-inset="true">
						<c:forEach items="${mypageList}" var="list">			     
					        <li><a href="#" onclick="fnMyPageReqDetail('${list.req_id}');">${list.customer_req}</a></li>
					    </c:forEach> 
			    	</ul>
				</div>
				<div id="two" class="ui-body-d ui-content">
					<form>
					    <div class="ui-field-contain">
					         <label for="text-12">아이디:</label>
					        <label for="text-12">NAYHA ( 2014년 03월 21일 가입 )</label>
					    </div>				
					    <div class="ui-field-contain">
					         <label for="text-12">전화번호:</label>
					         <input type="text" name="text-12" id="text-12" value="">
					    </div>
					    <div class="ui-field-contain">
							 <label for="password">현재 비밀번호</label>
							 <input type="password" data-clear-btn="true" name="password" id="password" value="" autocomplete="off">
					    </div>	
					    <div class="ui-field-contain">
							 <label for="new_password">새 비밀번호</label>
							 <input type="password" data-clear-btn="true" name="new_password" id="new_password" value="" autocomplete="off">
					    </div>
					    <div class="ui-field-contain">
							 <label for="new_password_2">새 비밀번호 확인</label>
							 <input type="password" data-clear-btn="true" name="password_2" id="password_2" value="" autocomplete="off">
					    </div>					    					    			    
				    </form>					
				</div>		  
			</div>
		</div>
	</div> <!-- end Page -->	     
</body>
</html>