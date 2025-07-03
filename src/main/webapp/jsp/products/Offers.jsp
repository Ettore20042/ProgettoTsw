<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    request.setAttribute("pageTitle", "BricoShop - Offers");
%>
<!DOCTYPE html>
<html lang="it">
    <head>
        <title><c:out value="${pageTitle}" default="BricoShop"/></title>
        <jsp:include page="/WEB-INF/jsp/components/common/headContent.jsp" />
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/productList.css" />
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/components/_productsFilter.css">
        <script src="${pageContext.request.contextPath}/Js/products/productFilter.js" defer></script>
        <script src="${pageContext.request.contextPath}/Js/products/productListUpdater.js" defer></script>
    </head>
    <body data-offers-page="true" data-context-path="${pageContext.request.contextPath}">
        <jsp:include page="/WEB-INF/jsp/components/common/header.jsp"/>

        <main class="offers-container">

            <section class="product-list">
                <h2 class="product-list_heading offers-list_heading">Offerte imperdibili</h2>

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

        <jsp:include page="/WEB-INF/jsp/components/common/footer.jsp"/>
    </body>
</html>
