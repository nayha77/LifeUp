$(document).on('pageinit', '#contractDetailPage' ,function(){
	
	$("#contractDetailPage").on('click', '#btnBack', function() {
		_Commn.fnPageMove("/request/detail", $('#frm'));
	});
		
	$("#contractDetailPage").find("h1[id='pageTitle']").text("견적상세");	
	_Commn.fnMarkingLeftMenu($("#contractDetailPage").find("a[id='menuRequest']"));	
});	

function fnContractSave() {
	if($('#tbxSalesBenefit').val().trim() == "") {
		alert('견적을 입력하세요');
		return;
	}

	_Async.post (
		"/contract/registContract",
		JSON.stringify( { request_id: $('#hdnRequestId').val(), salesman_benefit: $('#tbxSalesBenefit').val() } ),
		function (data) {    
			if(data.message == 'success') {
				_Commn.fnPageMove("/contract/detail", $('#frm'));
			} else {
				alert(data.detail);
			}
		} 
	);
}

function fnContractConfirm() {
	_Async.post (
		"/request/updateContractStatus",
		JSON.stringify( { request_id: $('#hdnRequestId').val(), salesman_id : $('#hdnSalesman_id').val(), status : '0002' } ),
		function (data) {    
			if(data.message == 'success') {
				$('#btnConfirm').hide();						
			} else {
				alert(data.message);
			}
		} 
	);	
}

function fnContractCancel() {
	_Async.post (
		"/contract/contractCancel",
		JSON.stringify( { request_id: $('#hdnRequestId').val(), status : '0003' } ),
		function (data) {    
			if(data.message == 'success') {
				$('#btnCancel').hide();
			} else {
				alert(data.message);
			}
		} 
	);	
}

function fnContractReply() {
	if($('#tbxShortMsg').val().trim() == "") {
		alert('댓글 메세지를 입력하세요');
		return;
	}		
	
	_Async.post (
		"/contract/registReply",
		JSON.stringify( { request_id: $('#hdnRequestId').val(), salesman_id: $('#hdnSalesman_id').val(), message: $('#tbxShortMsg').val() } ),
		function (data) {    
			if(data.message == 'success') {				
				$('#replyContainer').append("<li data-icon='false'><a href='#' style='cursor: default;'>${sessionScope._USER_INFO_.userNm} " + $('#tbxShortMsg').val().trim() + "<span class='ui-li-count'>오늘</span></a></li>");
				$('#replyContainer').listview("refresh");
				
				$('#replyContainer').show();
				$('#tbxShortMsg').val("");
			} else {
				alert(data.detail);
			}
		} 
	);		
}