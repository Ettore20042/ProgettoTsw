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
        <jsp:include page="/WEB-INF/jsp/components/common/headContent.jsp" />
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/productList.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/components/_productsFilter.css">
        <script src="${pageContext.request.contextPath}/Js/products/productFilter.js" defer></script>
        <script src="${pageContext.request.contextPath}/Js/products/productListUpdater.js" defer></script>
    </head>
    <c:set var="category" value="${breadcrumbCategories[breadcrumbCategories.size() - 1]}"/>
    <body data-context-path="${pageContext.request.contextPath}" data-category-id="${category.categoryId}">
        <jsp:include page="/WEB-INF/jsp/components/common/header.jsp" />

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
                <h2 class="product-list_heading">Sfoglia i prodotti</h2>

                <div class="product-list_filter-box">
                    <jsp:include page="../../WEB-INF/jsp/components/products/_productsFilter.jsp"/>
                </div>

                <div class="product-list_grid">
                    <c:choose>
                        <c:when test="${empty productList}">
                            <p>Nessun prodotto trovato.</p>
                        </c:when>
                        <c:otherwise>
                            <div class="product-list_cards">
                                <jsp:include page="../../WEB-INF/jsp/components/products/_productListCard.jsp"/>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </section>
        </main>

        <jsp:include page="/WEB-INF/jsp/components/common/footer.jsp" />
    </body>
</html>