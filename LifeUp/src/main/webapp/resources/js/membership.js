$(document).on('pageinit', '#membershipPage' ,function() {
	$("#loginPage").on('click', '#btnBack', function() {
		_Commn.fnPageMove("/main");
	});	
	
	fnValidator();
});	

function fnShowDoc(docType) {
	if(docType == 1) {
		$("#divDocOne").toggle();
	} else {
		$("#divDocTwo").toggle();
	}			
}

function fnChoiceUser(userType) {
	if(userType == 1) {
		$("#divSalesForm").hide();
		$("#divNormalForm").show();
	} else {
		$("#divNormalForm").hide();
		$("#divSalesForm").show();
	}	
}

function fnAccountValidation() {
	if( !$('#chkAgreeOne').is(":checked") || !$('#chkAgreeTwo').is(":checked")) {
		alert('이용약관과 개인정보 수집 및 이용에 대한 안내를 모두 동의해주세요');
		return false;
	} 
	
	if($("#membershipFrm").find('input[name=userType]:radio:checked').val() == 1)
		$('#frmNormal').submit();
	else
		$('#frmSales').submit();    	
}

function fnValidator() {
	
	$('#frmNormal').validate({
        rules: {
        	userId: { required: true, email: true, "remote": {
	            		url: '/account/chkExistUserId.do?userType=1',
	            		type: "post",
	                    data: {
	                    	tbxUserId: function() {
	                            return $('#tbxUserId').val();
	                        }
	                    }
	          		} },   
      		userNm : { required: true }, 
        	password: { required: true },
        	passwordConfirm: { equalTo: "#tbxNPwd" },
            mobile: { required: true },
            region: { required: true }
        },
        messages: {
            userId: {
            			required: "아이디(이메일주소)를 입력하세요.",
                        email: "올바른 이메일주소를 입력하세요.",
                        remote : jQuery.format("중복 아이디 입니다")
                    },
			userNm: { required: "성명을 입력하세요." },  
			password: { required: "비밀번호를 입력하세요." },
			passwordConfirm: { equalTo: "비밀번호를 다시 확인하세요." },                       
            mobile: { required: "전화번호를 입력해주세요" },
            region: { required: "거주지역을 선택해주세요" }
        }
    });
	
	$('#frmSales').validate({
        rules: {
        	userId: { required: true, email: true, "remote": {
	            		url: '/account/chkExistUserId.do?userType=2',
	            		type: "post",
	                    data: {
	                    	tbxSalesmanId: function() {
	                            return $('#tbxSalesmanId').val();
	                        }
	                    }
	          		} },   
      		userNm : { required: true }, 
        	password: { required: true },
        	passwordConfirm: { equalTo: "#tbxSPwd" },
        	mobile: { required: true },
        	officeNo: { required: false },
        	vendorId: { required: true },
        	location: { required: false },
            introMsg: { required: true }                                
        },
        messages: {
            userId: {
            			required: "아이디(이메일주소)를 입력하세요.",
                        email: "올바른 이메일주소를 입력하세요.",
                        remote : jQuery.format("중복 아이디 입니다")
                    },
			userNm: { required: "성명을 입력하세요." },  
			password: { required: "비밀번호를 입력하세요." },
			passwordConfirm: { equalTo: "비밀번호를 다시 확인하세요." },
			mobile: { required: "전화번호를 입력해주세요" },
//				officeNo: { numeric: "숫자만 입력하세요." },                
          	vendorId: { required: "소속회사를 선택하세요." },
//              	location: { required: "근무지점을 입력하세요." },
          	introMsg: { required: "인사말을 입력하세요." }             
        }
    });		
}

function fnAccountSidoChange(obj) {

	if(obj.value == '0')			
		return;
		
	$("#ddlNGugun").find("option").remove().end().append("<option value=\"\">선택</option>");
	
	_Async.post (
		"/selectRegionJson",
		sido_cd = obj.value,
		function (data) {    
			var resultData = data.Sido2; 
			
			$.each(resultData, function(index, row){	    		      		
				$("#ddlNGugun").append("<option value='"+ row.gugun_cd +"'>" + row.gugun_nm  + "</option>");
			});
			
			$("#frmNormal").find("select[name='region']").selectmenu("refresh");
		}    			
	);   	         
}		