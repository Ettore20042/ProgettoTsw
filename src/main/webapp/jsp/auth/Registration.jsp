<!DOCTYPE html>
<html lang="en" >
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<head>
    <!-- Favicon (base icon for all browsers) -->



    <script src="${pageContext.request.contextPath}/Js/CheckCredential.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/auth.css?v=<%=System.currentTimeMillis()%>" type="text/css"/>
    <meta charset="UTF-8">
    <title>Registration</title>
</head>
<body>
<jsp:include page="/jsp/common/Header.jsp" />
<main>
    <div class="login">
        <h2 class="registration">Registrati</h2>
        <form id=registerForm" action="RegistrationServlet" method="post">
            <div class="nome-cognome-container">
                <input type="text"  class="barre" name="name" placeholder="Nome*" required>
                <input type="text" class="barre" name="surname" placeholder="Cognome*" required>
            </div>

            <input type="number" class="barre" name="phone" placeholder="Telefono*" required>
            <input type="email" class="barre" name="email" placeholder="Email*" required>
            <div class="bar-icon-container">
                <input type="password" class="barre" name="password" placeholder="Password*" required>
                <span  onclick="togglePassword()"><img src="${pageContext.request.contextPath}/img/icon/eye.png" class="icon"></span>
            </div>
            <div class="bar-icon-container">
                <input type="password" class="barre" name="confirmPassword" placeholder="Conferma Password*" required>
                <img src="${pageContext.request.contextPath}/img/icon/return.png" class="icon">
            </div>
            <button type="submit" class="button">Registrati</button>
        </form>
        <div class="account-prompt-registrati">
            <span>Hai già un account?</span>
            <a href="${pageContext.request.contextPath}/jsp/auth/Login.jsp" class="user-form-container_link">Accedi</a>
        </div>
    </div>
</main>
<jsp:include page="/jsp/common/Footer.jsp" />
</body>
</html>