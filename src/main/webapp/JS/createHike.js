// Flag to track unsaved changes
let unsavedChanges = true;

const stepper1Node = document.querySelector('#stepper1');
const stepper1 = new Stepper(document.querySelector('#stepper1'));

stepper1Node.addEventListener('show.bs-stepper', function (event) {
    console.warn('show.bs-stepper', event);
});
stepper1Node.addEventListener('shown.bs-stepper', function (event) {
    console.warn('shown.bs-stepper', event);
});

// Function for validation of Name & Description input
function validateStep1() {
    const inputElement = document.getElementById('floatingInput');
    const inputFeedback = document.getElementById('inputFeedback');
    const textareaElement = document.getElementById('floatingTextarea2');
    const textareaFeedback = document.getElementById('textareaFeedback');
    const isInputValid = inputElement.value.trim() !== '';
    const isTextareaValid = textareaElement.value.trim() !== '';
    // Get the switch-element state
    const switchStateInput = document.getElementById('switchState');
    const switchState = switchStateInput.value;

    // Validation: Name input
    if (!isInputValid) {
        inputElement.classList.add('is-invalid');
        inputFeedback.style.display = 'block';
    } else {
        inputElement.classList.remove('is-invalid');
        inputFeedback.style.display = 'none';
    }
    // Validation: Description input
    if (!isTextareaValid) {
        textareaElement.classList.add('is-invalid');
        textareaFeedback.style.display = 'block';
    } else {
        textareaElement.classList.remove('is-invalid');
        textareaFeedback.style.display = 'none';
    }
    // Additional validation based on the switch state
    // Validation: Map vs. file-upload input
    if (switchState === 'map') {
        const mapInput = document.getElementById('gpxDataInput');
        const mapFeedback = document.getElementById('mapFeedback');
        const isMapValid = waypoints.length > 0;
        if (!isMapValid) {
            mapInput.classList.add('is-invalid');
            mapFeedback.style.display = 'block';
        } else {
            mapInput.classList.remove('is-invalid');
            mapFeedback.style.display = 'none';
        }
        return isInputValid && isTextareaValid && isMapValid;
    } else if (switchState === 'upload') {
        const fileUploadInput = document.getElementById('customFileEnd');
        const fileUploadFeedback = document.getElementById('fileUploadFeedback');
        const isFileUploadValid = fileUploadInput.files.length > 0;
        if (!isFileUploadValid) {
            fileUploadInput.classList.add('is-invalid');
            fileUploadFeedback.style.display = 'block';
        } else {
            fileUploadInput.classList.remove('is-invalid');
            fileUploadFeedback.style.display = 'none';
        }
        return isInputValid && isTextareaValid && isFileUploadValid;
    }
    // Default case (should not reach here)
    return false;
}

// Get the switch, feature elements, and switch state input
const featureSwitch = document.getElementById('featureSwitch');
const fileUploadFeature = document.getElementById('fileUploadFeature');
const mapFeature = document.getElementById('mapFeature');
const switchStateInput = document.getElementById('switchState');

// Add event listener to the switch
featureSwitch.addEventListener('change', function() {
    // Toggle the visibility of features based on the switch state
    fileUploadFeature.style.display = featureSwitch.checked ? 'block' : 'none';
    mapFeature.style.display = featureSwitch.checked ? 'none' : 'block';

    // Update the switch state input value
    switchStateInput.value = featureSwitch.checked ? 'upload' : 'map';

    // Remove 'is-invalid' class and hide feedback for Map vs. file-upload inputs when switching
    const mapInput = document.getElementById('gpxDataInput');
    const mapFeedback = document.getElementById('mapFeedback');
    const fileUploadInput = document.getElementById('customFileEnd');
    const fileUploadFeedback = document.getElementById('fileUploadFeedback');
    mapInput.classList.remove('is-invalid');
    mapFeedback.style.display = 'none';
    fileUploadInput.classList.remove('is-invalid');
    fileUploadFeedback.style.display = 'none';
});

// Reset the file input by clearing its value
function resetFileInput() {
    const fileInput = document.getElementById('customFileEnd');
    fileInput.value = ''; // This clears the selected file
}

// Function to create hike and send GPX data to the servlet
function createHike() {
    // Reset the flag
    unsavedChanges = false;

    // Update the hidden input field with cached GPX data
    updateGPXInput();
}

// Attach a beforeunload event to show a toast-pop-up warning if there are unsaved changes
window.addEventListener('beforeunload', function (e) {
    if (unsavedChanges) {
        const confirmationMessage = 'You have unsaved changes. Are you sure you want to leave?';
        (e || window.event).returnValue = confirmationMessage; // Standard
        return confirmationMessage; // IE and Firefox
    }
});

// Check if the URL contains a success parameter
const urlParams = new URLSearchParams(window.location.search);
const successParam = urlParams.get('success');

// If the success parameter is present, show the success modal
if (successParam === 'true') {
    $(document).ready(function () {
        $('#successModal').modal('show');
    });
}