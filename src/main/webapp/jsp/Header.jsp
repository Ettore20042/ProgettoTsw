<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<header>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/header.css?v=<%=System.currentTimeMillis()%>" type="text/css"/>





    <div class="top-container">
        <div class="top-container-left">

            <a href="${pageContext.request.contextPath}/jsp/HomePage.jsp">
                <img src="${pageContext.request.contextPath}/img/header/logo.png" alt="Logo" id="idlogo">
            </a>

        </div>

        <div class="top-container-center">
                <form action="/SearchBar" method="get">
                <input type="search" id="search" name="q" placeholder="Cerca...">
                 <button type="submit"><img src="${pageContext.request.contextPath}/img/header/lente.svg" id="idsearch"></button>
                </form>
        </div>
        <div class="top-container-right">
                    <img src="${pageContext.request.contextPath}/img/header/omino.jpeg" alt="Logo" id="idomino" />
                    <a href="${pageContext.request.contextPath}/jsp/auth/login.jsp">Accedi</a>
                    <p>/</p>
                    <a href="${pageContext.request.contextPath}/jsp/auth/registration.jsp">Registrati</a>
                    <img src="${pageContext.request.contextPath}/img/header/carrello.svg" alt="Logo" id="idcarrello" />
                    <a href="${pageContext.request.contextPath}/carrello" id="cartlink">Carrello</a>
        </div>
    </div>
    <nav>
        <ul>
            <li><a href="${pageContext.request.contextPath}/">Home</a></li>
            <li><a href="${pageContext.request.contextPath}/prodotti">Prodotti</a></li>
            <li><a href="${pageContext.request.contextPath}/contatti">Contatti</a></li>
        </ul>
    </nav>
</header>