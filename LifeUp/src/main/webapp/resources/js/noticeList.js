$(document).on('pageinit', '#NoticeListPage' ,function(){
	
	$("#NoticeListPage").on('click', '#btnBack', function() {
		_Commn.fnPageMove("/main");
	});		
	
	_Commn.fnMarkingLeftMenu($("#menuFAQ"));
});	