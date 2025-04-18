<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<header>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/header.css?v=<%=System.currentTimeMillis()%>" type="text/css"/>
    <div class="logo">
        <img src="${pageContext.request.contextPath}/img/header/download.png" alt="Logo" />
    </div>
    <form action="/SearchBar" method="get">
        <input type="search" id="search" name="q" placeholder="Cerca...">
        <button type="submit"><img src="${pageContext.request.contextPath}/img/header/lente.svg"></button>
    </form>
    <img src="${pageContext.request.contextPath}/img/header/omino.jpeg" alt="Logo" class="logo">
    <div class="user-info">
        <a href="${pageContext.request.contextPath}/jsp/auth/login.jsp">Accedi</a>
        <a href="${pageContext.request.contextPath}/jsp/auth/registration.jsp">Registrati</a>
    </div>
    <img src="${pageContext.request.contextPath}/img/header/carrello.svg" alt="Logo" class="logo">
    <div class="cart">
        <a href="${pageContext.request.contextPath}/carrello">Carrello</a>
    </div>
    <nav>
        <ul>
            <li><a href="${pageContext.request.contextPath}/">Home</a></li>
            <li><a href="${pageContext.request.contextPath}/prodotti">Prodotti</a></li>
            <li><a href="${pageContext.request.contextPath}/contatti">Contatti</a></li>
        </ul>
    </nav>
</header>