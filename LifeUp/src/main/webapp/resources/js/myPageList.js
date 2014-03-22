$(document).on('pageinit', '#myPageList' ,function(){	
	$("#myPageList").on('click', '#btnBack', function() {
		_Commn.fnPageMove("/main");
	});
	
	_Commn.fnMarkingLeftMenu($("#menuMyInfo"));
});

function fnMyPageReqDetail(requestId) {
	$('#hdnRequestId').val(requestId);
	_Commn.fnPageMove("/request/detail", $('#frm'));
}