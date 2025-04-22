
<!DOCTYPE html>
<html lang="en">
<head>
    <!-- Favicon (base icon for all browsers) -->
    <link rel="icon" href="${pageContext.request.contextPath}/img/favicon/favicon.ico" type="image/x-icon">

    <!-- PNG icons -->
    <link rel="icon" type="image/png" sizes="32x32" href="${pageContext.request.contextPath}/img/favicon/favicon-32x32.png">
    <link rel="icon" type="image/png" sizes="16x16" href="${pageContext.request.contextPath}/img/favicon/favicon-16x16.png">

    <!-- Apple icon -->
    <link rel="apple-touch-icon" sizes="180x180" href="${pageContext.request.contextPath}/img/favicon/apple-touch-icon.png">

    <!-- Manifest for modern browsers -->
    <link rel="manifest" href="${pageContext.request.contextPath}/img/favicon/site.webmanifest">

    <!-- Shortcut fallback -->
    <link rel="shortcut icon" href="${pageContext.request.contextPath}/img/favicon/favicon.ico" type="image/x-icon">

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
            <input type="email" id="login-email" name="email"  placeholder="Email" required class="barre"><br><br>
            <input type="password" id="password" name="password" placeholder="Password" required class="barre"><br><br>
            <button type="submit" class="button" >Accedi</button><br>
            <a href="${pageContext.request.contextPath}/jsp/auth/registration.jsp">Crea un account</a>
        </form>
    </div>
</main>
<jsp:include page="/jsp/Footer.jsp" />
</body>
</html>