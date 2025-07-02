<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%--
  Created by IntelliJ IDEA.
  User: ettor
  Date: 21/06/2025
  Time: 12:04
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Checkout</title>
    <jsp:include page="/WEB-INF/jsp/components/common/headContent.jsp"/>
</head>
<body>
<jsp:include page="/WEB-INF/jsp/components/common/header.jsp"/>

<h1>Checkout ${total},${quantity},${productId}</h1>
<c:forEach var="item" items="${cart}">
    <div class="checkout-item">
        <h2>${item.productName}</h2>
        <p>Prezzo: <fmt:formatNumber value="${item.price}" pattern="€#,##0.00"/></p>
        <p>Quantità: ${item.quantity}</p>

    </div>
</c:forEach>
<p>Totale: <fmt:formatNumber value="${total}" pattern="€#,##0.00"/></p>
<c:if test="${not empty addresses}">
    <c:forEach var="address" items="${addresses}">
        <div class="checkout-address">
            <h3>Indirizzo di spedizione</h3>
            <p>
                <c:if test="${not empty address.street}">${address.street}</c:if>
                <c:if test="${not empty address.city}">, ${address.city}</c:if>
                <c:if test="${not empty address.state}">, ${address.state}</c:if>
                <c:if test="${not empty address.zipCode}">, ${address.zipCode}</c:if>
            </p>
            <c:if test="${not empty address.country}">
                <p>${address.country}</p>
            </c:if>
        </div>
    </c:forEach>
</c:if>
<jsp:include page="/WEB-INF/jsp/components/common/footer.jsp"/>
</body>
</html>
