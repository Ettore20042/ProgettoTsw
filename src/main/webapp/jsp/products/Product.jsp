<%@ page import="model.Bean.Product" %>
<%@ page import="model.Bean.User" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    Product product = (Product) request.getAttribute("product");
    request.setAttribute("pageTitle", product.getProductName());
%>
<!DOCTYPE html>
<html lang="it">
<head>
    <title><c:out value="${pageTitle}" default="BricoShop"/></title>
    <jsp:include page="/jsp/common/HeadContent.jsp" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/product.css">
    <script src="${pageContext.request.contextPath}/Js/products/ProductPage.js" defer></script>
</head>
<body>
    <jsp:include page="/jsp/common/Header.jsp"/>
    <main class="product-page">

        <div class="breadcrumb">
            <div class="breadcrumb_wrapper">
                <c:forEach var="category" items="${breadcrumbCategories}">
                    <a href="${pageContext.request.contextPath}/ProductListServlet?categoryId=${category.categoryId}" class="breadcrumb_item breadcrumb_link">${category.categoryName}</a>
                    <span class="material-symbols-rounded">keyboard_arrow_right</span>
                </c:forEach>
                <span class="breadcrumb_item">${product.getProductName()}</span>
            </div>
        </div>


        <section class="product-card">
            <div class="product-card_header-info">
                <h2 class="product-card_brand">${productBrand.getBrandName()}</h2>
                <h1 class="product-card_name">${product.getProductName()}</h1>
            </div>

            <div class="product-card_gallery">
                <div class="product-card_gallery-track">
                    <c:forEach var="image" items="${productImages}">
                        <div class="product-card_gallery-item">
                            <img src="${pageContext.request.contextPath}/${image.getImagePath()}" alt="${image.getImageDescription()}" class="product-card_image">
                        </div>
                    </c:forEach>
                </div>

                <button class="product-card_arrow product-card_arrow--prev" aria-label="Immagine precedente">❮</button>
                <button class="product-card_arrow product-card_arrow--next" aria-label="Immagine successiva">❯</button>

                <div class="product-card_gallery-dots">
                    <%-- I pallini verranno generati da JavaScript --%>
                </div>
            </div>


            <div class="product-card_details">
                <p class="product-card_price"><fmt:formatNumber value="${product.getPrice()}" pattern="€ #,##0.00" /></p>
                <p class="product-card_shipping-info">Iva inclusa. Spedizione gratuita</p>
                <%--Aggiungere elemento per quantità, da vedere se gestire con js oppure da server--%>
                <c:if test="${product.getQuantity() > 0}">
                    <div class="product-card_quantity">
                        <label class="product-card_quantity-label">Quantità: </label>
                        <select name="quantity" id="quantity" class="product-card_quantity-select">
                            <c:forEach begin="1" end="${product.getQuantity()}" var="i">
                                <option value="${i}">${i}</option>
                            </c:forEach>
                        </select>
                    </div>
                </c:if>
                <c:if test="${product.getQuantity() == 0}">
                    <p class="product-card_stock-status">Non disponibile momentaneamente</p>
                </c:if>
                <button class="product-card_button product-card_button--add-to-cart">Aggiungi al carrello</button>
                <% if (request.getSession().getAttribute("user") == null) { %>
                <a href="${pageContext.request.contextPath}/jsp/auth/Login.jsp?redirectAfterLogin=CheckoutServlet"
                   class="product-card_button product-card_button--buy-now"
                   style="display: inline-block; text-decoration: none; text-align: center; cursor: pointer;">
                    Acquista Ora</a>
                <% } else { %>
                <form action="${pageContext.request.contextPath}/CheckoutServlet" method="post">
                    <button type="submit" class="product-card_button product-card_button--buy-now">Acquista Ora</button>
                </form>
                <% } %>

            </div>


            <div class="product-card_description">
                <h2 class="product-card_description-heading">Descrizione</h2>
                <p>${product.getDescription()}</p>
            </div>
        </section>
    </main>


    <jsp:include page="/jsp/common/Footer.jsp"/>
</body>
</html>
