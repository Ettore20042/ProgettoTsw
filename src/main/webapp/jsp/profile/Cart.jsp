<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Bean.CartItem" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    request.setAttribute("pageTitle", "BricoShop - Cart");
%>
<!DOCTYPE html>
<html lang="it">
    <head>
        <title>Cart</title>
        <jsp:include page="/WEB-INF/jsp/components/common/headContent.jsp"/>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/cart.css">
        <script src="${pageContext.request.contextPath}/Js/profile/cart.js" defer></script>
    </head>
    <body>
        <jsp:include page="/WEB-INF/jsp/components/common/header.jsp"/>

        <div class="cart-container">
            <h1 class="cart-title">Il tuo carrello</h1>

            <%
                List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
                if (cart == null || cart.isEmpty()) {
            %>
            <div class="cart-empty">
                <p>Il carrello è vuoto.</p>
                <a href="${pageContext.request.contextPath}/CategoryServlet" class="continue-shopping"
                   style="width: 30%; display:inline-block; margin-top:5px;">
                    Continua lo shopping</a>
            </div>
            <%
            } else {
                double cartTotal = 0.0;
            %>
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
                    <%
                        for (CartItem item : cart) {
                            double itemTotal = item.getPrice() * item.getQuantity();
                            cartTotal += itemTotal;
                    %>
                    <tr class="cart-row" data-product-id="<%= item.getProductId() %>">
                        <td class="product-remove">
                            <form action="${pageContext.request.contextPath}/cart-update" method="post">
                                <input type="hidden" name="productId" value="<%= item.getProductId() %>">
                                <input type="hidden" name="action" value="remove">
                                <button type="submit" class="remove-button remove-item-btn">
                                    <img src="${pageContext.request.contextPath}/img/icon/delete.png" class="remove-icon">
                                </button>
                            </form>
                        </td>
                        <td class="product-name">
                            <%= item.getProductName() != null ? item.getProductName().replaceAll("<", "&lt;").replaceAll(">", "&gt;") : "" %>
                        </td>
                        <td class="product-quantity">
                            <form class="quantity-form" action="${pageContext.request.contextPath}/CartServlet" method="post">
                                <input type="hidden" name="productId" value="<%= item.getProductId() %>">
                                <input type="hidden" name="action" value="update">
                                <input type="number"
                                       class="quantity-input"
                                       name="quantity"
                                       data-product-id="<%= item.getProductId() %>"
                                       data-price="<%= item.getPrice() %>"
                                       value="<%= item.getQuantity() %>"
                                       min="1"
                                       max="999">
                            </form>
                        </td>
<%--                        <td class="product-price">&euro; <%= String.format("%.2f", item.getPrice()) %></td>--%>
                        <td class="total-value">&euro; <%= String.format("%.2f", itemTotal) %></td>
                    </tr>
                    <%
                        }
                    %>
                    </tbody>
                </table>
            </div>

            <div class="cart-summary">
                <div class="cart-total-label"><strong>
                    <span>Totale</span>
                    <span class="cart-total-value">&euro; <%= String.format("%.2f", cartTotal) %></span>
                </strong>
                </div>
            </div>


            <div class="cart-actions">
                <a href="${pageContext.request.contextPath}/CategoryServlet" class="continue-shopping">Continua lo shopping</a>
                <form action="${pageContext.request.contextPath}/CheckoutServlet" method="post" class=" checkout-btn"> <button>Procedi al checkout</button></form>
            </div>
            <%
                }
            %>
        </div>

        <jsp:include page="/WEB-INF/jsp/components/common/footer.jsp"/>
    </body>
</html>
