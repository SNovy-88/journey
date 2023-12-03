const ORS_API_KEY = '5b3ce3597851110001cf6248e11f847fc0db4d8eb62bc09dcf82494f';


// Initialize the map
const map = L.map('map').setView([47, 11], 7); // Set the initial view

// Add a tile layer to the map (you can choose a different tile provider)
L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
    attribution: '&copy; OpenStreetMap contributors'
}).addTo(map);

// Initialize an empty array to store waypoints
const waypoints = [];

// Initialize a polyline to connect waypoints with lines
const polyline = L.polyline([], {color: 'none'}).addTo(map);

// Get the <ul> element to display coordinates
const coordinatesList = document.getElementById('coordinates-list');

// Get the modal and input elements
const waypointModal = document.getElementById('waypointModal');
const waypointNameInput = document.getElementById('waypointNameInput');

// Initialize a variable to store GPX data
let cachedGPXData = '';

// Add a click event listener to the map
map.on('click', function (e) {
    // Open the modal when the map is clicked
    $('#waypointModal').modal('show');

    // Store the clicked location in a variable
    const clickedLatLng = e.latlng;

    // Set up a click event listener for the "Add Waypoint" button in the modal
    $('#waypointModal').on('shown.bs.modal', function () {
        $('#waypointNameInput').focus();
    });

    // Set up a click event listener for the "Cancel" button in the modal
    $('#waypointModal .btn-secondary').on('click', function () {
        // Close the modal without adding the waypoint
        $('#waypointModal').modal('hide');
        unsavedChanges = false;
    });

    $('#waypointModal').on('hidden.bs.modal', function () {
        // Clear the input field when the modal is closed
        waypointNameInput.value = '';
    });

    // Function to be called when the "Add Waypoint" button is clicked
    window.addWaypoint = async function () {
        // Get the waypoint name from the input field
        const waypointName = waypointNameInput.value;

        // Close the modal
        $('#waypointModal').modal('hide');

        // Add a marker at the clicked location
        const marker = L.marker(clickedLatLng).addTo(map);

        // Store the waypoint in the array with name
        waypoints.push({name: waypointName, latlng: clickedLatLng});

        // Update the polyline with the new waypoint
        polyline.setLatLngs(waypoints.map(wp => wp.latlng));

        // If there are at least two waypoints, fetch route and zoom the map
        if (waypoints.length >= 2) {
            const prevWaypoint = waypoints[waypoints.length - 2].latlng;
            await fetchRoute(prevWaypoint, clickedLatLng);
            map.fitBounds(polyline.getBounds());
        }

        // Update the coordinates list
        updateCoordinatesList();

        // Create GPX data and update the hidden input field
        cachedGPXData = createGPX();
    };
});

async function fetchRoute(startLatLng, endLatLng) {
    const profile = 'foot-hiking'; // Specify the hiking profile
    const url = `https://api.openrouteservice.org/v2/directions/${profile}?api_key=${ORS_API_KEY}&start=${startLatLng.lng},${startLatLng.lat}&end=${endLatLng.lng},${endLatLng.lat}`;

    try {
        const response = await fetch(url);
        const data = await response.json();

        const routeCoordinates = data.features[0].geometry.coordinates.map(coord => L.latLng(coord[1], coord[0]));

        // Clear the existing polyline
        polyline.setLatLngs([]);

        // Add the route polyline to the map
        const routePolyline = L.polyline(routeCoordinates, { color: 'red' }).addTo(map);

        // Append the route coordinates to the existing polyline
        polyline.setLatLngs(polyline.getLatLngs().concat(routeCoordinates));
    } catch (error) {
        console.error('Error fetching route:', error);
    }
}

// Function to update the coordinates list
function updateCoordinatesList() {
    // Clear the existing list
    coordinatesList.innerHTML = '';

    // Add coordinates to the list
    waypoints.forEach(function (waypoint, index) {
        const li = document.createElement('li');
        li.textContent = 'Waypoint ' + (index + 1) + ': ' + waypoint.name + ' (' + waypoint.latlng.lat + ', ' + waypoint.latlng.lng + ')';
        coordinatesList.appendChild(li);
    });
}

// Function to export waypoints as GPX
function exportAsGPX() {
    // Create a Blob with the GPX data
    const blob = new Blob([cachedGPXData], {type: 'application/gpx+xml'});

    // Create a link for downloading the GPX file
    const link = document.createElement('a');
    link.href = URL.createObjectURL(blob);
    link.download = 'waypoints.gpx';
    link.click();
}

// Function to create GPX with track and waypoints
function createGPX() {
    return '<?xml version="1.0" encoding="UTF-8" standalone="no" ?>' +
        '<gpx version="1.1" creator="Journey">' +
        '<trk>' +
        '<name>A hike created with Journey!</name>' +
        '<trkseg>' +
        waypoints.map(function (waypoint) {
            return '<trkpt lat="' + waypoint.latlng.lat + '" lon="' + waypoint.latlng.lng + '">' +
                '<name>' + waypoint.name + '</name>' +
                '</trkpt>' +
                '<wpt lat="' + waypoint.latlng.lat + '" lon="' + waypoint.latlng.lng + '">' +
                '<name>' + waypoint.name + '</name>' +
                '</wpt>';
        }).join('') +
        '</trkseg>' +
        '</trk>' +
        '</gpx>';
}

// Function to update the hidden input field with cached GPX data
function updateGPXInput() {
    document.getElementById('gpxDataInput').value = cachedGPXData;
}