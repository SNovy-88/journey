<%@ page import="at.fhv.journey.model.Hike" %>
<%@ page import="java.util.List" %>

<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="static at.fhv.journey.utils.CssClassGetters.getFitnessLevelCSSClass" %>

<html>
<head lang="en">
    <meta charset="UTF-8">
    <link rel="stylesheet" href="CSS/styles.css">
    <link rel="stylesheet" href="CSS/resultList.css">
    <link rel="stylesheet" href="CSS/search.css">
    <link rel="stylesheet" href="CSS/createHike.css">
    <title>Journey | Results</title>

    <!-- Bootstrap css href -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">

</head>
<body>

<div class="scroll">
    <jsp:include page="navBar.jsp"/>

    <%-- Retrieve the search string from the request --%>
    <% String searchString = request.getParameter("searchString"); %>


    <div class="search-container-rlist">
        <form action="/Journey_war_exploded/searchResultList">
            <input type="text" class="search-input" name="searchString" placeholder="All Hikes" value="<%= searchString %>">
            <button class="search-button-rlist">Search</button>
        </form>
    </div>

<div class="filter">
    <h2 class="filterHead"> FILTER </h2>
    <div class="filterClass">
        <label for="fitness">Fitness-Level:</label>
        <br>
        <select name="fitness" id="fitness" class="filterRating">
            <option value="0" selected="selected" hidden="hidden">Choose here</option>
            <option value="1">Easy</option>
            <option value="2">Moderate</option>
            <option value="3">Intermediate</option>
            <option value="4">Challenging</option>
            <option value="5">Expert</option>
        </select>
    </div>
    <div class="filterClass">
        <label for="stamina">Stamina:</label>
        <br>
        <select name="stamina" id="stamina" class="filterRating">
            <option value="0" selected="selected" hidden="hidden">Choose here</option>
            <option value="1">Untrained</option>
            <option value="2">Moderate</option>
            <option value="3">Intermediate</option>
            <option value="4">Athletic</option>
            <option value="5">Elite</option>
        </select>
    </div>
    <div class="filterClass">
    <label for="experience">Experience:</label>
    <br>
    <select name="experience" id="experience" class="filterRating">
        <option value="0" selected="selected" hidden="hidden">Choose here</option>
        <option value="1">Novice</option>
        <option value="2">Practised</option>
        <option value="3">Intermediate</option>
        <option value="4">Experienced</option>
        <option value="5">Expert</option>
    </select>
    </div>
    <div class="filterClass">
    <label for="scenery">Scenery:</label>
    <br>
    <select name="scenery" id="scenery" class="filterRating">
        <option value="0" selected="selected" hidden="hidden">Choose here</option>
        <option value="1">Unremarkable</option>
        <option value="2">Ordinary</option>
        <option value="3">Enjoyable</option>
        <option value="4">Beautiful</option>
        <option value="5">Stunning</option>
    </select>
    </div>
    <div class="filterClass">
    <p> Preferred months:</p>
        <div class="monthsSelect">
            <input class="month" type="checkbox" id="month1" name="month1" value="1">
            <label for="month1"> Jan </label><br>
            <input class="month" type="checkbox" id="month2" name="month2" value="2">
            <label for="month2"> Feb </label><br>
            <input class="month" type="checkbox" id="month3" name="month3" value="4">
            <label for="month3"> Mar </label><br>
            <input class="month" type="checkbox" id="month4" name="month4" value="8">
            <label for="month4"> Apr </label><br>
            <input class="month" type="checkbox" id="month5" name="month5" value="16">
            <label for="month5"> May </label><br>
            <input class="month" type="checkbox" id="month6" name="month6" value="32">
            <label for="month6"> Jun </label><br>
            <input class="month" type="checkbox" id="month7" name="month7" value="64">
            <label for="month7"> Jul </label><br>
            <input class="month" type="checkbox" id="month8" name="month8" value="128">
            <label for="month8"> Aug </label><br>
            <input class="month" type="checkbox" id="month9" name="month9" value="256">
            <label for="month9"> Sep </label><br>
            <input class="month" type="checkbox" id="month10" name="month10" value="512">
            <label for="month10"> Oct </label><br>
            <input class="month" type="checkbox" id="month11" name="month11" value="1024">
            <label for="month11"> Nov </label><br>
            <input class="month" type="checkbox" id="month12" name="month12" value="2048">
            <label for="month12"> Dec </label><br>
        </div>
    </div>
    <div class="filterClass">
        <p>Height-Difference:</p>
        <div class="input-group">
            <input type="number" pattern="\d+" aria-label="height-difference" class="form-control" id="height-difference" name="height-difference">
            <span class="input-group-text">m</span>
        </div>
    </div>
    <div class="filterClass">
        <p>Distance:</p>
        <div class="input-group">
            <input type="number" aria-label="distance" class="form-control" id="distance" name="distance" step="any">
            <span class="input-group-text">km</span>
        </div>
    </div>
    <div class="filterClass">
        <p>Duration:</p>
        <div class="input-group">
            <input type="number" aria-label="duration-hour" class="form-control" id="duration-hr" pattern="\d+" inputmode="numeric" step="1" min="0" name="duration-hr">
            <span class="input-group-text">hr</span>
            <input type="number" aria-label="duration-min" class="form-control" id="duration-min" pattern="\d+" inputmode="numeric" step="1" min="0" max="59" name="duration-min">
            <span class="input-group-text">min</span>
        </div>
    </div>
    <button onclick="filter()">Apply</button>
</div>
</div>

<div class="hike-box-container"> <!-- hike-box-container contains every hike element from the search results -->

    <%--Declaration and Initialisation of List hikeList with parameter from the request
       attribute sent by servlet --%>
    <% List<Hike> hikeList=(List<Hike>) request.getAttribute("hikeList");
    for (Hike hike : hikeList) { %>
        <div class="hike-box"> <!--hike-box is one hike in the search results list-->
            <div class="row"> <!-- grid system for the infos inside a box -->
                <div class="col-md-4"> <!-- column for the image -->
                    <div class="image-container">
                        <div class="image rounded" style="background-image: url('pictures/examples/ex02.jpg');"></div>
                    </div>
                </div>
                <div class="col-md-8"> <!-- column for the header and description -->
                    <p class="fitnesslevel"><span class="<%= getFitnessLevelCSSClass(hike) %>"><%= hike.convertFitnessLevelToString() %></span></p>

                    <h2 class="hike-name" title="<%=hike.getName()%>" id="<%=hike.getHike_id()%>"><%= hike.getName() %></h2>
                    <script>
                        document.getElementById("<%=hike.getHike_id()%>").addEventListener('click', function(){
                            var form = document.getElementById('moreDetailsForm');
                            form.querySelector('[name="hike-id"]').value = '<%=hike.getHike_id()%>';
                            form.submit();
                        });
                    </script>

                    <div class="container text-center">
                        <div class="row row-cols-auto"> <!-- table inside the grid for the description -->
                            <div class="col-md-3 fs-6"> <!-- distance with icon -->
                                <svg xmlns="http://www.w3.org/2000/svg" width="14" height="14" fill="currentColor" class="bi bi-arrows" viewBox="0 0 16 16">
                                    <path d="M1.146 8.354a.5.5 0 0 1 0-.708l2-2a.5.5 0 1 1 .708.708L2.707 7.5h10.586l-1.147-1.146a.5.5 0 0 1 .708-.708l2 2a.5.5 0 0 1 0 .708l-2 2a.5.5 0 0 1-.708-.708L13.293 8.5H2.707l1.147 1.146a.5.5 0 0 1-.708.708l-2-2Z"></path>
                                </svg>
                                <%= hike.getDistance() %>km
                            </div>
                            <div class="col-md-3 fs-6"> <!-- duration with icon -->
                                <svg xmlns="http://www.w3.org/2000/svg" width="14" height="14" fill="currentColor" class="bi bi-stopwatch" viewBox="0 0 16 16">
                                    <path d="M8.5 5.6a.5.5 0 1 0-1 0v2.9h-3a.5.5 0 0 0 0 1H8a.5.5 0 0 0 .5-.5V5.6z"></path>
                                    <path d="M6.5 1A.5.5 0 0 1 7 .5h2a.5.5 0 0 1 0 1v.57c1.36.196 2.594.78 3.584 1.64a.715.715 0 0 1 .012-.013l.354-.354-.354-.353a.5.5 0 0 1 .707-.708l1.414 1.415a.5.5 0 1 1-.707.707l-.353-.354-.354.354a.512.512 0 0 1-.013.012A7 7 0 1 1 7 2.071V1.5a.5.5 0 0 1-.5-.5zM8 3a6 6 0 1 0 .001 12A6 6 0 0 0 8 3z"></path>
                                </svg>
                                <%= hike.getDurationHour() %>h <%= hike.getDurationMin() %>min
                            </div>
                            <div class="col-md-3 fs-6"> <!-- height difference with icon -->
                                <svg xmlns="http://www.w3.org/2000/svg" width="14" height="14" fill="currentColor" class="bi bi-arrows-vertical" viewBox="0 0 16 16">
                                    <path d="M8.354 14.854a.5.5 0 0 1-.708 0l-2-2a.5.5 0 0 1 .708-.708L7.5 13.293V2.707L6.354 3.854a.5.5 0 1 1-.708-.708l2-2a.5.5 0 0 1 .708 0l2 2a.5.5 0 0 1-.708.708L8.5 2.707v10.586l1.146-1.147a.5.5 0 0 1 .708.708l-2 2Z"></path>
                                </svg>
                                <%= hike.getHeightDifference() %>m
                            </div>
                        </div>
                    </div>
                    <hr> <!-- line element -->
                    <div class="col-md-12 text-right"> <!-- column for the links -->

                            <!-- <a class="safe-trail-link" href="#">Safe Trail +</a> --> <!--link for favourites not working yet-->
                            <!-- zur späteren implementierung sollte dies ein button sein,
                            der die hike_id mitbekommt, zur späteren details abfrage, sowas in der art:
                            <form action="hikeDetails.jsp" >
                                <input type="submit" value="detailsPage">
                            </form>
                            -->
                            <form action ="/Journey_war_exploded/detailPage" id="moreDetailsForm">
                                <input type="hidden" value = "<%=hike.getHike_id()%>" name = hike-id>
                                <button type="submit" value = "hikeDetails" id = "hikeDetailsButton" class = "hike-details-link">More Details</button>
                            </form>
                    </div>
                </div>
            </div>
        </div>
    <% } %>
    <% if (hikeList.isEmpty()) {
        %> <h1 class="noHikeText"> No matching results found
        <br>
        <br>
        Try another search?
        </h1> <%
    } %>
</div>

<!-- Bootstrap js implementation -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>
<script src="JS/filter.js"></script>

</body>
</html>
