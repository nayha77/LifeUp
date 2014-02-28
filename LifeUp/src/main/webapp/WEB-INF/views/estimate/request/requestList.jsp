<%@ page language="java" contentType="text/html; charset=UTF-8"%>

<%@ taglib prefix="mvc" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
  
<mvc:main>
<style type="text/css">
	.selectedRow {
	   background-color: #F9EDA5;
	   cursor: pointer;
	}
</style>
<script type="text/javascript">
	function fnLoad() {		     
		fnInit();		
		
		$('#hdnCurrentSeq').val(${param.currentSeq});
	}
	
	function fnInit() {
		$("div[id^=contents]").mouseover(function(e){
			 $(this).addClass('selectedRow');
		}).mouseout(function() {
	        $(this).removeClass('selectedRow');
	   	});

//		$("div[id^=contents]").click(function(e){
//		});		
	}	
	
	function fnWrite(userCheck) {
		if(typeof(userCheck) == "undefined" || userCheck == '2') {
			alert('일반사용자는 로그인 후 등록할 수 있습니다');
			return;
		}
		
		location.href="/request/writeform";
	}
	
	function fnDetail(requestId) {
		$('#hdnID').val(requestId);		
		document.frm.action = "/request/detail";
		document.frm.submit();
	}	
	
	function lastAddedLiveFunc()
	{		
		_Async.post (
    		"/request/listJson",
    		currentSeq = $('#hdnCurrentSeq').val(),
    		function (data) {
				if (data.list != "") {
					$.each(data.list, function(idx, row) {
 						$(".messages").append("<div id='contents' onclick=\"fnDetail('"+row.REQUEST_ID+"');\" class='message other alert pinned alert alert-success chrome-extension' style='margin-bottom: 7px; padding-right: 15px;'><div id='"+row.REQUEST_ID+"' class='message-title' style='height: 8px;'><span class='text'>"+row.REGION_NM + " > "+  row.VENDOR_NM + " > " + row.CAR_NM + " > " + "</span><span style='float: right;'>" + row.CREATE_DATE + "</span></div><hr class='message-inner-separator' style='margin-bottom: 10px;'><div class='info-inner' style='vertical-align: top;'>"+row.CUSTOMER_REQ +"</div>");						
 						$(".messages").append("</div>");
					});
					
					$('#hdnCurrentSeq').val(data.currentSeq);					
					$('div#lastPostsLoader').empty();
							
					fnInit();
				} else {					
					$('div#lastPostsLoader').empty();					
					$('#moreView').empty();
					$('#moreView').text("더이상 등록된 견적 요청정보가 없습니다");
				}			
			}
    	); 
	}
</script>
<form id='frm' name='frm' method='post'>
	<input type='hidden' id='hdnCurrentSeq' name='currentSeq' value='5' />
	<input type='hidden' id='hdnID' name='ID'/>
	<div class="messages" style="margin-bottom: -10px;">		
		<c:forEach items="${estimateRegList}" var="estimateReg" varStatus="status">
			<div id="contents" onclick="fnDetail('${estimateReg.REQUEST_ID}');" class="message other alert pinned alert alert-success chrome-extension" style="margin-bottom: 7px; padding-right: 15px;">
			    <div id="${estimateReg.REQUEST_ID}" class="message-title" style='height: 8px;'>
			    	<span class="text" >${estimateReg.REGION_NM} > ${estimateReg.VENDOR_NM} > ${estimateReg.CAR_NM}</span>
			    	<span style='float: right;'>${estimateReg.CREATE_DATE}</span>
			    </div>
			    <hr class="message-inner-separator" style='margin-bottom: 10px;'>
			    <div class="info-inner" style='vertical-align: top;'>
			       ${estimateReg.CUSTOMER_REQ}
			    </div>
			</div>
		</c:forEach>
	</div>					
</form>
<div>
	<ul class="breadcrumb" style='text-align: center; cursor: pointer;' onclick='lastAddedLiveFunc();'>
		<li id='moreView'>더보기</li>
	</ul>
</div>
<div style='float: right;'>
	<span class="breadcrumb" onclick="fnWrite(${sessionScope._USER_INFO_.userType});" style="cursor: pointer;">등록</span>
</div>				
</mvc:main>