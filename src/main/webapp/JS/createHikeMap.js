// Initialize the map
const map = L.map('map').setView([47, 11], 7); // Set the initial view

// Add OpenStreetMap tile layer to the map
L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
    attribution: '&copy; OpenStreetMap contributors'
}).addTo(map);

// Initialize an empty array to store waypoints
const waypoints = [];

// Coordinates-table element
const coordinatesTable = document.getElementById('coordinates-table');

// Get the modal and input elements
const waypointNameInput = document.getElementById('waypointNameInput');

// Initialize a variable to store GPX data
let cachedGPXData = '';

// Route-display variable
let routePolyline;

// Variable to store an array of route data
let storedRouteDataMap = [];

// Click event listener for the map
map.on('click', function (e) {
    // Open the modal when clicking on the map
    $('#waypointModal').modal('show');

    // Store the clicked location in a variable
    const clickedLatLng = e.latlng;

    // Click event listener for the "Add Waypoint" button in the modal
    $('#waypointModal').on('shown.bs.modal', function () {
        // Reset the description input and type selection when modal opens
        $('#waypointDescriptionInput').val('');
        $('#waypointTypeSelect').val('standard');

        // Focus on the waypoint name input
        $('#waypointNameInput').focus();
    });

    // Click event listener for the "Cancel" button in the modal
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
        const customIcon = getWaypointIcon(waypointType);

        // Add a marker at the clicked location with the custom icon
        const marker = L.marker(clickedLatLng, { icon: customIcon }).addTo(map);

        // Enable dragging the marker on the map
        enableMarkerDragging(marker, waypoints.length - 1);

        // Store the waypoint in waypoints array with name, type, description, and marker
        waypoints.push({ name: waypointName, type: waypointType, description: waypointDescription, latlng: clickedLatLng, marker: marker });

        // If there are at least two waypoints, fetch route and zoom the map accordingly
        if (waypoints.length >= 2) {
            const prevWaypoint = waypoints[waypoints.length - 2].latlng;
            addRouting(prevWaypoint, clickedLatLng);
            map.fitBounds(L.latLngBounds(waypoints.map(wp => wp.latlng)));
        }

        // Update the coordinates table below the map
        updateCoordinatesTable();

        // Cache GPX data and update the hidden input field
        cachedGPXData = createGPX();
    };
});

// Function to add route to map
async function addRouting(startLatLng, endLatLng) {
    const coordinates = [startLatLng, endLatLng];
    try {
        const { geojson, details } = await fetchRoute(coordinates);

        // Add the route GeoJSON layer to the map
        routePolyline = L.geoJSON(geojson, {color: 'red'}).addTo(map);

        // Store the route data in an array
        storedRouteDataMap.push(details);

    } catch (error) {
        console.error('Error fetching route:', error);
    }
}

// Function to update the coordinates table below the map
function updateCoordinatesTable() {
    // Clear the existing table
    coordinatesTable.innerHTML = '';

    // Create the table header
    const thead = document.createElement('thead');
    thead.className = 'thead-light border table-borderless';
    const headerRow = document.createElement('tr');
    headerRow.innerHTML = `
        <th scope="col">Nr.</th>
        <th scope="col">Name</th>
        <th scope="col">Type</th>
        <th scope="col">Description</th>
    `;
    thead.appendChild(headerRow);

    // Create the table body
    const tbody = document.createElement('tbody');
    waypoints.forEach(function (waypoint, index) {
        const row = document.createElement('tr');

        // Default values if it is empty
        const name = waypoint.name.trim() !== '' ? waypoint.name : 'Unnamed Waypoint';
        const desc = waypoint.description.trim() !== '' ? waypoint.description : 'No Description';
        let type;
        switch (waypoint.type) {
            case 'standard':
                type = 'Standard';
                break;
            case 'poi':
                type = 'Point of Interest';
                break;
            case 'hut':
                type = 'Hut / Refuge';
                break;
            default:
                type = 'Unknown Type';
                break;
        }

        row.innerHTML = `
            <th scope="row">${index + 1}</th>
            <td>${name}</td>
            <td>${type}</td>
            <td>${desc}</td>
        `;
        tbody.appendChild(row);
    });

    // Append the header and body to the table
    coordinatesTable.appendChild(thead);
    coordinatesTable.appendChild(tbody);
}

// Function to be called when the "Delete Last Waypoint" button is clicked
window.deleteLastWaypoint = function () {
    if (waypoints.length > 0) {
        // Remove the last waypoint from the array
        const removedWaypoint = waypoints.pop();

        // Remove the marker from the map
        map.removeLayer(removedWaypoint.marker);

        // Update the route (and fit bounds)
        updateRoute();
    }
};

// Function to update the route when waypoints are added, deleted, or dragged
async function updateRoute() {
    // Clear the existing route
    clearRoute();

    // Clear the storedRouteDataArray before fully recalculating the route
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

    // Update the coordinates table
    updateCoordinatesTable();

    // Cache GPX data and update the hidden input field
    cachedGPXData = createGPX();
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
    link.download = 'YourJourney.gpx';
    link.click();
}

// Function to create GPX with all the data
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
                '</trkpt>';
        }).join('') +
        '</trkseg>' +
        '</trk>' +
        '</gpx>';
}

// Function to update the hidden input field with cached GPX data
function updateGPXInput() {
    document.getElementById('gpxDataInput').value = cachedGPXData;
}