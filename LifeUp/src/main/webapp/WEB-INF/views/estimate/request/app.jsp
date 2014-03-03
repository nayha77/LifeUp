<%@ page language="java" contentType="text/html; charset=UTF-8"%>

<%@ taglib prefix="mvc" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<mvc:simple>
<script type="text/javascript">	
	function fnLoad() {
	}
</script>

	<div class="messages">		
		<div id="contents" style="margin-bottom: 7px; padding-right: 15px;">
		    <div id="" class="message-title" style='height: 8px;'>
		    <span class="label label-info">--------</span>
			   	<span class="text">  ${user_id}</span>
			   	<span class="text">  | ${user_pw}</span>
			   	<span class="text">  | ${user_hpid}</span>			   	
			</div>
		</div>
	</div>

</mvc:simple>