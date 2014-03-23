$(document).on('pageinit', '#loginPage' ,function() {	
		       	
	$("#loginPage").on('click', '#btnBack', function() {
		_Commn.fnPageMove("/main");
	});	
	
	$("#loginPage").find("h1[id='pageTitle']").text("로그인");	
	_Commn.fnMarkingLeftMenu($("#loginPage").find("a[id='menuLogin']"));
	$("#loginPage").find("a[id='menuLogin']").next().css("background-color", "#38c");
	
	// 로그인/사용자찾기 패널 취소
	$('a[href=#frmUserLogin]').click(function() {
    	$('#frmUserLogin').show();
    	$('#frmFindUserInfo').hide();
    	
    	$("#frmUserLogin").find("input[name='password']").focus();
    }); 	
	
	var userId = $.cookie("userId");
	var userType = $.cookie("userType");	   

	if(typeof userId != 'undefined' && typeof userType != 'undefined') {
		$("#frmUserLogin").find("input[name='userId']").val(userId); 
		$("#frmUserLogin").find("input[name=userType]").filter("[value=\"" + userType + "\"]").prop("checked", true).checkboxradio("refresh");
	} else {        			
		$("#frmUserLogin").find("input[name=userType]").filter('[value="1"]').prop("checked", true).checkboxradio("refresh");
		$("#frmUserLogin").find("input[name='userId']").focus();
		
		return;
	}
	
	$("#frmUserLogin").find("input[name='password']").focus();
});	

// 사용자/비밀번호 찾기 Div Open
function fnActiveFormOpen(flag) {
	var title = "로그인";
	
	if(flag == 'U') {
		title = '사용자찾기';
	} else if(flag == 'P') {
		title = '비밀번호찾기';
	} 
	
	$('#frmUserLogin').hide();		
	$('#frmFindUserInfo').hide();		

	if(flag == "L") {
		$('#frmUserLogin').show();				
		$("#frmUserLogin").find("input[name='userId']").focus();
	} else {		
		$('#frmFindUserInfo').show();		
		$("#frmFindUserInfo").find("input[name='txtFUserId']").focus();				
	}
	
	$("#loginPage").find("h1[id='pageTitle']").text(title);
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
				// AutoCheck 값 설정 후 main으로 이동
				$("#frmUserLogin").find("input[name='saveYn']").val(autoLogin);
				_Commn.fnPageMove("/main", $('#frmUserLogin'));				    	
				
				sendUserInfoToApp($('#txtUser').val(), $('#txtUserPwd').val(), $('input[name=userType]:checked').val());
			} else {
				alert(data.message);    					
			}
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