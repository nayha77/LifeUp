$(document).on('pageinit', '#faqListPage' ,function(){
	
	$("#faqListPage").on('click', '#btnBack', function() {
		_Commn.fnPageMove("/main");
	});	
	
	_Commn.fnMarkingLeftMenu($("#menuFAQ"));
});	