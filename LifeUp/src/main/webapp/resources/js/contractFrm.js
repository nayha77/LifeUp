$(document).on('pageinit', '#contractFrmPage' ,function(){
	
	$("#contractFrmPage").on('click', '#btnBack', function() {
		_Commn.fnPageMove("/request/detail", $('#frm'));
	});
	
	$("#contractFrmPage").find("h1[id='pageTitle']").text("견적의뢰");	
	_Commn.fnMarkingLeftMenu($("#contractFrmPage").find("a[id='menuRequest']"));	
	
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
