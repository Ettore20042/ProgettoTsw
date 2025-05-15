<%--
  Created by IntelliJ IDEA.
  User: ettor
  Date: 29/04/2025
  Time: 11:39
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Prodotto</title>
</head>
<body>
    <main class="product-page">
        <section class="product-card">
            <div class="product-card_images">
                <img src="${pageContext.request.contextPath}/img/products/${product.getImage()}" alt="${product.getName()}">
            </div>
            <div class="product-card_details">
                <h1 class="product-card_details--name">${product.getName()}</h1>
                <p class="product-card_details--price">€${product.getPrice()}</p>
                <button class="product-card_add-to-cart--button">Aggiungi al carrello</button>
                <button class="product-card_buy-now--button">Acquista Ora</button>
            </div>
            <div class="product-card_description">
                <h2>Descrizione</h2>
                <p>${product.getDescription()}</p>
            </div>
        </section>
    </main>
</body>
</html>
