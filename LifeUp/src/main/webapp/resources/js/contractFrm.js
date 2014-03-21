$(document).on('pageinit', '#contractFrmPage' ,function(){
	
	$("#contractFrmPage").on('click', '#btnBack', function() {
		_Commn.fnPageMove("/request/detail", $('#frm'));
	});
	
	// 선택 메뉴 마킹
	_Commn.fnMarkingLeftMenu($("#menuRequest"));
	
	$('#tbxSalesBenefit').focus();
});	

function fnContractSave() {
	
	$('.error').hide();
	
	if($('#tbxSalesBenefit').val().trim() == "") {
		$('#tbxSalesBenefit').after('<div class="error" style="padding-top: 13px;">견적을 입력하세요</div>');
		return;
	}

	_Async.post (
		"/contract/registContract.do",
		JSON.stringify( { request_id: $('#hdnRequestId').val(), salesman_benefit: $('#tbxSalesBenefit').val() } ),
		function (data) {    
			if(data.message == 'success') {				
				_Commn.fnPageMove("/contract/writeform", $('#frm'));
			} else {
				alert(data.detail);
			}
		} 
	);
}
