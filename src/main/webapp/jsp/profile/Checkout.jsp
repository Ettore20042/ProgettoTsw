<%@ page import="java.util.Map" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%--
  Created by IntelliJ IDEA.
  User: ettor
  Date: 21/06/2025
  Time: 12:04
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Checkout</title>
    <jsp:include page="/WEB-INF/jsp/components/common/headContent.jsp"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/checkout.css" type="text/css">
    <script src="${pageContext.request.contextPath}/Js/profile/checkout.js" defer></script>
</head>
<body data-context-path="${pageContext.request.contextPath}">
<jsp:include page="/WEB-INF/jsp/components/common/header.jsp"/>

<div class="checkout-container">
    <div id="message"></div>

    <h1 class="checkout-title">Checkout</h1>

    <div class="checkout-main">
        <!-- Sezione 1: Riepilogo Ordine (Sinistra su desktop) -->
        <div class="checkout-section order-section">
            <h2 class="section-title">Riepilogo Ordine</h2>
            <div class="order-summary">
                <c:forEach var="item" items="${cart}">
                    <div class="checkout-item">
                        <h3 class="item-name">${item.productName}</h3>
                        <div class="item-details">
                            <span class="item-price">Prezzo: <fmt:formatNumber value="${item.price}" pattern="€#,##0.00"/></span>
                            <span class="item-quantity">Quantità: ${item.quantity}</span>

                        </div>
                    </div>
                </c:forEach>
                <div class="order-total">
                    <strong id="total">Totale: <fmt:formatNumber value="${total}" pattern="€#,##0.00"/></strong>
                    <!-- Campo nascosto per facilitare il recupero del valore numerico -->
                    <input type="hidden" id="totalValue" value="${total}">

                </div>
               <!-- Conferma Ordine -->
                <div class="order-actions">
                    <button class="btn-back">Torna al carrello </button>
                    <button type="button" class="btn-confirm-order">Conferma Ordine</button>
                </div>
            </div>
        </div>

        <!-- Sezione 2: Indirizzi (Destra su desktop) -->
        <div class="checkout-section addresses-section">
            <h2 class="section-title">Indirizzi</h2>

            <c:if test="${not empty addresses}">
                <!-- Indirizzi di spedizione -->
                <div class="address-section">
                    <h3 class="subsection-title">Seleziona indirizzo di spedizione</h3>
                    <div class="shipping-addresses">
                        <c:set var="shippingCount" value="0" />
                        <c:forEach var="address" items="${addresses}">
                            <c:if test="${address.addressType == 'shipping'}">
                                <div class="checkout-address">
                                    <c:set var="addr" value="${address.address}" />
                                    <label class="address-label">
                                        <input type="radio" name="shippingAddressId" value="${addr.addressId}"
                                               id="shipping_${addr.addressId}"
                                            ${shippingCount == 0 ? 'checked' : ''} />

                                        <span class="address-text">
                                            <c:if test="${not empty addr.street}">${addr.street}</c:if>
                                            <c:if test="${not empty addr.streetNumber}"> ${addr.streetNumber}</c:if>
                                            <c:if test="${not empty addr.city}">, ${addr.city}</c:if>
                                            <c:if test="${not empty addr.zipCode}"> ${addr.zipCode}</c:if>
                                            <c:if test="${not empty addr.province}">, ${addr.province}</c:if>
                                        </span>
                                        <img src="${pageContext.request.contextPath}/img/icon/delete.png" class="delete-icon" alt="delete Address">
                                    </label>
                                </div>
                                <c:set var="shippingCount" value="${shippingCount + 1}" />
                            </c:if>
                        </c:forEach>
                    </div>
                </div>

                <!-- Indirizzi di fatturazione -->
                <div class="address-section">
                    <h3 class="subsection-title">Seleziona indirizzo di fatturazione</h3>
                    <div class="billing-addresses">
                        <c:set var="billingCount" value="0" />
                        <c:forEach var="address" items="${addresses}">
                            <c:if test="${address.addressType == 'billing'}">
                                <div class="checkout-address">
                                    <c:set var="addr" value="${address.address}" />
                                    <label class="address-label">
                                        <input type="radio" name="billingAddressId" value="${addr.addressId}"
                                               id="billing_${addr.addressId}"
                                            ${billingCount == 0 ? 'checked' : ''} />
                                        <span class="address-text">
                                            <c:if test="${not empty addr.street}">${addr.street}</c:if>
                                            <c:if test="${not empty addr.streetNumber}"> ${addr.streetNumber}</c:if>
                                            <c:if test="${not empty addr.city}">, ${addr.city}</c:if>
                                            <c:if test="${not empty addr.zipCode}"> ${addr.zipCode}</c:if>
                                            <c:if test="${not empty addr.province}">, ${addr.province}</c:if>
                                        </span>
                                        <img src="${pageContext.request.contextPath}/img/icon/delete.png" class="delete-icon" alt="delete Address">
                                    </label>
                                </div>
                                <c:set var="billingCount" value="${billingCount + 1}" />
                            </c:if>
                        </c:forEach>
                    </div>
                </div>
            </c:if>

            <!-- Pulsante per aggiungere un nuovo indirizzo -->
            <div class="add-address-section">
                <button type="button" id="addAddressBtn" class="btn-add-address">

                    Aggiungi nuovo indirizzo
                </button>
            </div>
        </div>

        <!-- Sezione 3: Metodo di Pagamento (Sotto su tablet/desktop) -->
        <div class="checkout-section payment-section">
            <h2 class="section-title">Metodo di Pagamento</h2>

            <div class="payment-methods">
                <div class="payment-option">
                    <label class="payment-label">
                        <input type="radio" name="paymentMethod" value="credit_card" id="credit_card" required>
                        <span class="payment-text">
                            Carta di Credito/Debito
                        </span>
                    </label>
                </div>

                <div class="payment-option">
                    <label class="payment-label">
                        <input type="radio" name="paymentMethod" value="paypal" id="paypal" required>
                        <span class="payment-text">
                            PayPal
                        </span>
                    </label>
                </div>

                <div class="payment-option">
                    <label class="payment-label">
                        <input type="radio" name="paymentMethod" value="bank_transfer" id="bank_transfer" required>
                        <span class="payment-text">
                            Bonifico Bancario
                        </span>
                    </label>
                </div>
            </div>

            <!-- Form dati carta di credito (visibile solo se selezionata) -->
            <div id="credit-card-form" class="payment-details" style="display: none;">
                <h3 class="subsection-title">Dati Carta di Credito</h3>
                <div class="card-form">
                    <div class="form-row">
                        <div class="form-group">
                            <label for="cardNumber">Numero Carta</label>
                            <input type="text" id="cardNumber" name="cardNumber" placeholder="1234 5678 9012 3456" maxlength="19">
                        </div>
                    </div>

                    <div class="form-row">
                        <div class="form-group">
                            <label for="cardHolder">Intestatario</label>
                            <input type="text" id="cardHolder" name="cardHolder" placeholder="Nome Cognome">
                        </div>
                    </div>

                    <div class="form-row">
                        <div class="form-group half-width">
                            <label for="expiryDate">Scadenza</label>
                            <input type="text" id="expiryDate" name="expiryDate" placeholder="MM/AA" maxlength="5">
                        </div>
                        <div class="form-group half-width">
                            <label for="cvv">CVV</label>
                            <input type="text" id="cvv" name="cvv" placeholder="123" maxlength="4">
                        </div>
                    </div>
                </div>
            </div>


        </div>
    </div>
</div>

<jsp:include page="/WEB-INF/jsp/components/profile/_addAddressForm.jsp"/>

<jsp:include page="/WEB-INF/jsp/components/common/footer.jsp"/>
</body>
</html>
