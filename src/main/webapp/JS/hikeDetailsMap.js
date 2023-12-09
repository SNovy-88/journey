const ORS_API_KEY = '5b3ce3597851110001cf6248e11f847fc0db4d8eb62bc09dcf82494f';

// Initialize the upload map
let detailMap = null;

// Function to initialize the Leaflet map and show the route
async function initializeAndShowRoute() {
    // Get the GPX data from the hidden input
    const gpxData = document.getElementById('xmlText').value;
    console.log("XML Text: " + gpxData);

    if (!detailMap) {
        // Create a new map instance for file upload
        detailMap = L.map('detailMap').setView([47, 11], 7); // Adjust the initial view as needed

        // Add a tile layer to the upload map
        L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
            attribution: '&copy; OpenStreetMap contributors'
        }).addTo(detailMap);
    }

    // Parse GPX data to get waypoints
    const parser = new DOMParser();
    const xmlDoc = parser.parseFromString(gpxData, 'text/xml');
    const waypoints = Array.from(xmlDoc.querySelectorAll('wpt')).map((wpt) => ({
        lat: parseFloat(wpt.getAttribute('lat')),
        lon: parseFloat(wpt.getAttribute('lon')),
        name: wpt.querySelector('name').textContent.trim() || 'Unnamed Waypoint',
    }));

    // Create a custom icon for the waypoint marker
    const customIcon = L.icon({
        iconUrl: 'pictures/Leaflet/pin-icon-wpt.png',
        iconSize: [33, 51],
        iconAnchor: [16, 51],
        popupAnchor: [0, -51],
    });

    // Add waypoint markers with the custom icon and popup to the upload map
    waypoints.forEach((waypoint) => {
        const marker = L.marker([waypoint.lat, waypoint.lon], { icon: customIcon }).addTo(detailMap);
        marker.bindPopup(waypoint.name);
    });

    // Request routes between waypoints using OpenRouteService API
    for (let i = 0; i < waypoints.length - 1; i++) {
        const startPoint = waypoints[i];
        const endPoint = waypoints[i + 1];

        const route = await calculateRoute(startPoint, endPoint);

        // Add the route as a layer to the upload map
        L.polyline(route, { color: 'red' }).addTo(detailMap);
    }

    // Fit the upload map to the bounds of all routes
    const bounds = L.latLngBounds(waypoints.map((wpt) => L.latLng(wpt.lat, wpt.lon)));
    detailMap.fitBounds(bounds);
}

// Function to calculate route between two waypoints using OpenRouteService API
async function calculateRoute(startPoint, endPoint) {
    const profile = 'foot-hiking'; // Specify the hiking profile
    const url = `https://api.openrouteservice.org/v2/directions/${profile}?api_key=${ORS_API_KEY}&start=${startPoint.lon},${startPoint.lat}&end=${endPoint.lon},${endPoint.lat}`;

    try {
        const response = await fetch(url);
        const data = await response.json();

        if (data.features && data.features.length > 0) {
            // Extract coordinates from the route geometry
            return data.features[0].geometry.coordinates.map(([lon, lat]) => [lat, lon]);
        } else {
            console.error('Error calculating route:', data);
            return [];
        }
    } catch (error) {
        console.error('Error calculating route:', error);
        return [];
    }
}