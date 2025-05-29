<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<html>
<head>
    <title>Categories</title>
    <jsp:include page="/jsp/common/HeadContent.jsp" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/categories.css?v=<%=System.currentTimeMillis()%>" type="text/css"/>
    <script src="${pageContext.request.contextPath}/Js/products/CategoryList.js?v=<%=System.currentTimeMillis()%>"></script>
</head>
<body>
<jsp:include page="/jsp/common/Header.jsp" />

<main class="categories-container">

    <section class="categories">
        <h2 class="categories-main_title--h2">Categorie</h2>
        <div class="category-grid">
            <c:forEach var="category" items="${categories}">
                <c:if test="${category.parentCategory == null || category.categoryPath == ''}">
                    <div class="category-card">
                        <div class="category-card_maincategory">
                            <img src="${pageContext.request.contextPath}/${category.categoryPath}" alt="${category.categoryName}" />
                            <h3>${category.categoryName}</h3>
                            <a href="${pageContext.request.contextPath}/ProductServlet?categoryId=${category.categoryId}" class="view-btn">Vedi prodotti</a>
                            <button class="toggle-subcategories">▶</button>
                        </div>


                        <div class="subcategory-menu">
                            <c:forEach var="subcat" items="${categories}">
                                <c:if test="${subcat.parentCategory == category.categoryId}">
                                    <a href="${pageContext.request.contextPath}/ProductServlet?categoryId=${subcat.categoryId}">
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
    <div class="product-grid">
        <c:forEach var="product" items="${products}">
            <div class="product-card">
                <a href="${pageContext.request.contextPath}/ProductServlet?productId=${product.productId}" class="a-class">
                    <img src="${pageContext.request.contextPath}/ImageServlet?productId=${product.productId}" alt="${product.productName}" class="product-card_product_image--img" />
                    <h6 class="product-card_productName--title">${product.productName}</h6>
                </a>
                <p class="category-container_card_price">Prezzo: €${product.price}</p>
                <button class="product-card_add-to-cart--button">Aggiungi al carrello</button>
            </div>
        </c:forEach>
    </div>

</main>

<jsp:include page="/jsp/common/Footer.jsp" />
</body>
</html>