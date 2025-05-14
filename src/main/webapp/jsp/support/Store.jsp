<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>

    <title>Mappa Store</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/store.css?v=<%=System.currentTimeMillis()%>" type="text/css"/>
</head>
<body>
<jsp:include page="/jsp/common/Header.jsp" />
<h2 id="idtext">Trova lo Store più vicino a te</h2>
<div class="button-search-container">

    <div id="search-box">
        <label for="search-input"></label><input type="text" id="search-input" placeholder="Inserisci la tua città o luogo">
        <button  id="search-button">Cerca</button>
    </div>
    <div id="map" ></div>
</div>

<jsp:include page="/jsp/common/Footer.jsp" />

<script>
    let map;
    let markers = [];
    let autocomplete;
    let searchMarker = null;
    let geocoder;

    const stores = [
        { name: "Store Roma Centro", lat: 41.9028, lng: 12.4964 },
        { name: "Store Milano Nord", lat: 45.4642, lng: 9.1900 },
        { name: "Store Napoli", lat: 40.8518, lng: 14.2681 }
    ];

    function initMap() {
        map = new google.maps.Map(document.getElementById("map"), {
            center: { lat: 42.0, lng: 12.0 },
            zoom: 6,
        });

        geocoder = new google.maps.Geocoder();

        showMarkers(stores);

        autocomplete = new google.maps.places.Autocomplete(
            document.getElementById("search-input"),
            {
                types: ['geocode'],
                componentRestrictions: { country: 'it' }
            }
        );

        autocomplete.addListener("place_changed", onPlaceChanged);
        document.getElementById("search-button").addEventListener("click", onManualSearch);
    }

    function onPlaceChanged() {
        const place = autocomplete.getPlace();
        if (!place.geometry) {
            alert("Luogo non trovato.");
            return;
        }

        showSearchMarker(place.geometry.location, place.name);
    }

    function onManualSearch() {
        const input = document.getElementById("search-input").value.trim();

        if (!input) {
            alert("Inserisci una città o un luogo.");
            return;
        }

        geocoder.geocode({ address: input }, function(results, status) {
            if (status === "OK" && results[0]) {
                const location = results[0].geometry.location;
                const name = results[0].formatted_address;
                showSearchMarker(location, name);
            } else {
                alert("Luogo non trovato.");
            }
        });
    }

    function showSearchMarker(location, title) {
        if (searchMarker) {
            searchMarker.setMap(null);
        }

        searchMarker = new google.maps.Marker({
            position: location,
            map: map,
            title: title,
            icon: {
                url: "http://maps.google.com/mapfiles/ms/icons/blue-dot.png"
            }
        });

        map.setCenter(location);
        map.setZoom(12);
    }

    function showMarkers(storeList) {
        clearMarkers();
        storeList.forEach(store => {
            const marker = new google.maps.Marker({
                position: { lat: store.lat, lng: store.lng },
                map,
                title: store.name
            });
            markers.push(marker);
        });
    }

    function clearMarkers() {
        markers.forEach(marker => marker.setMap(null));
        markers = [];
    }
</script>


<!-- Google Maps API -->
<script async defer
        src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBBeuZoLXSQA42geWr_OQJ1nwGUs886BXI&callback=initMap&libraries=places">
</script>

</body>
</html>