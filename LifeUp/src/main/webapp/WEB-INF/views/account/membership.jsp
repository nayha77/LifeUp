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
	
	function fnFrmInitialize() {
		$('#divChoiceMember').show();
		$('#divNormalCase').hide();
		$('#divSalesCase').hide();
		$('.divSubmit').hide();		
		
        $('.selectpicker').selectpicker({
            'selectedText': ''
        });
        
        $("input[type=text]").each(function() {
        	$(this).val("");
        });   
        
        $("input[type=password]").each(function() {
        	$(this).val("");
        });         
	}
	
	function fnValidation() {		
		$('#frmNormal').validate({
            rules: {
            	userId: { required: true, minlength: 4, maxlength:20, "remote": {
            		url: '/account/chkExistUserId.do?userType=1',
            		type: "post",
                    data:
                    {
                    	tbxUserId: function()
                        {
                            return $('#frmNormal :input[name="userId"]').val();
                        }
                    }
          		} }, 
            	email: { required: true, email: true },            	
            	password: { required: true },
            	passwordConfirm: { equalTo: "#tbxNPwd" },                
                email: { required: true, email: true },
                mobile: { required: false, numeric: true }
            },
            messages: {
            	userId: {
                    required: "아이디를 입력하세요.",
                    minlength: jQuery.format("아이디는 {0}자 이상으로 입력하세요"),
                    maxlength: jQuery.format("아이디는 {0}자 이하로 입력하세요"),
                    remote : jQuery.format("{0}는 이미 있는 아이디입니다.")
                },
                password: { required: "비밀번호를 입력하세요." },
                passwordConfirm: { equalTo: "비밀번호를 다시 확인하세요." },
                email: {
                			required: "이메일주소를 입력하세요.",
                            email: "올바른 이메일주소를 입력하세요." 
                       }, 
                mobile: { numeric: "숫자만 입력하세요." },                          
            },
            submitHandler: function (frm) {
            	frm.submit();
            },
            success: function (e) { }
        });
		
		$('#frmSales').validate({
            rules: {
            	userId: { required: true, minlength: 4, maxlength:20, "remote": {
            		url: '/account/chkExistUserId.do?userType=2',
            		type: "post",
                    data:
                    {
                    	tbxUserId: function()
                        {
                            return $('#frmSales :input[name="userId"]').val();
                        }
                    }
          		} },            	
            	email: { required: true, email: true },
            	password: { required: true },
            	passwordConfirm: { equalTo: "#tbxSPwd" },             	
                email: { required: true, email: true },                
                officeNo: { required: false, numeric: true },
                mobile: { required: true, numeric: true },
                introMsg: { required: true },
                vendorId: { required: true }
            },
            messages: {
               	userId: {
                    required: "아이디를 입력하세요.",
                    minlength: jQuery.format("아이디는 {0}자 이상으로 입력하세요"),
                    maxlength: jQuery.format("아이디는 {0}자 이하로 입력하세요"),
					remote : jQuery.format("{0}는 이미 있는 아이디입니다.")
                },
                password: { required: "비밀번호를 입력하세요." },
                passwordConfirm: { equalTo: "비밀번호를 다시 확인하세요." },
                email: {
                			required: "이메일주소를 입력하세요.",
                            email: "올바른 이메일주소를 입력하세요." 
                       },  
				officeNo: { numeric: "숫자만 입력하세요." },
              	mobile: { numeric: "숫자만 입력하세요." },    
              	introMsg: { required: "인사말을 입력하세요." },
              	vendorId: { required: "제조업체를 입력하세요." },
            },
            submitHandler: function (frm) {
            	frm.submit();
            },
            success: function (e) { }
        });		
	}
	
	function fnRegister() {		
		if($('#divNormalCase').is($('#divNormalCase').show())) {
			document.frmNormal.submit();
		} else {
			document.frmSales.submit();
		}	
	}
	
	function fnMoveStep() {
		fnFrmInitialize();
	}
	
	function fnChoiceMemberType(type) {
		$('#divChoiceMember').hide();		
		
		if(type == 'N') {
			$('#divSalesCase').hide();
			$('#divNormalCase').show();
			$('#divNSubmit').show();
		} else {
			$('#divNormalCase').hide();
			$('#divSalesCase').show();
			$('#divSSubmit').show();
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

<div class="control-group" id='divContent' style='text-align: center;'>
	<table border='0' align='center' style='width: 220px;' >
	<tr>
		<td>
			<div id='divNormal' style='text-align: center; width: 220px;'>
				<form id='frmNormal' name='frmNormal' method='post' action='/account/register'>
					<div class="control-group" id='divNormalCase'>
						<div class="control-label" style='text-align: left;'><i class="icon-check"></i>아이디</div>
						<div class="controls">
							<input type='hidden' id='hdnUserType' name='userType' value='1' />
							<input type='text' id='tbxUserId' name='userId' />
						</div>
						<div class="control-label" style='text-align: left;'><i class="icon-check"></i>비밀번호</div>
						<div class="controls"><input type='password' id='tbxNPwd' name='password' /></div>
						<div class="control-label" style='text-align: left;'><i class="icon-check"></i>비밀번호 확인</div>
						<div class="controls"><input type='password' id='tbxPwdConfirm' name='passwordConfirm' /></div>		
						<div class="control-label" style='text-align: left;'><i class="icon-check"></i>성명</div>
						<div class="controls"><input type='text' id='tbxUserNm' name='userNm' /></div>
						<div class="control-label" style='text-align: left;'><i class="icon-check"></i>이메일</div>
						<div class="controls"><input type='text' id='tbxEmail' name='email' /></div>
						<div class="control-label" style='text-align: left;'>전화번호</div>
						<div class="controls"><input type='text' id='tbxMobile' name='mobile' /></div>
						<div class="control-label" style='text-align: left;'>거주지역</div>
						<div class="controls">
							<div class="bs-docs-example">		  
								<select class="selectpicker" data-live-search="true" id='ddlRegion' name='region'>
							  		<option value='0001'>서울시 용산구</option>
									<option value='0002'>서울시 구로구</option>
									<option value='0003'>경기도 군포시 산본동</option>
									<option value='0004'>경기도 안양시 산본동</option>
							  	</select>		
							</div>		
						</div>		
					</div>
					<div id='divNSubmit' class='divSubmit'>
						<input type='submit' class="btn btn-primary" value='회원가입' />	
						<a href="#" class="btn" data-dismiss="modal" onClick="fnMoveStep();">이전으로</a>
					</div>
				</form>
			</div>
			<div id='divSales' style='text-align: center; width:220px;'>
				<form id='frmSales' name='frmSales' method='post' action='/account/register'>	
					<div class="control-group" id='divSalesCase'>
						<div class="control-label" style='text-align: left;'><i class="icon-check"></i>아이디</div>
						<div class="controls">
							<input type='hidden' id='hdnUserType' name='userType' value='2' />
							<input type='text' id='tbxUserId' name='userId' />
						</div>
						<div class="control-label" style='text-align: left;'><i class="icon-check"></i>비밀번호</div>
						<div class="controls"><input type='password' id='tbxSPwd' name='password' /></div>
						<div class="control-label" style='text-align: left;'><i class="icon-check"></i>비밀번호 확인</div>
						<div class="controls"><input type='password' id='tbxPwdConfirm' name='passwordConfirm' /></div>		
						<div class="control-label" style='text-align: left;'><i class="icon-check"></i>성명</div>
						<div class="controls"><input type='text' id='tbxUserNm' name='userNm' /></div>
						<div class="control-label" style='text-align: left;'><i class="icon-check"></i>이메일</div>
						<div class="controls"><input type='text' id='tbxEmail' name='email' /></div>
						<div class="control-label" style='text-align: left;'>핸드폰번호</div>
						<div class="controls"><input type='text' id='tbxMobile' name='mobile' /></div>
						<div class="control-label" style='text-align: left;'>사무실전화번호</div>
						<div class="controls"><input type='text' id='tbxOffice' name='officeNo' /></div>	
						<div class="control-label" style='text-align: left;'><i class="icon-check"></i>제조업체</div>
						<div class="controls"><input type='text' id='tbxVendor' name='vendorId' /></div>
						<div class="control-label" style='text-align: left;'>근무지점</div>
						<div class="controls"><input type='text' id='tbxLocation' name='location' /></div>		
						<div class="control-label" style='text-align: left;'><i class="icon-check"></i>인사말</div>
						<div class="controls">
							<textarea id='tbxIntro' name='introMsg' rows="15">
							</textarea>
						</div>	
					</div>
					<div style='text-align: center;' id='divSSubmit' class='divSubmit'>
						<input type='submit' class="btn btn-primary" value='회원가입' />	
						<a href="#" class="btn" data-dismiss="modal" onClick="fnMoveStep();">이전으로</a>
					</div>
				</form>
			</div>		
		</td>
	</tr>
	</table>
</div>	
</mvc:simple>