<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%
    request.setAttribute("pageTitle", "BricoBravo - Home");
%>
<!DOCTYPE html>
<html lang="it">
    <head>
        <title><c:out value="${pageTitle}" default="BricoShop"/></title>
        <jsp:include page="/jsp/common/HeadContent.jsp" />
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/homepage.css?v=<%=System.currentTimeMillis()%>" type="text/css"/>
        <script src="${pageContext.request.contextPath}/Js/Homepage.js" defer></script>
    </head>
    <body>
        <jsp:include page="common/Header.jsp"/>
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
                    <c:forEach var="product"  items="${products}">
                        <div class="product">
                            <a href="${pageContext.request.contextPath}/ProductServlet?productId=${product.productId}" class="a-class">
                                <img src="${pageContext.request.contextPath}/ImageServlet?productId=${product.productId}"
                                                       alt="${product.productName}"
                                                       class="product-image" />
                            <h2>${product.productName}</h2></a>
                            <p>Prezzo: €${product.price}</p>
                        </div>
                    </c:forEach>
                </div>

                <button class="scroll-button right" onclick="scrollToRight()">❯</button>

            </div>
            <section class="about-us">
                <h2>Il più importante Marketplace Italiano del settore Home & Garden</h2>
                <p>Nel 1959 eravamo un negozio di ferramenta a conduzione familiare. Oggi BricoBravo è un punto di riferimento nel settore del bricolage e del fai da te oltre ad essere anche un ecommerce online dove dare sfogo alla tua passione per la casa, la decorazione e il giardinaggio.</p>

                <p>Qualunque sia il tuo progetto, da noi puoi trovare facilmente ed acquistare online gli strumenti per realizzarlo: dagli utensili, gli oggetti per il fai da te e la manutenzione, fino ai mobili, i complementi per l’arredamento, il riscaldamento con stufe e caminetti e la climatizzazione di piccoli e grandi spazi con condizionatori fissi e portatili.</p>

                <p>Oltre ad offriti tante idee per gli interni, da BricoBravo ti proponiamo anche soluzioni per attrezzare gli spazi esterni con tutte le comodità che desideri: piscine, gazebo o casette e box.</p>

                <p>E siccome abbiamo a cuore proprio tutte le tue passioni, qui troverai anche prodotti per prenderti cura della tua auto e della tua moto. Realizza i tuoi progetti con le offerte e le promozioni di BricoBravo e approfitta dei consigli e dell’assistenza dei nostri esperti.</p>
            </section>


        </main>

        <jsp:include page="common/Footer.jsp" />
    </body>
</html>
