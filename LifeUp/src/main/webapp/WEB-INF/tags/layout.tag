<%@ tag language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang='ko'>
<head>
<meta charset='utf-8'>
	<title>SSAGEZYO</title>
	<meta name='viewport' content='width=device-width, initial-scale=1.0'>
	<meta name='description' content=''>
	<meta name='author' content=''>

	<!-- Le styles -->
	<link href='<spring:url value="/resources/css/bootstrap.css"/>' rel='stylesheet'>
	<style type='text/css'>
		body {
			padding-top: 60px;
			padding-bottom: 40px;
		}
        
        table.table thead th {
            text-align: center;
        }
        table.table .txt_c {
            text-align: center;
        }
	</style>
	<link href='<spring:url value="/resources/css/bootstrap-responsive.css"/>' rel='stylesheet'>
	<!-- Le HTML5 shim, for IE6-8 support of HTML5 elements -->
	<!--[if lt IE 9]>
      <script src='<spring:url value="/resources/js/html5.js"/>'></script>
    <![endif]-->
</head>
<body>
	<div class='navbar navbar-fixed-top'>
		<div class='navbar-inner'>
			<div class='container'>
				<a class='btn btn-navbar' data-toggle='collapse' data-target='.nav-collapse'>
                    <span class='icon-bar'></span>
                    <span class='icon-bar'></span>
                    <span class='icon-bar'></span>
				</a>
                <a class='brand' href='<spring:url value="/main"/>'>SSAGEZYO</a>
                <div class="btn-group pull-right">
                    <c:if test="${empty sessionScope.userInfo}">
	                    <button class="btn" onclick="$('#loginModal').modal('show'); $('#txtUserID').focus();"><i class="icon-user"></i> 로그인</button>
                    	<button class="btn" onclick="document.location.href='<spring:url value="/account/Membership"/>';"><i class="icon-user"></i> 회원가입</button>                    		                    
                    </c:if>
                    <c:if test="${not empty sessionScope.userInfo}">
                    	<a class="btn" href='/logout'><i class="icon-user"></i>로그아웃</a>
                    </c:if>
                </div>
				<div class='nav-collapse'>
					<ul class='nav'>
						<li class='active'><a href='<spring:url value="/notice/post"/>'>공지사항</a></li>	
						<c:if test="${not empty sessionScope.userInfo}">
							<li class='active'><a href='#' onclick="fnMyInfo();">내정보</a></li>							
						</c:if>						
					</ul>
				</div>
				<!--/.nav-collapse -->
			</div>
		</div>
	</div>
	<div class='container'>
		<jsp:doBody/>	
		<hr>
		<footer style="text-align: center;">
		<p></p>
		</footer>	
    </div>
	<!-- /container -->  		   
    <div id="loginModal" class="modal hide">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal">×</button>
            <h3>로그인</h3>
        </div>
        <div class="modal-body">
			<div style="margin-left: 50px;">
			    <label class="control-label">사용자</label>
			    <div class="controls">
					<input type='radio' id='rdoUserType' name='userType' value='1' checked="checked" />일반사용자 
					<input type='radio' id='rdoUserType' name='userType' value='2' />영업사원
				</div>			               
			    <label class="control-label">아이디</label>
			    <div class="controls"><input type='text' id='txtUserID' /></div>                
			    <label class="control-label">비밀번호</label>
			    <div class="controls"><input type='password' id='txtUserPwd' /></div>
			</div>			                   
        </div>
        <div class="modal-footer">
        	<div style="float: left">
	            <button class="btn" onclick="fnOpenFindUser('U');"><i class="icon-user"></i> 사용자찾기</button>
	            <button class="btn" onclick="fnOpenFindUser('P');"><i class="icon-refresh"></i> 비밀번호찾기</button>
        	</div>
            <a href="#" class="btn" data-dismiss="modal">취소</a>
            <button class="btn btn-primary" onclick="fnLogin();">로그인</button>            
        </div>
    </div> 
    <div id="findUserModal" class="modal hide">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal">×</button>
            <h3><span id="spTitle"></span></h3>
        </div>
        <div class="modal-body">
			<div style="margin-left: 50px;">
			    <label class="control-label">사용자</label>
			    <div class="controls">
					<input type='radio' id='rdoFUserType' name='fUserType' value='1' checked="checked" />일반사용자 
					<input type='radio' id='rdoFUserType' name='fUserType' value='2' />영업사원
				</div>                
			    <label class="control-label">이메일</label>
			    <div class="controls"><input type='text' id='txtFEmail' /></div>                
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
			    <div class="controls"><input type="text" id="txtIUserId" /></div>                
			    <label class="control-label">Email</label>
			    <div class="controls"><input type="text" id="txtIEmail" /></div>                
			    <label class="control-label">이동전화</label>
			    <div class="controls"><input type="text" id="txtIMobile" /></div>
				<label class="control-label">이전 비밀번호</label>
			    <div class="controls"><input type="password" id="txtIPrevPasswd" /></div>			    
			    <label class="control-label">신규 비밀번호</label>
			    <div class="controls"><input type="password" id="txtIPasswd" /></div>                		    
			</div>
	    </div>
	    <div class="modal-footer">
	        <a href="#" class="btn" data-dismiss="modal">취소</a>
	        <button class="btn btn-primary" onclick="fnMyInfoUpdate();">수정</button>
	    </div>
	</div>     
	<!-- Le javascript
    ================================================== -->
	<!-- Placed at the end of the document so the pages load faster -->
	<script src='<spring:url value="/resources/js/jquery.js"/>'></script>
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
	
	<script src='<spring:url value="/resources/js/webService.js"/>'></script>		
    <script type="text/javascript">
		var _Commn = new webService.Web.ComnService();
		var _Async = new webService.Web.AsyncService(_Commn.fnBeforRun, _Commn.fnAfterRun);
    
        $.form = function() {
            var createForm = function(method, url, params) {
                var form = $('<form name="jquery.form"/>')
                			.attr('method', method === 'get' ? 'get' : 'post')
                			.attr('action', url);
                form.append('<input type="hidden" name="_method" value="' + method + '" />');
                form.appendTo('body');
                
                if(params) {
                    for(var key in params)
                        form.append('<input type="hidden" name="' + key + '" value="' + params[key] + '" />');
                }
                
                return form;
            };
            return {
                get: function(url, params) {
                    createForm('get', url, params).submit();
                },
                post: function(url, params) {
                    createForm('post', url, params).submit();
                },
                put: function(url, params) {
                    createForm('put', url, params).submit();
                },
                delete: function(url, params) {
                    createForm('delete', url, params).submit();
                }       
            };
        }();
        
        $('#loginModal').modal({ show: false });
        $('#loginModal').on('shown', function() {
			$('input[name=username]').focus();
        });
        
        $(document).ready(function() {
			if('${loginRequest}' === 'true') {
			    $('#loginModal').modal('show');
			}
		});
        
        // 로그인
    	function fnLogin() {    		    	
      	    _Async.post (
    			"/account/actionLogin.do",
    			JSON.stringify({ userId: $('#txtUserID').val(), password: $('#txtUserPwd').val(), userType: $('input[name=userType]:checked').val() }),
    			function (data) {                
    				if(data.message == 'success' || data.message == 'duplicated')
    					document.location.href='<spring:url value="/main.do"/>';
    				else
    					alert(data.message);
    			} 
    		);
    	}
        
        // 사용자찾기
    	function fnFindUser() {
    		var url = "/account/findUser.do";
    		
    		if($("#spTitle").html() == "비밀번호찾기")
    			url = "/account/findPwd.do";
    			
    		_Async.post (
    			url,
    			JSON.stringify({ email: $('#txtFEmail').val(), userType: $('#findUserModal').find(':input[name=fUserType]:checked').val() }),
    			function (data) {                
    				if(data.message =='success') {
    					alert('등록된 메일로 전송되었습니다');
    					
    					$('#txtFEmail').val("");
    					$('#findUserModal').find(':input[name=fUserType][value=1]').attr('checked', true);
    				}    					    				    		
    			} 
    		);							
    	}        
    	
        // 내정보 
    	function fnMyInfo() {			
      	    _Async.post (
    			"/account/fnMyInfo.do",
    			'',
    			function (data) {                
    				if(data.message == 'success') {
    					$('#myInfoModal').modal('show'); 
    					$("#txtIUserId").val(data.userInfo.userId);
    					$("#txtIEmail").val(data.userInfo.email);
    					$("#txtIMobile").val(data.userInfo.mobile);
    					$('#txtIPrevPasswd').focus();
    				}
    			} 
    		);				
    	}  
        
        // 내정보 수정
    	function fnMyInfoUpdate() {
      	    _Async.post (
    			"/account/fnMyInfoUpdate.do",
    			JSON.stringify({ email: $('#txtIEmail').val(), mobile: $('#txtIMobile').val(), password: $('#txtIPasswd').val(), prevPassword: $('#txtIPrevPasswd').val() }),
    			function (data) {                
    				if(data.message == 'success') {
    					$('#myInfoModal').modal('hide');
    					
    					$('#txtIPasswd').val("");
    					$('#txtIPrevPasswd').val("");
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
        	        	
        	$('#loginModal').modal('hide');        	
        	$('#findUserModal').modal('show'); 
        	$('#spTitle').html(title); 
        	$('#txtFEmail').focus();
        }
    </script>
</body>
</html>