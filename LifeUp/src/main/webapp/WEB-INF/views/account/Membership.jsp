<%@ page language="java" contentType="text/html; charset=UTF-8"%>

<%@ taglib prefix="mvc" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<mvc:simple>
<script type="text/javascript">
	
	function fnLoad() {
		fnFrmInitialize();
		fnValidation();
	}			
	
	function fnValidation() {
		
		$('#frmNormal').validate({
            rules: {
            	tbxUserId: { required: true, minlength: 4, maxlength:20, "remote": {
            		url: '/account/chkExistUserId.do?userType=1',
            		type: "post",
                    data:
                    {
                    	tbxUserId: function()
                        {
                            return $('#frmNormal :input[name="tbxUserId"]').val();
                        }
                    }
          		} }, 
            	tbxEmail: { required: true, email: true },            	
            	tbxPwd: { required: true },
                tbxPwdConfirm: { equalTo: "#tbxPwd" },                
                tbxEmail: { required: true, email: true },
                tbxMobile: { required: false, numeric: true }
            },
            messages: {
            	tbxUserId: {
                    required: "아이디를 입력하세요.",
                    minlength: jQuery.format("아이디는 {0}자 이상으로 입력하세요"),
                    maxlength: jQuery.format("아이디는 {0}자 이하로 입력하세요"),
                    remote : jQuery.format("{0}는 이미 있는 아이디입니다.")
                },
                tbxPwd: { required: "비밀번호를 입력하세요." },
                tbxPwdConfirm: { equalTo: "비밀번호를 다시 확인하세요." },
                tbxEmail: {
                			required: "이메일주소를 입력하세요.",
                            email: "올바른 이메일주소를 입력하세요." 
                           }, 
                tbxMobile: { numeric: "숫자만 입력하세요." },                          
            },
            submitHandler: function (frm) {
            	
            },
            success: function (e) { 
            }
        });
		
		$('#frmSales').validate({
            rules: {
            	tbxUserId: { required: true, minlength: 4, maxlength:20, "remote": {
            		url: '/account/chkExistUserId.do?userType=2',
            		type: "post",
                    data:
                    {
                    	tbxUserId: function()
                        {
                            return $('#frmSales :input[name="tbxUserId"]').val();
                        }
                    }
          		} },            	
            	tbxEmail: { required: true, email: true },            	
            	tbxPwd: { required: true },
                tbxPwdConfirm: { equalTo: "#tbxPwd" },                
                tbxEmail: { required: true, email: true },                
                tbxOffice: { required: false, numeric: true },
                tbxMobile: { required: true, numeric: true }
            },
            messages: {
               	tbxUserId: {
                    required: "아이디를 입력하세요.",
                    minlength: jQuery.format("아이디는 {0}자 이상으로 입력하세요"),
                    maxlength: jQuery.format("아이디는 {0}자 이하로 입력하세요"),
					remote : jQuery.format("{0}는 이미 있는 아이디입니다.")
                },
                tbxPwd: { required: "비밀번호를 입력하세요." },
                tbxPwdConfirm: { equalTo: "비밀번호를 다시 확인하세요." },
                tbxEmail: {
                			required: "이메일주소를 입력하세요.",
                            email: "올바른 이메일주소를 입력하세요." 
                           },  
				tbxOffice: { numeric: "숫자만 입력하세요." },
              	tbxMobile: { numeric: "숫자만 입력하세요." },                          
            },
            submitHandler: function (frm) {
            	
            },
            success: function (e) { 
            }
        });		
	}
	
	function fnFrmInitialize() {
		$('#divChoiceMember').show();
		$('#divNormalCase').hide();
		$('#divSalesCase').hide();
		$('#divSubmit').hide();		
		
        $('.selectpicker').selectpicker({
            'selectedText': ''
        });
	}
	
	function fnRegister() {
	}
	
	function fnMoveStep() {
		fnFrmInitialize();
	}
	
	function fnChoiceMemberType(type) {
		$('#divChoiceMember').hide();
		$('#divSubmit').show();
		
		if(type == 'N') {
			$('#divSalesCase').hide();
			$('#divNormalCase').show();
		} else {
			$('#divNormalCase').hide();
			$('#divSalesCase').show();
		}	
	}	
	
	function fnDupChkUserId() {
		
	}
</script>

<div class="control-group" id='divChoiceMember' style='text-align: center;'>
	<div>
		<button class="btn btn-large btn-primary" onclick="fnChoiceMemberType('N');">일반회원</button>
	<div>
	<div style='height: 10px;'></div>
	</div>
		<button class="btn btn-large btn-primary" onclick="fnChoiceMemberType('S');">영업사원</button>
	</div>
</div>

<form id='frmNormal' name='frmNormal'>
	<div class="control-group" id='divNormalCase'>
		<div class="control-label">아이디</div>
		<div class="controls"><input type='text' id='tbxUserId' name='tbxUserId' /></div>
		<div class="control-label">성명</div>
		<div class="controls"><input type='text' id='tbxUserNm' name='tbxUserNm' /></div>
		<div class="control-label">이메일</div>
		<div class="controls"><input type='text' id='tbxEmail' name='tbxEmail' /></div>
		<div class="control-label">전화번호</div>
		<div class="controls"><input type='text' id='tbxMobile' name='tbxMobile' /></div>
		<div class="control-label">거주지역</div>
		<div class="controls"><input type='text' id='tbxRegion' name='tbxRegion' /></div>
		<div class="control-label">비밀번호</div>
		<div class="controls"><input type='password' id='tbxPwd' name='tbxPwd' /></div>
		<div class="control-label">비밀번호 확인</div>
		<div class="controls"><input type='password' id='tbxPwdConfirm' name='tbxPwdConfirm' /></div>
	</div>
</form>

<form id='frmSales' name='frmSales'>	
	<div class="control-group" id='divSalesCase'>
		<div class="control-label">아이디</div>
		<div class="controls"><input type='text' id='tbxUserId' name='tbxUserId' /></div>
		<div class="control-label">성명</div>
		<div class="controls"><input type='text' id='tbxUserNm' name='tbxUserNm' /></div>
		<div class="control-label">이메일</div>
		<div class="controls"><input type='text' id='tbxEmail' name='tbxEmail' /></div>
		<div class="control-label">전화번호</div>
		<div class="controls"><input type='text' id='tbxMobile' name='tbxMobile' /></div>
		<div class="control-label">사무실전화번호</div>
		<div class="controls"><input type='text' id='tbxOffice' name='tbxOffice' /></div>	
		<div class="control-label">제조업체</div>
		<div class="controls"><input type='text' id='tbxVendor' name='tbxVendor' /></div>
		<div class="control-label">근무지점</div>
		<div class="controls"><input type='text' id='tbxLocation' name='tbxLocation' /></div>		
		<div class="control-label">거주지역</div>
		<div class="controls">
			<div class="bs-docs-example">		  
				<select class="selectpicker" data-live-search="true" name='tbxRegion'>
			  		<option value='0001'>서울시 용산구</option>
					<option value='0002'>서울시 구로구</option>
					<option value='0003'>경기도 군포시 산본동</option>
					<option value='0004'>경기도 안양시 산본동</option>
			  	</select>		
			</div>		
		</div>
		<div class="control-label">인사말</div>
		<div class="controls"><input type='text' id='tbxIntro' name='tbxIntro' /></div>	
		<div class="control-label">비밀번호</div>
		<div class="controls"><input type='password' id='tbxPwd' name='tbxPwd' /></div>
		<div class="control-label">비밀번호 확인</div>
		<div class="controls"><input type='password' id='tbxPwdConfirm' name='tbxPwdConfirm' /></div>
	</div>
</form>

<div style='text-align: center;' id='divSubmit'>
	<button class="btn btn-primary" onclick="fnRegister();">회원가입</button>
	<a href="#" class="btn" data-dismiss="modal" onClick="fnMoveStep();">이전으로</a>
</div>
</mvc:simple>