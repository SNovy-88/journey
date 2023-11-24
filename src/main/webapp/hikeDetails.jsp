<%--
  Created by IntelliJ IDEA.
  User: wolfp
  Date: 26.10.2023
  Time: 14:45
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="at.fhv.journey.model.Hike" %>
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="static at.fhv.journey.utils.CssClassGetters.getFitnessLevelCSSClass" %>
<%@ page import="static at.fhv.journey.utils.MonthsFunctions.*" %>
<!-- Bootstrap css href -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">

<html>
    <head lang="en">
        <meta charset="UTF-8">
        <link rel="stylesheet" href="CSS/styles.css">
        <link rel="stylesheet" href="CSS/hikeDetails.css">
        <title>Journey | Detail-Page</title>
    </head>

    <body>
    <% Hike hike = (Hike) request.getAttribute("hike"); %>
    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>

    <script>
        // Document ready function
        $(document).ready(function () {

            // Extract the start and end months from the range
            let start = <%=getStartMonthInt(hike.getRecommendedMonths())%>;
            let end = <%=getEndMonthInt(hike.getRecommendedMonths())%>;

            // Iterate over each month element
            $('.month').each(function () {
                let month = parseInt($(this).data('month'));

                // Check if the month is within the range
                if (end > 12) {
                    let startNew = 1;
                    let endNew = end - 12;
                    checkRangeAndHighlightRecommendedMonths($(this), month, startNew, endNew);
                    checkRangeAndHighlightRecommendedMonths($(this), month, start, end);
                } else if (end <= 12) {
                    checkRangeAndHighlightRecommendedMonths($(this), month, start, end);
                }
            });
        });

        function insertIcons(value, full, empty, container_id) {
            console.log('insertIcons called with value:', value);
            if (value >= 1 && value <= 5) {
                var svgHTML = '';
                for (var i = 0; i < value; i++) {
                    svgHTML += full;
                }
                for (var j = 0; j < 5 - value; j++) {
                    svgHTML += empty;
                }
                document.getElementById(container_id).innerHTML = svgHTML;
            }
        }


        function checkRangeAndHighlightRecommendedMonths(element, month, start, end){
            if (month >= start && month <= end) {
                element.css('background-color', '#b1ff2e');
            }
        }

    </script>

    <!--Navigation bar-->
    <jsp:include page="navBar.jsp"/>
    <!--end of Navigation bar-->

    <!-- Hike Details -->
        <div class ="hike-details-page-container">

            <!-- Left Field -->
            <div class = "left-box">
                <div class = left-box-header>
                    <a class="back-button" onclick="history.back()" >  <!-- Back-Button to go back to Result-page -->
                        <svg xmlns="http://www.w3.org/2000/svg" height="1em" viewBox="0 0 320 512"><!--! Font Awesome Free 6.4.2 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license (Commercial License) Copyright 2023 Fonticons, Inc. -->
                            <path d="M9.4 233.4c-12.5 12.5-12.5 32.8 0 45.3l192 192c12.5 12.5 32.8 12.5 45.3 0s12.5-32.8 0-45.3L77.3 256 246.6 86.6c12.5-12.5 12.5-32.8 0-45.3s-32.8-12.5-45.3 0l-192 192z"></path>
                        </svg>
                        Back
                    </a>
                    <span class = "author"><%=hike.getAuthor() + " | " + hike.getDateCreated()%> </span>

                </div>
                <div class="image-container">
                    <img class="image" src="pictures/examples/ex02.jpg" alt="Hike picture"/>
                </div>
                <div class = hike-details-stats-container>
                    <div class="row">
                        <div class="col"> <!-- fitness level -->
                            <p class="fitnesslevel"><span class="<%= getFitnessLevelCSSClass(hike) %>"><%= hike.convertFitnessLevelToString() %></span></p>
                        </div>
                        <div class="col stats"> <!-- distance with icon -->
                            <svg xmlns="http://www.w3.org/2000/svg" width="14" height="14" fill="currentColor" class="bi bi-arrows" viewBox="0 0 16 16">
                                <path d="M1.146 8.354a.5.5 0 0 1 0-.708l2-2a.5.5 0 1 1 .708.708L2.707 7.5h10.586l-1.147-1.146a.5.5 0 0 1 .708-.708l2 2a.5.5 0 0 1 0 .708l-2 2a.5.5 0 0 1-.708-.708L13.293 8.5H2.707l1.147 1.146a.5.5 0 0 1-.708.708l-2-2Z"></path>
                            </svg>
                            <%= hike.getDistance() %>km
                        </div>
                        <div class="col stats"> <!-- duration with icon -->
                            <svg xmlns="http://www.w3.org/2000/svg" width="14" height="14" fill="currentColor" class="bi bi-stopwatch" viewBox="0 0 16 16">
                                <path d="M8.5 5.6a.5.5 0 1 0-1 0v2.9h-3a.5.5 0 0 0 0 1H8a.5.5 0 0 0 .5-.5V5.6z"></path>
                                <path d="M6.5 1A.5.5 0 0 1 7 .5h2a.5.5 0 0 1 0 1v.57c1.36.196 2.594.78 3.584 1.64a.715.715 0 0 1 .012-.013l.354-.354-.354-.353a.5.5 0 0 1 .707-.708l1.414 1.415a.5.5 0 1 1-.707.707l-.353-.354-.354.354a.512.512 0 0 1-.013.012A7 7 0 1 1 7 2.071V1.5a.5.5 0 0 1-.5-.5zM8 3a6 6 0 1 0 .001 12A6 6 0 0 0 8 3z"></path>
                            </svg>
                            <%= hike.getDurationHour() %>h <%= hike.getDurationMin() %>min
                        </div>
                        <div class="col stats"> <!-- height difference with icon -->
                            <svg xmlns="http://www.w3.org/2000/svg" width="14" height="14" fill="currentColor" class="bi bi-arrows-vertical" viewBox="0 0 16 16">
                                <path d="M8.354 14.854a.5.5 0 0 1-.708 0l-2-2a.5.5 0 0 1 .708-.708L7.5 13.293V2.707L6.354 3.854a.5.5 0 1 1-.708-.708l2-2a.5.5 0 0 1 .708 0l2 2a.5.5 0 0 1-.708.708L8.5 2.707v10.586l1.146-1.147a.5.5 0 0 1 .708.708l-2 2Z"></path>
                            </svg>
                            <%= hike.getHeightDifference() %>m
                        </div>
                    </div>
                </div>
                <div class="description"> <!-- Name and short descprition -->
                    <h1><%= hike.getName() %></h1>
                    <p><%= hike.getDescription()%></p>
                </div>


            </div>
            <!-- Right Field -->
            <div class = "right-box">
                <%--<button class="favorite-button">  <!-- Button to mark Favorites (Does nothing right now!)-->
                    <svg xmlns="http://www.w3.org/2000/svg" height="1em" viewBox="0 0 576 512"><!--! Font Awesome Free 6.4.2 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license (Commercial License) Copyright 2023 Fonticons, Inc. -->
                        <path d="M287.9 0c9.2 0 17.6 5.2 21.6 13.5l68.6 141.3 153.2 22.6c9 1.3 16.5 7.6 19.3 16.3s.5 18.1-5.9 24.5L433.6 328.4l26.2 155.6c1.5 9-2.2 18.1-9.6 23.5s-17.3 6-25.3 1.7l-137-73.2L151 509.1c-8.1 4.3-17.9 3.7-25.3-1.7s-11.2-14.5-9.7-23.5l26.2-155.6L31.1 218.2c-6.5-6.4-8.7-15.9-5.9-24.5s10.3-14.9 19.3-16.3l153.2-22.6L266.3 13.5C270.4 5.2 278.7 0 287.9 0zm0 79L235.4 187.2c-3.5 7.1-10.2 12.1-18.1 13.3L99 217.9 184.9 303c5.5 5.5 8.1 13.3 6.8 21L171.4 443.7l105.2-56.2c7.1-3.8 15.6-3.8 22.6 0l105.2 56.2L384.2 324.1c-1.3-7.7 1.2-15.5 6.8-21l85.9-85.1L358.6 200.5c-7.8-1.2-14.6-6.1-18.1-13.3L287.9 79z"/>
                    </svg>
                    Favorite
                </button>--%> <!-- Button has no functionality yet -->
                <h1>Hike details</h1>
                <div class = "pathdetails-container"> <!-- Container for Path-details -->
                    <div class="pathdetail">
                        <span class="pathdetail-label">Stamina:</span>
                            <div id="stamina" class="pathdetail-icons">
                                <script>
                                    var svgHTMLfull ='';
                                        svgHTMLfull += '<svg xmlns="http://www.w3.org/2000/svg" width="30" height="30" fill="#EC3737" class="bi bi-heart-pulse-fill" viewBox="0 0 16 16">' +
                                        '<path d="M1.475 9C2.702 10.84 4.779 12.871 8 15c3.221-2.129 5.298-4.16 6.525-6H12a.5.5 0 0 1-.464-.314l-1.457-3.642-1.598 5.593a.5.5 0 0 1-.945.049L5.889 6.568l-1.473 2.21A.5.5 0 0 1 4 9H1.475Z"/>' +
                                        '<path d="M.88 8C-2.427 1.68 4.41-2 7.823 1.143c.06.055.119.112.176.171a3.12 3.12 0 0 1 .176-.17C11.59-2 18.426 1.68 15.12 8h-2.783l-1.874-4.686a.5.5 0 0 0-.945.049L7.921 8.956 6.464 5.314a.5.5 0 0 0-.88-.091L3.732 8H.88Z"/>' +
                                        '</svg>';

                                    var svgHTMLempty ='';
                                        svgHTMLempty += '<svg xmlns="http://www.w3.org/2000/svg" width="30" height="30" fill="currentColor" class="bi bi-heart-pulse" viewBox="0 0 16 16">' +
                                        '<path d="m8 2.748-.717-.737C5.6.281 2.514.878 1.4 3.053.918 3.995.78 5.323 1.508 7H.43c-2.128-5.697 4.165-8.83 7.394-5.857.06.055.119.112.176.171a3.12 3.12 0 0 1 .176-.17c3.23-2.974 9.522.159 7.394 5.856h-1.078c.728-1.677.59-3.005.108-3.947C13.486.878 10.4.28 8.717 2.01L8 2.748ZM2.212 10h1.315C4.593 11.183 6.05 12.458 8 13.795c1.949-1.337 3.407-2.612 4.473-3.795h1.315c-1.265 1.566-3.14 3.25-5.788 5-2.648-1.75-4.523-3.434-5.788-5Z"/>' +
                                        '<path d="M10.464 3.314a.5.5 0 0 0-.945.049L7.921 8.956 6.464 5.314a.5.5 0 0 0-.88-.091L3.732 8H.5a.5.5 0 0 0 0 1H4a.5.5 0 0 0 .416-.223l1.473-2.209 1.647 4.118a.5.5 0 0 0 .945-.049l1.598-5.593 1.457 3.642A.5.5 0 0 0 12 9h3.5a.5.5 0 0 0 0-1h-3.162l-1.874-4.686Z"/>' +
                                        '</svg>';

                                    var stamina = <%=hike.getStamina()%>;
                                    insertIcons(stamina, svgHTMLfull, svgHTMLempty,'stamina');
                                </script>
                            </div>

                    </div>
                    <div class="pathdetail">
                        <span class="pathdetail-label">Experience:</span>
                        <div id="experience" class="pathdetail-icons">
                            <script>
                                var svgHTMLfull='';
                                svgHTMLfull += '<svg xmlns="http://www.w3.org/2000/svg" width="30" height="30" fill="#804E0D" class="bi bi-mortarboard-fill" viewBox="0 0 16 16">' +
                                    '<path d="M8.211 2.047a.5.5 0 0 0-.422 0l-7.5 3.5a.5.5 0 0 0 .025.917l7.5 3a.5.5 0 0 0 .372 0L14 7.14V13a1 1 0 0 0-1 1v2h3v-2a1 1 0 0 0-1-1V6.739l.686-.275a.5.5 0 0 0 .025-.917l-7.5-3.5Z"/>' +
                                    '<path d="M4.176 9.032a.5.5 0 0 0-.656.327l-.5 1.7a.5.5 0 0 0 .294.605l4.5 1.8a.5.5 0 0 0 .372 0l4.5-1.8a.5.5 0 0 0 .294-.605l-.5-1.7a.5.5 0 0 0-.656-.327L8 10.466 4.176 9.032Z"/>' +
                                    '</svg>'

                                var svgHTMLempty='';
                                svgHTMLempty += '<svg xmlns="http://www.w3.org/2000/svg" width="30" height="30" fill="currentColor" class="bi bi-mortarboard" viewBox="0 0 16 16">' +
                                    '<path d="M8.211 2.047a.5.5 0 0 0-.422 0l-7.5 3.5a.5.5 0 0 0 .025.917l7.5 3a.5.5 0 0 0 .372 0L14 7.14V13a1 1 0 0 0-1 1v2h3v-2a1 1 0 0 0-1-1V6.739l.686-.275a.5.5 0 0 0 .025-.917l-7.5-3.5ZM8 8.46 1.758 5.965 8 3.052l6.242 2.913L8 8.46Z"/>' +
                                    '<path d="M4.176 9.032a.5.5 0 0 0-.656.327l-.5 1.7a.5.5 0 0 0 .294.605l4.5 1.8a.5.5 0 0 0 .372 0l4.5-1.8a.5.5 0 0 0 .294-.605l-.5-1.7a.5.5 0 0 0-.656-.327L8 10.466 4.176 9.032Zm-.068 1.873.22-.748 3.496 1.311a.5.5 0 0 0 .352 0l3.496-1.311.22.748L8 12.46l-3.892-1.556Z"/>' +
                                    '</svg>';

                                var experience = <%=hike.getExperience()%>;
                                insertIcons(experience, svgHTMLfull, svgHTMLempty, 'experience');
                            </script>
                        </div>
                    </div>
                    <div class="pathdetail">
                        <span class="pathdetail-label">Scenery:</span>
                            <div id="scenery" class="pathdetail-icons">
                                <script>
                                    var svgHTMLfull = '';
                                    svgHTMLfull += '<svg xmlns="http://www.w3.org/2000/svg" width="30" height="30" fill="#FFC230" class="bi bi-sun-fill" viewBox="0 0 16 16">';
                                    svgHTMLfull += '<path d="M8 12a4 4 0 1 0 0-8 4 4 0 0 0 0 8zM8 0a.5.5 0 0 1 .5.5v2a.5.5 0 0 1-1 0v-2A.5.5 0 0 1 8 0zm0 13a.5.5 0 0 1 .5.5v2a.5.5 0 0 1-1 0v-2A.5.5 0 0 1 8 13zm8-5a.5.5 0 0 1-.5.5h-2a.5.5 0 0 1 0-1h2a.5.5 0 0 1 .5.5zM3 8a.5.5 0 0 1-.5.5h-2a.5.5 0 0 1 0-1h2A.5.5 0 0 1 3 8zm10.657-5.657a.5.5 0 0 1 0 .707l-1.414 1.415a.5.5 0 1 1-.707-.708l1.414-1.414a.5.5 0 0 1 .707 0zm-9.193 9.193a.5.5 0 0 1 0 .707L3.05 13.657a.5.5 0 0 1-.707-.707l1.414-1.414a.5.5 0 0 1 .707 0zm9.193 2.121a.5.5 0 0 1-.707 0l-1.414-1.414a.5.5 0 0 1 .707-.707l1.414 1.414a.5.5 0 0 1 0 .707zM4.464 4.465a.5.5 0 0 1-.707 0L2.343 3.05a.5.5 0 1 1 .707-.707l1.414 1.414a.5.5 0 0 1 0 .708z"/>';
                                    svgHTMLfull += '</path></svg>';

                                    var svgHTMLempty = '';
                                    svgHTMLempty += '<svg xmlns="http://www.w3.org/2000/svg" width="30" height="30" fill="currentColor" class="bi bi-sun" viewBox="0 0 16 16">';
                                    svgHTMLempty += '<path d="M8 11a3 3 0 1 1 0-6 3 3 0 0 1 0 6zm0 1a4 4 0 1 0 0-8 4 4 0 0 0 0 8zM8 0a.5.5 0 0 1 .5.5v2a.5.5 0 0 1-1 0v-2A.5.5 0 0 1 8 0zm0 13a.5.5 0 0 1 .5.5v2a.5.5 0 0 1-1 0v-2A.5.5 0 0 1 8 13zm8-5a.5.5 0 0 1-.5.5h-2a.5.5 0 0 1 0-1h2a.5.5 0 0 1 .5.5zM3 8a.5.5 0 0 1-.5.5h-2a.5.5 0 0 1 0-1h2A.5.5 0 0 1 3 8zm10.657-5.657a.5.5 0 0 1 0 .707l-1.414 1.415a.5.5 0 1 1-.707-.708l1.414-1.414a.5.5 0 0 1 .707 0zm-9.193 9.193a.5.5 0 0 1 0 .707L3.05 13.657a.5.5 0 0 1-.707-.707l1.414-1.414a.5.5 0 0 1 .707 0zm9.193 2.121a.5.5 0 0 1-.707 0l-1.414-1.414a.5.5 0 0 1 .707-.707l1.414 1.414a.5.5 0 0 1 0 .707zM4.464 4.465a.5.5 0 0 1-.707 0L2.343 3.05a.5.5 0 1 1 .707-.707l1.414 1.414a.5.5 0 0 1 0 .708z">';
                                    svgHTMLempty += '</path></svg>';

                                    var scenery = <%=hike.getScenery()%>;
                                    insertIcons(scenery, svgHTMLfull, svgHTMLempty, 'scenery');
                                </script>
                            </div>
                    </div>
                    <div>
                        <span class="pathdetail-label">Recommended Months:</span>
                    </div>
                </div>
                <div class="months-container">
                    <div class="binder-image-container">
                        <img src="pictures/binder.png" alt = "Calendar Binder">
                    </div>
                    <div class="container text-center">
                        <div class = "row">
                            <div class = "col month" data-month="1">
                                Jan
                            </div>
                            <div class = "col month" data-month="2">
                                Feb
                            </div>
                            <div class = "col month" data-month="3">
                                Mar
                            </div>
                            <div class = "col month" data-month="4">
                                Apr
                            </div>
                        </div>
                        <div class = "row">
                            <div class = "col month"  data-month="5">
                                Mai
                            </div>
                            <div class = "col month"  data-month="6">
                                Jun
                            </div>
                            <div class = "col month"  data-month="7">
                                Jul
                            </div>
                            <div class = "col month"  data-month="8">
                                Aug
                            </div>
                        </div>
                        <div class = "row">
                            <div class = "col month" data-month="9">
                                Sep
                            </div>
                            <div class = "col month" data-month="10">
                                Oct
                            </div>
                            <div class = "col month" data-month="11">
                                Nov
                            </div>
                            <div class = "col month" data-month="12">
                                Dec
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>
