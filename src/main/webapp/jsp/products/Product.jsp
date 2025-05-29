<%@ page import="model.Bean.Product" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%--
  Created by IntelliJ IDEA.
  User: ettor
  Date: 29/04/2025
  Time: 11:39
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    Product product = (Product) request.getAttribute("product");
    request.setAttribute("pageTitle", product.getProductName());
%>
<jsp:include page="/jsp/common/Header.jsp"/>

<body>

    <main class="product-page">
        <section class="product-card">
            <h2 class="product-card--brand">${productBrand.getBrandName()}</h2>
            <h1 class="product-card--name">${product.getProductName()}</h1>
            <div class="product-card_images">
                <div class="product-card_slider-track">
                    <c:forEach var="image" items="${productImages}">
                        <img src="${pageContext.request.contextPath}/${image.getImagePath()}" alt="${image.getImageDescription()}" class="product-card_slide">
                    </c:forEach>
                </div>
            </div>
            <div class="product-card_details">
                <p class="product-card_details--price"><fmt:formatNumber value="${product.getPrice()}" pattern="€ #,##0.00" /></p>
                <p class="product-card_details--shipping">Iva inclusa. Spedizione gratuita</p>
                <%--Aggiungere elemento per quantità, da vedere se gestire con js oppure da server--%>
                <c:if test="${product.getQuantity() > 0}">
                    <div class="product-card_quantity">
                        <label class="product-card_quantity--label">Quantità: </label>
                        <select name="quantity" id="quantity" class="product-card_quantity--select">
                            <c:forEach begin="1" end="${product.getQuantity()}" var="i">
                                <option value="${i}">${i}</option>
                            </c:forEach>
                        </select>
                    </div>
                </c:if>
                <c:if test="${product.getQuantity() == 0}">
                    <p class="product-card_details--out-of-stock">Non disponibile momentaneamente</p>
                </c:if>
                <button class="product-card_buy-buttons product-card_add-to-cart--button">Aggiungi al carrello</button>
                <button class="product-card_buy-buttons product-card_buy-now--button">Acquista Ora</button>
            </div>
            <div class="product-card_description">
                <h2 class="product-card_description--heading">Descrizione</h2>
                <p>${product.getDescription()}</p>
            </div>
        </section>
    </main>


</body>
<jsp:include page="/jsp/common/Footer.jsp"/>
</html>
