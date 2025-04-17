<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Title</title>
</head>
<body>
<jsp:include page="/jsp/Header.jsp" />
<main>
    <h1>Registrati</h1>
    <form action="RegistrationServlet" method="post">
        <input type="text" name="name" placeholder="Nome" required>
        <input type="text" name="surname" placeholder="Cognome" required>
        <input type="number" name="phone" placeholder="Telefono" required>
        <input type="email" name="email" placeholder="Email" required>
        <input type="password" name="password" placeholder="Password" required>
        <button type="submit">Registrati</button>
    </form>
</main>
<jsp:include page="/jsp/Footer.jsp" />
</body>
</html>