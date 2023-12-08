const ORS_API_KEY = '5b3ce3597851110001cf6248e11f847fc0db4d8eb62bc09dcf82494f';

// Initialize the upload map
let detailMap = null;

// Document ready function
document.addEventListener("DOMContentLoaded", function () {

    initializeAndShowRoute();
});

function insertIcons(value, full, empty, container_id) {
    console.log('insertIcons called with value:', value);
    let svgHTML = '';
    let container = document.getElementById(container_id)
    if (value >= 1 && value <= 5) {
        for (let i = 0; i < value; i++) {
            svgHTML += full;
        }
        for (let j = 0; j < 5 - value; j++) {
            svgHTML += empty;
        }
        container.innerHTML = svgHTML;
    }else {
        for (let i = 0; i < 5; i++){
            svgHTML += empty;
            container.innerHTML = svgHTML;
        }
    }
}

function checkRangeAndHighlightRecommendedMonths(element, month, start, end){
    if (month >= start && month <= end) {
        element.css('background-color', '#b1ff2e');
    }
}

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

const staminaEmptyIcon = '<svg style="margin-right: 5px" xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi bi-heart-pulse" viewBox="0 0 16 16">' +
    '<path d="m8 2.748-.717-.737C5.6.281 2.514.878 1.4 3.053.918 3.995.78 5.323 1.508 7H.43c-2.128-5.697 4.165-8.83 7.394-5.857.06.055.119.112.176.171a3.12 3.12 0 0 1 .176-.17c3.23-2.974 9.522.159 7.394 5.856h-1.078c.728-1.677.59-3.005.108-3.947C13.486.878 10.4.28 8.717 2.01L8 2.748ZM2.212 10h1.315C4.593 11.183 6.05 12.458 8 13.795c1.949-1.337 3.407-2.612 4.473-3.795h1.315c-1.265 1.566-3.14 3.25-5.788 5-2.648-1.75-4.523-3.434-5.788-5Z"/>' +
    '<path d="M10.464 3.314a.5.5 0 0 0-.945.049L7.921 8.956 6.464 5.314a.5.5 0 0 0-.88-.091L3.732 8H.5a.5.5 0 0 0 0 1H4a.5.5 0 0 0 .416-.223l1.473-2.209 1.647 4.118a.5.5 0 0 0 .945-.049l1.598-5.593 1.457 3.642A.5.5 0 0 0 12 9h3.5a.5.5 0 0 0 0-1h-3.162l-1.874-4.686Z"/>' +
    '</svg>';
const staminaFullIcon = '<svg style="margin-right: 5px" xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="#EC3737" class="bi bi-heart-pulse-fill" viewBox="0 0 16 16">' +
    '<path d="M1.475 9C2.702 10.84 4.779 12.871 8 15c3.221-2.129 5.298-4.16 6.525-6H12a.5.5 0 0 1-.464-.314l-1.457-3.642-1.598 5.593a.5.5 0 0 1-.945.049L5.889 6.568l-1.473 2.21A.5.5 0 0 1 4 9H1.475Z"/>' +
    '<path d="M.88 8C-2.427 1.68 4.41-2 7.823 1.143c.06.055.119.112.176.171a3.12 3.12 0 0 1 .176-.17C11.59-2 18.426 1.68 15.12 8h-2.783l-1.874-4.686a.5.5 0 0 0-.945.049L7.921 8.956 6.464 5.314a.5.5 0 0 0-.88-.091L3.732 8H.88Z"/>' +
    '</svg>';

const experienceEmptyIcon = '<svg style="margin-right: 5px" xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi bi-mortarboard" viewBox="0 0 16 16">' +
    '<path d="M8.211 2.047a.5.5 0 0 0-.422 0l-7.5 3.5a.5.5 0 0 0 .025.917l7.5 3a.5.5 0 0 0 .372 0L14 7.14V13a1 1 0 0 0-1 1v2h3v-2a1 1 0 0 0-1-1V6.739l.686-.275a.5.5 0 0 0 .025-.917l-7.5-3.5ZM8 8.46 1.758 5.965 8 3.052l6.242 2.913L8 8.46Z"/>' +
    '<path d="M4.176 9.032a.5.5 0 0 0-.656.327l-.5 1.7a.5.5 0 0 0 .294.605l4.5 1.8a.5.5 0 0 0 .372 0l4.5-1.8a.5.5 0 0 0 .294-.605l-.5-1.7a.5.5 0 0 0-.656-.327L8 10.466 4.176 9.032Zm-.068 1.873.22-.748 3.496 1.311a.5.5 0 0 0 .352 0l3.496-1.311.22.748L8 12.46l-3.892-1.556Z"/>' +
    '</svg>';
const experienceFullIcon = '<svg style="margin-right: 5px" xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="#804E0D" class="bi bi-mortarboard-fill" viewBox="0 0 16 16">' +
    '<path d="M8.211 2.047a.5.5 0 0 0-.422 0l-7.5 3.5a.5.5 0 0 0 .025.917l7.5 3a.5.5 0 0 0 .372 0L14 7.14V13a1 1 0 0 0-1 1v2h3v-2a1 1 0 0 0-1-1V6.739l.686-.275a.5.5 0 0 0 .025-.917l-7.5-3.5Z"/>' +
    '<path d="M4.176 9.032a.5.5 0 0 0-.656.327l-.5 1.7a.5.5 0 0 0 .294.605l4.5 1.8a.5.5 0 0 0 .372 0l4.5-1.8a.5.5 0 0 0 .294-.605l-.5-1.7a.5.5 0 0 0-.656-.327L8 10.466 4.176 9.032Z"/>' +
    '</svg>';

const sceneryEmptyIcon = '<svg style="margin-right: 5px" xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi bi-sun" viewBox="0 0 16 16">' +
    '<path d="M8 11a3 3 0 1 1 0-6 3 3 0 0 1 0 6zm0 1a4 4 0 1 0 0-8 4 4 0 0 0 0 8zM8 0a.5.5 0 0 1 .5.5v2a.5.5 0 0 1-1 0v-2A.5.5 0 0 1 8 0zm0 13a.5.5 0 0 1 .5.5v2a.5.5 0 0 1-1 0v-2A.5.5 0 0 1 8 13zm8-5a.5.5 0 0 1-.5.5h-2a.5.5 0 0 1 0-1h2a.5.5 0 0 1 .5.5zM3 ' +
    '8a.5.5 0 0 1-.5.5h-2a.5.5 0 0 1 0-1h2A.5.5 0 0 1 3 8zm10.657-5.657a.5.5 0 0 1 0 .707l-1.414 1.415a.5.5 0 1 1-.707-.708l1.414-1.414a.5.5 0 0 1 .707 0zm-9.193 9.193a.5.5 0 0 1 0 .707L3.05 13.657a.5.5 0 0 1-.707-.707l1.414-1.414a.5.5 0 0 1 .707 0zm9.193 ' +
    '2.121a.5.5 0 0 1-.707 0l-1.414-1.414a.5.5 0 0 1 .707-.707l1.414 1.414a.5.5 0 0 1 0 .707zM4.464 4.465a.5.5 0 0 1-.707 0L2.343 3.05a.5.5 0 1 1 .707-.707l1.414 1.414a.5.5 0 0 1 0 .708z">' +
    '</path></svg>';
const sceneryFullIcon = '<svg style="margin-right: 5px" xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="#FFC230" class="bi bi-sun-fill" viewBox="0 0 16 16">' +
    '<path d="M8 12a4 4 0 1 0 0-8 4 4 0 0 0 0 8zM8 0a.5.5 0 0 1 .5.5v2a.5.5 0 0 1-1 0v-2A.5.5 0 0 1 8 0zm0 13a.5.5 0 0 1 .5.5v2a.5.5 0 0 1-1 0v-2A.5.5 0 0 1 8 13zm8-5a.5.5 0 0 1-.5.5h-2a.5.5 0 0 1 0-1h2a.5.5 0 0 1 .5.5zM3 8a.5.5 0 0 1-.5.5h-2a.5.5 0 0 1 0-1h2A.5.5 0 0 1 3 ' +
    '8zm10.657-5.657a.5.5 0 0 1 0 .707l-1.414 1.415a.5.5 0 1 1-.707-.708l1.414-1.414a.5.5 0 0 1 .707 0zm-9.193 9.193a.5.5 0 0 1 0 .707L3.05 13.657a.5.5 0 0 1-.707-.707l1.414-1.414a.5.5 0 0 1 .707 0zm9.193 2.121a.5.5 0 0 1-.707 0l-1.414-1.414a.5.5 0 0 1 .707-.707l1.414 1.414a.5.5 0 0 1 0 ' +
    '.707zM4.464 4.465a.5.5 0 0 1-.707 0L2.343 3.05a.5.5 0 1 1 .707-.707l1.414 1.414a.5.5 0 0 1 0 .708z"/>' +
    '</path></svg>';