<%@ page language="java" contentType="text/html; charset=UTF-8"%>

<%@ taglib prefix="mvc" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
  
<mvc:test>
<style type="text/css">
.selectedRow {
   background-color: #F9EDA5;
   cursor: pointer;
}

</style>

<script type="text/javascript">

	function fnLoad() {		     
		console.log('fnload');
		$("div[id^=contents]").mouseover(function(e){
			 $(this).addClass('selectedRow');
		}).mouseout(function() {
	        $(this).removeClass('selectedRow');
	   });
		
		//$("#contents").click(function(e){ 요건 전체 안먹음;;
		$("div[id^=contents]").click(function(e){
			var ID = $(this).find('p').attr('id');
			document.location.href='/request/detail?ID='+ID;
		});
		
		 $('.breadcrumb').focus();
	}
	
	function lastAddedLiveFunc()
	{
		$('div#lastPostsLoader').html('Loading. . .');
		_Async.post (
    		"/request/listJson",
    		currentSeq = $('#hdnCurrentSeq').val(),
    		function (data) {
				if (data.list != "") {
					$.each(data.list, function(idx, row) {
 						$(".messages").append("<div id='contents' class='message other alert pinned alert alert-success chrome-extension'><p id='"+row.REQUEST_ID+"'class='message-title'><span class='text'>"+row.REGION_NM + " > "+  row.CAR_NM+">"+ row.CREATE_DATE +"</span></p><hr class='message-inner-separator'><div class='info-inner'>"+row.CUSTOMER_REQ +":"+row.CUSTOMER_ID +"</div>");						
 						$(".messages").append("</div>");
					});
					$('#hdnCurrentSeq').val(data.currentSeq);
					
					$('div#lastPostsLoader').empty();
					fnLoad();
				}else{
					
					$('div#lastPostsLoader').empty();
					$('div#lastPostsLoader').html("마지막 데이타 입니다.");
				}				
			}
    	); 
	}

</script>

	<div class="alert alert-info">견적의뢰 하는 곳</div>
	
		<form id='frm' name='frm'>
		<input type='hidden' id='hdnCurrentSeq' name='hdnCurrentSeq' value='2' />
		<div class="messages">		
			<c:forEach items="${estimateRegList}" var="estimateReg" varStatus="status">
				<div id="contents" class="message other alert pinned alert alert-success chrome-extension" >
				    <p id="${estimateReg.REQUEST_ID}" class="message-title"><span class="text" >${estimateReg.REGION_NM}  > ${estimateReg.CAR_NM}> ${estimateReg.CREATE_DATE}</span></p>
				    <hr class="message-inner-separator">
				    <div class="info-inner">
				       ${estimateReg.CUSTOMER_REQ}: ${estimateReg.CUSTOMER_ID}
				    </div>
				</div>
			</c:forEach>
		</div>			
		<div id="lastPostsLoader" ></div>
		<input type='button' value="더보기" onclick="lastAddedLiveFunc();" />
		
		</form>		

			
		<ul class="breadcrumb">
         <li><a href="/">홈</a> <span class="divider">/</span></li>
		 <li><a href="/request/writeform">등록</a> <span class="divider">/</span></li>
		 <li><a href="/request/list">리스트</a></li>        
        </ul>
<script></script>	
</mvc:test>