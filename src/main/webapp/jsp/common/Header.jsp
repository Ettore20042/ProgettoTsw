<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<header class="main-header">

    <link rel="icon" type="image/x-icon" href="${pageContext.request.contextPath}/img/favicon/favicon.ico">


    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/header.css?v=<%=System.currentTimeMillis()%>" type="text/css"/>
    <meta name="color-scheme" content="light">
    <meta name="viewport" content="user-scalable=no, initial-scale=1, maximum-scale=1, minimum-scale=1, width=device-width">
    <div class="main-header_content">
        <button id = "openNavButton" tabindex="0">&#9776;</button>

        <a href="${pageContext.request.contextPath}/" class="main-header_logo-link">
            <img src="${pageContext.request.contextPath}/img/header/Logo_brico.jpg" alt="Logo" id="logoImage" />
        </a>

        <div class="search-bar main-header_search-bar">
            <form action="/SearchBar" method="get" class="search-bar_form">
                <input type="search" id="searchBar" name="q" placeholder="Cerca...">
                <button type="submit">
                    <img src="${pageContext.request.contextPath}/img/header/lente.svg" id="searchLens">
                </button>
            </form>
        </div>

        <div class="main-header_user-actions">
            <button class="user-actions_button user-actions_button--profile" id="userProfileButton">
                <img src="${pageContext.request.contextPath}/img/header/icona_profilo.svg" alt="Icona profilo" id="profileIcon" tabindex="0"/>
            </button>

            <div class="user-actions_dropdown" id="userActionsDropdown">
                <a href="${pageContext.request.contextPath}/jsp/auth/login.jsp">Accedi</a>
                <a href="${pageContext.request.contextPath}/jsp/auth/registration.jsp">Registrati</a>
            </div>
            <a href="${pageContext.request.contextPath}/carrello" class="user-actions_button user-actions_button--cart">
                <img src="${pageContext.request.contextPath}/img/header/carrello.svg" alt="Logo" id="cartIcon" tabindex="0"/>
                <!--<a href="${pageContext.request.contextPath}/carrello">Carrello</a>-->
            </a>

        </div>
    </div>
    <nav class="mobile-nav main-header_nav" id="mobileNav">
        <ul class="mobile-nav_list">
            <li class="mobile-nav_item--close"><button id="closeNavButton">&times;</button></li>
            <li><a href="${pageContext.request.contextPath}/" class="mobile-nav_link">Home</a></li>
            <li><a href="${pageContext.request.contextPath}/prodotti" class="mobile-nav_link">Prodotti</a></li>
            <li><a href="${pageContext.request.contextPath}/contatti" class="mobile-nav_link">Contatti</a></li>
        </ul>
    </nav>
    <script src="${pageContext.request.contextPath}/Js/common/header.js"></script>
</header>
