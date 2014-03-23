$(document).on('pageinit', '#myPageList' ,function(){	
	$("#myPageList").on('click', '#btnBack', function() {
		_Commn.fnPageMove("/main");
	});
	
	$("#myPageList").find("h1[id='pageTitle']").text("내정보");	
	_Commn.fnMarkingLeftMenu($("#myPageList").find("a[id='menuMyInfo']"));	
});

function fnMyPageReqDetail(requestId) {
	$('#hdnRequestId').val(requestId);
	_Commn.fnPageMove("/request/detail", $('#frm'));
}