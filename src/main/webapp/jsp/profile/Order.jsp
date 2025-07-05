<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="model.Bean.User" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    request.setAttribute("pageTitle", "BricoShop - User Orders");
%>
<!DOCTYPE html>
<html lang="it">
<head>
    <title>Orders</title>
    <jsp:include page="/WEB-INF/jsp/components/common/headContent.jsp" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/order.css">
</head>

<body>
    <jsp:include page="/WEB-INF/jsp/components/common/header.jsp" />

    <main class="listorders-user-container">
        <div class="listorders-user-list">
            <h1>I tuoi ordini</h1>

            <c:choose>
                <c:when test="${not empty orderList}">
                    <c:forEach var="order" items="${orderList}">
                        <div class="listorders-user-order-card">
                            <div class="order-card-details">
                                <p>Stato: ${order.status}</p>
                                <p>Data: ${order.orderDate}</p>
                            </div>

                            <div class="order-card-products-section">
                                <p>Prodotti:</p>

                                <div class="listorders-user-order-card-products">
                                    <c:forEach var="item" items="${order.orderItems}">
                                        <c:forEach var="product" items="${productList}">
                                            <c:if test="${product.productId == item.productId}">
                                                <div class="order-product-item">
                                                    <img src="${pageContext.request.contextPath}/ImageServlet?productId=${item.productId}"
                                                         alt="Immagine prodotto">
                                                    <div class="product-info">
                                                        <h4 class="product-name">${product.productName}</h4>
                                                        <p>Prezzo: €${product.price}</p>
                                                        <p>Quantità: ${item.quantity}</p>
                                                        <p>Totale: <fmt:formatNumber value="${product.price * item.quantity}" type="currency" currencySymbol="€" /></p>
                                                    </div>
                                                </div>
                                            </c:if>
                                        </c:forEach>
                                    </c:forEach>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <p class="no-orders-message">Non hai ancora effettuato nessun ordine</p>
                </c:otherwise>
            </c:choose>
        </div>
    </main>

    <jsp:include page="/WEB-INF/jsp/components/common/footer.jsp" />
</body>
</html>
