<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<section class="product-filter">
    <h2 class="product-filter_title">Filtri</h2>
    <details class="product-filter_details-box product-filter_price">
        <summary class="product-filter_details-summary">Prezzo</summary>
        <button class="product-filter_details-reset">Ripristina</button>
        <input type="range" class="product-filter_price-range">
        <span class="product-filter_price-range-value">Prezzo: 0 - ${priceMax}</span>
        <input type="number" class="product-filter_price-min" placeholder="0" min="0" max="${priceMax}">
        <input type="number" class="product-filter_price-max" placeholder="${priceMax}" min="0" max="${priceMax}">
    </details>

    <details class="product-filter_details-box product-filter_brand">
        <summary class="product-filter_details-summary">Brand</summary>
        <button class="product-filter_details-reset">Ripristina</button>
        <ul class="product-filter_brand-list">
            <c:forEach var="brand" items="${brandList}">
                <li>
                    <label>
                        <input type="checkbox" name="brand" value="${brand.brandId}">
                        ${brand.brandName}
                    </label>
                </li>
            </c:forEach>
        </ul>
    </details>
</section>
