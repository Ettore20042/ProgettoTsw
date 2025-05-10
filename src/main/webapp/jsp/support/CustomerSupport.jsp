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
</head>
<body>
    <jsp:include page="/jsp/common/Header.jsp"/>

    <div class="main-support">
        <h2 class="main-support_title"> Assistenza clienti</h2>
        <div class="main-support_questions">
            <details class="disclosure-box main-support_disclosure">
                <summary class="disclosure-box_button main-support_disclosure_button">
                    <h3 class="disclosure-box_heading main-support_disclosure_heading">Come posso contattare il servizio clienti?</h3>
                </summary>
                <p class="disclosure-box_text main-support_disclosure_text">
                    Puoi contattare il nostro servizio clienti tramite email,
                    telefono o chat dal vivo. Trovi tutte le informazioni nella sezione "Contattaci".
                </p>
            </details>
            <details class="disclosure-box main-support_disclosure">
                <summary class="disclosure-box_button main-support_disclosure_button">
                    <h3 class="disclosure-box_heading main-support_disclosure_heading">Come posso effettuare un reso?</h3>
                </summary>
                <p class="disclosure-box_text main-support_disclosure_text">
                    Puoi restituire un articolo entro 30 giorni dalla consegna. Assicurati che il prodotto sia nelle stesse condizioni in cui l'hai ricevuto.
                </p>
            </details>
            <details class="disclosure-box main-support_disclosure">
                <summary class="disclosure-box_button main-support_disclosure_button">
                    <h3 class="disclosure-box_heading main-support_disclosure_heading">Quali metodi di pagamento accettate?</h3>
                </summary>
                <p class="disclosure-box_text main-support_disclosure_text">
                    Accettiamo carte di credito (Visa, MasterCard), PayPal e bonifico bancario.Per maggiori dettagli, visita la nostra
                    <a href="${pageContext.request.contextPath}/jsp/support/PaymentMethods.jsp" class="disclosure-box_link support_disclosure_link">pagina</a> dei metodi di pagamento.
                </p>
            </details>
            <details class="disclosure-box main-support_disclosure">
                <summary class="disclosure-box_button main-support_disclosure_button">
                    <h3 class="disclosure-box_heading main-support_disclosure_heading">Quanto tempo occorre per la spedizione?</h3>
                </summary>
                <p class="disclosure-box_text main-support_disclosure_text">
                    Le spedizioni standard richiedono 3-5 giorni lavorativi. La spedizione express richiede 1-2 giorni.
                </p>
            </details>
            <details class="disclosure-box main-support_disclosure">
                <summary class="disclosure-box_button main-support_disclosure_button">
                    <h3 class="disclosure-box_heading main-support_disclosure_heading">Come posso tracciare il mio ordine?</h3>
                </summary>
                <p class="disclosure-box_text main-support_disclosure_text">
                    Puoi tracciare l'ordine cliccando sul link inviato via email o accedendo al tuo account.
                    <a href="${pageContext.request.contextPath}/jsp/support/PaymentMethods.jsp" class="disclosure-box_link support_disclosure_link">Clicca  qui </a>
                </p>
            </details>

        </div>
    </div>
    <jsp:include page="/jsp/common/Footer.jsp"/>
</body>
</html>
