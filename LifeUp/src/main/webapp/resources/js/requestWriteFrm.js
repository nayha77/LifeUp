var _Commn = new webService.Web.ComnService();

$(document).on('pageinit', '#requestWriteFrmPage' ,function(){
	// 선택 메뉴 마킹
	_Commn.fnMarkingLeftMenu($("#menuRequest"));
	
	_Commn.SetDatePickter();					
});

function fnWriteFrmList() {
	_Commn.fnPageMove("/request/list");
}

function fnSidoChange(obj){
	if(obj.value == '0')			
		return;
		
		$("#ddlGugun").find("option").remove().end().append("<option value=\"\">선택</option>");

		_Async.post (
			"/selectRegionJson",
			sido_cd = obj.value,
			function (data) {    
			var resultData = data.Sido2; 
			
			$.each(resultData, function(index, row){	    		      		
				$("#ddlGugun").append("<option value='"+ row.gugun_cd +"'>" + row.gugun_nm  + "</option>");	
			});
			
			$("#ddlGugun").show();
			$("#ddlGugun").selectmenu("refresh");
			}    			
		);   	         
}	

// 차량 종류 셀렉박스
function fnVenderChange(obj){
	if(obj.value == '')
		return;
	
		$("#ddlCar").find("option").remove().end().append("<option value=\"\">선택</option>");
		
	    _Async.post (
			"/selectCarJson",
			venderId = obj.value,
			function (data) {    
				var resultData = data.carCodeList;  
			$.each(resultData, function(index, row){
				$("#ddlCar").append("<option value='"+ row.car_id +"'>" + row.car_nm  + "</option>");    		        	  
			});
			
			$("#ddlCar").show();
			$("#ddlCar").selectmenu("refresh");							
			} 
		);   	       
}	

function fnChangeDDL(obj) {
	$(obj).parent().parent().find(".error").hide();
}

function fnChangeTextValue(obj) {
	if(obj != "")
		$(obj).parent().parent().find(".error").hide();
}

function fnWriteFrmSave() {		
	var check = true;
	
	$('.error').hide();
	
	if($('#ddlSido').val() == "" || $('#ddlGugun').val() == "") {
		check = false;
		$('#ddlGugun').parent().after('<div class="error" style="padding-top: 13px;">거주지역을 선택하세요</div>');
	} else if($('#ddlVendor').val() == "" || $('#ddlCar').val() == "") {
		check = false;
		$('#ddlCar').parent().after('<div class="error" style="padding-top: 13px;">차량을 선택하세요</div>');
	} else if($('#carTrim').val() == "") {
		check = false;
		$('#carTrim').focus();
		$('#carTrim').parent().after('<div class="error" style="padding-top: 13px;">트림을 입력하세요</div>');
	} else if($('#carOption').val() == "") {
		check = false;
		$('#carOption').focus();
		$('#carOption').parent().after('<div class="error" style="padding-top: 13px;">옵션을 입력하세요</div>');			
	} else if($('#purchase_period_cd').val() == "") {
		check = false;
		$('#purchase_period_cd').parent().after('<div class="error" style="padding-top: 13px;">구매예정일을 입력하세요</div>');
	} else if($('#customer_req').val() == "") {
		check = false;
		$('#customer_req').focus();
		$('#customer_req').parent().after('<div class="error" style="padding-top: 13px;">요구사항을 입력하세요</div>');
	}				
	
	if(check == false)
		return;
	
	    _Async.post (
			"/request/writing",
			JSON.stringify({ region_cd: $('#ddlGugun').val(), 
							 car_id: $('#ddlCar').val(), 
							 car_trim: $('#carTrim').val(), 
							 car_option: $('#carOption').val(),
							 purchase_period_cd: $('#purchase_period_cd').val(),
							 customer_req: $('#customer_req').val()}),
			function (data) {    
				if(data.message == "success") {
					_Commn.fnPageMove("/request/list");
				} else {
					alert(data.message);
				}			
			} 
		);   
}
