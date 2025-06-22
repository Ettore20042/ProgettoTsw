<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    request.setAttribute("pageTitle", " Registrazione");
%>
<!DOCTYPE html>
<html lang="it">
<head>
    <title>Registrati</title>
    <jsp:include page="/jsp/common/HeadContent.jsp" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/auth.css">
    <script src="${pageContext.request.contextPath}/Js/CheckCredential.js" defer></script>
</head>
<body>
<jsp:include page="/jsp/common/Header.jsp" />
<main>

    <div class="auth-form-container">
        <% if (request.getAttribute("error") != null) { %>
        <div style=" color: #fff; background-color: #e74c3c; padding: 15px;border-radius: 5px;margin-bottom: 20px;font-weight: bold;text-align: center;">
            <%= request.getAttribute("error") %>
        </div>
        <% } %>

        <h2 class="auth-form-container__title auth-form-container__title--registration">Registrati</h2>
        <form id="registerForm" action="${pageContext.request.contextPath}/RegistrationServlet" method="post">
            <div class="auth-form-container__name-row">
                <input type="text" class="auth-form-container__input" name="name" placeholder="Nome*" required>
                <input type="text" class="auth-form-container__input" name="surname" placeholder="Cognome*" required>
            </div>

            <input type="number" class="auth-form-container__input" name="phone" placeholder="Telefono*" required>
            <input type="email" class="auth-form-container__input" name="email" placeholder="Email*" required>
            <div class="auth-form-container__input-wrapper">
                <input type="password" class="auth-form-container__input" name="password" placeholder="Password*" required>
                <span onclick="togglePassword()"><img src="${pageContext.request.contextPath}/img/icon/eye.png" class="auth-form-container__icon"></span>
            </div>
            <div class="auth-form-container__input-wrapper">
                <input type="password" class="auth-form-container__input" name="confirmPassword" placeholder="Conferma Password*" required>
                <img src="${pageContext.request.contextPath}/img/icon/return.png" class="auth-form-container__icon">
            </div>
            <button type="submit" class="auth-form-container__button">Registrati</button>
        </form>
        <div class="auth-form-container__prompt--registration">
            <span>Hai già un account?</span>
            <a href="${pageContext.request.contextPath}/jsp/auth/Login.jsp" class="auth-form-container__link">Accedi</a>
        </div>
    </div>
</main>
<jsp:include page="/jsp/common/Footer.jsp" />
</body>
</html>