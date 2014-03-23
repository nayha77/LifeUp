$(document).on('pageinit', '#requestListPage' ,function() {		
	$("#requestListPage").on('click', '#btnBack', function() {		
		_Commn.fnPageMove("/main");
	});
	
	_Commn.fnMarkingLeftMenu($("#menuRequest"));
	
	$('#ddlVendor').val('${param.vendorCd}');		
	$('#ddlSido').val('${param.sidoCd}');

	if($('#ddlSido').val != "")
		fnSidoChange('${param.gugunCd}', '${param.pageMove}');
});	

function fnSetCtrlVal() {
	$('#ddlVendor').val($('#hdnReqVendor').val());		
	$('#ddlSido').val($('#hdnReqSido').val());
	
 	$('#ddlStatus').val($('#hdnReqStatus').val());
 	$("#ddlStatus").selectmenu("refresh");	 
 	
	if($('#hdnReqSido').val != "")
		fnSidoChange($('#hdnReqGugun').val(), '${param.pageMove}');			
	}
 
function fnGetCtrlVal() {
	$('#hdnReqStatus').val($('#ddlStatus').val());
	$('#hdnReqVendor').val($('#ddlVendor').val());		
	$('#hdnReqSido').val($('#ddlSido').val());
	$('#hdnReqGugun').val($('#ddlGugun').val());
	
	$('#reqPopup').popup('close');
}
	
function fnReqWrite(userCheck) {
	if(typeof(userCheck) == "undefined" || userCheck == '2') {
		alert('로그인 후 등록할 수 있습니다');
		_Commn.fnPageMove("/account/login");
	} else {	
		_Commn.fnPageMove("/request/writeform");
	}
}

function fnReqDetail(requestId) {
	$('#hdnRequestId').val(requestId);
	_Commn.fnPageMove("/request/detail", $('#frm'));
}		 
	
// 지역(시/도) 조회 및 지역(구/군) 셋팅
function fnReqSidoChange(gugunCd, pageMoveYn) {			
	var sido = $('#ddlSido').val();

	if(typeof pageMoveYn == "undefined" || pageMoveYn == 'N')
		$("#hdnCurrentSeq").val('0');
				
	if(sido == '') {			
		$("#ddlGugun").empty().data('options');
		$("#ddlGugun").find("option").end().append("<option value=\"\">구(군)</option>");
		
		if(typeof pageMoveYn == "undefined" || pageMoveYn == 'N') {
			$("#ddlGugun").selectmenu("refresh");
			$("#ddlVendor").selectmenu("refresh");
			
			fnReqSearch();
		}
	} else {		
 		_Async.post (
   			"/selectRegionJson",
   			sido_cd = sido,
   			function (data) {   				
   				$("#ddlGugun").empty().data('options');
   				$("#ddlGugun").find("option").end().append("<option value=\"\">구(군)</option>");
   				
				var resultData = data.Sido2; 
				$.each(resultData, function(index, row){	    		      		
					$("#ddlGugun").append("<option value='"+ row.gugun_cd +"'>" + row.gugun_nm  + "</option>");	
				});
								
				if(gugunCd != "") { // 페이지 로딩시 조회 			
					$('#ddlGugun').val(gugunCd);
				}
				
				$("#ddlGugun").selectmenu("refresh");
									
				if(typeof pageMoveYn == "undefined" || pageMoveYn == 'N') {
					fnReqSearch();
					$("#hdnCurrentSeq").val(7);
				} else {
					$("#ddlSido").selectmenu("refresh");
					$("#ddlVendor").selectmenu("refresh");						
				}
   			}    			
   		); 	 		
	}			
}

// 드롭다운박스 검색조건 
function fnReqDDLChange() {
	$("#hdnCurrentSeq").val('0');
	fnReqSearch();
}

// 검색조회 
function fnReqSearch()
{			
	_Async.post (
		"/request/listJson",
		JSON.stringify({ currentSeq: $("#hdnCurrentSeq").val(), 
						 sido_cd: $('#ddlSido').val(), 
						 region_cd: $('#ddlGugun').val(), 
						 vendor_id: $('#ddlVendor').val(), 
						 status_cd: $('#ddlStatus').val() }),
		function (data) {
			$("#rowData").empty();
			
			if (data.list != null && data.list != "") {
				$.each(data.list, function(idx, row) {						
					$("#rowData").append("<li data-role='list-divider'>" + row.REGION_NM + " > " + row.VENDOR_NM + " > " + row.CAR_NM + "<span class='ui-li-count'>" + row.HIT_CNT + "</span></li>");
					$("#rowData").append("<li><a href='#' onclick=\"fnReqDetail('" + row.REQUEST_ID + "');\"><p>" + row.CUSTOMER_REQ + "</p>");
					$("#rowData").append("</a></li>"); 				
				});					
														
				$("#rowData").listview("refresh");					
				$("#hdnCurrentSeq").val(data.currentSeq);
				
				$('#moreView').val("더보기");	
			} else {
				$('#moreView').val("더이상 등록된 견적 요청정보가 없습니다");	
			}		
			
			$("#moreView").button("refresh");
		}    		    	
	); 
}

// 더보기 
function fnMoreView()
{			
	$('#moreView').val("더보기");	
	$("#moreView").button("refresh");
	
	_Async.post (
		"/request/listJson",
		JSON.stringify({ currentSeq: $("#hdnCurrentSeq").val(), 
						 sido_cd: $('#ddlSido').val(), 
						 region_cd: $('#ddlGugun').val(), 
						 vendor_id: $('#ddlVendor').val(), 
						 status_cd: $('#ddlStatus').val() }),
		function (data) {
			
			if (data.list != null && data.list != "") {
				$.each(data.list, function(idx, row) {						
					$("#rowData").append("<li data-role='list-divider' style='height:20px; padding-top: 10px;'>" + row.REGION_NM + " > " + row.VENDOR_NM + " > " + row.CAR_NM + "<span class='ui-li-count'>" + row.HIT_CNT + "</span></li>");
					$("#rowData").append("<li><a href='#' onclick=\"fnReqDetail('" + row.REQUEST_ID + "');\"  style='height:55px;'><p>" + row.CUSTOMER_REQ + "</p>");
					$("#rowData").append("</a></li>"); 				
				});					
				
				$('#hdnCurrentSeq').val(data.currentSeq);
				
				$("#rowData").listview("refresh");									
			} else {
				$('#moreView').val("더이상 등록된 견적 요청정보가 없습니다");	
				$("#moreView").button("refresh");
			}			
			
			$('#moreView').focus();			
		}
	); 
}
