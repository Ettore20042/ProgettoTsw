
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Le nostre policy</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/info.css?v=<%=System.currentTimeMillis()%>" type="text/css"/>
    <jsp:include page="/jsp/common/HeadContent.jsp" />
</head>
<body>
<jsp:include page="/jsp/common/Header.jsp"/>

<section class="main-info">
    <h2 class="main-info_title">Le nostre policy di reso e rimborso</h2>
    <p class="main-info_text">
        La soddisfazione dei nostri clienti è la nostra priorità assoluta. Per questo motivo abbiamo definito una policy chiara e trasparente per la gestione dei resi e dei rimborsi.
        Il nostro obiettivo è offrire un'esperienza d'acquisto serena, tutelando i tuoi diritti in ogni fase.
    </p>
    <p class="main-info_text">
        Se hai acquistato un prodotto e hai cambiato idea, o se hai riscontrato un problema con l’articolo ricevuto, potrai avvalerti del diritto di recesso o richiedere un rimborso
        secondo le modalità descritte di seguito.
    </p>

    <h3 class="main-info_subtitle">Politica di reso</h3>
    <p class="main-info_text">
        È possibile restituire qualsiasi prodotto entro 30 giorni dalla data di ricezione, a condizione che sia integro, non utilizzato e nella confezione originale.
        I costi di spedizione per la restituzione sono a carico del cliente, salvo in caso di prodotti difettosi o danneggiati.
    </p>
    <p class="main-info_text">
        Per avviare una procedura di reso, ti chiediamo di contattare il nostro Servizio Clienti all’indirizzo email <a href="mailto:supporto@esempio.com">supporto@esempio.com</a>
        specificando il numero d’ordine, il prodotto da restituire e il motivo del reso. Riceverai una conferma via email con le istruzioni dettagliate per il reso.
    </p>
    <p class="main-info_text">
        Una volta ricevuto il prodotto e verificata la sua condizione, provvederemo all’approvazione del reso e ti informeremo tempestivamente sull'esito della richiesta.
    </p>

    <h3 class="main-info_subtitle">Politica di rimborso</h3>
    <p class="main-info_text">
        Una volta approvato il reso, il rimborso verrà elaborato entro 5-7 giorni lavorativi. L’importo sarà accreditato sul metodo di pagamento utilizzato al momento dell’acquisto.
        I tempi effettivi possono variare in base all’istituto bancario o al circuito della carta di credito.
    </p>
    <p class="main-info_text">
        In caso di prodotti difettosi o errori nella spedizione, provvederemo al rimborso completo comprensivo delle spese di spedizione. È possibile, in alternativa, richiedere
        la sostituzione del prodotto senza costi aggiuntivi.
    </p>
    <p class="main-info_text">
        Ti ricordiamo che non possiamo effettuare rimborsi per articoli personalizzati, prodotti in saldo o usati, salvo difetti di fabbrica certificati.
    </p>

    <h3 class="main-info_subtitle">Assistenza clienti</h3>
    <p class="main-info_text">
        Il nostro team di assistenza è sempre disponibile per aiutarti. Per domande, chiarimenti o supporto nella gestione dei resi e rimborsi,
        puoi contattarci via email o attraverso il nostro modulo di contatto sul sito. Ti risponderemo nel più breve tempo possibile.
    </p>
    <p class="main-info_text">
        Per garantire una gestione efficiente delle richieste, ti invitiamo a conservare la ricevuta o la conferma d'ordine ricevuta via email al momento dell'acquisto.
        Questi documenti potrebbero essere richiesti dal nostro Servizio Clienti per verificare i dati dell'ordine e accelerare la procedura.
    </p>

    <p class="main-info_text">
        Le nostre policy vengono aggiornate periodicamente per rispecchiare le normative vigenti e migliorare continuamente la qualità del servizio.
        Ti consigliamo di consultare questa pagina ogni tanto per restare informato su eventuali modifiche.
    </p>
</section>

<jsp:include page="/jsp/common/Footer.jsp"/>
</body>
</html>
