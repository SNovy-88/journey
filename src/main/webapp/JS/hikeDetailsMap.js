const ORS_API_KEY = '5b3ce3597851110001cf6248e11f847fc0db4d8eb62bc09dcf82494f';

// Document ready function
document.addEventListener("DOMContentLoaded", function () {
    initializeAndShowRoute();
});

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
        type: wpt.querySelector('type').textContent.trim() || 'standard',
    }));

    // Add waypoint markers with the custom icon and popup to the detail map
    waypoints.forEach((waypoint) => {
        let icon;

        // Choose icon based on waypoint type
        switch (waypoint.type) {
            case 'poi':
                icon = L.icon({
                    iconUrl: 'pictures/Leaflet/pin-icon-poi.png',
                    iconSize: [64, 64],
                    iconAnchor: [32, 64],
                    popupAnchor: [0, -32]
                });
                break;
            case 'hut':
                icon = L.icon({
                    iconUrl: 'pictures/Leaflet/pin-icon-hut.png',
                    iconSize: [64, 64],
                    iconAnchor: [32, 64],
                    popupAnchor: [0, -32]
                });
                break;
            default:
                icon = L.icon({
                    iconUrl: 'pictures/Leaflet/pin-icon-wpt.png',
                    iconSize: [64, 64],
                    iconAnchor: [32, 64],
                    popupAnchor: [0, -32]
                });
        }

        const marker = L.marker([waypoint.lat, waypoint.lon], { icon: icon }).addTo(detailMap);
        marker.bindPopup(waypoint.name);
    });

    // Request routes between waypoints using OpenRouteService API
    for (let i = 0; i < waypoints.length - 1; i++) {
        const startPoint = waypoints[i];
        const endPoint = waypoints[i + 1];

        const { geojson, details } = await fetchRoute([
            { lat: startPoint.lat, lng: startPoint.lon },
            { lat: endPoint.lat, lng: endPoint.lon }
        ]);

        // Add the route as a layer to the upload map
        const routeLayer = L.geoJSON(geojson, { color: 'red' }).addTo(detailMap);

        // Extract elevation data
        const elevationData = extractElevationData(geojson);

        // Add elevation profile chart
        addElevationProfileChart(elevationData, routeLayer);
    }

    // Fit the upload map to the bounds of all routes
    const bounds = L.latLngBounds(waypoints.map((wpt) => L.latLng(wpt.lat, wpt.lon)));
    detailMap.fitBounds(bounds);
}

function extractElevationData(responseData) {
    const coordinates = responseData.features[0].geometry.coordinates;
    const elevationData = coordinates.map(coord => coord[2]); // Extracting height from the third entry of each coordinate
    return elevationData;
}

function addElevationProfileChart(elevationData, routeLayer) {
    const ctx = document.getElementById('elevationChart').getContext('2d');

    const chartData = {
        labels: elevationData.map((_, index) => `Point ${index + 1}`),
        datasets: [{
            label: 'Elevation Profile',
            data: elevationData,
            borderColor: 'green',
            backgroundColor: 'rgba(1, 50, 32, 0.1)',
            fill: true
        }]
    };

    const chartOptions = {
        scales: {
            x: {
                display: false, // Hide x-axis labels
                title: {
                    display: false
                }
            },
            y: {
                title: {
                    display: true,
                    text: 'Elevation (meters)'
                }
            }
        },
        plugins: {
            legend: {
                display: false // Hide the legend
            }
        },
        elements: {
            point: {
                radius: 0 // Set point radius to 0 to hide points
            }
        }
    };

    new Chart(ctx, {
        type: 'line',
        data: chartData,
        options: chartOptions
    });
}
