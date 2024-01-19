
//sets the value of the hidden input field to the value of the search input field
function setHiddenInput(){
    console.log("setHiddenInput called");
    let searchValue = document.getElementById("search-input").value;
    document.getElementById("search-input-hidden").value = searchValue;
}

//sets the chosen dropdown value to the dropdown after the site reloads, so it doesnt need to be reselected
function setSelectedDropdownOption(dropdownButtonId) {
    var dropdownButton = document.getElementById(dropdownButtonId);
    var parameterValue = dropdownButton.getAttribute('data-parameter-value');
    dropdownButton.textContent = convertValueToString(dropdownButtonId, parameterValue);
    /*if (parameterValue) {
        dropdownButton.textContent = convertValueToString(dropdownButtonId, parameterValue);
    } else {
        dropdownButton.textContent = "Choose here";
    }*/
}

//calls the setSelectedDropdownOption function for each dropdown button
window.onload = function() {
    //List of all dropdwon button IDs
    var dropdownButtonIds = ['drop-down-btn-fitness', 'drop-down-btn-stamina', 'drop-down-btn-experience', 'drop-down-btn-scenery'];

    // Call setSelectedDropdownOption for each dropdown button
    dropdownButtonIds.forEach(function(dropdownButtonId) {
        setSelectedDropdownOption(dropdownButtonId);
    });
}

//converts the value of the dropdown button to a string
function convertValueToString(type, value) {
    switch (type) {
        case "drop-down-btn-fitness":
            switch (value) {
                case "1":
                    return "Easy";
                case "2":
                    return "Moderate";
                case "3":
                    return "Intermediate";
                case "4":
                    return "Challenging";
                case "5":
                    return "Expert";
                default:
                    return "Choose here";
            }
        case "drop-down-btn-stamina":
            switch (value) {
                case "1":
                    return "Untrained";
                case "2":
                    return "Moderate";
                case "3":
                    return "Intermediate";
                case "4":
                    return "Athletic";
                case "5":
                    return "Elite";
                default:
                    return "Choose here";
            }
        case "drop-down-btn-experience":
            switch (value) {
                case "1":
                    return "Novice";
                case "2":
                    return "Practised";
                case "3":
                    return "Intermediate";
                case "4":
                    return "Experienced";
                case "5":
                    return "Expert";
                default:
                    return "Choose here";
            }
        case "drop-down-btn-scenery":
            switch (value) {
                case "1":
                    return "Unremarkable";
                case "2":
                    return "Ordinary";
                case "3":
                    return "Enjoyable";
                case "4":
                    return "Beautiful";
                case "5":
                    return "Stunning";
                default:
                    return "Choose here";
            }

    }
}

function resetFilter() {
    let dropdownFitness = document.getElementById("drop-down-btn-fitness");
    let dropdownStamina = document.getElementById("drop-down-btn-stamina");
    let dropdownExperience = document.getElementById("drop-down-btn-experience");
    let dropdownScenery = document.getElementById("drop-down-btn-scenery");

    let dropdownFitnessHidden = document.getElementById("drop-down-btn-fitness-hidden");
    let dropdownStaminaHidden = document.getElementById("drop-down-btn-stamina-hidden");
    let dropdownExperienceHidden = document.getElementById("drop-down-btn-experience-hidden");
    let dropdownSceneryHidden = document.getElementById("drop-down-btn-scenery-hidden");

    dropdownFitness.textContent = "Choose here";
    dropdownFitnessHidden.value = "";

    dropdownStamina.textContent = "Choose here";
    dropdownStaminaHidden.value = "";

    dropdownExperience.textContent = "Choose here";
    dropdownExperienceHidden.value = "";

    dropdownScenery.textContent = "Choose here";
    dropdownSceneryHidden.value = "";

    let monthList = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];
    monthList.forEach(function (month) {
        document.getElementById(month).checked = false;
    });

    let heightDiff = document.getElementById("height-difference");
    let distance = document.getElementById("distance");
    let durationHr = document.getElementById("duration-hr");
    let durationMin = document.getElementById("duration-min");

    heightDiff.value = "";
    distance.value = "";
    durationHr.value = "";
    durationMin.value = "";

    setHiddenInput();
    document.getElementById('filterForm').submit();
}