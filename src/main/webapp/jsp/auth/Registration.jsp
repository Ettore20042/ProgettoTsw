<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    request.setAttribute("pageTitle", "Registrazione");
%>
<!DOCTYPE html>
<html lang="it">
<head>
    <title>Registrati</title>
    <jsp:include page="/WEB-INF/jsp/components/common/headContent.jsp" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/auth.css">
    <script src="${pageContext.request.contextPath}/Js/CheckCredential.js?v=2350" defer></script>
</head>
<body>
<jsp:include page="/WEB-INF/jsp/components/common/header.jsp" />
<main>
    <div class="auth-form-container">
        <% if (request.getAttribute("error") != null) { %>
        <div class="server-error-message" style="color: #fff; background-color: #e74c3c; padding: 15px; border-radius: 5px; margin-bottom: 20px; font-weight: bold; text-align: center;">
            <%= request.getAttribute("error") %>
        </div>
        <% } %>

        <% if (request.getAttribute("success") != null) { %>
        <div class="server-success-message" style="color: #fff; background-color: #27ae60; padding: 15px; border-radius: 5px; margin-bottom: 20px; font-weight: bold; text-align: center;">
            <%= request.getAttribute("success") %>
        </div>
        <% } %>

        <h2 class="auth-form-container__title auth-form-container__title--registration">Registrati</h2>
        <form id="registerForm" action="${pageContext.request.contextPath}/RegistrationServlet" method="post" novalidate>
            <div class="auth-form-container__name-row">
                <label for="name" class="visually-hidden">Inserisci il tuo nome</label>
                <input type="text"
                       class="auth-form-container__input"
                       name="name"
                       placeholder="Nome*"
                       required
                       value="<%= request.getParameter("name") != null ? request.getParameter("name") : "" %>"
                       autocomplete="given-name"
                        id="name">
                <label for="surname" class="visually-hidden">Inserisci il tuo cognome</label>
                <input type="text"
                       class="auth-form-container__input"
                       name="surname"
                       placeholder="Cognome*"
                       required
                       value="<%= request.getParameter("surname") != null ? request.getParameter("surname") : "" %>"
                       autocomplete="family-name"
                        id="surname">
            </div>
            <label for="tel" class="visually-hidden">Inserisci il numero di telefono</label>
            <input type="tel"
                   class="auth-form-container__input"
                   name="phone"
                   placeholder="Telefono* (es. 3123456789)"
                   required
                   pattern="[0-9]{8,15}"
                   value="<%= request.getParameter("phone") != null ? request.getParameter("phone") : "" %>"
                   autocomplete="tel"
                    id="tel">
            <label for="email" class="visually-hidden">Inserisci la tua email</label>
            <input type="email"
                   class="auth-form-container__input"
                   name="email"
                   placeholder="Email*"
                   required
                   value="<%= request.getParameter("email") != null ? request.getParameter("email") : "" %>"
                   autocomplete="email"
                    id="email">

            <div class="auth-form-container__input-wrapper">
                <label for="password" class="visually-hidden">Inserisci la password</label>
                <input type="password" id="password" name="password" placeholder="Conferma Password" required class="auth-form-container__input">
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
            <div class="auth-form-container__input-wrapper">
                <label for="confirmPassword" class="visually-hidden">Conferma la password</label>
                <input type="password" id="confirmPassword" name="password" placeholder="Conferma Password" required class="auth-form-container__input">
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

            <div class="password-requirements" style="font-size: 12px; color: #666; margin-bottom: 15px; line-height: 1.4;">
                <strong>La password deve contenere:</strong>
                <ul style="margin: 8px 0; padding-left: 20px; list-style-type: disc;">
                    <li>8-20 caratteri</li>
                    <li>Almeno una lettera maiuscola (A-Z)</li>
                    <li>Almeno una lettera minuscola (a-z)</li>
                    <li>Almeno un numero (0-9)</li>
                    <li>Almeno un carattere speciale ($@#&!)</li>
                </ul>
            </div>

            <div class="form-actions">
                <button type="submit" class="auth-form-container__button">
                    <span class="button-text">Registrati</span>
                    <span class="button-loader" style="display: none;">Caricamento...</span>
                </button>
            </div>
        </form>

        <div class="auth-form-container__prompt--registration">
            <span>Hai già un account?</span>
            <a href="${pageContext.request.contextPath}/jsp/auth/Login.jsp" class="auth-form-container__link">Accedi</a>
        </div>
    </div>
</main>
<jsp:include page="/WEB-INF/jsp/components/common/footer.jsp" />

<script>
    // Script aggiuntivo per migliorare l'UX
    document.addEventListener('DOMContentLoaded', function() {
        // Gestione loading button
        const form = document.getElementById('registerForm');
        const submitButton = form.querySelector('button[type="submit"]');
        const buttonText = submitButton.querySelector('.button-text');
        const buttonLoader = submitButton.querySelector('.button-loader');

        form.addEventListener('submit', function(e) {
            if (validateForm()) {
                submitButton.disabled = true;
                buttonText.style.display = 'none';
                buttonLoader.style.display = 'inline';
            }
        });

        // Gestione accessibilità per toggle password
        document.querySelectorAll('.auth-form-container__icon').forEach(icon => {
            icon.addEventListener('keypress', function(e) {
                if (e.key === 'Enter' || e.key === ' ') {
                    e.preventDefault();
                    this.click();
                }
            });
        });

        // Auto-hide messaggi del server dopo 5 secondi
        const serverMessages = document.querySelectorAll('.server-error-message, .server-success-message');
        serverMessages.forEach(message => {
            setTimeout(() => {
                message.style.opacity = '0';
                message.style.transition = 'opacity 0.5s ease-out';
                setTimeout(() => {
                    if (message.parentNode) {
                        message.remove();
                    }
                }, 500);
            }, 5000);
        });
    });
</script>
</body>
</html>