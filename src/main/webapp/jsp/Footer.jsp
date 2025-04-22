<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<footer>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/footer.css?v=<%=System.currentTimeMillis()%>" type="text/css"/>
    <div class="footer-content">
        <div class="footer-links">
            <p> 2025 Brico Shop. Tutti i diritti riservati.</p>
            <ul>
                <li><a href="${pageContext.request.contextPath}/privacy">Privacy Policy</a></li>
                <li><a href="${pageContext.request.contextPath}/termini">Termini e Condizioni</a></li>
                <li><a href="${pageContext.request.contextPath}/contatti">Contatti</a></li>
            </ul>
        </div>
        <div class="footer-social">
            <ul>
                <li>Seguici sui social:</li>
                <li><a href="https://www.facebook.com/"><img src="${pageContext.request.contextPath}/img/footer/facebook.svg" alt="Facebook" id="idfacebook"></a></li>
                <li><a href="https://www.instagram.com/"><img src="${pageContext.request.contextPath}/img/footer/instagram.png" alt="Instagram" id="idinstagram"></a></li>
                <li><a href="https://www.twitter.com/"><img src="${pageContext.request.contextPath}/img/footer/x.svg" alt="Twitter" id="idtwitter"></a></li>
                <li><a href="https://www.linkedin.com/"><img src="${pageContext.request.contextPath}/img/footer/linkedin.svg" alt="LinkedIn" id="idlinkedin"></a></li>
            </ul>

        </div>
    </div>
</footer>