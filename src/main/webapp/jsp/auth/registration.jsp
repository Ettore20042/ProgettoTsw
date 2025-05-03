<!DOCTYPE html>
<html lang="en" >
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<head>
    <!-- Favicon (base icon for all browsers) -->




    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/auth.css?v=<%=System.currentTimeMillis()%>" type="text/css"/>
    <meta charset="UTF-8">
    <title>Registration</title>
</head>
<body>
<jsp:include page="/jsp/Header.jsp" />
<main>
    <div class="login">
        <h2 class="registration">Registrati</h2>
        <form action="RegistrationServlet" method="post">
            <input type="text"  class="barre" name="name" placeholder="Nome*" required>
            <input type="text" class="barre" name="surname" placeholder="Cognome*" required>
            <input type="number" class="barre" name="phone" placeholder="Telefono*" required>
            <input type="email" class="barre" name="email" placeholder="Email*" required>
            <input type="password" class="barre" name="password" placeholder="Password*" required>
            <input type="password" class="barre" name="confirmPassword" placeholder="Conferma Password*" required>
            <button type="submit" class="button">Registrati</button>
        </form>
        <div class="account-prompt-registrati">
            <span>Hai già un account?</span>
            <a href="${pageContext.request.contextPath}/jsp/auth/login.jsp">Accedi</a>
        </div>
    </div>
</main>
<jsp:include page="/jsp/Footer.jsp" />
</body>
</html>