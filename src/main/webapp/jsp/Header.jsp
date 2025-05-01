<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/header.css?v=<%=System.currentTimeMillis()%>" type="text/css"/>
    <meta name="color-scheme" content="light">
</head>
<body>
<header>
    <div class="top-container">
        <button id = "openNav" onClick = "openNav()" tabindex="0">&#9776;</button>

        <a href="/jsp/HomePage.jsp" class="top-container-logo">
            <img src="${pageContext.request.contextPath}/img/header/Logo_brico.jpg" alt="Logo" id="idlogo" />
        </a>

        <div class="top-container-searchBar">
            <form action="/SearchBar" method="get">
                <input type="search" id="searchBar" name="q" placeholder="Cerca...">
                <button type="submit"><img src="${pageContext.request.contextPath}/img/header/lente.svg" id="searchLens"></button>
            </form>
        </div>

        <div class="top-container-userIcons">
            <img src="${pageContext.request.contextPath}/img/header/icona_profilo.svg" alt="Logo" id="idProfileIcon" tabindex="0"/>
            <div class="top-container-login-dropdown">
                <a href="${pageContext.request.contextPath}/jsp/auth/login.jsp">Accedi</a>
                <a href="${pageContext.request.contextPath}/jsp/auth/registration.jsp">Registrati</a>
            </div>
            <img src="${pageContext.request.contextPath}/img/header/carrello.svg" alt="Logo" id="idCarrello" tabindex="0"/>
            <!--<a href="${pageContext.request.contextPath}/carrello">Carrello</a>-->
        </div>
    </div>
    <nav>
        <ul>
            <li><a href="javascript:void(0)" class="closebtn" onclick="closeNav()">&times;</a></li>
            <li><a href="${pageContext.request.contextPath}/">Home</a></li>
            <li><a href="${pageContext.request.contextPath}/prodotti">Prodotti</a></li>
            <li><a href="${pageContext.request.contextPath}/contatti">Contatti</a></li>
        </ul>
    </nav>
</header>
</body>
</html>
