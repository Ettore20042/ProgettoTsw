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
    </head>
    <body>
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
                <h2 class="product-list_heading">Elenco prodotti</h2>
                <c:choose>
                    <c:when test="${empty productList}">
                        <p>Nessun prodotto trovato.</p>
                    </c:when>
                    <c:otherwise>
                        <div class="product-list_grid">
                        <jsp:include page="../../WEB-INF/jsp/components/products/_productListCard.jsp"/>
                        </div>
                    </c:otherwise>
                </c:choose>
            </section>
        </main>

        <jsp:include page="/WEB-INF/jsp/components/common/footer.jsp" />
    </body>
</html>