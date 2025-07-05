<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%
    request.setAttribute("pageTitle", "BricoBravo - Home");
%>
<!DOCTYPE html>
<html lang="it">
    <head>
        <title><c:out value="${pageTitle}" default="BricoShop"/></title>
        <jsp:include page="/WEB-INF/jsp/components/common/headContent.jsp" />
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/homepage.css?v=<%=System.currentTimeMillis()%>" type="text/css"/>
        <script src="${pageContext.request.contextPath}/Js/Homepage.js" defer></script>
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/productList.css" />
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/components/_productCard.css">

    </head>
    <body>
        <jsp:include page="../WEB-INF/jsp/components/common/header.jsp"/>
        <main>
            <!-- Aggiungi all'inizio della pagina, dopo i tag iniziali -->

            <section class="welcome-section">
                <div class="categoria-section">
                    <img src="${pageContext.request.contextPath}/img/homepage/materassoa.jpg" alt="Product" id="welcome-category-image">
                    <h3>I nostri prodotti</h3>
                    <a href="${pageContext.request.contextPath}/CategoryServlet" class="button" id="idscopriora">Scopri di più</a>
                </div>
                <div class="small-section">
                    <div class="shop-brand-section">
                        <div class="brand-section">
                        <img src="${pageContext.request.contextPath}/img/homepage/brand.png" alt="Brand" id="welcome-brand-image">
                        <h3>I nostri Brand</h3>
                        <a href="${pageContext.request.contextPath}/BrandServlet" class="button">Scopri di pi&ugrave;</a>
                         </div>

                        <div class="shop-section">
                            <img src="${pageContext.request.contextPath}/img/homepage/negozio.png" alt="Shop" id="welcome-shop-image">
                            <h3>I nostri store</h3>
                            <a href="${pageContext.request.contextPath}/jsp/support/Store.jsp" class="button">Trova il negozio</a>
                        </div>
                    </div>
                        <div class="offers-section">
                            <img src="${pageContext.request.contextPath}/img/homepage/promo.png" alt="Promo" id="welcome-promo-image">
                            <h3>Le nostre offerte</h3>
                            <a href="${pageContext.request.contextPath}/ProductListServlet?offers=true" class="button">Scopri di più</a>
                        </div>

                </div>
            </section>
            <h1 id="idevidenza">In evidenza</h1>
            <div class="scroll-container">

                <button class="scroll-button left" onclick="scrollToLeft()">❮</button>

                <div class="featured" id="featured">
                    <!-- I prodotti arriveranno già dalla servlet -->
                    <c:choose>
                        <c:when test="${empty productList}">
                            <p>Nessun prodotto trovato.</p>
                        </c:when>
                        <c:otherwise>
                    <div class="product-list_cards">

                               <jsp:include page="../WEB-INF/jsp/components/products/_productListCard.jsp"/>
                     </div>
                        </c:otherwise>
                    </c:choose>
                </div>
                <button class="scroll-button right" onclick="scrollToRight()">❯</button>

            </div>
            <section class="project-ideas">
                <h2>Ispirazioni per i tuoi progetti</h2>
                <div class="idea-cards">
                    <div class="idea-card">
                        <img src="${pageContext.request.contextPath}/img/homepage/idee-mensola.jpg" alt="Mensola Fai da Te">
                        <h3>Come montare una mensola</h3>
                        <p>Tutorial passo-passo con materiali consigliati e attrezzi essenziali.</p>
                        <a href="https://www.youtube.com/shorts/OF4UPwOpfSU?feature=share" class="button">Guarda la guida</a>
                    </div>
                    <div class="idea-card">
                        <img src="${pageContext.request.contextPath}/img/homepage/idee-giardino.jpg" alt="Giardino">
                        <h3>Allestisci il tuo giardino</h3>
                        <p>Soluzioni per esterni con mobili, casette e illuminazione sostenibile.</p>
                        <a href="https://www.youtube.com/shorts/7OPZINPil4Q?feature=share" class="button">Scopri di più</a>
                    </div>
                </div>
            </section>

            <section class="about-us">
                <h2>Il più importante Marketplace Italiano del settore Home & Garden</h2>
                <p>Nel 1959 eravamo un negozio di ferramenta a conduzione familiare. Oggi BricoShop è un punto di riferimento nel settore del bricolage e del fai da te oltre ad essere anche un ecommerce online dove dare sfogo alla tua passione per la casa, la decorazione e il giardinaggio.</p>

                <p>Qualunque sia il tuo progetto, da noi puoi trovare facilmente ed acquistare online gli strumenti per realizzarlo: dagli utensili, gli oggetti per il fai da te e la manutenzione, fino ai mobili, i complementi per l’arredamento, il riscaldamento con stufe e caminetti e la climatizzazione di piccoli e grandi spazi con condizionatori fissi e portatili.</p>

                <p>Oltre ad offriti tante idee per gli interni, da BricoShop ti proponiamo anche soluzioni per attrezzare gli spazi esterni con tutte le comodità che desideri: piscine, gazebo o casette e box.</p>

                <p>E siccome abbiamo a cuore proprio tutte le tue passioni, qui troverai anche prodotti per prenderti cura della tua auto e della tua moto. Realizza i tuoi progetti con le offerte e le promozioni di BricoShop e approfitta dei consigli e dell’assistenza dei nostri esperti.</p>
            </section>


        </main>

        <jsp:include page="../WEB-INF/jsp/components/common/footer.jsp" />
    </body>
</html>
