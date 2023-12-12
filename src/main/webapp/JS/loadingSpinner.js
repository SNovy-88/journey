document.addEventListener("DOMContentLoaded", function () {
    // Search value in string
    var searchString = getParameterByName("searchString");


    window.location.href = "/Journey_war_exploded/searchResultList?searchString=" + encodeURIComponent(searchString);
});

// Function for parameters of the QueryString
function getParameterByName(name, url) {
    if (!url) url = window.location.href;
    name = name.replace(/[\[\]]/g, "\\$&");
    var regex = new RegExp("[?&]" + name + "(=([^&#]*)|&|#|$)"),
        results = regex.exec(url);
    if (!results) return null;
    if (!results[2]) return '';
    return decodeURIComponent(results[2].replace(/\+/g, ' '));
}