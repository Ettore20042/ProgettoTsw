<%--
  Created by IntelliJ IDEA.
  User: Lenovo
  Date: 21/06/2025
  Time: 17:18
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="it">
<head>
    <title><c:out value="${pageTitle}" default="BricoShop"/></title>
    <jsp:include page="/jsp/common/HeadContent.jsp" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/brands.css">
</head>

<body>
<jsp:include page="/jsp/common/Header.jsp"/>

<main class="manage-products-container">
    <section class="admin-button">
        <a href="${pageContext.request.contextPath}/Admin.jsp" class="admin-button-toggle">Gestione Admin</a>
    </section>

    <section class="search-products">
        <div class="search-products-add-product-button">
            <a href="${pageContext.request.contextPath}/AddProduct.jsp" class="add-product-button-toggle">Aggiungi un prodotto</a>
        </div>

        <div class="search-products-search-bar">
            <form id="searchForm" action="SearchBarServlet" method="get" class="search-bar-form" autocomplete="off">
                <input type="search" id="searchBar" name="searchQueryTable" placeholder="Cerca..." autocomplete="off">
                <button type="submit" aria-label="Cerca">
                    <img src="${pageContext.request.contextPath}/img/header/lente.svg" id="searchLens" alt="Cerca">
                </button>
            </form>
        </div>

        <div class="search-products-on-table">
            <table class="search-products-on-table--table">
                <tr>
                    <th>ID</th>
                    <th>Nome</th>
                    <th>Prezzo</th>
                    <th>Colore</th>
                    <th>Quantità</th>
                </tr>
                <c:forEach var="product" items="${productList}">
                    <tr id="tableBody">
                        <td>${product.productId}</td>
                        <td>${product.productName}</td>
                        <td>${product.price}</td>
                        <td>${product.color}</td>
                        <td>${product.quantity}</td>
                    </tr>
                </c:forEach>
            </table>
        </div>

    </section>
</main>

<jsp:include page="/jsp/common/Footer.jsp"/>
</body>
</html>
