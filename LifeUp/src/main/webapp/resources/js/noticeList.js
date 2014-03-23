$(document).on('pageinit', '#noticeListPage' ,function(){
	
	$("#noticeListPage").on('click', '#btnBack', function() {
		_Commn.fnPageMove("/main");
	});		
	
	$("#noticeListPage").find("h1[id='pageTitle']").text("공지사항");	
	_Commn.fnMarkingLeftMenu($("#noticeListPage").find("a[id='menuNotice']"));	
});	