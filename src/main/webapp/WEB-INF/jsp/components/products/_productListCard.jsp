<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<c:forEach var="product" items="${productList}">
    <section class="product-card">

        <a href="${pageContext.request.contextPath}/ProductServlet?productId=${product.productId}" class="product-card_link">
            <div class="product-card_gallery">
                <%-- Altrimenti, usa l'immagine di default --%>
                <div class="product-card_gallery-item">
                    <img src="${pageContext.request.contextPath}/ImageServlet?productId=${product.productId}" alt="Image of ${product.productName}" class="product-card_image">
                </div>
            </div>
            <div class="product-card_header-info">
                <h2 class="product-card_brand">${product.brand.getBrandName()}</h2>
                <h1 class="product-card_name">${product.getProductName()}</h1>
            </div>
        </a>




        <div class="product-card_details">
            <div class="product-card_price">
                <c:choose>
                    <c:when test="${not empty product.salePrice and product.salePrice > 0 and product.salePrice < product.price}">
                        <p class="product-card_price--sale">
                            <fmt:formatNumber value="${product.salePrice}" pattern="€#,##0.00" />
                        </p>
                        <p class="product-card_price--original-in-sale">
                            <fmt:formatNumber value="${product.price}" pattern="€#,##0.00" />
                        </p>
                    </c:when>
                    <c:otherwise>
                        <p class="product-card_price--original">
                            <fmt:formatNumber value="${product.getPrice()}" pattern="€#,##0.00" />
                        </p>
                    </c:otherwise>
                </c:choose>
            </div>
            <c:if test="${product.getQuantity() > 0}">
                <p class="product-card_stock-status--available">Disponibilità immediata</p>
            </c:if>
            <c:if test="${product.getQuantity() == 0}">
                <p class="product-card_stock-status--not-available">Non disponibile momentaneamente</p>
            </c:if>
            <form action="${pageContext.request.contextPath}/CartServlet" class="add-to-cart-form" data-product-id="${product.productId}" method="post" style="display: contents;">
                <input type="hidden" name="productId" value="${product.productId}" />
                <input type="hidden" name="quantity" value="1" />
                <button type="submit" class="product-card_button product-card_button--add-to-cart-icon">
                    <span class="material-symbols-rounded">shopping_cart</span>
                </button>
            </form>
            <% if (request.getSession().getAttribute("user") == null) { %>
            <a href="${pageContext.request.contextPath}/jsp/auth/Login.jsp?redirectAfterLogin=CheckoutServlet"
               class="product-card_button product-card_button--buy-now">
                Acquista Ora</a>
            <% } else { %>
            <form action="${pageContext.request.contextPath}/CheckoutServlet" method="post">
                <button type="submit" class="product-card_button product-card_button--buy-now">Acquista Ora</button>
            </form>
            <% } %>

        </div>
    </section>
</c:forEach>