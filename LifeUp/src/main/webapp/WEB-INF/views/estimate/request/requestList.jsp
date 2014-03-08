<%@ page language="java" contentType="text/html; charset=UTF-8"%>

<%@ taglib prefix="mvc" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
  
<mvc:main>
<script type="text/javascript">
	function fnLoad() {		   			
	}
	
	function fnWrite(userCheck) {
		if(typeof(userCheck) == "undefined" || userCheck == '2') {
			alert('일반사용자만이 등록할 수 있습니다');
			return;
		}
		
		location.href="/request/writeform";
	}
	
	function fnDetail(requestId) {
		$('#hdnRequestId').val(requestId);		
		document.frm.action = "/request/detail";
		document.frm.submit();
	}	
	
	function lastAddedLiveFunc()
	{			
		_Async.post (
    		"/request/listJson",
    		currentSeq = $('#hdnCurrentSeq').val(),
    		function (data) {
				if (data.list != null && data.list != "") {
					$.each(data.list, function(idx, row) {						
  						$("#rowData").append("<li data-role='list-divider'>" + row.REGION_NM + " > " + row.VENDOR_NM + " > " + row.CAR_NM + "<span class='ui-li-count'>" + row.HIT_CNT + "</span></li>");
 						$("#rowData").append("<li><a href='#' onclick=\"fnDetail('" + row.REQUEST_ID + "');\"><p>" + row.CUSTOMER_REQ + "</p>");
 						$("#rowData").append("</a></li>");
					});					
					
					$('#hdnCurrentSeq').val(data.currentSeq);
				} else {							
					$('#moreView').val("더이상 등록된 견적 요청정보가 없습니다");	
				}			
			}
    	); 
	}
</script>
<form id='frm' name='frm' method='post'>
<input type="hidden" id="hdnCurrentSeq" name='currentSeq' value='7'>
<input type='hidden' id='hdnRequestId' name='request_id'/>		
</form>
<div class="ui-content jqm-content jqm-fullwidth" style="padding-top: 0px;">
	<c:if test="${not empty sessionScope._USER_INFO_ && sessionScope._USER_INFO_.userType == '1'}" >
		<div style="margin-bottom: -15px; margin-right: -10px; text-align: right;">
			<a href="#" data-role="button" data-icon="plus" data-inline="true" onclick="fnWrite(${sessionScope._USER_INFO_.userType});">견적의뢰</a>
		</div>
	</c:if>
	<ul data-role="listview" data-inset="true" id="rowData">
		<c:forEach items="${estimateRegList}" var="estimateReg" varStatus="status">
		    <li data-role="list-divider">
		    	${estimateReg.REGION_NM} > ${estimateReg.VENDOR_NM} > ${estimateReg.CAR_NM}
		    	<span class="ui-li-count">${estimateReg.HIT_CNT}</span>
		    </li>
		    <li>
		    	<a href="#" onclick="fnDetail('${estimateReg.REQUEST_ID}');">
			    	<p>${estimateReg.CUSTOMER_REQ}</p>
		        </a>
		    </li>
		</c:forEach>
	</ul>
	<input type="button" data-icon="plus" value="더보기" id="moreView" onclick='lastAddedLiveFunc();'>
</div>
</mvc:main>