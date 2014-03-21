﻿$(document).on('pageinit', '#requestDetailPage' ,function(){

	$("#requestDetailPage").on('click', '#btnBack', function() {
		_Commn.fnPageMove("/request/list", $('#frm'));
	});	
	
	_Commn.fnMarkingLeftMenu($("#menuRequest"));
});

function fnContractWrite(userType) {
	if(userType != 2) {
		alert('일반 사용자는 사용할 수 없습니다');
		return;
	}
	
	_Commn.fnPageMove("/contract/writeform", $('#frm'));
}

function fnContractDetail(salesman) {
	$('#hdnSalesmanId').val(salesman);		
	_Commn.fnPageMove("/contract/detail", $('#frm'));		
}
