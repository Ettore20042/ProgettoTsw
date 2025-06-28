<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="it">
<head>
    <title>Pannello di Gestione - ${entity}</title>
    <jsp:include page="/WEB-INF/jsp/components/common/headContent.jsp" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/manageproducts.css">
    <script src="${pageContext.request.contextPath}/Js/profile/Manage.js" defer></script>
    <script src="${pageContext.request.contextPath}/Js/profile/managers/ProductManager.js" defer></script>
    <script src="${pageContext.request.contextPath}/Js/profile/managers/UserManager.js" defer></script>
    <script src="${pageContext.request.contextPath}/Js/profile/managers/CategoryManager.js" defer></script>
    <script src="${pageContext.request.contextPath}/Js/profile/managers/BrandManager.js" defer></script>




</head>

<body data-context-path="${pageContext.request.contextPath}" data-entity = "${entity}">
<jsp:include page="/WEB-INF/jsp/components/common/header.jsp"/>

<main class="manage-components-container">
    <div class="manage-components-container-filter">
        <%-- Qui andrà la componente dei filtri riutilizzabile --%>
        <nav class="admin-nav">
            <a href="${pageContext.request.contextPath}/ManageServlet?entity=products" class="admin-button-toggle ${entity == 'products' ? '' : 'active'}">Gestione Prodotti</a>
            <a href="${pageContext.request.contextPath}/ManageServlet?entity=users" class="admin-button-toggle ${entity == 'users' ? '' : 'active'}">Gestione Utenti</a> <%-- Esempio per il futuro --%>
            <a href="${pageContext.request.contextPath}/ManageServlet?entity=brands" class="admin-button-toggle ${entity == 'brands' ? '' : 'active'}">Gestione Brands</a>
            <a href="${pageContext.request.contextPath}/ManageServlet?entity=categories" class="admin-button-toggle ${entity == 'categories' ? '' : 'active'}">Gestione Categorie</a>
        </nav>

        <%--<jsp:include page="/WEB-INF/jsp/components/products/_productsFilter.jsp">
            <jsp:param name="entity" value="${entity}"/>
            <jsp:param name="priceMax" value="${priceMax}"/>
            <jsp:param name="brandChaceMap" value="${brandChaceMap}"/>
            <jsp:param name="categoryChaceMap" value="${categoryChaceMap}"/>
            <jsp:param name="colorsList" value="${colorsList}"/>
        </jsp:include>--%>

    </div>

    <div class="manage-components-container-right">
        <div class="search-bar-tab manage-components-container-right_search-bar">
            <form id="searchForm" action="${pageContext.request.contextPath}/ManageServlet" method="get" class="search-bar-form-tab" autocomplete="off">
                <input type="hidden" name="entity" value="${entity}">
                <input type="search" id="searchBarTable" name="searchQuery" placeholder="Cerca in ${entity}..." autocomplete="off" value="${param.searchQuery}">
                <button type="submit" aria-label="Cerca">
                    <img src="${pageContext.request.contextPath}/img/header/lente.svg" id="searchLensTable" alt="Cerca">
                </button>
            </form>
            <div id="suggestions-for-table"></div>
        </div>



        <c:choose>
            <c:when test="${entity == 'products'}">
                <div class="manage-components-container-right--add-button">
                    <button  class="add-component-button-toggle" id="add-btn">Aggiungi un prodotto</button>
                </div>
                <jsp:include page="/WEB-INF/jsp/components/admin/_addProductForm.jsp"/>
            </c:when>
            <%-- Aggiungi qui i <c:when> per le altre entità (users, categories, etc.) --%>
            <c:otherwise>
                <p>Seleziona un'entità da gestire.</p>
            </c:otherwise>
        </c:choose>

        <div id="message" style="display: none"></div>
        <div class="manage-components-container-right--search-table">
            <c:choose>
                <c:when test="${entity == 'products'}">
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
                        <tbody class="componentTableBody">
                        <c:forEach var="item" items="${itemList}">
                            <tr>
                                <td>${item.productId}</td>
                                <td>${item.productName}</td>
                                <td>${item.price}</td>
                                <td>${item.color}</td>
                                <td>${item.quantity}</td>
                                <td><a href="#" class="edit-link" data-product-id="${item.productId}">Modifica</a></td>
                                <td><button type="submit" class="remove-button-product remove-item-btn" data-id="${item.productId}" >
                                    <img src="${pageContext.request.contextPath}/img/icon/delete.png" class="remove-icon">
                                </button></td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </c:when>
                <c:when test="${entity == 'users'}">
                    <table class="search-components-on-table--table">
                        <thead>
                        <tr>
                            <th>ID Utente</th>
                            <th>Nome</th>
                            <th>Cognome</th>
                            <th>Email</th>
                            <th>Telefono</th>
                            <th>Admin</th>
                            <th colspan="1"></th>
                        </tr>
                        </thead>
                        <tbody class="componentTableBody">
                        <c:forEach var="item" items="${itemList}">
                            <tr>
                                <td>${item.userId}</td>
                                <td>${item.firstName}</td>
                                <td>${item.lastName}</td>
                                <td>${item.email}</td>
                                <td>${item.phoneNumber}</td>
                                <c:choose>
                                    <c:when test="${item.isAdmin() == true}">
                                        <td>SI</td>
                                    </c:when>
                                    <c:otherwise>
                                        <td>NO</td>
                                    </c:otherwise>
                                </c:choose>
                                <td><a href="#">Modifica</a></td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </c:when>
                <c:otherwise>
                    <p>Seleziona un'entità da gestire.</p>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</main>

<jsp:include page="/WEB-INF/jsp/components/common/footer.jsp"/>
</body>
</html>

