<%--
  Created by IntelliJ IDEA.
  User: Utente
  Date: 03/05/2025
  Time: 19:10
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/info.css?v=<%=System.currentTimeMillis()%>" type="text/css"/>
    <title>Termini e condizioni</title>
    <jsp:include page="/jsp/common/HeadContent.jsp" />
</head>
<body>
<jsp:include page="/jsp/common/Header.jsp"/>

<section class="main-info">
    <h2 class="main-info_title">Termini e Condizioni</h2>

    <p class="main-info_text">Ultimo aggiornamento: 28 gennaio 2025</p>

    <h2 class="main-info_subtitle">1. Accettazione dei Termini</h2>
    <p class="main-info_text">
        Accedendo e utilizzando il sito www.bricoshop.com (“Sito”), l’utente accetta di essere vincolato dai presenti Termini e Condizioni e da tutte le leggi e regolamenti applicabili. Se non si è d’accordo con uno qualsiasi di questi termini, è vietato l’uso o l’accesso al Sito.
    </p>

    <h2 class="main-info_subtitle">2. Modifiche ai Termini</h2>
    <p class="main-info_text">
        Ci riserviamo il diritto di modificare i presenti Termini e Condizioni in qualsiasi momento. Le modifiche saranno efficaci al momento della loro pubblicazione sul Sito. È responsabilità dell’utente controllare periodicamente eventuali aggiornamenti.
    </p>

    <h2 class="main-info_subtitle">3. Uso del Sito</h2>
    <p class="main-info_text">
        Il Sito e i suoi contenuti sono destinati all’uso personale e non commerciale. L’utente si impegna a non riprodurre, duplicare, copiare, vendere o sfruttare qualsiasi parte del Sito senza il nostro espresso consenso scritto.
    </p>

    <h2 class="main-info_subtitle">4. Account dell’Utente</h2>
    <p class="main-info_text">
        Per accedere a determinate funzionalità del Sito, l’utente può essere tenuto a registrarsi e creare un account. L’utente è responsabile di mantenere la riservatezza delle credenziali del proprio account e di tutte le attività che si verificano con il proprio account.
    </p>

    <h2 class="main-info_subtitle">5. Limitazione di Responsabilità</h2>
    <p class="main-info_text">
        In nessun caso BricoShop sarà responsabile per eventuali danni diretti, indiretti, incidentali o consequenziali derivanti dall’uso o dall’impossibilità di utilizzare il Sito, inclusi ma non limitati a danni per perdita di profitti, dati o altre perdite immateriali.
    </p>

    <h2 class="main-info_subtitle">6. Legge Applicabile</h2>
    <p class="main-info_text">
        I presenti Termini e Condizioni sono regolati e interpretati secondo le leggi italiane. Qualsiasi controversia sarà sottoposta alla giurisdizione esclusiva dei tribunali italiani.
    </p>
</section>

<jsp:include page="/jsp/common/Footer.jsp"/>
</body>
</html>
