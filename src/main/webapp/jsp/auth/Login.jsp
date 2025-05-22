
<!DOCTYPE html>
<html lang="en">
<head>
    <!-- Favicon (base icon for all browsers) -->
    <jsp:include page="/jsp/common/HeadContent.jsp" />
    <script src="${pageContext.request.contextPath}/Js/CheckCredential.js"></script>
    <%@ page contentType="text/html;charset=UTF-8" %>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/auth.css?v=<%=System.currentTimeMillis()%>" type="text/css"/>
    <meta charset="UTF-8">
    <title>Login</title>
</head>
<body>
<jsp:include page="/jsp/common/Header.jsp" />
<main>
    <div class="login">
        <h2>Accedi</h2>
        <form id="loginForm" action="LoginServlet" method="post">
            <div class="bar-icon-container">
                <input type="text" id="email" name="email"  placeholder="Email" required class="barre">
                <img src="${pageContext.request.contextPath}/img/icon/email.png" class="icon"><br><br>
            </div>
            <span id="emailError" style="color: #E71D36; display: none;">Email non valida</span>
            <div class="bar-icon-container">
                <input type="password" id="password" name="password" placeholder="Password" required class="barre"><br><br>
                <img src="${pageContext.request.contextPath}/img/icon/padlock.png" class="icon"><br><br>

            </div>
            <span id="passwordError" style="color: #E71D36; display: none;">Password non valida</span>
            <button type="submit" class="button" >Accedi</button><br>
            <div class="account-prompt">
                <span>Non hai un account?</span>
                <a href="${pageContext.request.contextPath}/jsp/auth/Registration.jsp" class="user-form-container_link">Crea un account</a>
            </div>
        </form>
    </div>

</main>
<jsp:include page="/jsp/common/Footer.jsp" />
</body>
</html>