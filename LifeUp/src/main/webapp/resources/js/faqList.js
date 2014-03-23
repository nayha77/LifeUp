$(document).on('pageinit', '#faqListPage' ,function(){
	
	$("#faqListPage").on('click', '#btnBack', function() {
		_Commn.fnPageMove("/main");
	});	
		
	$("#faqListPage").find("h1[id='pageTitle']").text("FAQ");	
	_Commn.fnMarkingLeftMenu($("#faqListPage").find("a[id='menuFAQ']"));	
});	