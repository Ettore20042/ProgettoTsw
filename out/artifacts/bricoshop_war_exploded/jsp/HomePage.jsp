<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <!-- Favicon (base icon for all browsers) -->
    <link rel="icon" href="${pageContext.request.contextPath}/img/favicon/favicon.ico" type="image/x-icon">


    <title>Brico Shop</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/homepage.css?v=<%=System.currentTimeMillis()%>" type="text/css"/>
</head>
<body>
<jsp:include page="Header.jsp" />

<main>
    <section class="welcome-section">
        <div class="categoria-section">
            <img src="${pageContext.request.contextPath}/img/homepage/materassoa.jpg" alt="Product" id="welcome-category-image">
            <h3>I nostri prodotti</h3>
            <a href="${pageContext.request.contextPath}/jsp/category.jsp" class="button" id="idscopriora">Scopri di più</a>
        </div>
        <div class="small-section">
            <div class="brand-section">
                <img src="${pageContext.request.contextPath}/img/homepage/brand.png" alt="Brand" id="welcome-brand-image">
                <h3>I nostri Brand</h3>
                <a href="${pageContext.request.contextPath}/jsp/brand.jsp" class="button">Scopri di più</a>
            </div>
            <div class="shop-offers-container">
                <div class="shop-section">
                    <img src="${pageContext.request.contextPath}/img/homepage/negozio.png" alt="Shop" id="welcome-shop-image">
                    <h3>I nostri store</h3>
                    <a href="${pageContext.request.contextPath}/jsp/shop.jsp" class="button">Trova il negozio</a>
                </div>
                <div class="offers-section">
                    <img src="${pageContext.request.contextPath}/img/homepage/promo.png" alt="Promo" id="welcome-promo-image">
                    <h3>Le nostre offerte</h3>
                    <a href="${pageContext.request.contextPath}/jsp/offers.jsp" class="button">Scopri di più</a>
                </div>
            </div>
        </div>
    </section>
    <div class="featured">
        <h2>In primo piano</h2>


    </div>
    <section class="about-us">
        <h2>Il più importante Marketplace Italiano del settore Home & Garden</h2>
        <p>Nel 1959 eravamo un negozio di ferramenta a conduzione familiare. Oggi BricoBravo è un punto di riferimento nel settore del bricolage e del fai da te oltre ad essere anche un ecommerce online dove dare sfogo alla tua passione per la casa, la decorazione e il giardinaggio.</p>

        <p>Qualunque sia il tuo progetto, da noi puoi trovare facilmente ed acquistare online gli strumenti per realizzarlo: dagli utensili, gli oggetti per il fai da te e la manutenzione, fino ai mobili, i complementi per l’arredamento, il riscaldamento con stufe e caminetti e la climatizzazione di piccoli e grandi spazi con condizionatori fissi e portatili.</p>

        <p>Oltre ad offriti tante idee per gli interni, da BricoBravo ti proponiamo anche soluzioni per attrezzare gli spazi esterni con tutte le comodità che desideri: piscine, gazebo o casette e box.</p>

        <p>E siccome abbiamo a cuore proprio tutte le tue passioni, qui troverai anche prodotti per prenderti cura della tua auto e della tua moto. Realizza i tuoi progetti con le offerte e le promozioni di BricoBravo e approfitta dei consigli e dell’assistenza dei nostri esperti.</p>
    </section>
    <!-- Prova dei dao con questo form-->
    <form action="hello-servlet" method="get">
        <input type="submit" value="Clicca qui per vedere il messaggio di benvenuto">

    </form>

</main>

<jsp:include page="Footer.jsp" />
</body>
</html>