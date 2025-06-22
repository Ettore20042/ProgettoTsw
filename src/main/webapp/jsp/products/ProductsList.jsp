<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
    request.setAttribute("pageTitle", "BricoShop - Prodotti");
%>
<!DOCTYPE html>
<html lang="it">
    <head>
        <title><c:out value="${pageTitle}" default="BricoShop"/></title>
        <jsp:include page="/jsp/common/HeadContent.jsp" />
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/productList.css">
    </head>
    <body>
        <jsp:include page="/jsp/common/Header.jsp" />

        <main class="product-list-page">

            <div class="breadcrumb">
                <div class="breadcrumb_wrapper">
                    <c:forEach var="category" items="${breadcrumbCategories}" varStatus="status">
                        <a href="${pageContext.request.contextPath}/ProductListServlet?categoryId=${category.categoryId}" class="breadcrumb_item breadcrumb_link">${category.categoryName}</a>
                        <c:if test="${not status.last}">
                            <span class="material-symbols-rounded">keyboard_arrow_right</span>
                        </c:if>
                    </c:forEach>
                </div>
            </div>

            <section class="product-list">
                <h2 class="product-list_heading">Elenco prodotti</h2>
                <c:choose>
                    <c:when test="${empty productList}">
                        <p>Nessun prodotto trovato.</p>
                    </c:when>
                    <c:otherwise>
                        <div class="product-list_grid">


                            <c:forEach var="product" items="${productList}">
                                <section class="product-card">

                                    <a href="${pageContext.request.contextPath}/ProductServlet?productId=${product.productId}" class="product-card_link">
                                        <div class="product-card_gallery">
                                            <div class="product-card_gallery-item">
                                                <img src="${pageContext.request.contextPath}/ImageServlet?productId=${product.productId}" alt="Image of ${product.productName}" class="product-card_image">
                                            </div>
                                        </div>

                                        <div class="product-card_header-info">
                                            <h2 class="product-card_brand">${product.brand.brandName}</h2>
                                            <h1 class="product-card_name">${product.productName}</h1>
                                        </div>
                                    </a>


                                    <div class="product-card_details">
                                        <p class="product-card_price"><fmt:formatNumber value="${product.getPrice()}" pattern="€ #,##0.00" /></p>
                                        <c:if test="${product.getQuantity() > 0}">
                                            <p class="product-card_stock-status--available">Disponibile</p>
                                        </c:if>
                                        <c:if test="${product.getQuantity() == 0}">
                                            <p class="product-card_stock-status--not-available">Non disponibile momentaneamente</p>
                                        </c:if>
                                        <form action="${pageContext.request.contextPath}/CartServlet" class="add-to-cart-form" data-product-id="${product.productId}" method="post" style="display: contents;">
                                            <input type="hidden" name="productId" value="${product.productId}" />
                                            <input type="hidden" name="quantity" value="1" />
                                            <button type="submit" class="product-card_button product-card_button--add-to-cart">
                                                <span class="material-symbols-rounded">shopping_cart</span>
                                            </button>
                                        </form>

                                    </div>
                                </section>
                            </c:forEach>
                        </div>

                    </c:otherwise>
                </c:choose>

            </section>
        </main>

        <jsp:include page="/jsp/common/Footer.jsp" />
    </body>
</html>
