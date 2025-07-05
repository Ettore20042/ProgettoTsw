<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    request.setAttribute("title", "Accedi");
%>
<!DOCTYPE html>
<html lang="it">
<head>
    <title>Login</title>
    <jsp:include page="/WEB-INF/jsp/components/common/headContent.jsp" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/auth.css">
    <script src="${pageContext.request.contextPath}/Js/CheckCredential.js?v=2350" defer></script>
</head>
<body data-context-path="${pageContext.request.contextPath}">
<jsp:include page="/WEB-INF/jsp/components/common/header.jsp" />
<main>
    <div class="auth-form-container">
        <h2 class="auth-form-container__title">Accedi</h2>
        <form id="loginForm" action="${pageContext.request.contextPath}/LoginServlet" method="post">
        <div class="auth-form-container__input-wrapper">
                <input type="text" id="email" name="email" placeholder="Email" required class="auth-form-container__input">
                <img src="${pageContext.request.contextPath}/img/icon/email.png" class="auth-form-container__icon auth-form-container__icon-email"><br><br>
            </div>
            <span id="emailError" style="color: #E71D36; display: none;">Email non valida</span>
            <div class="auth-form-container__input-wrapper">
                <input type="password" id="password" name="password" placeholder="Conferma Password" required class="auth-form-container__input">
                <img src="${pageContext.request.contextPath}/img/icon/eye.png"
                     class="auth-form-container__icon auth-form-container__icon-password"
                     alt="Mostra password"
                     onclick="togglePassword(this)">
            </div>
            <span id="passwordError" style="color: #E71D36; display: none;">Password non valida</span>
            <c:if test="${not empty loginError}">
                <div style=" width:40% ;background-color: #f8d7da; color: #721c24; border: 1px solid #f5c6cb; padding: 10px; border-radius: 5px; margin-bottom: 15px;">
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
