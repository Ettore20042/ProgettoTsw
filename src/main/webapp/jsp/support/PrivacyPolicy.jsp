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
    <title>Privacy e policy</title>
    <jsp:include page="/jsp/common/HeadContent.jsp" />
</head>
<body>
<jsp:include page="/jsp/common/Header.jsp"/>

<section class="main-info">
    <h2 class="main-info_title">Informativa sulla privacy</h2>
    <p class="main-info_text">Ultimo aggiornamento: 28 gennaio 2025</p>

    <p class="main-info_text">La presente Informativa sulla privacy descrive come BricoBravo (il “Sito”, “noi”, “ci” o “nostro”) raccoglie, utilizza e divulga le tue informazioni personali quando visiti, utilizzi i nostri servizi o effettui un acquisto da www.bricobravo.com (il “Sito”) o comunichi in altro modo con noi in merito al Sito (collettivamente, i “Servizi”). Ai fini della presente Informativa sulla privacy, "tu" e "tuo" indicano te come utente dei Servizi, che tu sia un cliente, un visitatore del sito web o un altro individuo di cui abbiamo raccolto le informazioni ai sensi della presente Informativa sulla privacy.</p>

    <h2 class="main-info_subtitle">Modifiche alla presente Informativa sulla privacy</h2>
    <p class="main-info_text">Potremmo aggiornare la presente Informativa sulla privacy di tanto in tanto, anche per riflettere modifiche alle nostre pratiche o per altri motivi operativi, legali o normativi. Pubblicheremo l'Informativa sulla privacy rivista sul Sito, aggiorneremo la data "Ultimo aggiornamento" e adotteremo qualsiasi altra misura richiesta dalla legge applicabile.</p>

    <h2 class="main-info_subtitle">Come raccogliamo e utilizziamo le tue informazioni personali</h2>
    <p class="main-info_text">Per fornire i Servizi, raccogliamo informazioni personali su di te provenienti da una varietà di fonti, come indicato di seguito. Le informazioni che raccogliamo e utilizziamo variano a seconda di come interagisci con noi.</p>
    <p class="main-info_text">Oltre agli usi specifici indicati di seguito, potremmo usare le informazioni che raccogliamo su di te per comunicare con te, fornire o migliorare i Servizi, rispettare eventuali obblighi legali applicabili, far rispettare eventuali termini di servizio applicabili e proteggere o difendere i Servizi, i nostri diritti e i diritti dei nostri utenti o di altri.</p>

    <h2 class="main-info_subtitlee">Quali informazioni personali raccogliamo</h2>
    <p class="main-info_text">I tipi di informazioni personali che otteniamo su di te dipendono da come interagisci con il nostro Sito e usi i nostri Servizi. Quando usiamo il termine "informazioni personali", ci riferiamo alle informazioni che identificano, si riferiscono, descrivono o possono essere associate a te. Le sezioni seguenti descrivono le categorie e i tipi specifici di informazioni personali che raccogliamo.</p>

    <h2 class="main-info_subtitle">Informazioni che raccogliamo direttamente da te</h2>
    <p class="main-info_text">Le informazioni che ci invii direttamente tramite i nostri Servizi possono includere: recapiti, informazioni sugli ordini, sull'account, sugli acquisti, recensioni, buoni regalo, richieste di assistenza clienti, ecc. Alcune funzionalità potrebbero richiedere informazioni obbligatorie, la cui mancata fornitura può impedire l'accesso al servizio.</p>

    <h2 class="main-info_subtitle">Informazioni che raccogliamo sul tuo utilizzo</h2>
    <p class="main-info_text">Potremmo raccogliere automaticamente informazioni relative alla tua interazione con i Servizi, tramite cookie, pixel e tecnologie simili. Questi dati possono includere IP, tipo di browser, informazioni sul dispositivo, cronologia di navigazione e interazione con il sito.</p>

    <h2 class="main-info_subtitle">Informazioni che otteniamo da terze parti</h2>
    <p class="main-info_text">Potremmo ottenere informazioni su di te da fornitori di servizi, gestori dei pagamenti, tecnologie di tracciamento di terze parti o altri partner. Tutte queste informazioni saranno trattate in conformità con la presente Informativa sulla privacy.</p>

    <h2 class="main-info_subtitle">Come utilizziamo le tue informazioni personali</h2>
    <p class="main-info_text">Utilizziamo le informazioni per: fornire i prodotti e servizi richiesti; marketing e pubblicità personalizzata; sicurezza e prevenzione delle frodi; assistenza clienti e miglioramento dei servizi. Le basi giuridiche variano in base alla finalità (es. contratto, interesse legittimo, consenso).</p>

    <h2 class="main-info_subtitle">Cookie</h2>
    <p class="main-info_text">Utilizziamo cookie per migliorare il sito, raccogliere statistiche, ricordare le preferenze e personalizzare i contenuti. Puoi rimuovere o bloccare i cookie dal tuo browser, ma ciò potrebbe compromettere alcune funzionalità del sito. Per maggiori dettagli consulta: <a href="https://www.shopify.com/legal/cookies" target="_blank">Cookie Policy di Shopify</a>.</p>

    <h2 class="main-info_subtitle">Come divulghiamo le tue informazioni personali</h2>
    <p class="main-info_text">Possiamo condividere le tue informazioni con: fornitori di servizi (es. pagamento, spedizione, IT), partner pubblicitari e commerciali, affiliate aziendali, autorità legali o nell'ambito di una transazione aziendale (es. fusione). Ogni condivisione avverrà nel rispetto della normativa e dei tuoi diritti.</p>
</section>

<jsp:include page="/jsp/common/Footer.jsp"/>
</body>
</html>
