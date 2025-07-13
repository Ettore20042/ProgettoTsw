<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="it">
<head>
    <jsp:include page="/WEB-INF/jsp/components/common/headContent.jsp" />
    <title>I Nostri Store - BricoShop</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/pages/store.css?v=<%=System.currentTimeMillis()%>" type="text/css"/>
</head>
<body>
    <jsp:include page="/WEB-INF/jsp/components/common/header.jsp" />

    <main class="store-main">
        <div class="store-container">
            <!-- Header della pagina -->
            <section class="store-header">
                <h1>I Nostri Store</h1>
                <p>Trova il negozio BricoShop più vicino a te e vieni a trovarci!</p>
            </section>



                <!-- Lista store -->
                <div class="stores-container">
                    <h2>I Nostri Punti Vendita</h2>
                    <div id="stores-list">

                    </div>
                </div>
            </section>
        </div>
    </main>

    <jsp:include page="/WEB-INF/jsp/components/common/footer.jsp" />


    <script>
        // Variabili globali
        let map;
        let markers = [];
        let searchMarker = null;
        let geocoder;
        let autocomplete;

        // Dati degli store
        const stores = [
            {
                id: 1,
                name: "BricoShop Milano",
                address: "Via Torino 15, 20123 Milano MI",
                phone: "02 1234567",
                email: "milano@bricoshop.it",
                lat: 45.4642,
                lng: 9.1900,
                hours: {
                    weekdays: "8:30 - 19:30",
                    saturday: "8:30 - 20:00",
                    sunday: "9:00 - 18:00"
                }
            },
            {
                id: 2,
                name: "BricoShop Roma",
                address: "Via del Corso 123, 00186 Roma RM",
                phone: "06 9876543",
                email: "roma@bricoshop.it",
                lat: 41.9028,
                lng: 12.4964,
                hours: {
                    weekdays: "8:30 - 19:30",
                    saturday: "8:30 - 20:00",
                    sunday: "9:00 - 18:00"
                }
            },
            {
                id: 3,
                name: "BricoShop Napoli",
                address: "Via Toledo 456, 80134 Napoli NA",
                phone: "081 5555555",
                email: "napoli@bricoshop.it",
                lat: 40.8518,
                lng: 14.2681,
                hours: {
                    weekdays: "8:30 - 19:30",
                    saturday: "8:30 - 20:00",
                    sunday: "9:00 - 18:00"
                }
            }
        ];


        // Mostra lista store
        function displayStoresList() {
            const container = document.getElementById('stores-list');

            let html = '';
            stores.forEach((store, index) => {
                html += '<div class="store-card" data-index="' + index + '">' +
                    '<div class="store-header">' +
                        '<h3>' + store.name + '</h3>' +
                        '<span class="store-number">' + (index + 1) + '</span>' +
                    '</div>' +
                    '<div class="store-info">' +
                        '<p class="address">📍 ' + store.address + '</p>' +
                        '<p class="phone">📞 <a href="tel:' + store.phone + '">' + store.phone + '</a></p>' +
                        '<p class="email">✉️ <a href="mailto:' + store.email + '">' + store.email + '</a></p>' +
                    '</div>' +
                    '<div class="store-hours">' +
                        '<h4>🕒 Orari di apertura:</h4>' +
                        '<ul>' +
                            '<li>Lun-Ven: ' + store.hours.weekdays + '</li>' +
                            '<li>Sabato: ' + store.hours.saturday + '</li>' +
                            '<li>Domenica: ' + store.hours.sunday + '</li>' +
                        '</ul>' +
                    '</div>' +
                    '<div class="store-actions">' +
                        '<a href="https://www.google.com/maps/search/?api=1&query=' + store.lat + ',' + store.lng + '" class="locate-btn" target="_blank">' +
                            '📍 Mostra sulla Mappa' +
                        '</a>' +
                    '</div>' +
                '</div>';
            });

            container.innerHTML = html;
        }



        // Inizializzazione al caricamento della pagina
        document.addEventListener('DOMContentLoaded', function() {
            console.log("DOM caricato");
            // Mostra sempre la lista degli store
            displayStoresList();
        });


    </script>

</body>
</html>
