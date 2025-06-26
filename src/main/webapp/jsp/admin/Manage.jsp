<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="it">
<head>
    <title>Pannello di Gestione - ${entity}</title>
    <jsp:include page="/WEB-INF/jsp/components/common/headContent.jsp" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/manageproducts.css">
    <script src="${pageContext.request.contextPath}/Js/profile/ManageProducts.js" defer></script>
</head>

<body data-context-path="${pageContext.request.contextPath}">
<jsp:include page="/WEB-INF/jsp/components/common/header.jsp"/>

<main class="manage-components-container">
    <div class="manage-components-container-filter">
        <%-- Qui andrà la componente dei filtri riutilizzabile --%>
        <nav class="admin-nav">
            <a href="${pageContext.request.contextPath}/ManageServlet?entity=products" class="admin-button-toggle ${entity == 'products' ? 'active' : ''}">Gestione Prodotti</a>
            <a href="#" class="admin-button-toggle">Gestione Utenti</a> <%-- Esempio per il futuro --%>
            <a href="#" class="admin-button-toggle">Gestione Categorie</a> <%-- Esempio per il futuro --%>
        </nav>
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

        <c:if test="${entity == 'products'}">
            <div class="manage-components-container-right--add-button">
                <button onclick="openModal()" class="add-component-button-toggle">Aggiungi un prodotto</button>
            </div>
        </c:if>

        <div class="manage-components-container-right--modal" id="productModal">
            <div class="modal-content">
                <span class="close" onclick="closeModal()">&times;</span>
                <h2>Aggiungi un prodotto</h2>
                <form id="addProductForm" action="${pageContext.request.contextPath}/AddProductServlet" method="post" enctype="multipart/form-data">
                    <label for="productName">Nome Prodotto:</label>
                    <input type="text" id="productName" name="productName" required>

                    <label for="price">Prezzo:</label>
                    <input type="number" id="price" name="price" step="0.01" required>

                    <label for="salePrice">Prezzo in offerta:</label>
                    <input type="number" id="salePrice" name="salePrice" step="0.01">

                    <label for="color">Colore:</label>
                    <input type="text" id="color" name="color">

                    <label for="description">Descrizione:</label>
                    <textarea id="description" name="description" rows="4" cols="50"></textarea>

                    <label for="quantity">Quantità:</label>
                    <input type="number" id="quantity" name="quantity" required>

                    <label for="material">Materiale:</label>
                    <input type="text" id="material" name="material" placeholder="Materiale del prodotto">

                    <label for="image1">Immagine di copertina:</label>
                    <input type="file" id="image1" name="image1" accept="image/*">

                    <label for="images">Altre immagini:</label>
                    <input type="file" id="images" name="images" accept="image/*" required multiple>

                    <label for="descriptionImage">Descrizione Immagine:</label>
                    <input type="text" id="descriptionImage" name="descriptionImage" placeholder="Descrizione dell'immagine">

                    <label for="category">Categoria:</label>
                    <select id="category" name="category" required>
                        <option value="">Seleziona una categoria</option>
                        <c:forEach var="entry" items="${categoryCacheMap}">
                            <option value="${entry.key}">${entry.value.categoryName}</option>
                        </c:forEach>
                    </select>

                    <label for="brand">Marca:</label>
                    <select id="brand" name="brand" required>
                        <option value="">Seleziona una marca</option>
                        <c:forEach var="entry" items="${brandCacheMap}">
                            <option value="${entry.key}">${entry.value.brandName}</option>
                        </c:forEach>
                    </select>

                    <button type="submit">Aggiungi Prodotto</button>
                </form>
            </div>
        </div>

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
                        <tbody id="componentTableBody">
                        <c:forEach var="item" items="${itemList}">
                            <tr>
                                <td>${item.productId}</td>
                                <td>${item.productName}</td>
                                <td>${item.price}</td>
                                <td>${item.color}</td>
                                <td>${item.quantity}</td>
                                <td><a href="#">Modifica</a></td>
                                <td><button type="submit" class="remove-button-product remove-item-btn" data-id="${item.productId}" >
                                    <img src="${pageContext.request.contextPath}/img/icon/delete.png" class="remove-icon">
                                </button></td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </c:when>
                <%-- Aggiungi qui i <c:when> per le altre entità (users, categories, etc.) --%>
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

