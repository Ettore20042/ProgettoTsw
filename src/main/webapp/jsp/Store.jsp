<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <link rel="icon" href="${pageContext.request.contextPath}/img/favicon/favicon.ico" type="image/x-icon">
    <title>Mappa Store</title>
    <style>
        .map-button-search-container {
            display: flex;
            justify-content: center;
            flex-direction: row;
        }
        #map {
            height: 30vh;
            width: 60%;
            border-radius: 5%;
            margin: 0 0 5% 5%;
            border: 1rem solid #f1efea;
        }
        #search-box {
            margin: 20px 0;
        }
        #search-input {
            width: 100%;
            height: 2.5rem;
            padding: 0.5% 1%;
            border: none;
            border-radius: 0.5rem;
            font-size: 1rem;
            background-color: rgb(241, 239, 234);
            color: rgb(36, 70, 92);
            box-shadow: 0 0.1rem 0.2rem rgba(0, 0, 0, 0.2);
            margin-bottom: 5%;
        }
        button {
            background-color: rgb(30, 58, 71);
            color: #f1efea;
            padding: 0.5rem 1rem;
            border: greenyellow solid 1px;
            border-radius: 0.3rem;
            cursor: pointer;
            font-size: 1.3rem;
        }
    </style>
</head>
<body>
<jsp:include page="/jsp/Header.jsp" />
<h2>Trova lo Store più vicino a te</h2>
<div class="map-button-search-container">
    <div id="search-box">
        <input type="text" id="search-input" placeholder="Inserisci la tua città o luogo">
        <button id="search-button">Cerca</button>
    </div>
    <div id="map" style="height: 500px; width: 100%;"></div>
</div>

<jsp:include page="/jsp/Footer.jsp" />

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