<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
<title>HK</title>
<script src='<spring:url value="/resources/js/jquery.js"/>'></script>
<script src='<spring:url value="/resources/js/webService.js"/>'></script>
<script src='<spring:url value="/resources/js/html5.js"/>'></script>
<script src='<spring:url value="/resources/js/bootstrap-transition.js"/>'></script>
<script src='<spring:url value="/resources/js/bootstrap-alert.js"/>'></script>
<script src='<spring:url value="/resources/js/bootstrap-modal.js"/>'></script>
<script src='<spring:url value="/resources/js/bootstrap-dropdown.js"/>'></script>
<script src='<spring:url value="/resources/js/bootstrap-scrollspy.js"/>'></script>
<script src='<spring:url value="/resources/js/bootstrap-tab.js"/>'></script>
<script src='<spring:url value="/resources/js/bootstrap-tooltip.js"/>'></script>
<script src='<spring:url value="/resources/js/bootstrap-popover.js"/>'></script>
<script src='<spring:url value="/resources/js/bootstrap-button.js"/>'></script>
<script src='<spring:url value="/resources/js/bootstrap-collapse.js"/>'></script>
<script src='<spring:url value="/resources/js/bootstrap-carousel.js"/>'></script>
<script src='<spring:url value="/resources/js/bootstrap-typeahead.js"/>'></script>

<link href='<spring:url value="/resources/css/bootstrap.css"/>' rel='stylesheet'>

<script type="text/javascript">
	var _Commn = new webService.Web.ComnService();
	var _Async = new webService.Web.AsyncService(_Commn.fnBeforRun, _Commn.fnAfterRun);
		
	function fnFindUser() {
		var url;
		if($("#spTitle").html() == "사용자찾기")
			url = "findUser.do";
		else
			url = "findPwd.do";
					
		_Async.post (
			url,
			JSON.stringify({ email: $('#txtEmail').val(), userType: $('input[name=userType]:checked').val() }),
			function (data) {                
				if(data.message =='success')
					alert('등록된 메일로 전송되었습니다');
				
				$('#txtEmail').val("");	
			} 
		);							
	}
		
	function fnMyInfo() {
  	    _Async.post (
			"fnMyInfo.do",
			'',
			function (data) {                
				if(data.message == 'success')
					alert(data.message);
			} 
		);				
	}
</script>	
</head>
<body>
	<h2>메인화면</h2>
	<button class="btn" onclick="$('#findUserModal').modal('show'); $('#txtUserId').focus();$('#spTitle').html('사용자찾기');"><i class="icon-user"></i> 사용자찾기</button>
	<button class="btn" onclick="$('#findUserModal').modal('show'); $('#txtUserId').focus();$('#spTitle').html('비밀번호찾기');"><i class="icon-user"></i> 비밀번호찾기</button>
	<button class="btn" onclick="$('#myInfoModal').modal('show'); $('#txtIUserId').focus();"><i class="icon-user"></i> 내정보</button>
</body>
<div id="findUserModal" class="modal hide">	
    <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">×</button>
        <h3><span id="spTitle"></span></h3>
    </div>
    <div class="modal-body">   
        <div style="margin-left: 50px;">
        	<label class="control-label">사용자구분</label>        	
			<input type='radio' id='rdoUserType' name='userType' value='1' checked=checked />
			<span>일반사용자</span>			
			<input type='radio' id='rdoUserType' name='userType' value='2' />
			<span>영업사원</span>			
									
            <label class="control-label">이메일</label>
            <div class="controls">
                <input type="text" id="txtEmail" name="email"/>
            </div>
        </div>
    </div>
    <div class="modal-footer">
        <a href="#" class="btn" data-dismiss="modal">취소</a>
        <button class="btn btn-primary" onclick="fnFindUser();">찾기</button>
    </div>
</div>
<div id="myInfoModal" class="modal hide">
    <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">×</button>
        <h3>내정보</h3>
    </div>
    <div class="modal-body">
		<div style="margin-left: 50px;">
		    <label class="control-label">사용자 ID</label>
		    <div class="controls"><input type="text" id="txtIUserId" name="userId"/></div>                
		    <label class="control-label">Email</label>
		    <div class="controls"><input type="text" id="txtIEmail" name="email"/></div>                
		    <label class="control-label">비밀번호</label>
		    <div class="controls"><input type="text" id="txtIPasswd" name="password"/></div>                
		    <label class="control-label">이동전화</label>
		    <div class="controls"><input type="text" id="txtIMobile" name="mobile"/></div>
		</div>
    </div>
    <div class="modal-footer">
        <a href="#" class="btn" data-dismiss="modal">취소</a>
        <button class="btn btn-primary" onclick="fnMyInfo">수정</button>
    </div>
</div>     
</html>