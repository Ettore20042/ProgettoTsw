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
    // Global variables for map functionality
    let map;                // Google Maps instance
    let markers = [];       // Array to store all store location markers
    let autocomplete;       // Google Places Autocomplete object
    let searchMarker = null; // Marker for searched location
    let geocoder;           // Geocoder for converting addresses to coordinates

    // Store locations data
    const stores = [
        { name: "Store Roma Centro", lat: 41.9028, lng: 12.4964 },
        { name: "Store Milano Nord", lat: 45.4642, lng: 9.1900 },
        { name: "Store Napoli", lat: 40.8518, lng: 14.2681 }
    ];

    /**
     * Initialize the Google Map and related functionality
     * Called automatically by Google Maps API when loaded
     */
    function initMap() {
        // Create the map centered on Italy
        map = new google.maps.Map(document.getElementById("map"), {
            center: { lat: 42.0, lng: 12.0 },
            zoom: 6,
        });

        // Initialize geocoder for manual address searches
        geocoder = new google.maps.Geocoder();

        // Display store markers on the map
        showMarkers(stores);

        // Setup Google Places Autocomplete for the search input
        autocomplete = new google.maps.places.Autocomplete(
            document.getElementById("search-input"),
            {
                types: ['geocode'],
                componentRestrictions: { country: 'it' } // Restrict to Italy
            }
        );

        // Add event listeners
        autocomplete.addListener("place_changed", onPlaceChanged);
        document.getElementById("search-button").addEventListener("click", onManualSearch);
    }

    /**
     * Handle autocomplete selection
     */
    function onPlaceChanged() {
        const place = autocomplete.getPlace();
        if (!place.geometry) {
            alert("Luogo non trovato.");
            return;
        }

        showSearchMarker(place.geometry.location, place.name);
    }

    /**
     * Handle manual search button click
     */
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

    /**
     * Display a marker at the searched location
     * @param {Object} location - The coordinates of the searched location
     * @param {string} title - The name of the location
     */
    function showSearchMarker(location, title) {
        // Remove existing search marker if present
        if (searchMarker) {
            searchMarker.setMap(null);
        }

        // Create new marker at search location
        searchMarker = new google.maps.Marker({
            position: location,
            map: map,
            title: title, // Add title to marker itself, not in icon
            icon: {
                url: "https://cdn-icons-png.flaticon.com/512/4874/4874722.png",
                scaledSize: new google.maps.Size(32, 32)
            }
        });

        // Center and zoom the map to the searched location
        map.setCenter(location);
        map.setZoom(12);
    }

    /**
     * Display markers for all store locations
     * @param {Array} storeList - List of store objects with coordinates
     */
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

    /**
     * Remove all existing store markers from the map
     */
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