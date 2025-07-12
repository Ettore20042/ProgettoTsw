<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="it">
<head>
    <title>Pannello di Gestione - ${entity}</title>
    <jsp:include page="/WEB-INF/jsp/components/common/headContent.jsp" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/manage.css">


    <script src="${pageContext.request.contextPath}/Js/profile/Manage.js" defer></script>
    <script src="${pageContext.request.contextPath}/Js/profile/managers/ProductManager.js" defer></script>
    <script src="${pageContext.request.contextPath}/Js/profile/managers/UserManager.js" defer></script>
    <script src="${pageContext.request.contextPath}/Js/profile/managers/CategoryManager.js" defer></script>
    <script src="${pageContext.request.contextPath}/Js/profile/managers/BrandManager.js" defer></script>

    <c:if test="${entity == 'products'}">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/components/_productsFilter.css">
        <script src="${pageContext.request.contextPath}/Js/products/productFilter.js" defer></script>
        <script src="${pageContext.request.contextPath}/Js/products/adminProductUpdater.js" defer></script>
    </c:if>
</head>

<body data-context-path="${pageContext.request.contextPath}" data-entity = "${entity}">
<jsp:include page="/WEB-INF/jsp/components/common/header.jsp"/>

<main class="manage-components-container">
    <div class="manage-components-container-left">
        <nav class="admin-nav">
            <a href="${pageContext.request.contextPath}/ManageServlet?entity=products" class="admin-button-toggle ${entity == 'products' ? 'active' : ''}">Gestione Prodotti</a>
            <a href="${pageContext.request.contextPath}/ManageServlet?entity=users" class="admin-button-toggle ${entity == 'users' ? 'active' : ''}">Gestione Utenti</a> <%-- Esempio per il futuro --%>
            <a href="${pageContext.request.contextPath}/ManageServlet?entity=brands" class="admin-button-toggle ${entity == 'brands' ? 'active' : ''}">Gestione Brands</a>
            <a href="${pageContext.request.contextPath}/ManageServlet?entity=categories" class="admin-button-toggle ${entity == 'categories' ? 'active' : ''}">Gestione Categorie</a>
        </nav>
        <c:if test="${entity == 'products'}">
            <div class="manage-components-container-filter">
                <jsp:include page="../../WEB-INF/jsp/components/products/_productsFilter.jsp"/>
            </div>
        </c:if>
    </div>




  <div class="manage-components-container-right">
              <div class="search-bar-tab manage-components-container-right_search-bar">
                  <form id="searchForm" action="${pageContext.request.contextPath}/ManageServlet" method="get" class="search-bar-form-tab" autocomplete="off" role="search">
                      <input type="hidden" name="entity" id="entity" value="${entity}">
                      <label for="searchBarTable" class="visually-hidden" >Cerca in ${entity}</label>
                      <input type="search" id="searchBarTable" name="searchQuery" placeholder="Cerca in ${entity}..." autocomplete="off" value="${param.searchQuery}" role="combobox"  aria-label="Cerca in ${entity}" class="search-bar">
                      <button type="submit" class="search-submit-btn" aria-label="Cerca">
                          <img src="${pageContext.request.contextPath}/img/header/lente.svg" id="searchLensTable" alt="Cerca" aria-hidden="true">
                      </button>
                  </form>
                  <div id="suggestions-for-table" role="listbox" aria-live="polite"></div>
              </div>

        <div class="manage-components-container-right--add-button">
        <c:choose>
            <c:when test="${entity == 'products'}">
                <button class="product-filter_open-btn">Filtra e ordina</button>
                <button  class="add-component-button-toggle" id="add-btn">Aggiungi un prodotto</button>
                <jsp:include page="/WEB-INF/jsp/components/admin/_addProductForm.jsp"/>
            </c:when>
            <c:when test="${entity == 'brands'}">
                <button  class="add-component-button-toggle" id="add-btn">Aggiungi un brand</button>
                <jsp:include page="/WEB-INF/jsp/components/admin/_addBrandForm.jsp"/>
            </c:when>
            <c:when test="${entity == 'categories'}">
                <button  class="add-component-button-toggle" id="add-btn">Aggiungi una categoria</button>
                <jsp:include page="/WEB-INF/jsp/components/admin/_addCategoryForm.jsp"/>
            </c:when>
        </c:choose>
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
                            <th colspan="2" aria-label="colonna-azioni"></th>
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
                                <td><button type="submit" class="remove-button-product remove-item-btn" data-id="${item.productId}" aria-label="Rimuovi prodotto">
                                    <img src="${pageContext.request.contextPath}/img/icon/delete.png" class="remove-icon" alt="">
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
                            <th>Modifica</th>
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
                                        <td>
                                            <span role="button"
                                                  tabindex="0"
                                                  onclick="setAdmin(this, ${item.userId})"
                                                  onkeydown="if(event.key === 'Enter' || event.key === ' ') setAdmin(this, ${item.userId})"
                                                  aria-label="Aggiungi admin">
                                                  <img src="${pageContext.request.contextPath}/img/icon/check.png"
                                                   alt=""
                                                   class="icon admin-icon"
                                                   role="presentation">
                                            </span>
                                    </c:when>
                                    <c:otherwise>
                                        <td>NO</td>
                                        <td>
                                                  <span role="button" tabindex="0"
                                                        onclick="setAdmin(this, ${item.userId})"
                                                        onkeydown="if(event.key === 'Enter' || event.key === ' ') setAdmin(this, ${item.userId})"
                                                        aria-label="Rimuovi admin">
                                                    <img src="${pageContext.request.contextPath}/img/icon/remove.png" alt="" class="icon admin-icon" role="presentation">
                                                  </span>
                                        </td>

                                    </c:otherwise>
                                </c:choose>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </c:when>
                <c:when test="${entity == 'categories'}">
                <table class="search-components-on-table--table">
                    <thead>
                    <tr>
                        <th>ID</th>
                        <th>Nome</th>
                        <th>Path</th>
                        <th><img src="${pageContext.request.contextPath}/img/icon/wrench.png" alt="wrench" class="icon-wrench"></th>
                        <th aria-label="colonna-azioni"></th>
                    </tr>
                    </thead>
                    <tbody class="componentTableBody">
                    <c:forEach var="item" items="${itemList}">
                        <tr>
                            <td>${item.categoryId}</td>
                            <td>${item.categoryName}</td>
                            <td>${item.categoryPath}</td>
                            <td><a href="#" class="edit-link" data-category-id="${item.categoryId}">Modifica</a></td>
                            <td><button type="button" class="remove-button-category remove-item-btn" data-id="${item.categoryId}" aria-label="Rimuovi categoria">
                                <img src="${pageContext.request.contextPath}/img/icon/delete.png" class="remove-icon" alt="">
                            </button></td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </c:when>

                <c:when test="${entity == 'brands'}">
                    <table class="search-components-on-table--table">
                        <thead>
                        <tr>
                            <th>ID Brand</th>
                            <th>Path</th>
                            <th>Nome</th>
                            <th><img src="${pageContext.request.contextPath}/img/icon/wrench.png" alt="wrench" class="icon-wrench"></th>
                            <th aria-label="colonna-azioni"></th>
                        </tr>
                        </thead>
                        <tbody class="componentTableBody">
                        <c:forEach var="item" items="${itemList}">
                            <tr>
                                <td>${item.brandId}</td>
                                <td>${item.logoPath}</td>
                                <td>${item.brandName}</td>
                                <td><a href="#" class="edit-link" data-brand-id="${item.brandId}">Modifica</a></td>
                                <td><button type="button" class="remove-button-brand remove-item-btn" data-id="${item.brandId}" aria-label="Rimuovi brand">
                                    <img src="${pageContext.request.contextPath}/img/icon/delete.png" class="remove-icon" alt="">
                                </button></td>

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
