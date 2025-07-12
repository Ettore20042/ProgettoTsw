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

            <!-- Sezione ricerca -->
            <%--<section class="search-section">
                <div class="search-container">
                    <h2>Cerca una località</h2>
                    <div class="search-box">
                        <input type="text" id="search-input" placeholder="Inserisci città, via o CAP...">
                        <button id="search-btn">Cerca</button>
                    </div>
                </div>
            </section>--%>

            <!-- Container principale con mappa e lista -->
            <%--<section class="main-content">
                <!-- Mappa -->
                <div class="map-container">
                    <div id="map"></div>
                </div>--%>

                <!-- Lista store -->
                <div class="stores-container">
                    <h2>I Nostri Punti Vendita</h2>
                    <div id="stores-list">
                        <!-- Caricamento lista store via JavaScript -->
                    </div>
                </div>
            </section>
        </div>
    </main>

    <jsp:include page="/WEB-INF/jsp/components/common/footer.jsp" />

    <!-- JavaScript -->
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

        // Inizializzazione mappa
        /*function initMap() {
            try {
                console.log("Inizializzazione mappa Google Maps...");

                // Verifica che Google Maps sia caricato
                if (typeof google === 'undefined' || !google.maps) {
                    throw new Error("Google Maps non caricato");
                }

                // TEST: Verifica i dati degli store subito
                console.log("TEST: Verifico dati stores all'avvio");
                console.log("stores.length:", stores.length);
                console.log("Primo store:", stores[0]);
                console.log("Secondo store:", stores[1]);
                console.log("Terzo store:", stores[2]);

                // Crea la mappa centrata sull'Italia
                map = new google.maps.Map(document.getElementById("map"), {
                    center: { lat: 41.8719, lng: 12.5674 }, // Centro Italia
                    zoom: 6,
                    styles: [
                        {
                            featureType: "poi",
                            elementType: "labels",
                            stylers: [{ visibility: "off" }]
                        }
                    ]
                });

                // Inizializza geocoder
                geocoder = new google.maps.Geocoder();

                // Mostra i marker degli store
                showStoreMarkers();

                // Inizializza autocomplete
                initAutocomplete();

                // Event listener per il pulsante cerca
                document.getElementById('search-btn').addEventListener('click', searchLocation);

                // Mostra la lista degli store
                displayStoresList();

                console.log("Mappa inizializzata con successo");

            } catch (error) {
                console.error("Errore inizializzazione mappa:", error);
                handleMapError();
            }
        }*/

        // Gestione errori mappa
        /*function handleMapError() {
            const mapContainer = document.getElementById("map");
            mapContainer.innerHTML = `
                <div class="map-error">
                    <h3>Mappa non disponibile</h3>
                    <p>Si è verificato un problema nel caricamento della mappa. Puoi comunque consultare l'elenco dei nostri store qui sotto.</p>
                </div>
            `;
            // Mostra comunque la lista degli store
            displayStoresList();
        }*/

        // Mostra marker degli store
        /*function showStoreMarkers() {
            console.log('Creazione marker per', stores.length, 'store');
            console.log('Array stores completo:', stores);

            stores.forEach((store, index) => {
                console.log(`Creando marker ${index + 1} per:`, store.name);
                console.log('Dati store completi:', store);

                // Verifica che i dati dello store siano presenti
                if (!store || !store.name || !store.address) {
                    console.error(`Store ${index} ha dati mancanti:`, store);
                    return;
                }

                const marker = new google.maps.Marker({
                    position: { lat: store.lat, lng: store.lng },
                    map: map,
                    title: store.name,
                    label: {
                        text: (index + 1).toString(),
                        color: 'white',
                        fontSize: '14px',
                        fontWeight: 'bold'
                    },
                    icon: {
                        path: google.maps.SymbolPath.CIRCLE,
                        scale: 20,
                        fillColor: '#e74c3c',
                        fillOpacity: 1,
                        strokeColor: '#c0392b',
                        strokeWeight: 2
                    }
                });

                // Crea il contenuto dell'info window usando concatenazione di stringhe
                const infoContent =
                    '<div style="padding: 10px; max-width: 250px;">' +
                        '<h3 style="margin: 0 0 10px 0; color: #333;">' + store.name + '</h3>' +
                        '<p style="margin: 5px 0;"><strong>Indirizzo:</strong><br>' + store.address + '</p>' +
                        '<p style="margin: 5px 0;"><strong>Telefono:</strong> ' + store.phone + '</p>' +
                        '<p style="margin: 5px 0;"><strong>Email:</strong> ' + store.email + '</p>' +
                        '<div style="margin-top: 10px;">' +
                            '<strong>Orari:</strong><br>' +
                            'Lun-Ven: ' + store.hours.weekdays + '<br>' +
                            'Sabato: ' + store.hours.saturday + '<br>' +
                            'Domenica: ' + store.hours.sunday +
                        '</div>' +
                    '</div>';

                console.log('TEST - Contenuto con concatenazione per ' + store.name + ':', infoContent);

                // Info window
                const infoWindow = new google.maps.InfoWindow({
                    content: infoContent
                });

                marker.addListener('click', () => {
                    console.log('Marker clicked:', store.name);
                    console.log('Store data on click:', store);
                    console.log('Aprendo info window per:', store.name);

                    // Chiudi tutte le altre info window
                    markers.forEach(m => {
                        if (m.infoWindow) {
                            m.infoWindow.close();
                        }
                    });

                    // Apri questa info window
                    infoWindow.open(map, marker);

                    // Centra la mappa sul marker
                    map.setCenter(marker.getPosition());
                    map.setZoom(15);
                });

                marker.infoWindow = infoWindow;
                markers.push(marker);
            });
            console.log('Creati', markers.length, 'marker totali');
        }*/

        // Inizializza autocomplete
        /*function initAutocomplete() {
            const input = document.getElementById('search-input');
            autocomplete = new google.maps.places.Autocomplete(input, {
                types: ['geocode'],
                componentRestrictions: { country: 'it' }
            });

            autocomplete.addListener('place_changed', () => {
                const place = autocomplete.getPlace();
                if (!place.geometry) {
                    alert('Luogo non trovato. Riprova con un\'altra ricerca.');
                    return;
                }
                showSearchLocation(place.geometry.location, place.formatted_address);
            });
        }*/

        // Cerca località
        /*function searchLocation() {
            const query = document.getElementById('search-input').value.trim();
            if (!query) {
                alert('Inserisci una località da cercare.');
                return;
            }

            geocoder.geocode({
                address: query,
                componentRestrictions: { country: 'IT' }
            }, (results, status) => {
                if (status === 'OK' && results[0]) {
                    showSearchLocation(results[0].geometry.location, results[0].formatted_address);
                } else {
                    alert('Località non trovata. Riprova con un\'altra ricerca.');
                }
            });
        }*/

        // Mostra località cercata
        /*function showSearchLocation(location, address) {
            // Rimuovi marker precedente
            if (searchMarker) {
                searchMarker.setMap(null);
            }

            // Crea nuovo marker
            searchMarker = new google.maps.Marker({
                position: location,
                map: map,
                title: 'Località cercata',
                icon: {
                    url: 'data:image/svg+xml;charset=UTF-8,' + encodeURIComponent(`
                        <svg width="25" height="35" viewBox="0 0 25 35" xmlns="http://www.w3.org/2000/svg">
                            <path d="M12.5 0C5.6 0 0 5.6 0 12.5c0 6.9 12.5 22.5 12.5 22.5s12.5-15.6 12.5-22.5C25 5.6 19.4 0 12.5 0z" fill="#3498db"/>
                            <circle cx="12.5" cy="12.5" r="6" fill="white"/>
                        </svg>
                    `),
                    scaledSize: new google.maps.Size(25, 35),
                    anchor: new google.maps.Point(12.5, 35)
                }
            });

            // Info window per la ricerca
            const searchInfoWindow = new google.maps.InfoWindow({
                content: `<div class="search-info"><h4>📍 ${address}</h4></div>`
            });

            searchMarker.addListener('click', () => {
                searchInfoWindow.open(map, searchMarker);
            });

            // Centra mappa sulla località
            map.setCenter(location);
            map.setZoom(12);
        }*/

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

        // Localizza store sulla mappa
        /*function locateStore(index) {
            const store = stores[index];
            if (!map || !store) return;

            // Centra mappa sullo store
            map.setCenter({ lat: store.lat, lng: store.lng });
            map.setZoom(15);

            // Apri info window
            const marker = markers[index];
            if (marker && marker.infoWindow) {
                // Chiudi altre info window
                markers.forEach(m => m.infoWindow && m.infoWindow.close());
                marker.infoWindow.open(map, marker);
            }

            // Scroll verso la mappa
            document.querySelector('.map-container').scrollIntoView({
                behavior: 'smooth'
            });
        }*/

        // Inizializzazione al caricamento della pagina
        document.addEventListener('DOMContentLoaded', function() {
            console.log("DOM caricato");
            // Mostra sempre la lista degli store
            displayStoresList();
        });

        // Gestione errori Google Maps
        /*window.gm_authFailure = function() {
            console.error("Errore autenticazione Google Maps");
            handleMapError();
        };*/
    </script>

    <!-- Google Maps API -->
    <%--<script async defer
            src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBBeuZoLXSQA42geWr_OQJ1nwGUs886BXI&callback=initMap&libraries=places"
            onerror="handleMapError()">
    </script>

    <!-- Fallback timeout -->
    <script>
        setTimeout(() => {
            if (typeof google === 'undefined') {
                handleMapError();
            }
        }, 10000);
    </script>--%>
</body>
</html>
