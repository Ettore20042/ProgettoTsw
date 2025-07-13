<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="it">
<head>
    <title>Login</title>
    <meta charset="UTF-8">
    <jsp:include page="/WEB-INF/jsp/components/common/headContent.jsp" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/pages/auth.css">
    <script src="${pageContext.request.contextPath}/Js/auth/CheckCredential.js?v=2350" defer></script>
</head>
<body data-context-path="${pageContext.request.contextPath}">
<jsp:include page="/WEB-INF/jsp/components/common/header.jsp" />
<main>
    <div class="auth-form-container">

        <c:if test="${not empty errorMessage}">
            <div class="login-error">
                <span class="error-icon">⚠️</span>
                <span class="error-text">${errorMessage}</span>
            </div>
        </c:if>
        <h2 class="auth-form-container__title">Accedi</h2>
        <form id="loginForm" action="${pageContext.request.contextPath}/LoginServlet" method="post">
            <div class="auth-form-container__input-wrapper">
                <label for="email" class="visually-hidden">Inserisci la tua email</label>
                <input type="text" id="email" name="email" placeholder="Email" required class="auth-form-container__input" aria-describedby="emailHelp">
                <img src="${pageContext.request.contextPath}/img/icon/email.png" class="auth-form-container__icon auth-form-container__icon-email" alt="">

            </div>

            <span id="emailError" >Email non valida</span>
            <div class="auth-form-container__input-wrapper">
                <label for="password" class="visually-hidden"> Inserisci la password</label>
               <input type="password" id="password" name="password" placeholder="Conferma Password" required class="auth-form-container__input" aria-describedby="passwordHelp">
                <img src="${pageContext.request.contextPath}/img/icon/eye.png"
                     class="auth-form-container__icon auth-form-container__icon-password"
                     alt="Mostra password"
                     role="button"
                     tabindex="0"
                     aria-pressed="false"
                     aria-label="Mostra password"
                     onclick="togglePassword(this)"
                     onkeydown="if(event.key === 'Enter' || event.key === ' ') { event.preventDefault(); togglePassword(this); }">

            </div>
            <span id="passwordError" style="color: #E71D36; display: none;">Password non valida</span>
            <c:if test="${not empty loginError}">
                <div class="login-error">
                        ${loginError}
                </div>
            </c:if>


            <input type="hidden" name="redirectAfterLogin"
            value="<%= request.getParameter("redirectAfterLogin") != null ? request.getParameter("redirectAfterLogin") : "/" %>" />

            <input type="hidden" name="productId"
            value="<%= request.getParameter("productId") != null ? request.getParameter("productId") : "" %>" />

            <input type="hidden" name="quantitySelected"
            value="<%= request.getParameter("quantitySelected") != null ? request.getParameter("quantitySelected") : "" %>" />

            <button type="submit" class="auth-form-container__button">Accedi</button><br>
            <div class="auth-form-container__prompt">
                <span>Non hai un account?</span>
                <a href="${pageContext.request.contextPath}/jsp/auth/Registration.jsp" class="auth-form-container__link">Crea un account</a>
            </div>
        </form>
    </div>
</main>
<jsp:include page="/WEB-INF/jsp/components/common/footer.jsp" />
</body>
</html>
<style>
    .login-error {
        background-color: #f8d7da;
        color: #721c24;
        padding: 10px;
        border: 1px solid #f5c6cb;
        border-radius: 4px;
        margin-bottom: 15px;
    }

    .error-icon {
        margin-right: 5px;
    }
</style>