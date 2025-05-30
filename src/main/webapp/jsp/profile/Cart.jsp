<%@ page import="java.util.List" %>
<%@ page import="model.Bean.CartItem" %>

<%--
  Created by IntelliJ IDEA.
  User: Utente
  Date: 06/05/2025
  Time: 12:35
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    request.setAttribute("pageTitle", "BricoShop - Cart");
%>
<jsp:include page="/jsp/common/Header.jsp"/>

<body>
    <%
        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
        if (cart == null || cart.isEmpty()) {
    %>
    <p>Il carrello è vuoto.</p>
    <%
    } else {
    %>
    <table>
        <tr><th>Prodotto</th><th>Quantità</th><th>Prezzo</th></tr>
        <%
            for (CartItem item : cart) {
        %>
        <tr>
            <td><%= item.getProductName() %></td>
            <td><%= item.getQuantity() %></td>
            <td><%= item.getPrice() %></td>
        </tr>
        <%
            }
        %>
    </table>
    <%
        }
    %>

</body>
<jsp:include page="/jsp/common/Footer.jsp"/>
</html>