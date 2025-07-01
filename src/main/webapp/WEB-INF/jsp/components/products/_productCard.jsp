<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<section class="product-card">
    <div class="product-card_header-info">
        <h2 class="product-card_brand">${product.brand.getBrandName()}</h2>
        <h1 class="product-card_name">${product.getProductName()}</h1>
    </div>

    <div class="product-card_gallery">
        <div class="product-card_gallery-track">
            <c:choose>
                <c:when test="${not empty product.images}">
                    <%-- Se ci sono immagini del prodotto --%>
                    <c:forEach var="image" items="${product.images}">
                        <div class="product-card_gallery-item">
                            <img src="${pageContext.request.contextPath}/${image.getImagePath()}" alt="${image.getImageDescription()}" class="product-card_image">
                        </div>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <%-- Altrimenti, usa l'immagine di default --%>
                    <div class="product-card_gallery-item">
                        <img src="${pageContext.request.contextPath}/ImageServlet?productId=${product.productId}" alt="Image of ${product.productName}" class="product-card_image">
                    </div>
                </c:otherwise>
            </c:choose>

        </div>

        <button class="product-card_arrow product-card_arrow--prev" aria-label="Immagine precedente">❮</button>
        <button class="product-card_arrow product-card_arrow--next" aria-label="Immagine successiva">❯</button>

        <div class="product-card_gallery-dots">
            <%-- I pallini verranno generati da JavaScript --%>
        </div>
    </div>


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
        <p class="product-card_shipping-info">Iva inclusa. Spedizione gratuita</p>
        <%--Aggiungere elemento per quantità, da vedere se gestire con js oppure da server--%>
        <c:if test="${product.getQuantity() > 0}">
            <div class="product-card_quantity">
                <label class="product-card_quantity-label">Quantità: </label>
                <select name="quantity" id="quantity" class="product-card_quantity-select">
                    <c:forEach begin="1" end="${product.getQuantity()}" var="i">
                        <option value="${i}">${i}</option>
                    </c:forEach>
                </select>
            </div>
            <p class="product-card_stock-status--available">Disponibilità immediata</p>

            <form action="${pageContext.request.contextPath}/CartServlet" class="add-to-cart-form" data-product-id="${product.productId}" method="post" style="display: contents;">
                <input type="hidden" name="productId" value="${product.productId}" />
                <input type="hidden" name="quantity" value="1" />
                <button class="product-card_button product-card_button--add-to-cart">Aggiungi al carrello</button>
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

        </c:if>
        <c:if test="${product.getQuantity() == 0}">
            <p class="product-card_stock-status--not-available">Non disponibile momentaneamente</p>
        </c:if>


    </div>


    <div class="product-card_description">
        <h2 class="product-card_description-heading">Descrizione</h2>
        <p>${product.getDescription()}</p>
    </div>
</section>