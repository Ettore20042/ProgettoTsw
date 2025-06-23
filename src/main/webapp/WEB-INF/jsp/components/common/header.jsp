<%@ page import="model.Bean.User" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<header class="main-header" data-context-path="${pageContext.request.contextPath}">
    <div class="main-header_content">
        <button id="openNavButton" tabindex="0">&#9776;</button>

        <a href="${pageContext.request.contextPath}/" class="main-header_logo-link">
            <img src="${pageContext.request.contextPath}/img/header/Logo_brico.jpg" alt="Logo" id="logoImage" />
        </a>

        <div class="search-bar main-header_search-bar">
            <form id="searchForm" action="SearchBarServlet" method="get" class="search-bar_form" autocomplete="off">
                <input type="search" id="searchBar" name="searchQuery" placeholder="Cerca..." autocomplete="off">
                <button type="submit" aria-label="Cerca">
                    <img src="${pageContext.request.contextPath}/img/header/lente.svg" id="searchLens" alt="Cerca">
                </button>
            </form>

            <div id="suggestions" >
            </div>


        </div>


        <div class="main-header_user-actions">
            <button class="user-actions_button user-actions_button--profile" id="userProfileButton">
                <span class="user-actions_button-name">${user.firstName}</span>
                <img src="${pageContext.request.contextPath}/img/header/icona_profilo.svg" alt="Icona profilo" id="profileIcon" tabindex="0"/>
            </button>
            <div class="user-role_container">
                <%if (request.getSession().getAttribute("user") != null) {
                    User user = (User) session.getAttribute("user");
                    if (user.isAdmin()) { %>
                <a href="${pageContext.request.contextPath}/jsp/profile/ManageProducts.jsp" class="user-role-button">Admin</a>
                <% } } %>
            </div>
            <div class="user-actions_dropdown" id="userActionsDropdown">
                <% if (request.getSession().getAttribute("user") != null) {
                    User user = (User) session.getAttribute("user");%>
                <a href="${pageContext.request.contextPath}/jsp/profile/User.jsp" class="user-actions_dropdown--first-link">Account</a>
                <a href="${pageContext.request.contextPath}/LogoutServlet">Logout</a>
                <% } else { %>
                <a href="${pageContext.request.contextPath}/jsp/auth/Login.jsp" class="user-actions_dropdown--first-link">Accedi</a>
                <a href="${pageContext.request.contextPath}/jsp/auth/Registration.jsp">Registrati</a>
                <% } %>
            </div>

            <a href="${pageContext.request.contextPath}/jsp/profile/Cart.jsp" class="user-actions_button user-actions_button--cart">
                <img src="${pageContext.request.contextPath}/img/header/carrello.svg" alt="Logo" id="cartIcon" tabindex="0"/>
                <span class="cart-count">
                    <c:choose>
                        <c:when test="${sessionScope.cart != null}">
                            <c:out value="${sessionScope.cart.size()}" />
                        </c:when>
                        <c:otherwise>0</c:otherwise>
                    </c:choose>
                </span>
            </a>
        </div>
    </div>
    <nav class="mobile-nav main-header_nav" id="mobileNav">
        <ul class="mobile-nav_list">
            <li class="mobile-nav_item--close"><button id="closeNavButton">&times;</button></li>
            <li><a href="${pageContext.request.contextPath}/" class="mobile-nav_link">Home</a></li>
            <li><a href="${pageContext.request.contextPath}/CategoryServlet" class="mobile-nav_link">Categorie</a></li>
            <li><a href="${pageContext.request.contextPath}/jsp/support/ContactUs.jsp" class="mobile-nav_link">Contatti</a></li>
        </ul>
    </nav>
    <script src="${pageContext.request.contextPath}/Js/common/header.js"></script>
</header>
