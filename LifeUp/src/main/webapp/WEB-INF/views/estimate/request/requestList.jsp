<%@ taglib prefix="mvc" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<mvc:main>
<script type="text/javascript">
</script>


    <c:forEach items="${estimateRegList}" var="estimateReg">
    <tr onclick="document.location.href='<spring:url value="/${board.name}/post/${post.id}"/>';" style="cursor: pointer;">
        <td class="txt_c">${estimateReg.CUSTOMER_ID}</td>
        <td>${estimateReg.CUSTOMER_REQ}</td>
        <td class="txt_c">${estimateReg.CREATE_DATE}</td>
    </tr>
    </c:forEach>

</mvc:main>