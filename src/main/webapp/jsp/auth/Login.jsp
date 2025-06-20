<%
    request.setAttribute("title", "Accedi");
%>
<!DOCTYPE html>
<html lang="it">
<head>
    <title><c:out value="${pageTitle}" default="BricoShop"/></title>
    <jsp:include page="/jsp/common/HeadContent.jsp" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/auth.css">
    <script src="${pageContext.request.contextPath}/Js/CheckCredential.js" defer></script>
</head>
<body data-context-path="${pageContext.request.contextPath}">
<jsp:include page="/jsp/common/Header.jsp" />
<main>
    <div class="auth-form-container">
        <h2 class="auth-form-container__title">Accedi</h2>
        <form id="loginForm" action="LoginServlet" method="post">
            <div class="auth-form-container__input-wrapper">
                <input type="text" id="email" name="email" placeholder="Email" required class="auth-form-container__input">
                <img src="${pageContext.request.contextPath}/img/icon/email.png" class="auth-form-container__icon"><br><br>
            </div>
            <span id="emailError" style="color: #E71D36; display: none;">Email non valida</span>
            <div class="auth-form-container__input-wrapper">
                <input type="password" id="password" name="password" placeholder="Password" required class="auth-form-container__input"><br><br>
                <img src="${pageContext.request.contextPath}/img/icon/padlock.png" class="auth-form-container__icon"><br><br>
            </div>
            <span id="passwordError" style="color: #E71D36; display: none;">Password non valida</span>
            <button type="submit" class="auth-form-container__button">Accedi</button><br>
            <div class="auth-form-container__prompt">
                <span>Non hai un account?</span>
                <a href="${pageContext.request.contextPath}/jsp/auth/Registration.jsp" class="auth-form-container__link">Crea un account</a>
            </div>
        </form>
    </div>
</main>
<jsp:include page="/jsp/common/Footer.jsp" />


