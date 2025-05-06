<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<footer class="main-footer">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/footer.css" type="text/css">
    <div class="main-footer_content">
        <details class="disclosure-box main-footer_customer-support">
            <summary class="disclosure-box_button">
                <h3 class="disclosure-box_heading">Assistenza Clienti</h3>
            </summary>
            <ul class="disclosure-box_list">
                <li class="disclosure-box_item">
                    <a href="${pageContext.request.contextPath}/jsp/customer-support.jsp" class="disclosure-box_link">Centro assistenza</a>
                </li>
                <li class="disclosure-box_item">
                    <a href="${pageContext.request.contextPath}/jsp/politicheReso.jsp" class="disclosure-box_link">Politiche di reso e rimborso</a>
                </li>
                <li class="disclosure-box_item">
                    <a href="${pageContext.request.contextPath}/jsp/metodiPagamento.jsp" class="disclosure-box_link">Metodi di pagamento</a>
                </li>
                <li class="disclosure-box_item">
                    <a href="${pageContext.request.contextPath}/jsp/politicheReso.jsp" class="disclosure-box_link">Contattaci</a>
                </li>
            </ul>
        </details>
        <details class="disclosure-box main-footer_legal">
            <summary class="disclosure-box_button">
                <h3 class="disclosure-box_heading">Legal</h3>
            </summary>
            <ul class="disclosure-box_list">
                <li class="disclosure-box_item">
                    <a href="${pageContext.request.contextPath}/privacy.jsp" class="disclosure-box_link">Privacy Policy</a>
                </li>
                <li class="disclosure-box_item">
                    <a href="${pageContext.request.contextPath}/termini.jsp" class="disclosure-box_link">Termini e Condizioni</a>
                </li>
            </ul>
        </details>
        <div class="main-footer_social-box">
            <ul class="social_box_list">
                <li class="social_box_item">
                    <p>Seguici sui social:</p>
                </li>
                <li class="social_box_item">
                    <a href="https://www.facebook.com/" class="social-box_link">
                        <img src="${pageContext.request.contextPath}/img/footer/facebook.svg" class="social-box_icon" alt="Facebook">
                    </a>
                </li>
                <li class="social_box_item">
                    <a href="https://www.instagram.com/" class="social-box_link">
                        <img src="${pageContext.request.contextPath}/img/footer/instagram.png" class="social-box_icon" alt="Instagram">
                    </a>
                </li>
                <li class="social_box_item">
                    <a href="https://www.twitter.com/" class="social-box_link">
                        <img src="${pageContext.request.contextPath}/img/footer/twitter-X.svg" class="social-box_icon" alt="Twitter">
                    </a>
                </li>
            </ul>

        </div>
        <p class="main-footer_copyright"> 2025 Brico Shop. Tutti i diritti riservati.</p>
    </div>
</footer>