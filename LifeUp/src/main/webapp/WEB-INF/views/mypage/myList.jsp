<%@ page language="java" contentType="text/html; charset=UTF-8"%>

<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang='ko'>
<head>
<meta charset='utf-8'>
	<title>::: HGBURN Mypage:::</title>
	<meta name='viewport' content='width=device-width, initial-scale=1.0'>
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=IE8" />
	
	<link rel="stylesheet" href="http://code.jquery.com/mobile/1.4.2/jquery.mobile-1.4.2.min.css">
	<script src="http://code.jquery.com/jquery-1.10.2.min.js"></script>
	<script src="http://code.jquery.com/ui/1.10.4/jquery-ui.js"></script>
  	<script src="http://code.jquery.com/mobile/1.4.2/jquery.mobile-1.4.2.min.js"></script>
  	
  	<script src='<spring:url value="/resources/js/webService.js"/>'></script>
	<script type="text/javascript">
		var _Commn = new webService.Web.ComnService();
		function fnDetail(requestId) {
			$('#hdnRequestId').val(requestId);
			frm.action = "/request/detail";
			frm.submit();
			//_Commn.fnPageMove("/request/detail", $('#frm'));
		}		
	</script>
	<script src="http://ajax.aspnetcdn.com/ajax/jquery.validate/1.11.1/jquery.validate.js"></script>
	<script type="text/javascript">	
 		function fnValidator() {
				
			$('#frmNormal').validate({
	            rules: {
	            	mobile: { required: true },
	            	password: { required: true, "remote": {
			            		url: '/mypage/chkExistUserPassword',
			            		type: "post",
			                    data: {
			                    	password: function() {
			                            return $('#password').val();
			                        },
			                        user_id: function() {
						                return $('#userID').val();
						            }			
			                    }
			          		} },   
			          		new_password: { required: true },
			          		password_2: { equalTo: "#new_password" }			          		
	
	            },
	            messages: {
	            	mobile: { required: "전화번호를 입력해주세요" },
	            	password: {
	            				required: "현재 비밀번호를 입력하세요.",
	                            remote : jQuery.format("현재 비밀번호와 다릅니다")
	                        },
                   	new_password: { required: "비밀번호를 입력하세요." },
                   	password_2: { equalTo: "비밀번호를 다시 확인하세요." } 	                        

	            }
	        });		
			
 		}
 		function fnValidation() {
 			$('#frmNormal').submit();
 		}
		</script>	

       <script>
       // 내정보 수정하면 여기 타기 ~~
                $(document).on( "pagebeforeshow", function() {
                    // This example will work because it was bind with event delegation process            
                 $('a[href="#two"]').click();
                    // This example will work because element exist in a DOM during the pagebeforeshow event

             	fnValidator();      
                });
       
        </script>
		
</head>
<body>

	<div data-role="page" class="jqm-demos ui-responsive-panel" id="mainPage">
		<div data-role="header">
			<h1>마이 페이지 </h1>			
			<a href="#nav-panel" data-icon="bars" data-iconpos="notext">Menu</a>
			
			<c:if test="${empty sessionScope._USER_INFO_}">
				<a href="#right-panel" id="lnklogin">로그인</a>				
			</c:if>
			<c:if test="${not empty sessionScope._USER_INFO_}">
				<a href="<spring:url value="/account/logout" />">로그아웃</a>
			</c:if>
		</div>
		<div data-role="panel" data-display="push" data-theme="b" id="nav-panel">	
			<ul data-role="listview">
				<li data-icon="delete"><a href="#" data-rel="close" style="height:30px; padding-top: 18px;">닫기</a></li>
				<li><a href="<spring:url value="/main" />" style="height:30px; padding-top: 18px;">HOME</a></li>
				<c:if test="${not empty sessionScope._USER_INFO_}">
					<li><a href='#' onclick="fnMyInfo();" style="height:30px; padding-top: 18px;">내정보</a></li>							
				</c:if>	 				
				<li><a href="/request/list" style="height:30px; padding-top: 18px;">의뢰목록</a></li>
				<li><a href="/request/list" style="height:30px; padding-top: 18px;">영업랭킹</a></li>																					
				<li><a href="/board/Notice" style="height:30px; padding-top: 18px;">공지사항</a></li>
				<li><a href="/board/FAQ" style="height:30px; padding-top: 18px;">FAQ</a></li>
			</ul>	    
		</div>		
		<!-- content Start -->		
		<div class="ui-content jqm-content jqm-fullwidth" style="padding-top: 0px;">
		
			<div data-role="tabs" id="tabs">
			  <div data-role="navbar">
			    <ul>
			      <li><a href="#one" data-ajax="false" >내견적 리스트</a></li>
			      <li><a href="#two" data-ajax="false">내정보 수정</a></li>
			      <li><a href="ajax-content.html" data-ajax="false">알림 수정</a></li>
			    </ul>
			  </div>
			  <div id="one" >
				<form id='frm' name='frm' method='post'>
				<input type='hidden' id='hdnRequestId' name='request_id'/>
				</form>			  
			     <ul data-role="listview" data-inset="true">
			     <c:out value="${sessionScope._USER_INFO_.userType}"></c:out>
					<c:forEach items="${mypageList}" var="list">			     
						<c:choose>
						<c:when test="${sessionScope._USER_INFO_.userType == '1'}"> 
						 <li><a href="#" onclick="fnMyPageReqDetail('${list.req_id}');">${list.customer_req}</a></li>
						</c:when>
						<c:when test="${sessionScope._USER_INFO_.userType == '2'}">
						<li><a href="#" onclick="fnMyPageReqDetail('${list.req_id}');">${list.salesman_benefit}</a></li> 
						</c:when>
						<c:otherwise>데이타 없습니다. </c:otherwise>
						</c:choose>
				    </c:forEach> 
		    	</ul>
			  </div>
			  <div id="two" class="ui-body-d ui-content">
				<form id='frmNormal' name='frmNormal' method='post' >
				<input type='hidden' id='userID' name='userID' value="${sessionScope._USER_INFO_.userId}"/>
				    <div class="ui-field-contain">
			        <label for="text-12">아이디:</label>
			        <label for="text-12">${sessionScope._USER_INFO_.userId} ( 2014년 03월 21일 가입 )</label>
				    </div>				
				    <div class="ui-field-contain">
			         <label for="mobile">전화번호</label>
			         <input type="text" data-clear-btn="true" id='txtmobile' name='mobile' />			         
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
<a href="#" data-role="button" data-icon="plus" data-inline="true" data-mini="true" onclick="fnValidation();">정보수정</a>				    			    					    			    
			    </form>					
			  </div>
		  
			</div>
		</div> <!-- end content -->
	</div> <!-- end Page -->
			

</body>
</html>