<%@ page language="java" contentType="text/html; charset=UTF-8"%>

<%@ taglib prefix="mvc" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>



<mvc:test>

<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.10.1/jquery.min.js"></script>    
<script src='<spring:url value="/resources/js/bootstrap-select.js"/>'></script>


    <script type="text/javascript">
        $(window).on('load', function () {
            $('.selectpicker').selectpicker({
                //'selectedText': 'cat'
            });

            // $('.selectpicker').selectpicker('hide');
        });
    </script>
    
<div class="bs-docs-example">
  
  <select class="selectpicker" data-live-search="true">
  <option>서울시 용산구</option>
     <option>서울시 구로구</option>
      <option>경기도 군포시 산본동</option>
      <option>경기도 안양시 산본동</option>
  </select>

</div>
  
  
</mvc:test>