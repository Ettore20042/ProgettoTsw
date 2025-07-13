<%@ page import="model.Bean.User" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<header class="main-header" role="banner" aria-label="Intestazione principale" data-context-path="${pageContext.request.contextPath}">
    <div class="main-header_content">
        <button id="openNavButton"
                type="button"
                aria-label="Apri menu di navigazione"
                aria-expanded="false" <%-- --%>
                aria-controls="mobileNav"
                class="nav-toggle">
            <span class="sr-only">Menu</span>
            &#9776;
        </button>

        <a href="${pageContext.request.contextPath}/" class="main-header_logo-link">
            <img src="${pageContext.request.contextPath}/img/header/Logo_brico.jpg" alt="BricoStore - Torna alla home" id="logoImage" />
        </a>

      <div class="search-bar main-header_search-bar" role="search">
          <form id="searchForm" action="SearchBarServlet" method="get" class="search-bar_form" autocomplete="off">
              <label for="searchBar" class="sr-only">Cerca prodotti</label>
              <input type="search"
                     id="searchBar"
                     name="searchQuery"
                     placeholder="Cerca..."
                     autocomplete="off"
                     aria-label="Campo di ricerca prodotti"
                     aria-describedby="searchHelp"
                     aria-autocomplete="list"
                     aria-expanded="false"
                     aria-owns="suggestions"
                     role="combobox">
              <button type="submit" aria-label="Esegui ricerca">
                  <img src="${pageContext.request.contextPath}/img/header/lente.svg"
                       alt=""
                       role="presentation"
                       id="searchLens">
              </button>
          </form>

          <div id="searchHelp" class="sr-only">
              Digita per cercare prodotti. Usa i tasti freccia per navigare tra i suggerimenti.
          </div>

          <ul id="suggestions"
              role="listbox"
              aria-label="Suggerimenti di ricerca"
              aria-live="polite"
              style="display: none;">
              <!-- I suggerimenti verranno inseriti dinamicamente qui -->
          </ul>
      </div>
        <div class="main-header_user-actions">
            <button class="user-actions_button user-actions_button--profile"
                    id="userProfileButton"
                    type="button"
                    aria-label="Menu profilo utente: ${sessionScope.user != null ? sessionScope.user.firstName : 'Ospite'}"
                    aria-expanded="false"
                    aria-controls="userActionsDropdown">
                <span class="user-actions_button-name">
                    <c:choose>
                        <c:when test="${sessionScope.user != null}">
                            ${sessionScope.user.firstName}
                        </c:when>
                        <c:otherwise>
                            Ospite
                        </c:otherwise>
                    </c:choose>
                </span>
                <img src="${pageContext.request.contextPath}/img/header/icona_profilo.svg"
                     alt=""
                     role="presentation"
                     id="profileIcon"/>
            </button>

            <div class="user-role_container">
                <c:if test="${sessionScope.user != null && sessionScope.user.admin}">
                    <a href="${pageContext.request.contextPath}/ManageServlet?entity=products"
                       class="user-role-button"
                       aria-label="Pannello amministratore">Admin</a>
                </c:if>
            </div>

            <div class="user-actions_dropdown"
                 id="userActionsDropdown"
                 role="menu"
                 aria-labelledby="userProfileButton"
                 aria-hidden="true">
                <c:choose>
                    <c:when test="${sessionScope.user != null}">
                        <a href="${pageContext.request.contextPath}/OrderServlet?userId=${sessionScope.user.userId}"
                           class="user-actions_dropdown--first-link"
                           role="menuitem"
                           tabindex="-1">Account</a>
                        <a href="${pageContext.request.contextPath}/LogoutServlet"
                           role="menuitem"
                           tabindex="-1">Logout</a>
                    </c:when>
                    <c:otherwise>
                        <a href="${pageContext.request.contextPath}/jsp/auth/Login.jsp"
                           class="user-actions_dropdown--first-link"
                           role="menuitem"
                           tabindex="-1">Accedi</a>
                        <a href="${pageContext.request.contextPath}/jsp/auth/Registration.jsp"
                           role="menuitem"
                           tabindex="-1">Registrati</a>
                    </c:otherwise>
                </c:choose>
            </div>

            <a href="${pageContext.request.contextPath}/jsp/cart/Cart.jsp"
               class="user-actions_button user-actions_button--cart"
               aria-label="Carrello: ${sessionScope.totalItemsCart != null ? sessionScope.totalItemsCart : 0} articoli">
                <img src="${pageContext.request.contextPath}/img/header/carrello.svg"
                     alt=""
                     role="presentation"
                     id="cartIcon"/>
                <span class="cart-count" aria-hidden="true">
                    <c:choose>
                        <c:when test="${sessionScope.cart != null}">
                            <c:out value="${sessionScope.totalItemsCart}" />
                        </c:when>
                        <c:otherwise>0</c:otherwise>
                    </c:choose>
                </span>
            </a>
        </div>
    </div>

    <nav class="mobile-nav main-header_nav"
         id="mobileNav"
         role="navigation"
         aria-label="Menu principale"
         aria-hidden="true">
        <ul class="mobile-nav_list" role="menubar">
            <li class="mobile-nav_item--close" role="none">
                <button id="closeNavButton"
                        type="button"
                        aria-label="Chiudi menu di navigazione">&times;</button>
            </li>
            <li role="none">
                <a href="${pageContext.request.contextPath}/"
                   class="mobile-nav_link"
                   role="menuitem"
                   tabindex="-1">Home</a>
            </li>
            <li role="none">
                <a href="${pageContext.request.contextPath}/CategoryServlet"
                   class="mobile-nav_link"
                   role="menuitem"
                   tabindex="-1">Categorie</a>
            </li>
            <li role="none">
                <a href="${pageContext.request.contextPath}/ProductListServlet?offers=true"
                   class="mobile-nav_link"
                   role="menuitem"
                   tabindex="-1">Offerte</a>
            </li>
            <li role="none">
                <a href="${pageContext.request.contextPath}/jsp/support/ContactUs.jsp"
                   class="mobile-nav_link"
                   role="menuitem"
                   tabindex="-1">Contatti</a>
            </li>
        </ul>
    </nav>

    <script src="${pageContext.request.contextPath}/Js/common/header.js"></script>
</header>

