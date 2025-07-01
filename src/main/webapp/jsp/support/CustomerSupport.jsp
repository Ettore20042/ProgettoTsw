<%--
  Created by IntelliJ IDEA.
  User: Utente
  Date: 03/05/2025
  Time: 19:07
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Assistenza clienti</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/support.css?v=<%=System.currentTimeMillis()%>" type="text/css"/>
    <jsp:include page="/WEB-INF/jsp/components/common/headContent.jsp" />
</head>
<body>
    <jsp:include page="/WEB-INF/jsp/components/common/header.jsp"/>

    <div class="main-support">
        <div class="main-support_header">
            <h2 class="main-support_title"> Assistenza clienti</h2>
            <img src="${pageContext.request.contextPath}/img/icon/paperQuestions.png" alt="Customer Support" class="main-support_image">
        </div>
            <div class="main-support_questions">
            <details class="disclosure-box main-support_disclosure">
                <summary class="disclosure-box_button main-support_disclosure_button">
                    <h3 class=" disclosure-box_title">Come posso contattare il servizio clienti❓</h3>
                </summary>
                <p class=" main-support_disclosure_text">
                    Puoi contattare il nostro servizio clienti tramite email,
                    telefono o chat dal vivo. Trovi tutte le informazioni nella sezione
                    <a href="${pageContext.request.contextPath}/jsp/support/ContactUs.jsp"  class=" support_disclosure_link ">"Contattaci".</a>
                </p>
            </details>
            <details class="disclosure-box main-support_disclosure">
                <summary class="disclosure-box_button main-support_disclosure_button">
                    <h3 class="disclosure-box_title">Come posso effettuare un reso❔</h3>
                </summary>
                <p class=" main-support_disclosure_text">
                    Puoi restituire un articolo entro 30 giorni dalla consegna. Assicurati che il prodotto sia nelle stesse condizioni in cui l'hai ricevuto.
                </p>
            </details>
            <details class="disclosure-box main-support_disclosure">
                <summary class="disclosure-box_button main-support_disclosure_button">
                    <h3 class="disclosure-box_title">Quali metodi di pagamento accettate❓</h3>
                </summary>
                <p class=" main-support_disclosure_text">
                    Accettiamo carte di credito (Visa, MasterCard), PayPal e bonifico bancario.Per maggiori dettagli, visita la nostra
                    <a href="${pageContext.request.contextPath}/jsp/support/PaymentMethods.jsp" class=" support_disclosure_link">pagina</a> dei metodi di pagamento.
                </p>
            </details>
            <details class="disclosure-box main-support_disclosure">
                <summary class="disclosure-box_button main-support_disclosure_button">
                    <h3 class="disclosure-box_title">Quanto tempo occorre per la spedizione❔</h3>
                </summary>
                <p class=" main-support_disclosure_text">
                    Le spedizioni standard richiedono 3-5 giorni lavorativi. La spedizione express richiede 1-2 giorni.
                </p>
            </details>
            <details class="disclosure-box main-support_disclosure">
                <summary class="disclosure-box_button main-support_disclosure_button">
                    <h3 class="disclosure-box_title">Come posso tracciare il mio ordine❓</h3>
                </summary>
                <p class=" main-support_disclosure_text">
                    Puoi tracciare l'ordine cliccando sul link inviato via email o accedendo al tuo account.
                    <a href="${pageContext.request.contextPath}/jsp/profile/User.jsp" class=" support_disclosure_link">Clicca  qui </a>
                </p>
            </details>

        </div>
    </div>
    <jsp:include page="/WEB-INF/jsp/components/common/footer.jsp"/>
</body>
</html>
