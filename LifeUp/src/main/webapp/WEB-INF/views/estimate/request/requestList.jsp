<%@ page language="java" contentType="text/html; charset=UTF-8"%>

<%@ taglib prefix="mvc" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

  
<mvc:simple>
<script src="http://code.jquery.com/mobile/1.0.1/jquery.mobile-1.0.1.min.js"></script>
<style type="text/css">

</style>

<script type="text/javascript">

	function fnLoad() {		     
		console.log('fnload');
	}

	function lastAddedLiveFunc()
	{
		//$('div#lastPostsLoader').html('<img src="bigLoader.gif">');
		//$('div#lastPostsLoader').html('<img src="bigLoader.gif">');
		//console.log(  $('.items li:last').html() );	
		_Async.post (
    		"/request/listJson",
    		currentSeq = $('#hdnCurrentSeq').val(),
    		function (data) {
				if (data.list != "") {
					$.each(data.list, function(idx, row) {
						$(".items").append("<li>" + row.CUSTOMER_REQ + "</li>");
					});
		
					$('#hdnCurrentSeq').val(data.currentSeq);
				}				
			}
    	); 
	}

	//lastAddedLiveFunc();

	$(window).scroll(function(){

		var wintop = $(window).scrollTop(), docheight = $(document).height(), winheight = $(window).height();
		var scrolltrigger = 0.95;
	
		if((wintop/(docheight-winheight)) > scrolltrigger) {
			lastAddedLiveFunc();			
		}	
	});	

</script>
<form id='frm' name='frm'>
<input type='hidden' id='hdnCurrentSeq' name='hdnCurrentSeq' value='2' />
<input type='button' value="테스트" onclick="lastAddedLiveFunc();" />
	<%--
     <c:forEach items="${estimateRegList}" var="estimateReg">
    	<tr onclick="document.location.href='<spring:url value="/${board.name}/post/${post.id}"/>';" style="cursor: pointer;">
        <td class="txt_c">${estimateReg.CUSTOMER_ID}</td>
        <td>${estimateReg.CUSTOMER_REQ}</td>
        <td class="txt_c">${estimateReg.CREATE_DATE}</td>
    </tr>
    </c:forEach> --%>
    	
	<ul class="items">	
	 	<c:forEach items="${estimateRegList}" var="estimateReg">
	 	<li>${estimateReg.CUSTOMER_REQ}</li>
		</c:forEach>
	</ul>

	<div id="lastPostsLoader" style="display:none"></div>
</form>
</mvc:simple>