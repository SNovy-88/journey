const map = L.map('map').setView([47, 11], 7); // Set the initial view

// Add OpenStreetMap tile layer to the map
L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
    attribution: '&copy; OpenStreetMap contributors'
}).addTo(map);

const waypoints = [];
const coordinatesTable = document.getElementById('coordinates-table');
const waypointNameInput = document.getElementById('waypointNameInput');
let cachedGPXData = '';
let routePolyline;
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
        $('#waypointNameInput').focus();
    });

    // Click event listener for the "Cancel" button in the modal
    $('#waypointModal .btn-secondary').on('click', function () {
        $('#waypointModal').modal('hide');
        unsavedChanges = false;
    });

    $('#waypointModal').on('hidden.bs.modal', function () {
        // Clear the input field when the modal is closed
        waypointNameInput.value = '';
    });

    // Function to be called when the "Add Waypoint" button is clicked
    window.addWaypoint = function () {
        const waypointName = waypointNameInput.value;
        const waypointType = document.getElementById('waypointTypeSelect').value;
        const waypointDescription = document.getElementById('waypointDescriptionInput').value;
        $('#waypointModal').modal('hide');
        const customIcon = getWaypointIcon(waypointType); // Create a custom icon based on the selected waypoint type
        const marker = L.marker(clickedLatLng, { icon: customIcon }).addTo(map);
        enableMarkerDragging(marker, waypoints.length - 1);
        waypoints.push({ name: waypointName, type: waypointType, description: waypointDescription, latlng: clickedLatLng, marker: marker });

        // If there are at least two waypoints, fetch route and zoom the map accordingly
        if (waypoints.length >= 2) {
            const prevWaypoint = waypoints[waypoints.length - 2].latlng;
            addRouting(prevWaypoint, clickedLatLng);
            map.fitBounds(L.latLngBounds(waypoints.map(wp => wp.latlng)));
        }

        updateCoordinatesTable();
        cachedGPXData = createGPX();
    };
});

// Function to add route to map
async function addRouting(startLatLng, endLatLng) {
    const coordinates = [startLatLng, endLatLng];
    try {
        const { geojson, details } = await fetchRoute(coordinates);
        routePolyline = L.geoJSON(geojson, {color: 'red'}).addTo(map); // Add the route GeoJSON layer to the map
        storedRouteDataMap.push(details);
    } catch (error) {
        console.error('Error fetching route:', error);
    }
}

// Function to update the coordinates table below the map
function updateCoordinatesTable() {
    coordinatesTable.innerHTML = ''; // Clear the existing table

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
        const removedWaypoint = waypoints.pop();
        map.removeLayer(removedWaypoint.marker);
        updateRoute();
    }
};

// Function to update the route when waypoints are added, deleted, or dragged
async function updateRoute() {
    clearRoute(); // Clear the existing route
    storedRouteDataMap = []; // Clear the storedRouteDataArray before fully recalculating the route

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

    updateCoordinatesTable();
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