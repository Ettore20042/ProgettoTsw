<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="it">
<head>
    <title><c:out value="${pageTitle}" default="BricoShop"/></title>
    <jsp:include page="/WEB-INF/jsp/components/common/headContent.jsp" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/manageproducts.css">
    <script src="${pageContext.request.contextPath}/Js/profile/ManageProducts.js" defer></script>
</head>

<body data-context-path="${pageContext.request.contextPath}">
<jsp:include page="/WEB-INF/jsp/components/common/header.jsp"/>



<main class="manage-components-container">
    <div class="manage-components-container-filter">
        <%-- peppe rossetti --%>
            <a href="${pageContext.request.contextPath}/Admin.jsp" class="admin-button-toggle">Gestione Admin</a>
    </div>

    <div class="manage-components-container-right">
        <div class="search-bar-tab manage-components-container-right_search-bar">
            <form id="searchForm" action="${pageContext.request.contextPath}/ManageProductServlet" method="get" class="search-bar-form-tab" autocomplete="off">
                <input type="search" id="searchBarTable" name="searchQueryTable" placeholder="Cerca..." autocomplete="off">
                <button type="submit" aria-label="Cerca">
                    <img src="${pageContext.request.contextPath}/img/header/lente.svg" id="searchLensTable" alt="Cerca">
                </button>
            </form>


            <div id="suggestions-for-table">
            </div>


        </div>
        <div class="manage-components-container-right--add-button">
            <a href="${pageContext.request.contextPath}/AddProduct.jsp" class="add-component-button-toggle">Aggiungi un prodotto</a>
        </div>

        <div class="manage-components-container-right--search-table">
            <table class="search-components-on-table--table">
                <thead>
                <tr>
                    <th>ID</th>
                    <th>Nome</th>
                    <th>Prezzo</th>
                    <th>Colore</th>
                    <th>Quantità</th>
                    <th colspan="2"></th>
                </tr>
                </thead>
                <tbody id="componentTableBody">
                <c:forEach var="product" items="${productList}">
                    <tr>
                        <td>${product.productId}</td>
                        <td>${product.productName}</td>
                        <td>${product.price}</td>
                        <td>${product.color}</td>
                        <td>${product.quantity}</td>
                        <td><a href="Modifica.jsp">Modifica</a> </td>
                        <td><a href="Elimina.jsp">Elimina</a> </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>

        </div>
    </div>
</main>

<jsp:include page="/WEB-INF/jsp/components/common/footer.jsp"/>
</body>
</html>
