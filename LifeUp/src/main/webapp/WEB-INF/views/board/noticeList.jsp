<%@ page language="java" contentType="text/html; charset=UTF-8"%>

<%@ taglib prefix="mvc" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
  
<mvc:main>
<script type="text/javascript">	
	$(document).ready(function() {
	});
</script>

<div class="ui-content jqm-content jqm-fullwidth" style="padding-top: 0px;">
	<div data-role="collapsibleset" data-theme="a" data-content-theme="b">
		<c:forEach items="${noticeList}" var="notice" varStatus="status">
	    	<div data-role="collapsible">	    
			    <h2>${notice.TITLE}</h2>
		        <ul data-role="listview" data-theme="a" data-divider-theme="b">
		            <li><p><strong>${notice.CONTENT}</strong></p></li>
		        </ul>				       
		    </div>
		</c:forEach>		
	</div>
</div>
</mvc:main>