document.addEventListener("DOMContentLoaded", function () {
    document.querySelector("form").addEventListener("submit", function (event) {
        event.preventDefault();
        var searchString = document.querySelector(".search-input").value;
        window.location.href = "/Journey_war_exploded/loadingSpinner.jsp?searchString=" + encodeURIComponent(searchString); // Jump to loadingSpinner
    });
});

// Function to update Dropdown in Filter-options
function updateDropdownExIcons(dropdown, element) {
    // Setting the Text of the button to the selected option
    let dropdownButton = document.getElementById(dropdown);
    let selectedValue = element.getAttribute("data-id");
    dropdownButton.innerHTML = element.innerHTML; // sets Button text to chosen value
    dropdownButton.setAttribute("chosen-value-id", selectedValue);
    document.getElementById(dropdown + "-hidden").value = selectedValue;

    // Highlighting the selected option so this is visible when opening dropdown again
    let dropdownItem = document.querySelector("a.dropdown-item.active");
    if (dropdownItem) {
        dropdownItem.classList.remove("active");
    }

    element.classList.add("active");
}

// Function to dynamically add the icons and rating to the individual Hikes of the list
function insertHikeIconAndRating(iconContainer, icon, value){
    let container = document.getElementById(iconContainer)
    container.innerHTML = icon+" "+value+"/5";
}