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

        <main class="productList-container">

            <section class="productList">
                <h2 class="productList-main-title--h2">Elenco prodotti</h2>
                <c:choose>
                    <c:when test="${empty productList}">
                        <p>Nessun prodotto trovato.</p>
                    </c:when>
                    <c:otherwise>
                        <div class="productList-grid">
                            <c:forEach var="product" items="${productList}">
                                <div class="productList-product-card">
                                        <img src="${pageContext.request.contextPath}/ProductServlet?productId=${product.productId}" alt="${product.productName}" />
                                        <h6 class="productList-product-card_name--title">${product.productName}</h6>
                                        <c:if test="${product.getQuantity() == 0}">
                                            <p class="productList-product-card--out-of-stock">Non disponibile</p>
                                        </c:if>
                                        <p class="productList-product-card-price">Prezzo: €${product.price}</p>
                                            //
                                        <form action="${pageContext.request.contextPath}/CartServlet" class="add-to-cart-form" data-product-id="${product.productId}" method="post" style="display: contents;">
                                            <input type="hidden" name="productId" value="${product.productId}" />
                                            <input type="hidden" name="quantity" value="1" />
                                            <button type="submit" class="productList-product-card-add-to-cart--button">Aggiungi al carrello</button>
                                        </form>
                                </div>
                            </c:forEach>
                        </div>
                    </c:otherwise>
                </c:choose>

            </section>
        </main>

        <jsp:include page="/jsp/common/Footer.jsp" />
    </body>
</html>
