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
	
	function fnChooseRegion() {
		if($("#ddlGugun").val() == "") {
			$("#ddlSido")[0].selectedIndex = 0;
			$("#ddlSido").selectmenu("refresh");
		}
		
		fnSearch('R');		
	}
	
	function fnSearch(type)
	{			
		var currentSeq = $("#hdnCurrentSeq").val();
		if(type == "R" || type == "V") {
			currentSeq = 0;					
		}
			
		_Async.post (
    		"/request/listJson",
    		JSON.stringify({ currentSeq: currentSeq, region_cd: $('#ddlGugun').val(), vendor_id: $('#ddlVendor').val() }),
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
	
	function fnSidoChange(obj){
		if(obj.value == '0')			
			return;
 		
 		$("#ddlGugun").find("option").remove().end().append("<option value=\"\">선택</option>");

 		_Async.post (
   			"/regionSecondJson",
   			sido = obj.value,
   			function (data) {    
				var resultData = data.Sido2; 
				
				$.each(resultData, function(index, row){	    		      		
					$("#ddlGugun").append("<option value='"+ row.region_cd +"'>" + row.gugun  + "</option>");	
				});
				
				$("#ddlGugun").show();
				$("#ddlGugun").selectmenu("refresh");
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
				<fieldset data-role="controlgroup" data-type="horizontal">
				    <label for="ddlSido">시도</label>
				    <select name="ddlSido" id="ddlSido" onchange="fnSidoChange(this);">
				    	<option value="">시도</option>
						<c:forEach items="${sidos}" var="sido">
							<option value="${sido.sido}">${sido.sido}</option>
						</c:forEach>
				    </select>	
				    <label for="region_cd">구군</label>
				    <select name="region_cd" id="ddlGugun" onchange="fnChooseRegion();">
				    	<option value="">구군</option>				   		
				    </select>				    		       
				</fieldset>
			</div>
			<div class="ui-block-b" style="padding-left: 3px;">
				<fieldset data-role="controlgroup" data-type="horizontal">
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
		<div class="ui-block-b" style="width:30%; margin-right: -10px; text-align: right;">
			<a href="#" data-role="button" data-icon="plus" data-inline="true" onclick="fnWrite(${sessionScope._USER_INFO_.userType});">견적의뢰</a>
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