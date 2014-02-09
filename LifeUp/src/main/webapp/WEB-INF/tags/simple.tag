<%@ tag language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang='ko'>
<head>
<meta charset='utf-8'>
	<title>SSAGEZYO</title>
	<meta name='viewport' content='width=device-width, initial-scale=1.0'>
	<meta name='description' content=''>
	<meta name='author' content=''>
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=IE8" />

	<!-- Le styles -->
	<link href='<spring:url value="/resources/css/bootstrap.css"/>' rel='stylesheet'>
	<link href='<spring:url value="/resources/css/bootstrap-select.css"/>' rel='stylesheet'>	
	<style type='text/css'>
		body {
			padding-top: 60px;
			padding-bottom: 40px;
		}        
        table.table thead th {
            text-align: center;
        }
        table.table .txt_c {
            text-align: center;
        }
	</style>
	<link href='<spring:url value="/resources/css/bootstrap-responsive.css"/>' rel='stylesheet'>
	<!-- Le HTML5 shim, for IE6-8 support of HTML5 elements -->
	<!--[if lt IE 9]>
      <script src='<spring:url value="/resources/js/html5.js"/>'></script>
    <![endif]-->
	<!-- Placed at the end of the document so the pages load faster -->
	<script src='<spring:url value="/resources/js/jquery.js"/>'></script>
	<script src='<spring:url value="http://ajax.aspnetcdn.com/ajax/jquery.validate/1.11.1/jquery.validate.js"/>'></script>	
	<script src='<spring:url value="/resources/js/bootstrap-transition.js"/>'></script>
	<script src='<spring:url value="/resources/js/bootstrap-alert.js"/>'></script>
	<script src='<spring:url value="/resources/js/bootstrap-modal.js"/>'></script>
	<script src='<spring:url value="/resources/js/bootstrap-dropdown.js"/>'></script>
	<script src='<spring:url value="/resources/js/bootstrap-scrollspy.js"/>'></script>
	<script src='<spring:url value="/resources/js/bootstrap-tab.js"/>'></script>
	<script src='<spring:url value="/resources/js/bootstrap-tooltip.js"/>'></script>
	<script src='<spring:url value="/resources/js/bootstrap-popover.js"/>'></script>
	<script src='<spring:url value="/resources/js/bootstrap-button.js"/>'></script>
	<script src='<spring:url value="/resources/js/bootstrap-collapse.js"/>'></script>
	<script src='<spring:url value="/resources/js/bootstrap-carousel.js"/>'></script>
	<script src='<spring:url value="/resources/js/bootstrap-typeahead.js"/>'></script>
	<script src='<spring:url value="/resources/js/bootstrap-select.js"/>'></script>	
	<script src='<spring:url value="/resources/js/webService.js"/>'></script>		
    <script type="text/javascript">
		var _Commn = new webService.Web.ComnService();
		var _Async = new webService.Web.AsyncService(_Commn.fnBeforRun, _Commn.fnAfterRun);

		function fnJQueryValidatorAdd() {
			//영문숫자만
	    	jQuery.validator.addMethod("alphanumeric", function (value, element) {
	    	    return this.optional(element) || /^[a-zA-Z0-9]+$/.test(value);
	    	});

	    	//영문만
	    	jQuery.validator.addMethod("alpha", function (value, element) {
	    	    return this.optional(element) || /^[a-zA-Z]+$/.test(value);
	    	});

	    	//숫자만
	    	jQuery.validator.addMethod("numeric", function (value, element) {
	    	    return this.optional(element) || /^[0-9]+$/.test(value);
	    	});

	    	//한글만
	    	$.validator.addMethod("hangle", function (value, element) {
	    	    return this.optional(element) || /^[\uAC00-\uD7A3]+$/.test(value);
	    	}, "");			
		}
		
	    $(document).ready(function() {
	    	fnJQueryValidatorAdd();
			fnLoad();
		});
    </script>    
</head>
<body>
	<div class='navbar navbar-fixed-top'>
		<div class='navbar-inner'>
			<div class='container'>
				<a class='btn btn-navbar' data-toggle='collapse' data-target='.nav-collapse'>
                    <span class='icon-bar'></span>
                    <span class='icon-bar'></span>
                    <span class='icon-bar'></span>
				</a>
                <a class='brand' href='<spring:url value="/main"/>'>SSAGEZYO</a>
			</div>
		</div>
	</div>
	<div class='container'>
		<jsp:doBody/>	
		<hr>
		<footer style="text-align: center;">
		<p></p>
		</footer>	
    </div>   
</body>
</html>