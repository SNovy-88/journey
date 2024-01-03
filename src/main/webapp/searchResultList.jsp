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
    <script src="JS/search.js"></script>
    <script src="JS/hikeDetails.js"></script>

    <%-- Retrieve the search string from the request --%>
    <% String searchString;
        if (request.getParameter("searchString") != null) {
            searchString = request.getParameter("searchString");
        }else {
            searchString = request.getParameter("search-input-hidden");
        }
    %>


    <div class="search-container-rlist">
        <div class="row">
            <div class="col-md-2" style="text-align: left; padding-left: 7%">
                <h2 style="color: white;">Filter</h2>
            </div>
            <div class="col-md-10" >
                <form action="filterResultList">
                    <input id="search-input" type="text" class="search-input" name="searchString" placeholder="All Hikes" value="<%= searchString%>">
                    <button class="search-button-rlist">Search</button>
                </form>
            </div>
        </div>
    </div>

    <div class="filter">
        <form action="filterResultList">
            <div class="filterClass">
                <label for="drop-down-btn-fitness">Fitness-Level:</label>
                <br>
                <input type="hidden" id="drop-down-btn-fitness-hidden" name ="fitness-level" value="<%= (request.getParameter("fitness-level") != null) ? request.getParameter("fitness-level") : "" %>"> <!-- hidden input element for transferring fitness level with form element -->
                <div class="btn-group dropend">
                    <button id="drop-down-btn-fitness" data-id="fitness" chosen-value-id="" type="button" class="btn btn-secondary dropdown-toggle"
                            data-bs-toggle="dropdown" aria-expanded="false" data-parameter-value="<%= request.getParameter("fitness-level") %>">
<%--                        <%= (request.getParameter("fitness-level") != null) ? request.getParameter("fitness-level") : "Choose here" %> <!-- if fitness-level is not null, set the value of the button to the fitness-level, else set it to "Choose here" -->--%>
                    </button>
                    <ul class="dropdown-menu">
                        <li><a class="dropdown-item" href="javascript:void(0)" onclick="updateDropdownExIcons('drop-down-btn-fitness', this)" data-id="1">Easy</a></li>
                        <li><a class="dropdown-item" href="javascript:void(0)" onclick="updateDropdownExIcons('drop-down-btn-fitness', this)" data-id="2">Moderate</a></li>
                        <li><a class="dropdown-item" href="javascript:void(0)" onclick="updateDropdownExIcons('drop-down-btn-fitness', this)" data-id="3">Intermediate</a></li>
                        <li><a class="dropdown-item" href="javascript:void(0)" onclick="updateDropdownExIcons('drop-down-btn-fitness', this)" data-id="4">Expert</a></li>
                        <li><a class="dropdown-item" href="javascript:void(0)" onclick="updateDropdownExIcons('drop-down-btn-fitness', this)" data-id="5">Challenging</a></li>
                    </ul>
                </div>
            </div>
            <div class="filterClass">
                <label for="drop-down-btn-stamina">Stamina:</label>
                <br>
                <input type="hidden" id="drop-down-btn-stamina-hidden" name ="stamina" value="<%= (request.getParameter("stamina") != null) ? request.getParameter("stamina") : "" %>"> <!-- hidden input element for transferring stamina level with form element -->
                <div class="btn-group dropend">
                    <button id="drop-down-btn-stamina" data-id="stamina" chosen-value-id="" type="button" class="btn btn-secondary dropdown-toggle"
                            data-bs-toggle="dropdown" aria-expanded="false" data-parameter-value="<%= request.getParameter("stamina") %>">
                        Choose here
                    </button>
                    <ul class="dropdown-menu">
                        <li><a class="dropdown-item" href="javascript:void(0)" onclick="updateDropdownExIcons('drop-down-btn-stamina', this)" data-id="1">Untrained</a></li>
                        <li><a class="dropdown-item" href="javascript:void(0)" onclick="updateDropdownExIcons('drop-down-btn-stamina', this)" data-id="2">Moderate</a></li>
                        <li><a class="dropdown-item" href="javascript:void(0)" onclick="updateDropdownExIcons('drop-down-btn-stamina', this)" data-id="3">Intermediate</a></li>
                        <li><a class="dropdown-item" href="javascript:void(0)" onclick="updateDropdownExIcons('drop-down-btn-stamina', this)" data-id="4">Athletic</a></li>
                        <li><a class="dropdown-item" href="javascript:void(0)" onclick="updateDropdownExIcons('drop-down-btn-stamina', this)" data-id="5">Elite</a></li>
                    </ul>
                </div>
            </div>
            <div class="filterClass">
            <label for="drop-down-btn-experience">Experience:</label>
            <br>
                <input type="hidden" id="drop-down-btn-experience-hidden" name ="experience" value="<%= (request.getParameter("experience") != null) ? request.getParameter("experience") : "" %>"> <!-- hidden input element for transferring experience level with form element -->
                <div class="btn-group dropend">
                    <button id="drop-down-btn-experience" data-id="experience" chosen-value-id="" type="button" class="btn btn-secondary dropdown-toggle"
                            data-bs-toggle="dropdown" aria-expanded="false" data-parameter-value="<%= request.getParameter("experience") %>">
                        Choose here
                    </button>
                    <ul class="dropdown-menu">
                        <!-- updateDropdown(dropdown Button(to change title), this option (to highlight it), categorie (to get right icons)) -->
                        <li><a class="dropdown-item" href="javascript:void(0)" onclick="updateDropdownExIcons('drop-down-btn-experience', this)" data-id="1">Novice</a></li>
                        <li><a class="dropdown-item" href="javascript:void(0)" onclick="updateDropdownExIcons('drop-down-btn-experience', this)" data-id="2">Practised</a></li>
                        <li><a class="dropdown-item" href="javascript:void(0)" onclick="updateDropdownExIcons('drop-down-btn-experience', this)" data-id="3">Intermediate</a></li>
                        <li><a class="dropdown-item" href="javascript:void(0)" onclick="updateDropdownExIcons('drop-down-btn-experience', this)" data-id="4">Experienced</a></li>
                        <li><a class="dropdown-item" href="javascript:void(0)" onclick="updateDropdownExIcons('drop-down-btn-experience', this)" data-id="5">Expert</a></li>
                    </ul>
                </div>
            </div>
            <div class="filterClass">
            <label for="drop-down-btn-scenery">Scenery:</label>
            <br>
                <input type="hidden" id="drop-down-btn-scenery-hidden" name ="scenery" value="<%= (request.getParameter("scenery") != null) ? request.getParameter("scenery") : "" %>"> <!-- hidden input element for transferring experience level with form element -->
                <div class="btn-group dropend">
                    <button id="drop-down-btn-scenery" data-id="scenery" chosen-value-id="" type="button" class="btn btn-secondary dropdown-toggle"
                            data-bs-toggle="dropdown" aria-expanded="false" data-parameter-value="<%= request.getParameter("scenery") %>">
                        Choose here
                    </button>
                    <ul class="dropdown-menu">
                        <!-- updateDropdown(dropdown Button(to change title), this option (to highlight it), categorie (to get right icons)) -->
                        <li><a class="dropdown-item" href="javascript:void(0)" onclick="updateDropdownExIcons('drop-down-btn-scenery', this)" data-id="1">Unremarkable</a></li>
                        <li><a class="dropdown-item" href="javascript:void(0)" onclick="updateDropdownExIcons('drop-down-btn-scenery', this)" data-id="2">Ordinary</a></li>
                        <li><a class="dropdown-item" href="javascript:void(0)" onclick="updateDropdownExIcons('drop-down-btn-scenery', this)" data-id="3">Enjoyable</a></li>
                        <li><a class="dropdown-item" href="javascript:void(0)" onclick="updateDropdownExIcons('drop-down-btn-scenery', this)" data-id="4">Beautiful</a></li>
                        <li><a class="dropdown-item" href="javascript:void(0)" onclick="updateDropdownExIcons('drop-down-btn-scenery', this)" data-id="5">Stunning</a></li>
                    </ul>
                </div>
            </div>
            <div class="filterClass" >
            <label for="check-box">Preferred months:</label>
                <!-- - Checkboxes for month input -->
                <div class="form-check" id="check-box">
                    <div class="container text-lg-start">
                        <div class="row">
                            <div class="col">
                                <input class="form-check-input" type="checkbox" name="Jan" value="1" id="Jan">
                                <label class="form-check-label" for="Jan">
                                    Jan
                                </label>
                            </div>
                            <div class="col">
                                <input class="form-check-input" type="checkbox" name="Apr" value="8" id="Apr">
                                <label class="form-check-label" for="Apr">
                                    Apr
                                </label>
                            </div>
                            <div class="col">
                                <input class="form-check-input" type="checkbox" name="Jul" value="64" id="Jul">
                                <label class="form-check-label" for="Jul">
                                    Jul
                                </label>
                            </div>
                            <div class="col">
                                <input class="form-check-input" type="checkbox" name="Oct" value="512" id="Oct">
                                <label class="form-check-label" for="Oct">
                                    Oct
                                </label>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col">
                                <input class="form-check-input" type="checkbox" name="Feb" value="2" id="Feb">
                                <label class="form-check-label" for="Feb">
                                    Feb
                                </label>
                            </div>
                            <div class="col">
                                <input class="form-check-input" type="checkbox" name="May" value="16" id="May">
                                <label class="form-check-label" for="May">
                                    May
                                </label>
                            </div>
                            <div class="col">
                                <input class="form-check-input" type="checkbox" name="Aug" value="128" id="Aug">
                                <label class="form-check-label" for="Aug">
                                    Aug
                                </label>
                            </div>
                            <div class="col">
                                <input class="form-check-input" type="checkbox" name="Nov" value="1024" id="Nov">
                                <label class="form-check-label" for="Nov">
                                    Nov
                                </label>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col">
                                <input class="form-check-input" type="checkbox" name="Mar" value="4" id="Mar">
                                <label class="form-check-label" for="Mar">
                                    Mar
                                </label>
                            </div>
                            <div class="col">
                                <input class="form-check-input" type="checkbox" name="Jun" value="32" id="Jun">
                                <label class="form-check-label" for="Jun">
                                    Jun
                                </label>
                            </div>
                            <div class="col">
                                <input class="form-check-input" type="checkbox" name="Sep" value="256" id="Sep">
                                <label class="form-check-label" for="Sep">
                                    Sep
                                </label>
                            </div>
                            <div class="col">
                                <input class="form-check-input" type="checkbox" name="Dec" value="2048" id="Dec">
                                <label class="form-check-label" for="Dec">
                                    Dec
                                </label>
                            </div>
                        </div>
                    </div>
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
            <input type="hidden" name="search-input-hidden" id="search-input-hidden" value="">
            <button type="submit" onclick="setHiddenInput()">Apply</button>
        </form>
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
                        <div class="row row-cols-auto"> <!-- 2nd row for stamina, experience and scenery -->
                            <div class="col-md-3 fs-6" id="stamina-container-<%=hike.getHike_id()%>"> <!-- Stamina with Icon -->
                                <script>insertHikeIconAndRating("stamina-container-<%=hike.getHike_id()%>", staminaFullIcon, <%= hike.getStamina() %>)</script>
                            </div>
                            <div class="col-md-3 fs-6" id="experience-container-<%=hike.getHike_id()%>"> <!-- duration with icon -->
                                <script>insertHikeIconAndRating("experience-container-<%=hike.getHike_id()%>", experienceFullIcon, <%= hike.getExperience() %>)</script>
                            </div>
                            <div class="col-md-3 fs-6" id="scenery-container-<%=hike.getHike_id()%>"> <!-- height difference with icon -->
                                <script>insertHikeIconAndRating("scenery-container-<%=hike.getHike_id()%>", sceneryFullIcon, <%= hike.getScenery() %>)</script>
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
                            <form action ="detailPage" id="moreDetailsForm">
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
