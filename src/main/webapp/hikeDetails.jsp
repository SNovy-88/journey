<%@ page import="at.fhv.journey.model.Hike" %>
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="static at.fhv.journey.utils.CssClassGetters.getFitnessLevelCSSClass" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.List" %>
<%@ page import="at.fhv.journey.model.Comment" %>
<%@ page import="at.fhv.journey.model.User" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>
<%@ include file="favicon.jsp" %>
<%@ page import="at.fhv.journey.utils.imagePath" %>

<!-- JSTL tag library to retrieve GPX-XML data from DB without character losses -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!-- Bootstrap CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">

<html>
    <head lang="en">
        <meta charset="UTF-8">
        <link rel="stylesheet" href="CSS/styles.css">
        <link rel="stylesheet" href="CSS/hikeDetails.css">
        <title> Journey | See hike details </title>

        <!-- Bootstrap CSS and JS -->
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
        <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>

        <!-- Leaflet CSS -->
        <link rel="stylesheet" href="https://unpkg.com/leaflet/dist/leaflet.css" />

        <!-- Leaflet JavaScript -->
        <script src="https://unpkg.com/leaflet/dist/leaflet.js"></script>
        <script src="https://unpkg.com/leaflet-gpx@1.4.0/gpx.js"></script>

        <!-- Chart JS -->
        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    </head>
    <body>
    <jsp:include page="navBar.jsp"/>
    <% Hike hike = (Hike) request.getAttribute("hike"); %>
    <% List<Map<String, String>> waypointsList = (List<Map<String, String>>) request.getAttribute("waypointsList"); %>

    <!-- JavaScript -->
    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
    <script src="JS/hikeDetails.js"></script>
    <script src="JS/attributeIcons.js"></script>
    <script src="JS/hikeDetailsMap.js"></script>
    <script src="JS/parseGPX.js"></script>
    <script src="JS/waypointIcons.js"></script>
    <script src="JS/fetchRoute.js"></script>
    <script src="JS/ORS_API_KEY.js"></script>

    <script>
      $(document).ready(function () {
          let recommendedMonths = <%=hike.getRecommendedMonths()%>;
          highlightRecommendedMonths(recommendedMonths);
      });
    </script>
    <!-- Hike Details -->
        <div class ="hike-details-page-container">
            <!-- Left section of the page -->
            <div class = "left-box">
                <!-- Header part -->
                <div class = left-box-header>
                    <a class="back-button" onclick="history.back()" >  <!-- Back-Button to get back to Result-page -->
                        <svg xmlns="http://www.w3.org/2000/svg" height="1em" viewBox="0 0 320 512">
                            <path d="M9.4 233.4c-12.5 12.5-12.5 32.8 0 45.3l192 192c12.5 12.5 32.8 12.5 45.3 0s12.5-32.8 0-45.3L77.3 256 246.6 86.6c12.5-12.5 12.5-32.8 0-45.3s-32.8-12.5-45.3 0l-192 192z"></path>
                        </svg>
                        Back
                    </a>
                    <span class = "author"> <%=hike.getAuthor() + " | " + hike.getDateCreated()%> </span>
                </div>
                <!-- Image -->
                <div class="image-container">
                    <img class="image" src="<%=imagePath.getImagePath()%><%=hike.getImage()%>" alt="Hike picture"/>
                </div>
                <!-- Details and Attributes -->
                <div class = hike-details-stats-container>
                    <div class="row">
                        <!-- Fitness level -->
                        <div class="col">
                            <p class="fitnesslevel"><span class="<%= getFitnessLevelCSSClass(hike) %>"><%= hike.convertFitnessLevelToString() %></span></p>
                        </div>
                        <div class="col stats"> <!-- distance with icon -->
                            <svg xmlns="http://www.w3.org/2000/svg" width="14" height="14" fill="currentColor" class="bi bi-arrows" viewBox="0 0 16 16">
                                <path d="M1.146 8.354a.5.5 0 0 1 0-.708l2-2a.5.5 0 1 1 .708.708L2.707 7.5h10.586l-1.147-1.146a.5.5 0 0 1 .708-.708l2 2a.5.5 0 0 1 0 .708l-2 2a.5.5 0 0 1-.708-.708L13.293 8.5H2.707l1.147 1.146a.5.5 0 0 1-.708.708l-2-2Z"></path>
                            </svg>
                            <%= hike.getDistance() %>km
                        </div>
                        <!-- Duration -->
                        <div class="col stats">
                            <svg xmlns="http://www.w3.org/2000/svg" width="14" height="14" fill="currentColor" class="bi bi-stopwatch" viewBox="0 0 16 16">
                                <path d="M8.5 5.6a.5.5 0 1 0-1 0v2.9h-3a.5.5 0 0 0 0 1H8a.5.5 0 0 0 .5-.5V5.6z"></path>
                                <path d="M6.5 1A.5.5 0 0 1 7 .5h2a.5.5 0 0 1 0 1v.57c1.36.196 2.594.78 3.584 1.64a.715.715 0 0 1 .012-.013l.354-.354-.354-.353a.5.5 0 0 1 .707-.708l1.414 1.415a.5.5 0 1 1-.707.707l-.353-.354-.354.354a.512.512 0 0 1-.013.012A7 7 0 1 1 7 2.071V1.5a.5.5 0 0 1-.5-.5zM8 3a6 6 0 1 0 .001 12A6 6 0 0 0 8 3z"></path>
                            </svg>
                            <%= hike.getDurationHour() %>h <%= hike.getDurationMin() %>min
                        </div>
                        <!-- Height difference -->
                        <div class="col stats">
                            <svg xmlns="http://www.w3.org/2000/svg" width="14" height="14" fill="currentColor" class="bi bi-arrows-vertical" viewBox="0 0 16 16">
                                <path d="M8.354 14.854a.5.5 0 0 1-.708 0l-2-2a.5.5 0 0 1 .708-.708L7.5 13.293V2.707L6.354 3.854a.5.5 0 1 1-.708-.708l2-2a.5.5 0 0 1 .708 0l2 2a.5.5 0 0 1-.708.708L8.5 2.707v10.586l1.146-1.147a.5.5 0 0 1 .708.708l-2 2Z"></path>
                            </svg>
                            <%= hike.getHeightDifference() %>m
                        </div>
                    </div>
                </div>
                <!-- Name and description -->
                <div class="description">
                    <h1> <%= hike.getName() %> </h1>
                    <p> <%= hike.getDescription()%> </p>
                </div>
                <!-- Geo data (Map) -->
                <div>
                    <h2> Map view </h2>
                    <!-- JSTL 'c:out' to escape HTML characters -->
                    <input type="hidden" id="xmlText" name="xmlText" value="<c:out value='${xmlText}' />">
                    <div id="detailMap" style="height: 400px;"></div>
                    <br>
                    <canvas id="elevationChart" width="800" height="300"></canvas>
                    <br>
                    <!-- Accordion element for waypoint descriptions -->
                    <c:forEach var="waypoint" items="${waypointsList}" varStatus="loop">
                        <div class="card">
                            <div class="card-header" id="heading${loop.index}">
                                <h5 class="mb-0">
                                    <button class="btn btn-link" data-toggle="collapse" data-target="#collapse${loop.index}" aria-expanded="true" aria-controls="collapse${loop.index}">
                                        ${empty waypoint.name ? 'Waypoint' : waypoint.name}
                                        <c:choose>
                                            <c:when test="${waypoint.type eq 'poi'}">[Point of Interest]</c:when>
                                            <c:when test="${waypoint.type eq 'hut'}">[Hut / Refuge]</c:when>
                                        </c:choose>
                                    </button>
                                </h5>
                            </div>
                            <div id="collapse${loop.index}" class="collapse" aria-labelledby="heading${loop.index}" data-parent="#accordion">
                                <div class="card-body">
                                    ${empty waypoint.description ? 'No description available' : waypoint.description}
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
                <!-- Comment Form -->
                <form action="/Journey_war_exploded/detailPage" method="post" class="comment-form">
                    <textarea id="commentText" name="commentText" class="form-textarea" required placeholder="Tell us how your journey was!"></textarea>
                    <input type="hidden" name="hikeId" value="${hike.hike_id}">
                    <button type="submit" class="form-button"> Add Comment </button>
                </form>
                <!-- Comments Section -->
                <div class="comments-section">
                    <h2>Comments</h2>
                    <c:forEach var="comment" items="${hike.comments}">
                        <div class="comment">
                            <div class="comment-header">
                                <span class="comment-date">${comment.comment_date}</span>
                                <span class="comment-author">${comment.user.username}</span>
                            </div>
                            <p class="comment-text">${comment.comment_text}</p>
                        </div>
                    </c:forEach>
                </div>
            </div>
            <!-- Right section of the page -->
            <div class = "right-box">
                <%--<button class="favorite-button">  <!-- Button to mark Favorites (Does nothing right now!)-->
                    <svg xmlns="http://www.w3.org/2000/svg" height="1em" viewBox="0 0 576 512"><!--! Font Awesome Free 6.4.2 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license (Commercial License) Copyright 2023 Fonticons, Inc. -->
                        <path d="M287.9 0c9.2 0 17.6 5.2 21.6 13.5l68.6 141.3 153.2 22.6c9 1.3 16.5 7.6 19.3 16.3s.5 18.1-5.9 24.5L433.6 328.4l26.2 155.6c1.5 9-2.2 18.1-9.6 23.5s-17.3 6-25.3 1.7l-137-73.2L151 509.1c-8.1 4.3-17.9 3.7-25.3-1.7s-11.2-14.5-9.7-23.5l26.2-155.6L31.1 218.2c-6.5-6.4-8.7-15.9-5.9-24.5s10.3-14.9 19.3-16.3l153.2-22.6L266.3 13.5C270.4 5.2 278.7 0 287.9 0zm0 79L235.4 187.2c-3.5 7.1-10.2 12.1-18.1 13.3L99 217.9 184.9 303c5.5 5.5 8.1 13.3 6.8 21L171.4 443.7l105.2-56.2c7.1-3.8 15.6-3.8 22.6 0l105.2 56.2L384.2 324.1c-1.3-7.7 1.2-15.5 6.8-21l85.9-85.1L358.6 200.5c-7.8-1.2-14.6-6.1-18.1-13.3L287.9 79z"/>
                    </svg>
                    Favorite
                </button>--%> <!-- Button has no functionality yet -->
                <h1> Hike details </h1>
                <!-- Additional attributes -->
                <div class = "pathdetails-container">
                    <!-- Stamina -->
                    <div class="pathdetail">
                        <span class="pathdetail-label"> Stamina: </span>
                        <div id="stamina" class="pathdetail-icons">
                            <script>
                                let stamina = <%=hike.getStamina()%>;
                                $(document).ready(function ()
                                {insertIcons(stamina, staminaFullIcon, staminaEmptyIcon,'stamina')});
                            </script>
                        </div>
                    </div>
                    <!-- Experience -->
                    <div class="pathdetail">
                        <span class="pathdetail-label"> Experience: </span>
                        <div id="experience" class="pathdetail-icons">
                            <script>
                                let experience = <%=hike.getExperience()%>;
                                $(document).ready(function ()
                                {insertIcons(experience, experienceFullIcon, experienceEmptyIcon, 'experience')});
                            </script>
                        </div>
                    </div>
                    <!-- Scenery -->
                    <div class="pathdetail">
                        <span class="pathdetail-label"> Scenery: </span>
                        <div id="scenery" class="pathdetail-icons">
                            <script>
                                let scenery = <%=hike.getScenery()%>;
                                $(document).ready(function ()
                                {insertIcons(scenery, sceneryFullIcon, sceneryEmptyIcon, 'scenery')});
                            </script>
                        </div>
                    </div>
                    <!-- Recommended months -->
                    <div class="pathdetail">
                        <span class="pathdetail-label"> Recommended: </span>
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
                            <div class = "col month" data-month="4">
                                Mar
                            </div>
                            <div class = "col month" data-month="8">
                                Apr
                            </div>
                        </div>
                        <div class = "row">
                            <div class = "col month"  data-month="16">
                                Mai
                            </div>
                            <div class = "col month"  data-month="32">
                                Jun
                            </div>
                            <div class = "col month"  data-month="64">
                                Jul
                            </div>
                            <div class = "col month"  data-month="128">
                                Aug
                            </div>
                        </div>
                        <div class = "row">
                            <div class = "col month" data-month="256">
                                Sep
                            </div>
                            <div class = "col month" data-month="512">
                                Oct
                            </div>
                            <div class = "col month" data-month="1024">
                                Nov
                            </div>
                            <div class = "col month" data-month="2048">
                                Dec
                            </div>
                        </div>
                    </div>
                </div>
                <!-- Weather -->
                <div class="pathdetail">
                    <span class="pathdetail-label"> Weather Forecast: </span>
                </div>
                <br>
                <%
                    String lastLat = "0";
                    String lastLon = "0";

                    if (waypointsList != null) {
                        lastLat = waypointsList.get(0).get("latitude");
                        lastLon = waypointsList.get(0).get("longitude");
                    }
                %>
                <!-- Embedded weather forecast by windy.com -->
                <!--https://www.windy.com/de/-Gewitter-thunder?thunder,2023120621,47.180,9.439,10,m:eX6agqS-->
                    <iframe width="380" height="450" src="https://embed.windy.com/embed.html?type=map&location=coordinates&metricRain=mm&metricTemp=°C&metricWind=km/h&zoom=9&overlay=rain&product=ecmwf&level=surface&lat=<%=lastLat.substring(0,4)%>&lon=<%=lastLon.substring(0,4)%>&detailLat=<%=lastLat%>&detailLon=<%=lastLon%>&marker=true&message=true" frameborder="0"></iframe>
            </div>
        </div>
    </body>
</html>