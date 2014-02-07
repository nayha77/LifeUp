<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="mvc" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<mvc:simple>

<style type='text/css'>
#content {
	margin: 0px auto; padding: 50px 0px; width: 670px; text-align: left;
}
.field1 legend {
	display: block;
}
.field2 legend {
	display: block;
}
.bx {
	margin: 0px 0px 8px; padding: 20px 18px 0px 20px; border: 1px solid rgb(229, 229, 229); height: 111px; overflow: auto; position: relative; -ms-scrollbar-base-color: rgb(217, 217, 217); -ms-scrollbar-face-color: rgb(217, 217, 217); -ms-scrollbar-3dlight-color: rgb(217, 217, 217); -ms-scrollbar-shadow-color: rgb(217, 217, 217); -ms-scrollbar-highlight-color: rgb(217, 217, 217); -ms-scrollbar-darkshadow-color: rgb(217, 217, 217); -ms-scrollbar-track-color: rgb(242, 242, 242); -webkit-overflow-scrolling: touch;
}
</style>

<script type="text/javascript">
	
	function fnLoad() {
		fnFrmInitialize(1);
		fnValidation();
	}			
	
	function fnFrmInitialize(type) {			
		$('#divNotice').hide();
		$('#divChoiceMember').hide();
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

		if(type == 1) {
			$('#divChoiceMember').show();					
		} else {
			$('#divNotice').show();
		}
	}
	
	function fnChoiceMemberType() {
		
		if( !($('#check1').is(":checked") && $('#check2').is(":checked")) ) {
			alert('이용약관과 개인정보 수집 및 이용에 대한 안내를 모두 동의해주세요');
			return;
		}  
		
		var type = $('#hdnChoiceUserType').val();
		
		$('#divChoiceMember').hide();	
		$('#divNotice').hide();
		
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
	
	function fnValidation() {		
		$('#frmNormal').validate({
            rules: {
            	userId: { required: true, email: true, "remote": {
            		url: '/account/chkExistUserId.do?userType=1',
            		type: "post",
                    data:
                    {
                    	tbxUserId: function()
                        {
                            return $('#tbxUserId').val();
                        }
                    }
          		} },             	
            	password: { required: true },
            	passwordConfirm: { equalTo: "#tbxNPwd" },
                mobile: { required: false, numeric: true }
            },
            messages: {
                password: { required: "비밀번호를 입력하세요." },
                passwordConfirm: { equalTo: "비밀번호를 다시 확인하세요." },
                userId: {
                			required: "아이디(이메일주소)를 입력하세요.",
                            email: "올바른 이메일주소를 입력하세요.",
                            remote : jQuery.format("중복 아이디 입니다")
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
            	userId: { required: true, email: true, "remote": {
            		url: '/account/chkExistUserId.do?userType=2',
            		type: "post",
                    data:
                    {
                    	tbxSalesmanId: function()
                        {
                            return $('#tbxSalesmanId').val();
                        }
                    }
          		} },            	
            	password: { required: true },
            	passwordConfirm: { equalTo: "#tbxSPwd" },             	                
                officeNo: { required: false, numeric: true },
                mobile: { required: true, numeric: true },
                introMsg: { required: true },
                vendorId: { required: true }
            },
            messages: {
                password: { required: "비밀번호를 입력하세요." },
                passwordConfirm: { equalTo: "비밀번호를 다시 확인하세요." },
                userId: {
                			required: "이메일주소를 입력하세요.",
                            email: "올바른 이메일주소를 입력하세요.",
                            remote : jQuery.format("사용할 수 없는 아이디입니다.")
                       },  
				officeNo: { numeric: "숫자만 입력하세요." },
              	mobile: { numeric: "숫자만 입력하세요." },    
              	vendorId: { required: "소속회사를 선택하세요." },
              	introMsg: { required: "인사말을 입력하세요." },              	
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
	
	function fnChangeRegion(obj) {	
   	    _Async.post (
   			"/regionSecondJson.do",
   			sido = obj.value,
   			function (data) {    
				var resultData = data.Sido2;				
				$('#ddlGugun').find("option").remove().end().append("<option value=\"\">:::선택 :::</option>");
				
				$.each(resultData, function(index, entry){
					$("#ddlGugun").append("<option value='"+ entry["region_cd"] +"'>" + entry["gugun"]  + "</option>"); 				        
				});				
   			} 
   		);   	         
	}	
</script>

<div class="control-group" id='divNotice' style='text-align: center;'>
	<div id='content'>
		<div>
			<h1 style='font-size: 13px'>회원가입을 위해서 아래 이용약관·개인정보 수집에 대한 안내를 읽고 동의해 주세요.</h1>		
        </div>         
		<fieldset class="field1">
			<div class="bx">
				<h1 style='font-size: 13px'>제 1 조 (목적)</h1>
				<p>이 약관은 본 사이트 서비스의 이용과 관련하여 회사와 회원과의 권리, 의무 및 책임사항, 기타 필요한 사항을 규정함을 목적으로 합니다.</p>
				<h1 style='font-size: 13px'>제 2 조 (정의)</h1>
				<p>이 약관에서 사용하는 용어의 정의는 다음과 같습니다.</p>
				<ul>
				<li>①&quot;서비스&quot;라 함은 본 사이트에 제공하는 정보와 관련 제반 서비스를 의미합니다.</li>
				<li>②&quot;회원&quot;이라 함은 회사의 &quot;서비스&quot;에 접속하여 이 약관에 따라 &quot;회사&quot;와 이용계약을 체결하고 &quot;회사&quot;가 제공하는 &quot;서비스&quot;를 이용하는 고객을 말합니다.</li>
				<li>③&quot;아이디&quot;라 함은 &quot;회원&quot;의 식별과 &quot;서비스&quot; 이용을 위하여 &quot;회원&quot;이 정하고 &quot;회사&quot;가 승인하는 정보를 의미합니다</li>
				<li>④&quot;비밀번호&quot;라 함은 &quot;회원&quot;에게 허가된 아이디과 일치되는 &quot;회원&quot;임을 확인하고 비밀보호를 위해 &quot;회원&quot; 자신이 정한 문자 또는 숫자의 조합을 의미합니다.</li>
				<li>⑤&quot;유료서비스&quot;라 함은 &quot;회사&quot;가 유료로 제공하는 각종 온라인디지털콘텐츠 및 제반 서비스를 의미합니다.</li>
				<li>⑥&quot;포인트&quot;라 함은 서비스의 효율적 이용을 위해 회사가 임의로 책정 또는 지급, 조정할 수 있는 재산적 가치가 없는 &quot;서비스&quot; 상의 가상 데이터를 의미합니다.</li>
				<li>⑦&quot;게시물&quot;이라 함은 &quot;회원&quot;이 &quot;서비스&quot;를 이용함에 있어 &quot;서비스상&quot;에 게시한 부호ㆍ문자 등의 정보 형태의 글, 사진과 링크 등을 의미합니다.</li>
				</ul>
				<h1 style='font-size: 13px'>제 3 조 (약관의 게시와 개정)</h1>
				<ul>
				<li>①&quot;회사&quot;는 이 약관의 내용을 &quot;회원&quot;이 쉽게 알 수 있도록 서비스 초기 화면에 게시합니다.</li>
				<li>②&quot;회사&quot;는 &quot;약관의규제에관한법률&quot;, &quot;정보통신망이용촉진및정보보호등에관한법률(이하 &quot;정보통신망법&quot;)&quot; 등 관련법을 위배하지 않는 범위에서 이 약관을 개정할 수 있습니다.</li>
				<li>③&quot;회사&quot;가 약관을 개정할 경우에는 적용일자 및 개정사유를 명시하여 현행약관과 함께 제1항의 방식에 따라 그 개정약관의 적용일자 30일 전부터 적용일자 전일까지 공지합니다. </li>
				<li>④회사가 전항에 따라 개정약관을 공지 또는 통지하면서 회원에게 30일 기간 내에 의사표시를 하지 않으면 의사표시가 표명된 것으로 본다는 뜻을 명확하게 공지 또는 통지하였음에도 회원이 명시적으로 거부의 의사표시를 하지 아니한 경우 회원이 개정약관에 동의한 것으로 봅니다.</li>
				<li>⑤회원이 개정약관의 적용에 동의하지 않는 경우 회사는 개정 약관의 내용을 적용할 수 없으며, 이 경우 회원은 이용계약을 해지할 수 있습니다. 다만, 기존 약관을 적용할 수 없는 특별한 사정이 있는 경우에는 회사는 이용계약을 해지할 수 있습니다.</li>
				</ul>
				<h1 style='font-size: 13px'>제 4 조 (약관의 해석)</h1>
				<ul>
				<li>①&quot;회사&quot;는 &quot;유료서비스&quot; 및 개별 서비스에 대해서는 별도의 이용약관 및 정책(이하 &quot;유료서비스약관 등&quot;)을 둘 수 있으며, 해당 내용이 이 약관과 상충할 경우에는 &quot;유료서비스약관 등&quot;이 우선하여 적용됩니다.</li>
				<li>②이 약관에서 정하지 아니한 사항이나 해석에 대해서는 &quot;유료서비스약관 등&quot; 및 관계법령 또는 상관례에 따릅니다.</li>
				</ul>
				<h1 style='font-size: 13px'>제 5 조 (이용계약 체결)</h1>
				<ul>
				<li>①이용계약은 &quot;회원&quot;이 되고자 하는 자(이하 &quot;가입신청자&quot;)가 약관의 내용에 대하여 동의를 한 다음 회원가입신청을 하고 &quot;회사&quot;가 이러한 신청에 대하여 승낙함으로써 체결됩니다.</li>
				<li>②&quot;회사&quot;는 &quot;가입신청자&quot;의 신청에 대하여 &quot;서비스&quot; 이용을 승낙함을 원칙으로 합니다. 다만, &quot;회사&quot;는 다음 각 호에 해당하는 신청에 대하여는 승낙을 하지 않거나 사후에 이용계약을 해지할 수 있습니다.</li>
				<li>③제1항에 따른 신청에 있어 &quot;회사&quot;는 &quot;회원&quot;의 종류에 따라 전문기관을 통한 실명확인 및 본인인증을 요청할 수 있습니다.</li>
				<li>④&quot;회사&quot;는 서비스관련설비의 여유가 없거나, 기술상 또는 업무상 문제가 있는 경우에는 승낙을 유보할 수 있습니다.</li>
				<li>⑤제2항과 제4항에 따라 회원가입신청의 승낙을 하지 아니하거나 유보한 경우, &quot;회사&quot;는 원칙적으로 이를 가입신청자에게 알리도록 합니다.</li>
				<li>⑥이용계약의 성립 시기는 &quot;회사&quot;가 가입완료를 신청절차 상에서 표시한 시점으로 합니다.</li>
				</ul>
				<h1 style='font-size: 13px'>제 6 조 (회원정보의 변경)</h1>
				<ul>
				<li>①&quot;회원&quot;은 개인정보관리화면을 통하여 언제든지 본인의 개인정보를 열람하고 수정할 수 있습니다. 다만, 서비스 관리를 위해 필요한 실명, 아이디 등은 수정이 불가능합니다.</li>
				<li>②&quot;회원&quot;은 회원가입신청 시 기재한 사항이 변경되었을 경우 온라인으로 수정을 하거나 전자우편 기타 방법으로 &quot;회사&quot;에 대하여 그 변경사항을 알려야 합니다.</li>
				<li>③제2항의 변경사항을 &quot;회사&quot;에 알리지 않아 발생한 불이익에 대하여 &quot;회사&quot;는 책임지지 않습니다.</li>
				</ul>
				<h1 style='font-size: 13px'>제 7 조 (개인정보보호 의무)</h1>
				<p>&quot;회사&quot;는 &quot;정보통신망법&quot; 등 관계 법령이 정하는 바에 따라 &quot;회원&quot;의 개인정보를 보호하기 위해 노력합니다. 개인정보의 보호 및 사용에 대해서는 관련법 및 &quot;회사&quot;의 개인정보취급방침이 적용됩니다. 다만, &quot;회사&quot;의 공식 사이트 이외의 링크된 사이트에서는 &quot;회사&quot;의 개인정보취급방침이 적용되지 않습니다.</p>
				<h1 style='font-size: 13px'>제 8 조 (&quot;회원&quot;의 &quot;아이디&quot; 및 &quot;비밀번호&quot;의 관리에 대한 의무)</h1>
				<ul>
				<li>①&quot;회원&quot;의 &quot;아이디&quot;와 &quot;비밀번호&quot;에 관한 관리책임은 &quot;회원&quot;에게 있으며, 이를 제3자가 이용하도록 하여서는 안 됩니다.</li>
				<li>②&quot;회사&quot;는 &quot;회원&quot;의 &quot;아이디&quot;가 개인정보 유출 우려가 있거나, 반사회적 또는 미풍양속에 어긋나거나 &quot;회사&quot; 및 &quot;회사&quot;의 운영자로 오인한 우려가 있는 경우, 해당 &quot;아이디&quot;의 이용을 제한할 수 있습니다.</li>
				<li>③&quot;회원&quot;은 &quot;아이디&quot; 및 &quot;비밀번호&quot;가 도용되거나 제3자가 사용하고 있음을 인지한 경우에는 이를 즉시 &quot;회사&quot;에 통지하고 &quot;회사&quot;의 안내에 따라야 합니다.</li>
				<li>④제3항의 경우에 해당 &quot;회원&quot;이 &quot;회사&quot;에 그 사실을 통지하지 않거나, 통지한 경우에도 &quot;회사&quot;의 안내에 따르지 않아 발생한 불이익에 대하여 &quot;회사&quot;는 책임지지 않습니다.</li>
				</ul>
				<h1 style='font-size: 13px'>제 9 조 (&quot;회원&quot;에 대한 통지)</h1>
				<ul>
				<li>①&quot;회사&quot;가 &quot;회원&quot;에 대한 통지를 하는 경우 이 약관에 별도 규정이 없는 한 서비스 내 전자우편주소, 전자쪽지 등으로 할 수 있습니다.</li>
				<li>②&quot;회사&quot;는 &quot;회원&quot; 전체에 대한 통지의 경우 7일 이상 &quot;회사&quot;의 게시판에 게시함으로써 제1항의 통지에 갈음할 수 있습니다.</li>
				</ul>
				<h1 style='font-size: 13px'>제 10 조 (&quot;회사&quot;의 의무)</h1>
				<ul>
				<li>①&quot;회사&quot;는 관련법과 이 약관이 금지하거나 미풍양속에 반하는 행위를 하지 않으며, 계속적이고 안정적으로 &quot;서비스&quot;를 제공하기 위하여 최선을 다하여 노력합니다.</li>
				<li>②&quot;회사&quot;는 &quot;회원&quot;이 안전하게 &quot;서비스&quot;를 이용할 수 있도록 개인정보(신용정보 포함)보호를 위해 보안시스템을 갖추어야 하며 개인정보취급방침을 공시하고 준수합니다.</li>
				<li>③&quot;회사&quot;는 서비스이용과 관련하여 &quot;회원&quot;으로부터 제기된 의견이나 불만이 정당하다고 인정할 경우에는 이를 처리하여야 합니다. &quot;회원&quot;이 제기한 의견이나 불만사항에 대해서는 게시판을 활용하거나 전자우편 등을 통하여 &quot;회원&quot;에게 처리과정 및 결과를 전달합니다.</li>
				</ul>
				<h1 style='font-size: 13px'>부칙</h1>
				<ul>
				<li>①이 약관은 2014년 01월 01일부터 적용됩니다.</li>
				<li>②2014년 01월 01일부터 시행되던 종전의 약관은 본 약관으로 대체합니다.</li>
				</ul>				</div>
			<div class="check">
				<input name="check1" id="check1" type="checkbox" value="1">본 이용약관에 동의합니다.
			</div>
		</fieldset>
		</br>
		<fieldset class="field2">
			<div class="bx">
				<p>정보통신망법 규정에 따라 본사이트에 회원가입 신청하시는 분께 수집하는 개인정보의 항목, 개인정보의 수집 및 이용목적, 
					개인정보의 보유 및 이용기간을 안내 드리오니 자세히 읽은 후 동의하여 주시기 바랍니다.</p>

				<h1 style='font-size: 13px'>가. 수집하는 개인정보의 항목</h1>
				<ul>
				<li>첫째, 회사는 회원가입, 각종 서비스의 제공을 위해 최초 회원가입 당시 아래와 같은 최소한의 개인정보를 필수항목으로 수집하고 있습니다.
					<ul>
					<li>&lt;회원가입&gt;
						<ul>
						<li>- 이름, 비밀번호, 연락처(메일주소 또는 휴대폰 번호)</li>
						</ul>
					</li>
					<li>&lt;영업사원 회원가입&gt;
						<ul>
						<li>- 이름, 비밀번호, 연락처(메일주소 또는 휴대폰 번호), 근무회사, 근무지점</li>
						</ul>
					</li>						
					</ul>
				</li>
				<li>둘째, 서비스 이용과정이나 사업처리 과정에서 아래와 같은 정보들이 자동으로 생성되어 수집될 수 있습니다.
					<ul>
					<li>- IP Address, 쿠키, 방문 일시, 서비스 이용 기록, 불량 이용 기록</li>
					</ul>
				</li>
				</ul>
				<h1 style='font-size: 13px'>나. 개인정보 수집방법</h1>
				<ul>
				<li>회사는 다음과 같은 방법으로 개인정보를 수집합니다.
					<ul>
					<li>- 홈페이지, 아이디, 이벤트 응모</li>
					</ul>
				</li>
				</ul>
				<h1 style='font-size: 13px'>개인정보의 수집 및 이용 목적</h1>
				<ul>
				<li>가. 회원관리
				<p>회원제 서비스 제공, 개인식별, 이용약관 위반 회원에 대한 이용제한 조치, 불만처리 등 민원처리, 고지사항 전달, 회원탈퇴의사의 확인</p></li>
				<li>나. 신규 서비스 개발 및 마케팅&middot;광고에의 활용
				</ul>
				<h1 style='font-size: 13px'>개인정보의 보유 및 이용기간</h1>
				<p>이용자의 개인정보는 원칙적으로 개인정보의 수집 및 이용목적이 달성되면 지체 없이 파기합니다. 단, 다음의 정보에 대해서는 아래의 이유로 명시한 기간 동안 보존합니다.</p>
			</div>
			<div class="check">
				<input name="check2" id="check2" type="checkbox" value="1">개인정보 수집 및 이용에 동의합니다.
			</div>
		</fieldset>		
		</br>
		<div style='text-align: center;' id='divISubmit'>
			<input type='submit' class="btn btn-primary" value='동의합니다' onClick="fnChoiceMemberType();" />	
			<a href="#" class="btn" data-dismiss="modal" onClick="location.href='/main';">동의하지 않습니다</a>
		</div>	
	</div>
</div>

<div class="control-group" id='divChoiceMember' style='text-align: center;'>
	<div>		
		<input type='hidden' id='hdnChoiceUserType' name='hdnChoiceUserType' />
		<button class="btn btn-large btn-primary" onclick="fnFrmInitialize(2); $('#hdnChoiceUserType').val('N');">일반회원</button>
	<div>
	<div style='height: 10px;'></div>
	</div>
		<button class="btn btn-large btn-primary" onclick="fnFrmInitialize(2); $('#hdnChoiceUserType').val('S');">영업사원</button>
	</div>
</div>

<div class="control-group" id='divContent' style='text-align: center;'>
	<table border='0' align='center' style='width: 220px;' >
	<tr>
		<td>
			<div id='divNormal' style='text-align: center; width: 220px;'>
				<form id='frmNormal' name='frmNormal' method='post' action='/account/register'>
					<div class="control-group" id='divNormalCase'>
						<div class="control-label" style='text-align: left;'><i class="icon-check"></i>아이디(이메일)</div>
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
						<div class="control-label" style='text-align: left;'>전화번호</div>
						<div class="controls"><input type='text' id='tbxMobile' name='mobile' /></div>
						<div class="control-label" style='text-align: left;'>거주지역</div>
						<div class="controls">
							<div class="bs-docs-example">		  
								<select name="ddlSido"  id="ddlSido" onchange="fnChangeRegion(this);" >		   
								   	<c:forEach items="${regions}" var="region">
								   		<option value="${region.sido}">${region.sido}</option>
								   	</c:forEach>
							   	</select>
								<select id="ddlguGun"></select>							   	
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
						<a href="/main" class="btn" data-dismiss="modal">취소</a>
					</div>
				</form>
			</div>
			<div id='divSales' style='text-align: center; width:220px;'>
				<form id='frmSales' name='frmSales' method='post' action='/account/register'>	
					<div class="control-group" id='divSalesCase'>
						<div class="control-label" style='text-align: left;'><i class="icon-check"></i>아이디(이메일)</div>
						<div class="controls">
							<input type='hidden' id='hdnUserType' name='userType' value='2' />
							<input type='text' id='tbxSalesmanId' name='userId' />
						</div>
						<div class="control-label" style='text-align: left;'><i class="icon-check"></i>비밀번호</div>
						<div class="controls"><input type='password' id='tbxSPwd' name='password' /></div>
						<div class="control-label" style='text-align: left;'><i class="icon-check"></i>비밀번호 확인</div>
						<div class="controls"><input type='password' id='tbxPwdConfirm' name='passwordConfirm' /></div>		
						<div class="control-label" style='text-align: left;'><i class="icon-check"></i>성명</div>
						<div class="controls"><input type='text' id='tbxUserNm' name='userNm' /></div>
						<div class="control-label" style='text-align: left;'>핸드폰 번호</div>
						<div class="controls"><input type='text' id='tbxMobile' name='mobile' /></div>
						<div class="control-label" style='text-align: left;'>사무실 전화번호</div>
						<div class="controls"><input type='text' id='tbxOffice' name='officeNo' /></div>	
						<div class="control-label" style='text-align: left;'><i class="icon-check"></i>소속회사</div>
						<div class="controls">
							<select id='ddlVendor' name='vendorId'>
								<option value=''>::::선택::::</option>
								<c:forEach items="${vendorCodes}" var="vendor" >	
									<option value='${vendor.code}'>${vendor.value}</option>
								</c:forEach>
							</select>
						</div>						
						<div class="control-label" style='text-align: left;'>근무지점</div>
						<div class="controls"><input type='text' id='tbxLocation' name='location' /></div>		
						<div class="control-label" style='text-align: left;'><i class="icon-check"></i>인사말</div>
						<div class="controls">
							<textarea id='tbxIntro' name='introMsg' rows="3"></textarea>
						</div>	
					</div>
					<div style='text-align: center;' id='divSSubmit' class='divSubmit'>
						<input type='submit' class="btn btn-primary" value='회원가입' />	
						<a href="/main" class="btn" data-dismiss="modal">취소</a>
					</div>
				</form>
			</div>		
		</td>
	</tr>
	</table>
</div>	
</mvc:simple>