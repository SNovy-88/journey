const ORS_API_KEY = '5b3ce3597851110001cf6248e11f847fc0db4d8eb62bc09dcf82494f';


// Initialize the map
const map = L.map('map').setView([47, 11], 7); // Set the initial view

// Add a tile layer to the map (you can choose a different tile provider)
L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
    attribution: '&copy; OpenStreetMap contributors'
}).addTo(map);

// Initialize an empty array to store waypoints
const waypoints = [];

// Get the <ul> element to display coordinates
const coordinatesList = document.getElementById('coordinates-list');

// Get the modal and input elements
const waypointModal = document.getElementById('waypointModal');
const waypointNameInput = document.getElementById('waypointNameInput');

// Initialize a variable to store GPX data
let cachedGPXData = '';

// Declare routePolyline at the beginning of your script, outside any function, to ensure proper scope
let routePolyline;

// Declare a global variable to store an array of route data
let storedRouteDataMap = [];

// Add a click event listener to the map
map.on('click', function (e) {
    // Open the modal when the map is clicked
    $('#waypointModal').modal('show');

    // Store the clicked location in a variable
    const clickedLatLng = e.latlng;

    // Set up a click event listener for the "Add Waypoint" button in the modal
    $('#waypointModal').on('shown.bs.modal', function () {
        // Reset the description input and type selection
        $('#waypointDescriptionInput').val('');
        $('#waypointTypeSelect').val('standard');

        // Focus on the waypoint name input
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
    window.addWaypoint = function () {
        // Get the waypoint name from the input field
        const waypointName = waypointNameInput.value;

        // Get the selected waypoint type from the dropdown
        const waypointType = document.getElementById('waypointTypeSelect').value;

        // Get the waypoint description from the textarea
        const waypointDescription = document.getElementById('waypointDescriptionInput').value;

        // Close the modal
        $('#waypointModal').modal('hide');

        // Create a custom icon based on the selected waypoint type
        let customIconUrl;
        switch (waypointType) {
            case 'poi':
                customIconUrl = 'pictures/Leaflet/pin-icon-poi.png';
                break;
            case 'hut':
                customIconUrl = 'pictures/Leaflet/pin-icon-hut.png';
                break;
            default:
                customIconUrl = 'pictures/Leaflet/pin-icon-wpt.png';
                break;
        }

        // Create a custom icon for the waypoint marker
        const customIcon = L.icon({
            iconUrl: customIconUrl,
            iconSize: [64, 64],
            iconAnchor: [32, 64],
            popupAnchor: [0, -32]
        });

        // Add a marker at the clicked location with the custom icon
        const marker = L.marker(clickedLatLng, { icon: customIcon }).addTo(map);

        // Enable dragging for the marker
        enableMarkerDragging(marker, waypoints.length - 1);

        // Store the waypoint in the array with name, type, description, and marker
        waypoints.push({ name: waypointName, type: waypointType, description: waypointDescription, latlng: clickedLatLng, marker: marker });

        // If there are at least two waypoints, fetch route and zoom the map
        if (waypoints.length >= 2) {
            const prevWaypoint = waypoints[waypoints.length - 2].latlng;
            addRouting(prevWaypoint, clickedLatLng);
            map.fitBounds(L.latLngBounds(waypoints.map(wp => wp.latlng)));
        }

        // Update the coordinates list
        updateCoordinatesList();

        // Create GPX data and update the hidden input field
        cachedGPXData = createGPX();
    };
});

// Function to add route to map
async function addRouting(startLatLng, endLatLng) {
    const coordinates = [startLatLng, endLatLng];
    try {
        const { geojson, details } = await fetchRoute(coordinates);

        // Extract route coordinates from the GeoJSON data
        const routeCoordinates = geojson.features[0].geometry.coordinates.map(coord => L.latLng(coord[1], coord[0]));

        // Add the route GeoJSON layer to the map
        routePolyline = L.geoJSON(geojson, {color: 'red'}).addTo(map);

        // Store the route data in the global array
        storedRouteDataMap.push(details);

    } catch (error) {
        console.error('Error fetching route:', error);
    }
}

// Function to be called when the "Next" button is clicked in the first step
window.nextButtonClick = async function () {
    // Get the switch-element state
    const switchStateInput = document.getElementById('switchState');
    const switchState = switchStateInput.value;

    let totalDuration = null;
    let totalAscent = null;
    let totalDistance = null;

    if (switchState === 'map') {
        // Check if route data array is not empty
        if (storedRouteDataMap.length > 0) {
            // Sum up the total duration, ascent, and distance from all segments
            totalDuration = storedRouteDataMap.reduce((acc, segment) => acc + segment.duration, 0);
            totalAscent = storedRouteDataMap.reduce((acc, segment) => acc + segment.ascent, 0);
            totalDistance = storedRouteDataMap.reduce((acc, segment) => acc + segment.distance, 0);
        }
    } else if (switchState === 'upload') {
        // Check if showRoute() has been called and uploadMapRouteDataArray is not empty
        if (storedRouteDataUploadMap.length === 0) {
            // Call showRoute() to populate uploadMapRouteDataArray
            await showRoute();
        }

        // Check if route data array is not empty
        if (storedRouteDataUploadMap.length > 0) {
            // Sum up the total duration, ascent, and distance from all segments
            totalDuration = storedRouteDataUploadMap.reduce((acc, segment) => acc + segment.duration, 0);
            totalAscent = storedRouteDataUploadMap.reduce((acc, segment) => acc + segment.ascent, 0);
            totalDistance = storedRouteDataUploadMap.reduce((acc, segment) => acc + segment.distance, 0);
        }
    }

    // Autofill the input fields in the second step
    document.getElementById('duration-hr').value = Math.floor(totalDuration / 3600);
    document.getElementById('duration-min').value = Math.floor((totalDuration % 3600) / 60);
    document.getElementById('height-difference').value = Math.round(totalAscent);
    document.getElementById('distance').value = (totalDistance / 1000).toFixed(2);

    // Move to the next step
    stepper1.next();
};

// Function to update the coordinates list below the map
function updateCoordinatesList() {
    // Clear the existing list
    coordinatesList.innerHTML = '';

    // Add coordinates and delete button to the list
    waypoints.forEach(function (waypoint, index) {
        const li = document.createElement('li');
        li.innerHTML = `
            Waypoint ${index + 1}: ${waypoint.name} (${waypoint.latlng.lat}, ${waypoint.latlng.lng})
        `;
        coordinatesList.appendChild(li);
    });
}

// Function to be called when the "Delete Last Waypoint" button is clicked
window.deleteLastWaypoint = function () {
    if (waypoints.length > 0) {
        // Remove the last waypoint from the array
        const removedWaypoint = waypoints.pop();

        // Remove the marker from the map
        map.removeLayer(removedWaypoint.marker);

        // Update the route and fit bounds
        updateRoute();

        // Update the coordinates list
        updateCoordinatesList();

        // Create GPX data and update the hidden input field
        cachedGPXData = createGPX();
    }
};

// Function to update the route when waypoints are added, deleted, or dragged
async function updateRoute() {
    // Clear the existing route
    clearRoute();

    // Clear the storedRouteDataArray before recalculating the route
    storedRouteDataMap = [];

    // Recalculate the route if there are at least two waypoints
    if (waypoints.length >= 2) {
        const waypointPairs = [];
        for (let i = 0; i < waypoints.length - 1; i++) {
            const startLatLng = waypoints[i].latlng;
            const endLatLng = waypoints[i + 1].latlng;
            waypointPairs.push([startLatLng, endLatLng]);
        }

        // Fetch routes for all waypoint pairs
        for (const pair of waypointPairs) {
            await addRouting(pair[0], pair[1]);
        }
    }
}

// Function to clear the route from the map
function clearRoute() {
    // Remove existing route polylines from the map
    map.eachLayer(layer => {
        if (layer instanceof L.Polyline) {
            map.removeLayer(layer);
        }
    });
}

// Function to enable dragging for a marker
function enableMarkerDragging(marker, index) {
    marker.dragging.enable();

    marker.on('dragend', function (event) {
        // Find the index of the dragged marker in the waypoints array
        const draggedIndex = waypoints.findIndex(wp => wp.marker === marker);

        if (draggedIndex !== -1) {
            // Update the latlng of the dragged waypoint
            waypoints[draggedIndex].latlng = marker.getLatLng();

            // Update the route with the new waypoints
            updateRoute();

            // Update the coordinates list
            updateCoordinatesList();

            // Create GPX data and update the hidden input field
            cachedGPXData = createGPX();
        }
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
                '<type>' + waypoint.type + '</type>' +
                '<desc>' + waypoint.description + '</desc>' +
                '</trkpt>' +
                '<wpt lat="' + waypoint.latlng.lat + '" lon="' + waypoint.latlng.lng + '">' +
                '<name>' + waypoint.name + '</name>' +
                '<type>' + waypoint.type + '</type>' +
                '<desc>' + waypoint.description + '</desc>' +
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