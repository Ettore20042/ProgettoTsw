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
<html>
<head>
    <title>Prodotto</title>
    <jsp:include page="/jsp/common/HeadContent.jsp" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/product.css?v=<%=System.currentTimeMillis()%>" type="text/css"/>
</head>
<body>
<jsp:include page="/jsp/common/Header.jsp"/>
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
                <button class="product-card_buy-button product-card_add-to-cart--button">Aggiungi al carrello</button>
                <button class="product-card_buy-button product-card_buy-now--button">Acquista Ora</button>
            </div>
            <div class="product-card_description">
                <h2 class="product-card_description--heading">Descrizione</h2>
                <p>${product.getDescription()}</p>
            </div>
        </section>
    </main>
<jsp:include page="/jsp/common/Footer.jsp"/>
</body>
</html>
