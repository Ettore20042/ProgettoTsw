<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="it">
<head>
    <title>Conferma Ordine</title>
    <jsp:include page="/WEB-INF/jsp/components/common/headContent.jsp"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/cart/orderConfirmation.css" type="text/css">
</head>
<body data-context-path="${pageContext.request.contextPath}">
    <jsp:include page="/WEB-INF/jsp/components/common/header.jsp"/>

    <main class="confirmation-main">
        <div class="confirmation-container">
            <!-- Header di conferma -->
            <div class="confirmation-header">
                <div class="success-icon">
                    <svg viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                        <path d="M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm-2 15l-5-5 1.41-1.41L10 14.17l7.59-7.59L19 8l-9 9z" fill="currentColor"/>
                    </svg>
                </div>
                <h1 class="confirmation-title">Ordine Confermato!</h1>
                <p class="confirmation-message">
                    Grazie per il tuo acquisto. Il tuo ordine è stato registrato con successo.
                </p>
            </div>

            <!-- Dettagli ordine -->
            <div class="order-details-card">
                <h2 class="section-title">Dettagli Ordine</h2>

                <div class="order-info">
                    <div class="info-item">
                        <span class="info-label">Numero Ordine:</span>
                        <span class="info-value order-number">#${param.orderId != null ? param.orderId : '123456'}</span>
                    </div>

                    <div class="info-item">
                        <span class="info-label">Data Ordine:</span>
                        <span class="info-value">
                            <jsp:useBean id="now" class="java.util.Date" />
                            <fmt:formatDate value="${now}" pattern="dd/MM/yyyy" />
                        </span>
                    </div>

                    <div class="info-item">
                        <span class="info-label">Stato:</span>
                        <span class="info-value status-badge">In elaborazione</span>
                    </div>
                </div>
            </div>

            <!-- Prossimi passi -->
            <div class="next-steps-card">
                <h2 class="section-title">Cosa succede ora?</h2>

                <div class="steps-timeline">
                    <div class="step-item active">
                        <div class="step-icon">
                            <span>1</span>
                        </div>
                        <div class="step-content">
                            <h3 class="step-title">Ordine ricevuto</h3>
                            <p class="step-description">Il tuo ordine è stato registrato nel nostro sistema</p>
                        </div>
                    </div>

                    <div class="step-item">
                        <div class="step-icon">
                            <span>2</span>
                        </div>
                        <div class="step-content">
                            <h3 class="step-title">Preparazione</h3>
                            <p class="step-description">Stiamo preparando i tuoi prodotti per la spedizione</p>
                        </div>
                    </div>

                    <div class="step-item">
                        <div class="step-icon">
                            <span>3</span>
                        </div>
                        <div class="step-content">
                            <h3 class="step-title">Spedizione</h3>
                            <p class="step-description">Il tuo ordine sarà spedito entro 24-48 ore</p>
                        </div>
                    </div>

                    <div class="step-item">
                        <div class="step-icon">
                            <span>4</span>
                        </div>
                        <div class="step-content">
                            <h3 class="step-title">Consegna</h3>
                            <p class="step-description">Riceverai il tuo ordine all'indirizzo specificato</p>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Informazioni aggiuntive -->
            <div class="additional-info-card">
                <h2 class="section-title">Informazioni Importanti</h2>

                <div class="info-grid">
                    <div class="info-box">
                        <div class="info-icon">
                            📧
                        </div>
                        <h3 class="info-title">Email di conferma</h3>
                        <p class="info-text">
                            Ti abbiamo inviato un'email di conferma con tutti i dettagli del tuo ordine.
                        </p>
                    </div>

                    <div class="info-box">
                        <div class="info-icon">
                            📦
                        </div>
                        <h3 class="info-title">Tracking</h3>
                        <p class="info-text">
                            Riceverai il codice di tracking una volta che l'ordine sarà spedito.
                        </p>
                    </div>

                    <div class="info-box">
                        <div class="info-icon">
                            💳
                        </div>
                        <h3 class="info-title">Pagamento</h3>
                        <p class="info-text">
                            Il pagamento è stato elaborato con successo e riceverai una ricevuta.
                        </p>
                    </div>

                    <div class="info-box">
                        <div class="info-icon">
                            🔄
                        </div>
                        <h3 class="info-title">Resi</h3>
                        <p class="info-text">
                            Hai 30 giorni di tempo per restituire i prodotti se non soddisfatto.
                        </p>
                    </div>
                </div>
            </div>

            <!-- Azioni -->
            <div class="actions-section">
                <div class="actions-grid">
                    <a href="${pageContext.request.contextPath}/" class="btn btn-secondary">
                        <span class="btn-icon">🏠</span>
                        Torna alla Homepage
                    </a>

                    <a href="${pageContext.request.contextPath}/OrderServlet" class="btn btn-primary">
                        <span class="btn-icon">📋</span>
                        I Miei Ordini
                    </a>

                    <a href="${pageContext.request.contextPath}/jsp/support/ContactUs.jsp" class="btn btn-outline">
                        <span class="btn-icon">💬</span>
                        Contatta il Supporto
                    </a>
                </div>
            </div>

            <!-- Footer della conferma -->
            <div class="confirmation-footer">
                <p class="footer-text">
                    Grazie per aver scelto BricoShop! Per qualsiasi domanda o assistenza,
                    non esitare a contattarci.
                </p>
            </div>
        </div>
    </main>

    <jsp:include page="/WEB-INF/jsp/components/common/footer.jsp"/>
</body>
</html>
