// Initialize the upload map
let uploadMap = null;

// Function to reset the upload map
function resetUploadMap() {
    if (uploadMap) {
        // Clear all layers from the upload map
        uploadMap.eachLayer(layer => {
            if (layer !== undefined && layer !== uploadMap) {
                uploadMap.removeLayer(layer);
            }
        });

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
function showRoute() {
    const fileUploadInput = document.getElementById('customFileEnd');
    const fileUploadFeedback = document.getElementById('fileUploadFeedback');
    const isFileUploadValid = fileUploadInput.files.length > 0;

    if (!isFileUploadValid) {
        fileUploadInput.classList.add('is-invalid');
        fileUploadFeedback.textContent = 'Please select a GPX file.';
        fileUploadFeedback.style.display = 'block';
        return;
    }

    // Reset the upload map before showing a new route
    resetUploadMap();

    // Initialize a new Leaflet map for file upload
    const uploadMap = initializeUploadMap();

    const reader = new FileReader();
    reader.onload = function (e) {
        const gpxData = e.target.result;

        // Add GPX data as a layer to the upload map
        new L.GPX(gpxData, {
            async: true,
            marker_options: {
                startIconUrl: null,
                endIconUrl: null,
                shadowUrl: null,
                wptIconUrls: {
                    '': 'pictures/Leaflet/pin-icon-wpt.png',  // Adjust the path accordingly
                },
            },
            polyline_options: {
                color: 'blue',
            },
        }).on('loaded', function (e) {
            // Fit the upload map to the bounds of the GPX track
            uploadMap.fitBounds(e.target.getBounds());
            // Hide the message container when the map is loaded
            const messageContainer = document.getElementById('messageContainer');
            messageContainer.style.display = 'none';
        }).addTo(uploadMap);
    };
    reader.readAsText(fileUploadInput.files[0]);
}

// Function to reset the file input and upload map
function resetFileInput() {
    const fileInput = document.getElementById('customFileEnd');
    fileInput.value = ''; // This clears the selected file

    // Reset the upload map
    resetUploadMap();
}