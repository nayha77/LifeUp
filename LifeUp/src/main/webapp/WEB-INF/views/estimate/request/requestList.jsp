<%@ page language="java" contentType="text/html; charset=UTF-8"%>

<%@ taglib prefix="mvc" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

  
<mvc:simple>
<style type="text/css">
.focus-list .list {width:100%;}
.bond-num {position:relative;float:left;overflow: hidden;width:513px;height:126px;border:1px solid #c8c8c8;}
.bond-num h3 {font-size:16px;height:50px;line-height: 52px;border-bottom:1px solid #c8c8c8;color:#151515;}
.bond-num span {display:inline-block;margin-left:18px;margin-right:15px;color:#767676;}
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
						//$(".items").append("<li class='media'>" + row.CUSTOMER_REQ + "</li>");
						$(".media-list").append("<li class='media'><a class='pull-left' href='#'><img class='media-object' img src='/resources/img/request/member.png'></a>");
						$(".media-list").append("<div class='media-body'>");
						$(".media-list").append("<h4 class='media-heading'>"+row.CUSTOMER_REQ + "</h4>");
						$(".media-list").append(	row.CUSTOMER_REQ	);
						$(".media-list").append("  <div class='media'>");
						$(".media-list").append("    test");
						$(".media-list").append("   </div>");
						$(".media-list").append(" </div>");						
						$(".media-list").append("</li>");
					});
					$('#hdnCurrentSeq').val(data.currentSeq);
					//console.log("li =" + $("li").last().attr('id'));
					//console.log("data ==" + data.currentSeq);
					$('div#lastPostsLoader').empty();
				}else{
					$('div#lastPostsLoader').empty();
					$('div#lastPostsLoader').html("더 누르지 말아효~~");
					//console.log("data nothing");
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
	<div class="span12">
		<form id='frm' name='frm'>
		<input type='hidden' id='hdnCurrentSeq' name='hdnCurrentSeq' value='2' />
		<ul class="media-list">
			<c:forEach items="${estimateRegList}" var="estimateReg" varStatus="status">
			  	<li class="media">
			    <a class="pull-left" href="#">
			      <img class="media-object" img src="/resources/img/request/member.png">
			    </a>
			    <div class="media-body">
			      <h4 class="media-heading">${estimateReg.CUSTOMER_REQ}</h4>
			      	${estimateReg.CUSTOMER_REQ}
			      <!-- 안에 있는 미디어 객체 -->
			      <div class="media">
			        test
			     </div>
			    </div>
			  	</li>
			</c:forEach>
		</ul>
		<div id="lastPostsLoader" ></div>
		<input type='button' value="더보기" onclick="lastAddedLiveFunc();" />
		</form>					
	</div>
	
<%-- 	<div class="span12">	
		<div id="tab_list" class="focus-list">	
			<div class="list">	    	
				<div class="bond-num">
				<h3><span>지역</span><strong>1354545-4546542</strong>(차량종류)</h3>
					<form id='frm' name='frm'>
					<input type='hidden' id='hdnCurrentSeq' name='hdnCurrentSeq' value='2' />
					<input type='button' value="테스트" onclick="lastAddedLiveFunc();" />
					<ul class="items">	
					 	<c:forEach items="${estimateRegList}" var="estimateReg" varStatus="status">
					 	<li id="${status.count}">${estimateReg.CUSTOMER_REQ}</li>
						</c:forEach>
					</ul>
					<div id="lastPostsLoader" ></div>
					</form>
				</div>
			</div>
		</div>
	</div> --%>	
	<div class="span12">		
		<ul class="breadcrumb">
         <li><a href="/">홈</a> <span class="divider">/</span></li>
		 <li><a href="/request/writeform">등록</a> <span class="divider">/</span></li>
		 <li><a href="/request/list">리스트</a></li>        
        </ul>
	</div>	
</mvc:simple>