<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="it">
    <head>
        <title><c:out value="${pageTitle}" default="BricoShop"/></title>
        <jsp:include page="/WEB-INF/jsp/components/common/headContent.jsp" />
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/products/categories.css">
        <script src="${pageContext.request.contextPath}/Js/products/CategoryList.js" defer></script>
    </head>
    <body>
        <jsp:include page="/WEB-INF/jsp/components/common/header.jsp" />

        <main class="categories-container">

            <section class="categories">
                <h2 class="categories-main_title--h2">Categorie</h2>
                <div class="category-grid">
                    <c:forEach var="category" items="${categoryCacheMap.values()}">
                        <c:if test="${category.parentCategory == null || category.categoryPath == ''}">
                            <div class="category-card">
                                <div class="category-card_maincategory">

                                    <a href="${pageContext.request.contextPath}/ProductListServlet?categoryId=${category.categoryId}">
                                        <img src="${pageContext.request.contextPath}/${category.categoryPath}" alt="${category.categoryName}" />
                                        <h3>${category.categoryName}</h3>
                                    </a>
                                    <button class="toggle-subcategories">▶</button>
                                </div>


                                <div class="subcategory-menu">
                                    <c:forEach var="subcat" items="${categoryCacheMap.values()}">
                                        <c:if test="${subcat.parentCategory == category.categoryId}">
                                            <a href="${pageContext.request.contextPath}/ProductListServlet?categoryId=${subcat.categoryId}">
                                                    ${subcat.categoryName}
                                            </a>
                                        </c:if>
                                    </c:forEach>
                                </div>
                            </div>
                        </c:if>
                    </c:forEach>
                </div>

            </section>
            <h2 class="categories-main_title--h2">Sfoglia i nostri prodotti</h2>
            <div class="category-product-grid">
                <c:forEach var="product" items="${products}">
                    <div class="category-product-item">
                        <a href="${pageContext.request.contextPath}/ProductServlet?productId=${product.productId}" class="a-class">
                            <img src="${pageContext.request.contextPath}/ImageServlet?productId=${product.productId}"
                                 alt="${product.productName}" class="category-product-item_image--img" />
                            <h6 class="category-product-item_name--title">${product.productName}</h6>
                        </a>

                        <div class="category-product-price">
                            <c:choose>
                                <c:when test="${not empty product.salePrice and product.salePrice > 0 and product.salePrice < product.price}">
                                    <div class="product-card_price--sale">
                                        <p class="category-container_card_price--sale" >
                                             <fmt:formatNumber value="${product.salePrice}" pattern="€#,##0.00" />
                                        </p>
                                        <p class="product-card_price--original-in-sale">
                                            <fmt:formatNumber value="${product.price}" pattern="€#,##0.00" />
                                        </p>
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <p class="category-container_card_price--regular">
                                        <fmt:formatNumber value="${product.price}" pattern="€#,##0.00" />
                                    </p>
                                </c:otherwise>
                            </c:choose>
                        </div>
                        <form action="${pageContext.request.contextPath}/CartServlet" class="add-to-cart-form" data-product-id="${product.productId}" method="post" style="display: contents;">
                            <input type="hidden" name="productId" value="${product.productId}" />
                            <input type="hidden" name="quantity" value="1" />
                            <button type="submit" class="category-product-item_add-to-cart--button">Aggiungi al carrello</button>
                        </form>

                    </div>
                </c:forEach>
            </div>

        </main>
        <jsp:include page="/WEB-INF/jsp/components/common/footer.jsp" />
    </body>
</html>