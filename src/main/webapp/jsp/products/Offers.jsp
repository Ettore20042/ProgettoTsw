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
        <jsp:include page="/jsp/common/HeadContent.jsp" />
    </head>
    <body>
        <jsp:include page="/jsp/common/Header.jsp"/>

        <main class="offers-container">

            <section class="offers">
                <h2 class="offers-main-title--h2">Offerte imperdibili</h2>
                <div class="offers-grid">
                    <c:forEach var="product" items="${productList}">
                        <div class="offers-product-card">
                            <img src="${pageContext.request.contextPath}/ProductServlet?productId=${product.productId}" alt="${product.productName}"/>
                            <h6 class="offers-product-card-name--title">${product.productName}</h6>
                            <p class="offers-product-card-sale-price">Prezzo: <fmt:formatNumber value="${product.salePrice}" pattern="€ #,##0.00" /></p>
                            <p class="offers-product-card-text">SPEDIZIONE GRATUITA</p>
                            <%-- aggiungere bottone "Aggiungi al carrello" --%>
                        </div>
                    </c:forEach>
                </div>
            </section>
        </main>

        <jsp:include page="/jsp/common/Footer.jsp"/>
    </body>
</html>
