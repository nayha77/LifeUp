<%@ page language="java" contentType="text/html; charset=UTF-8"%>

<%@ taglib prefix="mvc" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
  
<mvc:main>
<script type="text/javascript">	
	$(document).ready(function() {
	});		

	function fnWrite(userCheck) {
		if(typeof(userCheck) == "undefined" || userCheck == '2') {
			alert('로그인 후 등록할 수 있습니다');
			return;
		}
		
		location.href="/request/writeform";
	}
	
	function fnDetail(requestId) {
		$('#hdnRequestId').val(requestId);		
		document.frm.action = "/request/detail";
		document.frm.submit();
	}		
	
	// 지역(시/도) 조회 및 지역(구/군) 셋팅
	function fnSidoChange(obj){			
		
		if(obj.value == '') {			
			$("#ddlGugun").empty().data('options');
			$("#ddlGugun").find("option").end().append("<option value=\"\">구(군)</option>");
			$("#ddlGugun").selectmenu("refresh");
		} else {
	 		_Async.post (
	   			"/regionSecondJson",
	   			sido_cd = obj.value,
	   			function (data) {   				
	   				$("#ddlGugun").empty().data('options');
	   				$("#ddlGugun").find("option").end().append("<option value=\"\">구(군)</option>");
	   				
					var resultData = data.Sido2; 
					$.each(resultData, function(index, row){	    		      		
						$("#ddlGugun").append("<option value='"+ row.gugun_cd +"'>" + row.gugun_nm  + "</option>");	
					});
					
					$("#ddlGugun").show();
					$("#ddlGugun").selectmenu("refresh");
	   			}    			
	   		); 
		}
		
		fnSearch('R');
	}		
		
	// 검색조회 / 더보기 
	function fnSearch(type)
	{			
		var currentSeq = $("#hdnCurrentSeq").val();
		if(type == "R" || type == "V") {
			currentSeq = 0;					
		}			
			
		_Async.post (
    		"/request/listJson",
    		JSON.stringify({ currentSeq: currentSeq, sido_cd: $('#ddlSido').val(), region_cd: $('#ddlGugun').val(), vendor_id: $('#ddlVendor').val() }),
    		function (data) {
    			if(type == "R" || type == "V") {
    				$("#rowData").empty();
    			}
    			
				if (data.list != null && data.list != "") {
					$.each(data.list, function(idx, row) {						
  						$("#rowData").append("<li data-role='list-divider'>" + row.REGION_NM + " > " + row.VENDOR_NM + " > " + row.CAR_NM + "<span class='ui-li-count'>" + row.HIT_CNT + "</span></li>");
 						$("#rowData").append("<li><a href='#' onclick=\"fnDetail('" + row.REQUEST_ID + "');\"><p>" + row.CUSTOMER_REQ + "</p>");
 						$("#rowData").append("</a></li>"); 				
					});					
					
					if(type == "M") {
						$('#hdnCurrentSeq').val(data.currentSeq);
					}
					
					$("#rowData").listview("refresh");
				} else {
					$('#moreView').val("더이상 등록된 견적 요청정보가 없습니다");	
					$("#moreView").button("refresh");
				}			
			}
    	); 
	}		
</script>

<div class="ui-content jqm-content jqm-fullwidth" style="padding-top: 0px;">
<form id='frm' name='frm' method='post'>
	<input type="hidden" id="hdnCurrentSeq" name='currentSeq' value='7'>
	<input type='hidden' id='hdnRequestId' name='request_id'/>		
	<div class="ui-grid-a" style="border-top: 0px; margin-top: 0px; padding-top: 0px;">
		<div class="ui-block-a" style="width:70%;">
			<div class="ui-block-a">
				<fieldset data-role="controlgroup" data-type="horizontal" data-mini="true">
				    <label for="ddlSido">시(도)</label>
				    <select name="ddlSido" id="ddlSido" onchange="fnSidoChange(this);">
				    	<option value="">시(도)</option>
						<c:forEach items="${sidos}" var="sido">
							<option value="${sido.sido_cd}">${sido.sido_nm}</option>
						</c:forEach>
				    </select>	
				    <label for="region_cd">구(군)</label>
				    <select name="region_cd" id="ddlGugun" onchange="fnSearch('R');">
				    	<option value="">구(군)</option>				   		
				    </select>				    		       
				</fieldset>
			</div>
			<div class="ui-block-b" style="padding-left: 7px;">
				<fieldset data-role="controlgroup" data-type="horizontal" data-mini="true">
				    <label for="ddlVendor">제조업체</label>
				    <select name="ddlVendor" id="ddlVendor"  onchange="fnSearch('V');">
				    	<option value="">제조업체</option>
				   		<c:forEach items="${venders}" var="vender">
				   			<option value="${vender.code}">${vender.value}</option>
				   		</c:forEach>
				    </select>			       
				</fieldset>
			</div>						
		</div>
		<div class="ui-block-b" style="width:30%; text-align: right;">
			<a href="#" data-role="button" data-icon="plus" data-inline="true" data-mini="true" onclick="fnWrite(${sessionScope._USER_INFO_.userType});">견적의뢰</a>
		</div>
	</div>	
	<ul data-role="listview" data-inset="true" id="rowData" style="margin-top: 0px;">
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
	<input type="button" data-icon="plus" value="더보기" id="moreView" onclick="fnSearch('M');">
</form>	
</div>
</mvc:main>