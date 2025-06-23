<%--
  Created by IntelliJ IDEA.
  User: Utente
  Date: 06/05/2025
  Time: 12:27
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/info.css?v=<%=System.currentTimeMillis()%>" type="text/css"/>
    <title>Contattaci</title>
    <jsp:include page="/jsp/common/HeadContent.jsp" />

</head>

<body>
<jsp:include page="/jsp/common/Header.jsp"/>
<section class="main-info contact-section">
    <h2 class="main-info_title contact-title">Contattaci</h2>

    <p class="main-info_text contact-text">
        Se hai domande, richieste o necessiti di assistenza, puoi scriverci compilando il modulo qui sotto. Ti risponderemo al più presto!
    </p>

    <div class="contact-form">
        <div class="contact-form_group">
            <label for="nome" class="contact-form_label">Nome</label>
            <input type="text" id="nome" name="nome" class="contact-form_input" required>
        </div>

        <div class="contact-form_group">
            <label for="email" class="contact-form_label">Email</label>
            <input type="email" id="email" name="email" class="contact-form_input" required>
        </div>

        <div class="contact-form_group">
            <label for="messaggio" class="contact-form_label">Messaggio</label>
            <textarea id="messaggio" name="messaggio" class="contact-form_textarea" rows="5" required></textarea>
        </div>

        <div class="contact-form_group">
            <input type="submit" value="Invia" class="contact-form_submit">
        </div>
    </div>
</section>

<jsp:include page="/jsp/common/Footer.jsp"/>
</body>
</html>
