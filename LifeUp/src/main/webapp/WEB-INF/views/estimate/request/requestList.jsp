<%@ page language="java" contentType="text/html; charset=UTF-8"%>

<%@ taglib prefix="mvc" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

  
<mvc:simple>
<style type="text/css">

</style>

<script type="text/javascript">

	function fnLoad() {		     
		console.log('fnload');
	}

	function lastAddedLiveFunc()
	{
		//$('div#lastPostsLoader').html('<img src="bigLoader.gif">');
		$('div#lastPostsLoader').html('Loading111');
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
					$('div#lastPostsLoader').empty();
				}				
			}
    	); 
	}

	$(window).scroll(function(){

		var wintop = $(window).scrollTop(), docheight = $(document).height(), winheight = $(window).height();
		var scrolltrigger = 0.95;
	
		if((wintop/(docheight-winheight)) > scrolltrigger) {
			lastAddedLiveFunc();			
		}	
	});	

</script>
	<!-- <div style="overflow-y:scroll; width:300px; height:150px;padding:10px;">  -->
	<div>
		<form id='frm' name='frm'>
		<input type='hidden' id='hdnCurrentSeq' name='hdnCurrentSeq' value='2' />
		<input type='button' value="테스트" onclick="lastAddedLiveFunc();" />
	    	
		<ul class="items">	
		 	<c:forEach items="${estimateRegList}" var="estimateReg">
		 	<li>${estimateReg.CUSTOMER_REQ}</li>
			</c:forEach>
		</ul>
		<div id="lastPostsLoader" ></div>
		</form>
	</div>
</mvc:simple>