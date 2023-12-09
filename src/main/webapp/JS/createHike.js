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
    validation(isInputValid, inputElement, inputFeedback);
    // Validation: Description input
    validation(isTextareaValid, textareaElement, textareaFeedback);
    // Additional validation based on the switch state
    // Validation: Map vs. file-upload input
    if (switchState === 'map') {
        const mapInput = document.getElementById('gpxDataInput');
        const mapFeedback = document.getElementById('mapFeedback');
        const isMapValid = waypoints.length > 0;
        validation(isMapValid, mapInput, mapFeedback);
        return isInputValid && isTextareaValid && isMapValid;
    } else if (switchState === 'upload') {
        const fileUploadInput = document.getElementById('customFileEnd');
        const fileUploadFeedback = document.getElementById('fileUploadFeedback');
        const isFileUploadValid = fileUploadInput.files.length > 0;

        if (!isFileUploadValid) {
            fileUploadInput.classList.add('is-invalid');
            fileUploadFeedback.textContent = 'Please select a GPX file.';
            fileUploadFeedback.style.display = 'block';
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
        return isInputValid && isTextareaValid && isFileUploadValid;
    }
    // Default case (should not reach here)
    return false;
}

//Function for validation of duration (hr and min), height difference, distance
//fitness level, stamina, experience and scenery
function validateStep2() {
    const inputHrElement = document.getElementById('duration-hr');
    const inputHrFeedback = document.getElementById('duration-hr-feedback');

    const inputMinElement = document.getElementById('duration-min');
    const inputMinFeedback = document.getElementById('duration-min-feedback');

    const inputHeightDiffElement = document.getElementById('height-difference');
    const inputHeightDiffFeedback = document.getElementById('height-difference-feedback');

    const inputDistanceElement = document.getElementById('distance');
    const inputDistanceFeedback = document.getElementById('distance-feedback');

    const inputFitnessElement = document.getElementById('drop-down-btn-fitness');
    const inputFitnessFeedback = document.getElementById('fitness-feedback');

    const inputStaminaElement = document.getElementById('drop-down-btn-stamina');
    const inputStaminaFeedback = document.getElementById('stamina-feedback');

    const inputExperienceElement = document.getElementById('drop-down-btn-experience');
    const inputExperienceFeedback = document.getElementById('experience-feedback');

    const inputSceneryElement = document.getElementById('drop-down-btn-scenery');
    const inputSceneryFeedback = document.getElementById('scenery-feedback');


    const isInputHrValid = isWholeNumber(inputHrElement.value.trim());
    const isInputMinValid = isWholeNumber(inputMinElement.value.trim()) && parseInt(inputMinElement.value) >= 0 && parseInt(inputMinElement.value) <= 59;
    const isInputHeightDiffValid = isWholeNumber(inputHeightDiffElement.value.trim()) && parseInt(inputHeightDiffElement.value) > 0;
    const isDistanceValid = isDecimalNumber(inputDistanceElement.value.trim()) && parseFloat(inputDistanceElement.value) > 0;
    const isFitnessValid = inputFitnessElement.getAttribute('chosen-value-id') !== '';
    const isStaminaValid = inputStaminaElement.getAttribute('chosen-value-id') !== '';
    const isExperienceValid = inputExperienceElement.getAttribute('chosen-value-id') !== '';
    const isSceneryValid = inputSceneryElement.getAttribute('chosen-value-id') !== '';

    validation(isInputHrValid, inputHrElement, inputHrFeedback);
    validation(isInputMinValid, inputMinElement, inputMinFeedback);
    validation(isInputHeightDiffValid, inputHeightDiffElement, inputHeightDiffFeedback);
    validation(isDistanceValid, inputDistanceElement, inputDistanceFeedback);
    validation(isFitnessValid, inputFitnessElement, inputFitnessFeedback);
    validation(isStaminaValid, inputStaminaElement, inputStaminaFeedback);
    validation(isExperienceValid, inputExperienceElement, inputExperienceFeedback);
    validation(isSceneryValid, inputSceneryElement, inputSceneryFeedback);

    return  isInputHrValid &&
        isInputMinValid &&
        isInputHeightDiffValid &&
        isDistanceValid &&
        isFitnessValid &&
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

//checks if number is a whole number withough decimals
function isWholeNumber(value){
    return /^\d+$/.test(value);
}

//checks if number is a decimal with either none, 1 or 2 decimals
function isDecimalNumber(value){
    return /^\d+(\.\d{1,2})?$/.test(value);
}

//Updates Dropbox Title to display chosen option
//Marks chosen option and displays icons according to chosen option
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

    //console.log(selectedValue);

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

// Add event listener to the switch
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
    // Reset the flag
    unsavedChanges = false;

    // Update the hidden input field with cached GPX data
    updateGPXInput();
}

// Prevent pressing enter while typing
document.getElementById("createHike").addEventListener("keypress", function (e) {
    if (e.key === "Enter") {
        e.preventDefault();
    }
});

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
