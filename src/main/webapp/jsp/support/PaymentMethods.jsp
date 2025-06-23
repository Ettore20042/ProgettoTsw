<%--
  Created by IntelliJ IDEA.
  User: Utente
  Date: 03/05/2025
  Time: 19:08
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Metodi di pagamento</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/info.css?v=<%=System.currentTimeMillis()%>" type="text/css"/>
    <jsp:include page="/WEB-INF/jsp/components/common/headContent.jsp" />
</head>
<body>
<jsp:include page="/WEB-INF/jsp/components/common/header.jsp"/>
<section class="main-info">
    <h2 class="main-info_title">Metodi di pagamento</h2>
    <p class="main-info_text">
        Offriamo diverse modalità di pagamento sicure e affidabili per rendere la tua esperienza di acquisto semplice e flessibile.
        Tutti i pagamenti sono processati attraverso connessioni criptate per garantire la massima protezione dei tuoi dati.
    </p>
    <div class="main-info_image-container">

        <h3 class="main-info_subtitle">Carte di credito e debito</h3>
        <img src="${pageContext.request.contextPath}/img/icon/credit-card.webp" alt="Credit-card" class="icon-payments" />
    </div>
        <p class="main-info_text">
        Accettiamo le principali carte di credito e debito, inclusi Visa, Mastercard, American Express e Maestro.
        L'addebito avverrà solo al momento della conferma dell'ordine. I dati della tua carta non saranno mai salvati nei nostri sistemi.
    </p>
    <div class="main-info_image-container">
        <img src="${pageContext.request.contextPath}/img/icon/PayPal.svg" alt="PayPal" id="logo-paypal"/>

    </div>
        <p class="main-info_text">
        Puoi scegliere di pagare con PayPal, utilizzando il tuo account personale per completare l'acquisto in modo rapido e sicuro,
        senza dover inserire i dati della tua carta direttamente sul nostro sito.
    </p>
        <div class="main-info_image-container">
        <h3 class="main-info_subtitle">Pagamento alla consegna</h3>
        <img src="${pageContext.request.contextPath}/img/icon/camionetta.png" alt="Camionetta" class="icon-payments"/>
    </div>
        <p class="main-info_text">
        In alcune località offriamo la possibilità di pagamento in contanti alla consegna (contrassegno).
        Questo metodo comporta un piccolo sovrapprezzo che verrà chiaramente indicato al momento dell’ordine.
        </p>
    <div class="main-info_image-container">
        <h3 class="main-info_subtitle">Bonifico bancario</h3>
        <img src="${pageContext.request.contextPath}/img/icon/banca.png" alt="banca" class="icon-payments"/>
    </div>
        <p class="main-info_text">
        Se preferisci, puoi effettuare il pagamento tramite bonifico bancario. In questo caso l’ordine sarà elaborato solo dopo
        la ricezione dell’importo sul nostro conto. Le istruzioni per il bonifico ti verranno inviate via email al momento della conferma.
    </p>
    <div class="main-info_image-container">
    <h3 class="main-info_subtitle">Sicurezza e protezione</h3>
    <img src="${pageContext.request.contextPath}/img/icon/security.png" alt="Sicurezza" class="icon-payments"/>
    </div>
        <p class="main-info_text">
        Tutte le transazioni sono protette da sistemi di crittografia SSL a 256 bit.
        I nostri partner per i pagamenti sono selezionati tra i migliori fornitori internazionali per garantire affidabilità e conformità alle normative PCI-DSS.
    </p>

    <p class="main-info_text">
        Per qualsiasi dubbio o problema relativo ai pagamenti, ti invitiamo a contattare il nostro Servizio Clienti. Saremo lieti di aiutarti.
    </p>
</section>

<jsp:include page="/WEB-INF/jsp/components/common/footer.jsp"/>
</body>
</html>
