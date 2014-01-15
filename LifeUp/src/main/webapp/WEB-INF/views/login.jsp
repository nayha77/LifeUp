<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<html>
<head>
<title>로그인</title>
<script src='<spring:url value="/resources/js/jquery.js"/>'></script>
<script src='<spring:url value="/resources/js/webService.js"/>'></script>
<script type="text/javascript">
	var _Commn = new webService.Web.ComnService();
	var _Async = new webService.Web.AsyncService(_Commn.fnBeforRun, _Commn.fnAfterRun);
	
	$(document).ready(function() {
		$('#txtUserID').focus();
	});	
	
	function fnLogin() {
  	    _Async.post (
			"actionLogin.do",
			JSON.stringify({ userId: $('#txtUserID').val(), password: $('#txtUserPwd').val(), userType: $('#rdoUserType').val() }),
			function (data) {                
				if(data.message != 'success')
					alert(data.message);
				else
					location.href='main.do';
			} 
		);		
/*		
  	    _Async.post (
			"actionLogin.do?userType=1&userId=" + $('#txtUserID').val() + "&password=" + $('#txtUserPwd').val(),
			JSON.stringify({ userId: $('#txtUserID').val(), password: $('#txtUserPwd').val() }),
			function (data) {                
				alert(data.message);                
			} 
		);
*/
	}

</script>
</head>
<body>
<form name='frm' action='actionLogin.do' method='post'>
	<table>
	<tbody>
	<tr>
		<td colspan='3'>
			<input type='radio' id='rdoUserType' name='userType' value='1' checked=checked />
			<label>일반사용자</label>
			<input type='radio' id='rdoUserType' name='userType' value='2' />
			<label>영업사원</label>
		</td>
	</tr>
	<tr>
		<td>ID</td>
		<td><input type='text' id='txtUserID' name='userId' /></td>
		<td rowspan='2'>
			<input type='button' id='btnLogin' name='btnLogin' value='Login' onClick='fnLogin();' />	
		</td>
	</tr>
	<tr>
		<td>PWD</td>
		<td><input type='text' id='txtUserPwd' name='password' /></td>
	</tr>
	</tbody>
	</table>
</form>
</body>
</html>