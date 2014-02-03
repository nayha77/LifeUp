<%@ page language="java" contentType="text/html; charset=UTF-8"%>

<%@ taglib prefix="mvc" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<mvc:simple>
<script type="text/javascript">
	
	function fnLoad() {
		fnFrmInitialize();
	}
	
	function fnFrmInitialize() {
		$('#divChoiceMember').show();
		$('#divNormalCase').hide();
		$('#divSalesCase').hide();
		$('#divSubmit').hide();		
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
		<button class="btn btn-primary" onclick="fnChoiceMemberType('N');">일반회원</button>
	<div>
	<div style='height: 10px;'></div>
	</div>
		<button class="btn btn-primary" onclick="fnChoiceMemberType('S');">영업사원</button>
	</div>
</div>

<div class="control-group" id='divNormalCase'>
	<div class="control-label">아이디</div>
	<div class="controls">
		<input type='text' id='tbxUserId' />
		<button class="btn btn-primary" style='margin-top: -10px;' onclick="fnDupChkUserId('N');">중복확인</button>
	</div>
	<div class="control-label">성명</div>
	<div class="controls"><input type='text' id='tbxNUserNm' /></div>
	<div class="control-label">이메일</div>
	<div class="controls"><input type='text' id='tbxNEmail' /></div>
	<div class="control-label">전화번호</div>
	<div class="controls"><input type='text' id='tbxNMobile' /></div>
	<div class="control-label">거주지역</div>
	<div class="controls"><input type='text' id='tbxNRegion' /></div>
	<div class="control-label">비밀번호</div>
	<div class="controls"><input type='text' id='tbxNPwd' /></div>
	<div class="control-label">비밀번호 확인</div>
	<div class="controls"><input type='text' id='tbxNPwdConfirm' /></div>
</div>

<div class="control-group" id='divSalesCase'>
	<div class="control-label">아이디</div>
	<div class="controls">
		<input type='text' id='tbxSUserId' />
		<button class="btn btn-primary" style='margin-top: -10px;' onclick="fnDupChkUserId('S');">중복확인</button>
	</div>
	<div class="control-label">성명</div>
	<div class="controls"><input type='text' id='tbxSUserNm' /></div>
	<div class="control-label">이메일</div>
	<div class="controls"><input type='text' id='tbxSEmail' /></div>
	<div class="control-label">전화번호</div>
	<div class="controls"><input type='text' id='tbxSMobile' /></div>
	<div class="control-label">사무실전화번호</div>
	<div class="controls"><input type='text' id='tbxSOffice' /></div>	
	<div class="control-label">제조업체</div>
	<div class="controls"><input type='text' id='tbxSVendor' /></div>
	<div class="control-label">근무지점</div>
	<div class="controls"><input type='text' id='tbxSLocation' /></div>		
	<div class="control-label">거주지역</div>
	<div class="controls"><input type='text' id='tbxSRegion' /></div>
	<div class="control-label">인사말</div>
	<div class="controls"><input type='text' id='tbxSIntro' /></div>	
	<div class="control-label">비밀번호</div>
	<div class="controls"><input type='text' id='tbxSPwd' /></div>
	<div class="control-label">비밀번호 확인</div>
	<div class="controls"><input type='text' id='tbxSPwdConfirm' /></div>
</div>

<div style='text-align: center;' id='divSubmit'>
	<button class="btn btn-primary" onclick="fnLogin();">회원가입</button>
	<a href="#" class="btn" data-dismiss="modal" onClick="fnMoveStep();">이전으로</a>
</div>
</mvc:simple>