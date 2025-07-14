<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Bean.CartItem" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="it">
    <head>
        <title>Cart</title>
        <jsp:include page="/WEB-INF/jsp/components/common/headContent.jsp"/>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/cart/cart.css">
        <script src="${pageContext.request.contextPath}/Js/cart/cart.js" defer></script>
    </head>
    <body data-context-path="${pageContext.request.contextPath}">
        <jsp:include page="/WEB-INF/jsp/components/common/header.jsp"/>

        <div class="cart-container">
            <h1 class="cart-title">Il tuo carrello</h1>

            <c:choose>
                <c:when test="${empty sessionScope.cart}">
                <div class="cart-empty">
                    <p>Il carrello è vuoto.</p>
                    <a href="${pageContext.request.contextPath}/CategoryServlet" class="continue-shopping"
                       >
                        Continua lo shopping</a>
                </div>
                </c:when>
                <c:otherwise>
                <div class="cart-table-container">
                    <table class="cart-table">
                        <thead>
                        <tr>
                            <th></th>
                            <th>Prodotto</th>
                            <th>Quantità</th>
                            <th>Prezzo</th>
                                <%--                        <th>Totale</th>--%>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="item" items="${sessionScope.cart}">
                            <tr class="cart-row" data-product-id="${item.getProductId()}">
                                <td class="product-remove">
                                    <form action="${pageContext.request.contextPath}/CartServlet" method="get">
                                        <input type="hidden" name="productId" value="${item.getProductId()}">
                                        <input type="hidden" name="action" value="remove">
                                        <button type="submit" class="remove-button remove-item-btn">
                                            <img src="${pageContext.request.contextPath}/img/icon/delete.png" class="remove-icon">
                                        </button>
                                    </form>
                                </td>
                                <td class="product-name">
                                        ${item.getProductName()}
                                </td>
                                <td class="product-quantity">
                                        <%--                            <form class="quantity-form" action="${pageContext.request.contextPath}/CartServlet" method="post">--%>
                                        <%--                                <input type="hidden" name="productId" value="<%= item.getProductId() %>">--%>
                                        <%--                                <input type="hidden" name="action" value="update">--%>
                                    <input type="number"
                                           class="quantity-input"
                                           name="quantity"
                                        <%--                                       data-product-id="<%= item.getProductId() %>"--%>
                                           data-price="${item.getPrice()}"
                                           value="${item.getQuantity()}"
                                           min="1"
                                           max="30000">
                                        <%--                            </form>--%>
                                </td>
                                    <%--                        <td class="product-price">&euro; <%= String.format("%.2f", item.getPrice()) %></td>--%>
                                <td class="total-value"><fmt:formatNumber value="${item.getPrice() * item.getQuantity()}" pattern="€#,##0.00" /></td>
                            </tr>
                        </c:forEach>

                        </tbody>
                    </table>
                </div>

                <div class="cart-summary">
                    <div class="cart-total-label"><strong>
                        <span>Totale</span>
                        <span class="cart-total-value">&euro;</span>
                    </strong>
                    </div>
                </div>


                <div class="cart-actions">
                    <a href="${pageContext.request.contextPath}/CategoryServlet" class="continue-shopping">Continua lo shopping</a>
                    <form action="${pageContext.request.contextPath}/CheckoutServlet" method="post"> <button class ="checkout-btn">Procedi al checkout</button></form>
                </div>
                </c:otherwise>
            </c:choose>




        </div>

        <jsp:include page="/WEB-INF/jsp/components/common/footer.jsp"/>
    </body>
</html>
