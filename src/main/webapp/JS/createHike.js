let unsavedChanges = true;
const stepper1 = new Stepper(document.querySelector('#stepper1'));

// Function for validation of Name & Description input
function validateStep1() {
    // Validation: Name input
    const inputElement = document.getElementById('floatingInput');
    const inputFeedback = document.getElementById('inputFeedback');
    const isInputValid = inputElement.value.trim() !== '';
    validation(isInputValid, inputElement, inputFeedback);

    // Validation: Description input
    const textareaElement = document.getElementById('floatingTextarea2');
    const textareaFeedback = document.getElementById('textareaFeedback');
    const isTextareaValid = textareaElement.value.trim() !== '';
    validation(isTextareaValid, textareaElement, textareaFeedback);

    // Get the switch-element state ('map' or 'upload')
    const switchStateInput = document.getElementById('switchState');
    const switchState = switchStateInput.value;

    // Additional validation based on the switch state
    // Validation: Map vs. file-upload input (Note: Remaining validation of 'upload' feature in showRoute() function)
    if (switchState === 'map') {
        const mapInput = document.getElementById('gpxDataInput');
        const mapFeedback = document.getElementById('mapFeedback');
        const isMapValid = waypoints.length > 1;
        validation(isMapValid, mapInput, mapFeedback);

        return isInputValid && isTextareaValid && isMapValid;

    } else if (switchState === 'upload') {
        const fileUploadInput = document.getElementById('customFileEnd');
        const fileUploadFeedback  = document.getElementById('fileUploadFeedback');
        const isFileUploadValid = fileUploadInput.files.length > 0;
        validation(isFileUploadValid, fileUploadInput, fileUploadFeedback );

        return isInputValid && isTextareaValid && isFileUploadValid;
    }

    // Default case (should not reach here)
    return false;
}

// Function to be called when the "Next" button is clicked in the first step to calculate Geo data automatically
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
            // Call showRoute() to populate uploadMapRouteDataArray (and validate uploadMap feature)
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

    // Check if the calculated values are NaN and replace them with 0
    totalDuration = isNaN(totalDuration) ? 0 : totalDuration;
    totalAscent = isNaN(totalAscent) ? 0 : totalAscent;
    totalDistance = isNaN(totalDistance) ? 0 : totalDistance;

    // Autofill the input fields in the second step
    document.getElementById('duration-hr').value = Math.floor(totalDuration / 3600);
    document.getElementById('duration-min').value = Math.floor((totalDuration % 3600) / 60);
    document.getElementById('height-difference').value = Math.round(totalAscent);
    document.getElementById('distance').value = (totalDistance / 1000).toFixed(2);

    stepper1.next();
    window.scrollTo(0, 0);
};

// Function for validation of duration (hr and min), height difference, distance
// fitness level, stamina, experience and scenery
function validateStep2() {
    const inputFitnessElement = document.getElementById('drop-down-btn-fitness');
    const inputFitnessFeedback = document.getElementById('fitness-feedback');

    const inputStaminaElement = document.getElementById('drop-down-btn-stamina');
    const inputStaminaFeedback = document.getElementById('stamina-feedback');

    const inputExperienceElement = document.getElementById('drop-down-btn-experience');
    const inputExperienceFeedback = document.getElementById('experience-feedback');

    const inputSceneryElement = document.getElementById('drop-down-btn-scenery');
    const inputSceneryFeedback = document.getElementById('scenery-feedback');

    const isFitnessValid = inputFitnessElement.getAttribute('chosen-value-id') !== '';
    const isStaminaValid = inputStaminaElement.getAttribute('chosen-value-id') !== '';
    const isExperienceValid = inputExperienceElement.getAttribute('chosen-value-id') !== '';
    const isSceneryValid = inputSceneryElement.getAttribute('chosen-value-id') !== '';

    validation(isFitnessValid, inputFitnessElement, inputFitnessFeedback);
    validation(isStaminaValid, inputStaminaElement, inputStaminaFeedback);
    validation(isExperienceValid, inputExperienceElement, inputExperienceFeedback);
    validation(isSceneryValid, inputSceneryElement, inputSceneryFeedback);

    return  isFitnessValid &&
        isStaminaValid &&
        isExperienceValid &&
        isSceneryValid;
}

// Function to display feedback and mark fields red
function validation(valid, input, feedback){
    if(!valid){
        input.classList.add('is-invalid');
        feedback.style.display = 'block';
    } else {
        input.classList.remove('is-invalid');
        feedback.style.display = 'none';
    }
}

// Updates Dropbox Title to display chosen option
// Marks chosen option and displays icons according to chosen option
function updateDropdown(dropdown, element) {
    // Setting the Text of the button to the selected option
    let dropdownButton = document.getElementById(dropdown);
    let selectedValue = element.getAttribute("data-id");
    dropdownButton.innerHTML = element.innerHTML;
    dropdownButton.setAttribute("chosen-value-id", selectedValue);
    document.getElementById(dropdown+"-hidden").value = selectedValue;

    // Highlighting the selected option so this is visible when opening dropdown again
    let dropdownItem = document.querySelector("a.dropdown-item.active");

    if (dropdownItem) {
        dropdownItem.classList.remove("active");
    }
    element.classList.add("active");

    // Inserting the right icons, depending on the hike attribute
    let attribute = dropdownButton.getAttribute("data-id");
    switch (attribute){
        case "stamina":
            insertIcons(selectedValue, staminaFullIcon, staminaEmptyIcon, 'stamina-icons');
            break;

        case "experience":
            insertIcons(selectedValue, experienceFullIcon, experienceEmptyIcon, 'experience-icons');
            break;

        case "scenery":
            insertIcons(selectedValue, sceneryFullIcon, sceneryEmptyIcon, 'scenery-icons');
            break;
    }
}

// Get the switch, feature elements, and switch state input
const featureSwitch = document.getElementById('featureSwitch');
const fileUploadFeature = document.getElementById('fileUploadFeature');
const uploadMapFeature = document.getElementById('uploadMap');
const mapFeature = document.getElementById('mapFeature');
const switchStateInput = document.getElementById('switchState');

// Event listener for the map/upload-switch
featureSwitch.addEventListener('change', function() {
    // Toggle the visibility of features based on the switch state
    fileUploadFeature.style.display = featureSwitch.checked ? 'block' : 'none';
    uploadMapFeature.style.display = featureSwitch.checked ? 'block' : 'none';
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

    // Show or hide the message container based on the switch state
    const mapContainer = document.getElementById('mapContainer');
    mapContainer.style.display = featureSwitch.checked ? 'block' : 'none';
});

// Function to create hike and send GPX data to the servlet
function createHike() {
    // Bypass the flag
    unsavedChanges = false;
    updateGPXInput();
}

// Prevent pressing enter while typing to submit the form
document.getElementById("createHike").addEventListener("keypress", function (e) {
    if (e.key === "Enter") {
        e.preventDefault();
    }
});

// Beforeunload event to show a toast-pop-up warning if there are unsaved changes
window.addEventListener('beforeunload', function (e) {
    if (unsavedChanges) {
        const confirmationMessage = 'You have unsaved changes. Are you sure you want to leave?';
        (e || window.event).returnValue = confirmationMessage; // Standard
        return confirmationMessage; // IE and Firefox
    }
});

// Check if the URL contains a success parameter after submitting
const urlParams = new URLSearchParams(window.location.search);
const successParam = urlParams.get('success');

// If the success parameter is present, show the success modal
if (successParam === 'true') {

    // Bypass the flag
    unsavedChanges = false

    $(document).ready(function () {
        $('#successModal').modal('show');

        // Event listener for modal close event
        $('#successModal').on('hidden.bs.modal', function () {
            // Redirect to search.jsp when the modal is closed
            window.location.href = "/Journey_war_exploded/search.jsp";
        });
    });
}