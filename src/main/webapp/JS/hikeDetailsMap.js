document.addEventListener("DOMContentLoaded", function () {
    initializeAndShowRoute();
});

let detailMap = null;

// Initialize arrays to accumulate distances and elevation data
let accumulatedDistances = [];
let accumulatedElevationData = [];
let totalAccumulatedDistance = 0;

// Function to initialize the Leaflet map and show the route
async function initializeAndShowRoute() {
    // Get the GPX data from the hidden input
    const gpxData = document.getElementById('xmlText').value;

    if (!detailMap) {
        detailMap = L.map('detailMap').setView([47, 11], 7); // Set the initial view

        // Add OpenStreetMap tile layer to the map
        L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
            attribution: '&copy; OpenStreetMap contributors'
        }).addTo(detailMap);
    }

    const waypoints = parseGPX(gpxData);

    // Add waypoint markers with the custom icon and popup to the detail map
    waypoints.forEach((waypoint) => {
        // Choose icon based on waypoint type
        const customIcon = getWaypointIcon(waypoint.type);

        const marker = L.marker([waypoint.lat, waypoint.lon], { icon: customIcon }).addTo(detailMap);
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

        // Accumulate distances and elevation data
        const elevationDataObj = extractElevationData(geojson);
        const adjustedDistances = elevationDataObj.distances.map((distance) => distance + totalAccumulatedDistance);
        accumulatedDistances = accumulatedDistances.concat(adjustedDistances);
        accumulatedElevationData = accumulatedElevationData.concat(elevationDataObj.elevationData);

        totalAccumulatedDistance += elevationDataObj.distances.slice(-1)[0]; // Update total accumulated distance
        L.geoJSON(geojson, { color: 'red' }).addTo(detailMap);
    }

    addElevationProfileChart(accumulatedDistances, accumulatedElevationData);

    // Fit the upload map to the bounds of all routes
    const bounds = L.latLngBounds(waypoints.map((wpt) => L.latLng(wpt.lat, wpt.lon)));
    detailMap.fitBounds(bounds);
}

// Extract specifically the elevation data for the chart
function extractElevationData(responseData) {
    const coordinates = responseData.features[0].geometry.coordinates;
    const elevationData = coordinates.map(coord => coord[2]); // Extracting height from the third entry of each coordinate

    // Calculate cumulative distances
    const distances = coordinates.reduce((acc, coord, index) => {
        if (index > 0) {
            const prevCoord = coordinates[index - 1];
            const distance = getDistance(prevCoord[1], prevCoord[0], coord[1], coord[0]); // Get corresponding distance data of the specific coordinates
            acc.push(acc[index - 1] + distance);
        } else {
            acc.push(0);
        }

        return acc;
    }, []);

    return { elevationData, distances };
}

// Function to calculate distance between two points for the chart
function getDistance(lat1, lon1, lat2, lon2) {
    const R = 6371; // Radius of the earth in km
    const dLat = deg2rad(lat2 - lat1);
    const dLon = deg2rad(lon2 - lon1);
    const a =
        Math.sin(dLat / 2) * Math.sin(dLat / 2) +
        Math.cos(deg2rad(lat1)) * Math.cos(deg2rad(lat2)) * Math.sin(dLon / 2) * Math.sin(dLon / 2);
    const c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
    const distance = R * c; // Distance in km

    return distance;
}

// Function to convert degrees to radians
function deg2rad(deg) {
    return deg * (Math.PI / 180);
}

// Add chart below the map
function addElevationProfileChart(distances, elevationData, distanceArray) {
    const ctx = document.getElementById('elevationChart').getContext('2d');

    // Use the last entry of the distances array as the total distance
    const totalDistance = distances.slice(-1)[0];

    const chartData = {
        labels: distances.map((distance) => `${distance.toFixed(2)} km`),
        datasets: [{
            label: 'Elevation',
            data: elevationData,
            borderColor: 'green',
            backgroundColor: 'rgba(1, 50, 32, 0.1)',
            fill: true,
            pointRadius: 0,
            pointHoverRadius: 0
        }]
    };

    const chartOptions = {
        scales: {
            x: {
                title: {
                    display: true,
                    text: `Distance (Total: ${totalDistance.toFixed(2)} km)`
                }
            },
            y: {
                title: {
                    display: true,
                    text: 'Elevation (meters)'
                }
            }
        }
    };

    new Chart(ctx, {
        type: 'line',
        data: chartData,
        options: chartOptions,
    });
}