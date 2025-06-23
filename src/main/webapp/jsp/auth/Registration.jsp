<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    request.setAttribute("pageTitle", " Registrazione");
%>
<!DOCTYPE html>
<html lang="it">
<head>
    <title>Registrati</title>
    <jsp:include page="/WEB-INF/jsp/components/common/headContent.jsp" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/auth.css">
    <script src="${pageContext.request.contextPath}/Js/CheckCredential.js" defer></script>
</head>
<body>
<jsp:include page="/WEB-INF/jsp/components/common/header.jsp" />
<main>

    <div class="auth-form-container">
        <% if (request.getAttribute("error") != null) { %>
        <div style="color: #fff; background-color: #e74c3c; padding: 15px; border-radius: 5px; margin-bottom: 20px; font-weight: bold; text-align: center;">
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
            </div>

            <div class="auth-form-container__input-wrapper">
                <input type="password" class="auth-form-container__input" name="confirmPassword" placeholder="Conferma Password*" required>
                <span onclick="togglePassword('confirmPassword')" style="cursor: pointer;" role="button" tabindex="0"
                      onkeydown="if(event.key==='Enter'||event.key===' ') togglePassword('confirmPassword')"
                      aria-label="Mostra/Nascondi conferma password">

                </span>
            </div>
            <div class="password-requirements" style="font-size: 12px; color: #666; margin-bottom: 15px;">
                La password deve contenere:
                <ul style="margin: 5px 0; padding-left: 20px;">
                    <li>8-20 caratteri</li>
                    <li>Almeno una lettera maiuscola</li>
                    <li>Almeno una lettera minuscola</li>
                    <li>Almeno un numero</li>
                    <li>Almeno un carattere speciale ($@#&!)</li>
                </ul>
            </div>
            <button type="submit" class="auth-form-container__button">Registrati</button>
        </form>

        <div class="auth-form-container__prompt--registration">
            <span>Hai già un account?</span>
            <a href="${pageContext.request.contextPath}/jsp/auth/Login.jsp" class="auth-form-container__link">Accedi</a>
        </div>
    </div>
</main>
<jsp:include page="/WEB-INF/jsp/components/common/footer.jsp" />
</body>
</html>