// Initialize the upload map
let uploadMap = null;

// Declare a global variable to store an array of route data
let storedRouteDataUploadMap = [];

// Function to reset the upload map
function resetUploadMap() {
    if (uploadMap) {
        // Clear all layers from the upload map
        uploadMap.eachLayer(layer => {
            if (layer !== undefined && layer !== uploadMap) {
                uploadMap.removeLayer(layer);
            }
        });

        // Clear the storedRouteDataArray before recalculating the route
        storedRouteDataUploadMap = [];

        // Reinitialize the upload map with default settings
        uploadMap.setView([47, 11], 7);

        // Add a new tile layer to the upload map
        L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
            attribution: '&copy; OpenStreetMap contributors'
        }).addTo(uploadMap);
    }
}

// Function to initialize the upload map
function initializeUploadMap() {
    if (!uploadMap) {
        // Create a new map instance for file upload
        uploadMap = L.map('uploadMap').setView([47, 11], 7); // Adjust the initial view as needed

        // Add a tile layer to the upload map
        L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
            attribution: '&copy; OpenStreetMap contributors'
        }).addTo(uploadMap);
    }

    return uploadMap;
}

// Function to show route on the upload map
async function showRoute() {
    return new Promise((resolve, reject) => {

        const fileUploadInput = document.getElementById('customFileEnd');
        const fileUploadFeedback = document.getElementById('fileUploadFeedback');
        const isFileUploadValid = fileUploadInput.files.length > 0;

        if (!isFileUploadValid) {
            fileUploadInput.classList.add('is-invalid');
            fileUploadFeedback.textContent = 'Please select a GPX file.';
            fileUploadFeedback.style.display = 'block';

            // Reject the promise
            reject("Invalid file upload");
            return;
        } else {
            const uploadedFileName = fileUploadInput.files[0].name;
            const isFileExtensionValid = uploadedFileName.toLowerCase().endsWith('.gpx');

            if (!isFileExtensionValid) {
                fileUploadInput.classList.add('is-invalid');
                fileUploadFeedback.textContent = 'Please upload a file with the ".gpx" extension.';
                fileUploadFeedback.style.display = 'block';
            } else {
                fileUploadInput.classList.remove('is-invalid');
                fileUploadFeedback.style.display = 'none';
            }
        }

        // Reset the upload map before showing a new route
        resetUploadMap();

        // Initialize a new Leaflet map for file upload
        const uploadMap = initializeUploadMap();

        const reader = new FileReader();
        reader.onload = async function (e) {
            const gpxData = e.target.result;

            // Parse GPX data to get waypoints
            const parser = new DOMParser();
            const xmlDoc = parser.parseFromString(gpxData, 'text/xml');
            const waypoints = Array.from(xmlDoc.querySelectorAll('wpt')).map((wpt) => ({
                lat: parseFloat(wpt.getAttribute('lat')),
                lon: parseFloat(wpt.getAttribute('lon')),
                name: wpt.querySelector('name').textContent.trim() || 'Unnamed Waypoint',
                type: wpt.querySelector('type').textContent.trim() || 'standard',
            }));

            // Add waypoint markers with the custom icon and popup to the upload map
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

                const marker = L.marker([waypoint.lat, waypoint.lon], {icon: icon}).addTo(uploadMap);
                marker.bindPopup(waypoint.name);
            });

            // Request routes between waypoints using OpenRouteService API
            for (let i = 0; i < waypoints.length - 1; i++) {
                const startPoint = waypoints[i];
                const endPoint = waypoints[i + 1];

                const {geojson, details} = await fetchRoute([
                    {lat: startPoint.lat, lng: startPoint.lon},
                    {lat: endPoint.lat, lng: endPoint.lon}
                ]);

                // Add the route as a layer to the upload map
                L.geoJSON(geojson, {color: 'red'}).addTo(uploadMap);

                // Store the route data in the global array
                storedRouteDataUploadMap.push(details);
            }

            // Fit the upload map to the bounds of all routes
            const bounds = L.latLngBounds(waypoints.map((wpt) => L.latLng(wpt.lat, wpt.lon)));
            uploadMap.fitBounds(bounds);

            // Hide the message container when the map is loaded
            const messageContainer = document.getElementById('messageContainer');
            messageContainer.style.display = 'none';

            // Resolve the promise
            resolve();
        };
        reader.readAsText(fileUploadInput.files[0]);
    });
}

// Function to reset the file input and upload map
function resetFileInput() {
    const fileInput = document.getElementById('customFileEnd');
    fileInput.value = ''; // This clears the selected file

    // Reset the upload map
    resetUploadMap();
}