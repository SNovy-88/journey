document.addEventListener("DOMContentLoaded", function () {
    document.querySelector("form").addEventListener("submit", function (event) {
        event.preventDefault(); //prevents default submit

        // input value from search-input
        var searchString = document.querySelector(".search-input").value;

       // jump to loadingSpinner
        window.location.href = "/Journey_war_exploded/loadingSpinner.jsp?searchString=" + encodeURIComponent(searchString);
    });
});