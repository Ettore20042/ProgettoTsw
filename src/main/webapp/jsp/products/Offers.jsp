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
    </head>
    <body>
        <jsp:include page="/WEB-INF/jsp/components/common/header.jsp"/>

        <main class="offers-container">

            <section class="product-list">
                <h2 class="product-list_heading">Offerte imperdibili</h2>
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

        <jsp:include page="/WEB-INF/jsp/components/common/footer.jsp"/>
    </body>
</html>
