
<!DOCTYPE html>
<html lang="en">
<head>
    <!-- Favicon (base icon for all browsers) -->



    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/auth.css?v=<%=System.currentTimeMillis()%>" type="text/css"/>
    <meta charset="UTF-8">
    <title>Login</title>
</head>
<body>
<jsp:include page="/jsp/Header.jsp" />
<main>
    <div class="login">
        <h2>Accedi</h2>
        <form action="LoginServlet" method="post">
            <div class="email-logo-container">
                <input type="email" id="login-email" name="email"  placeholder="Email" required class="barre">
                <img src="${pageContext.request.contextPath}/img/other/email.png" id="idemaillogo"><br><br>
            </div>
            <div class="password-logo-container">
                <input type="password" id="password" name="password" placeholder="Password" required class="barre"><br><br>
                <img src="${pageContext.request.contextPath}/img/other/padlock.png" id="idpasslogo"><br><br>
            </div>


            <input type="checkbox" id="remember-me" name="remember-me">
            <label for="remember-me">Ricordami</label><br><br>
            <button type="submit" class="button" >Accedi</button><br>
            <div class="account-prompt">
                <span>Non hai un account?</span>
                <a href="${pageContext.request.contextPath}/jsp/auth/registration.jsp">Crea un account</a>
            </div>        </form>
    </div>

</main>
<jsp:include page="/jsp/Footer.jsp" />
</body>
</html>