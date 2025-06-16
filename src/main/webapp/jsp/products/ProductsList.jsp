<%--
  Created by IntelliJ IDEA.
  User: Utente
  Date: 03/05/2025
  Time: 19:18
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
    request.setAttribute("pageTitle", "BricoShop - Prodotti");
%>
<jsp:include page="/jsp/common/Header.jsp" />
<body>

<main class="productList-container">

    <section class="productList">
        <h2 class="productList-main-title--h2">Elenco prodotti</h2>
        <div class="productList-grid">
            <c:forEach var="product" items="${products}">
                <div class="productList-product-card">
                    <div class="productList-product-card-maincategory">
                        <img src="${pageContext.request.contextPath}/ProductServlet?productId=${product.productId}" alt="${product.productName}" />
                        <h3>${product.productName}</h3>
                        <c:if test="${product.getQuantity() == 0}">
                            <p class="productList-product-card-maincategory--out-of-stock">Non disponibile</p>
                        </c:if>
                        <p class="productList-product-card-maincategory-price">Prezzo: €${product.price}</p>
                        <button class=""></button>
                    </div>
                </div>
            </c:forEach>
        </div>
    </section>
</main>

</body>
<jsp:include page="/jsp/common/Footer.jsp" />
</html>
