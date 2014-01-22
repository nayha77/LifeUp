<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
<title>HK</title>
<script src='<spring:url value="/resources/js/jquery.js"/>'></script>
<script src='<spring:url value="/resources/js/webService.js"/>'></script>
<script src='<spring:url value="/resources/js/html5.js"/>'></script>
<script type="text/javascript">
	var _Commn = new webService.Web.ComnService();
	var _Async = new webService.Web.AsyncService(_Commn.fnBeforRun, _Commn.fnAfterRun);
		
	function fnModifyPwd() {
		if($("#txtEmail").val() != "" && $("#txtPwd").val() != "")
			document.frm.submit();
		else
			alert("입력정보를 확인하세요");
	}		
</script>	
</head>
<body>
	<c:if test="${empty message}">
		<form name="frm" action="/account/tryModifyPwd" method="post">
			<div style="margin-left: 50px;">		
				<label>사용자ID</label>        	
				<input type="text" id="txtUserId" name="userId" value="${user.userId}" readOnly="readonly" />
				<label>EMAIL</label>		
				<input type="text" id="txtEmail" name="email" />
				<span>비밀번호</span>			
				<input type="password" id="txtPwd" name="password" />				    
				<input type="hidden" id="hdnUserType" name="userType" value="${user.userType}" />
			</div>
			<div>
				<input type="button" id="btnUpdate" value="변경" onClick="fnModifyPwd();" />
				<input type="button" id="btnLogin" value="로그인" onClick="document.location.href='/login';" />
			</div>
		</form>	
	</c:if>
	<c:if test="${not empty message}">
		<span>${message}</span>
	</c:if>
</body>
</html>