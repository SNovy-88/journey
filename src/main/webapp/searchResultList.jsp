<%@ page import="at.fhv.journey.model.Hike" %>
<%@ page import="java.util.List" %>

<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="static at.fhv.journey.utils.CssClassGetters.getFitnessLevelCSSClass" %>

<html>
<head lang="en">
    <meta charset="UTF-8">
    <link rel="stylesheet" href="CSS/styles.css">
    <link rel="stylesheet" href="CSS/resultList.css">
    <title>Journey | Results</title>

    <!-- Bootstrap css href -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">

</head>
<body>

<jsp:include page="navBar.jsp"/>

<%-- Retrieve the search string from the request --%>
<% String searchString = request.getParameter("searchString"); %>

<h1>List of Hikes for "<%= searchString %>"</h1>

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

                    <a class="hike-details-link-header" href="hikeDetails.jsp?trailId=<%= hike.getHike_id() %>"> <h2 title="<%=hike.getName()%>"><%= hike.getName() %></h2> </a>

                    <div class="container text-center">
                        <div class="row row-cols-auto"> <!-- table inside the grid for the description -->
                            <div class="col-md-3 fs-6"> <!-- distance with icon -->
                                <svg xmlns="http://www.w3.org/2000/svg" width="14" height="14" fill="currentColor" class="bi bi-arrows" viewBox="0 0 16 16">
                                    <path d="M1.146 8.354a.5.5 0 0 1 0-.708l2-2a.5.5 0 1 1 .708.708L2.707 7.5h10.586l-1.147-1.146a.5.5 0 0 1 .708-.708l2 2a.5.5 0 0 1 0 .708l-2 2a.5.5 0 0 1-.708-.708L13.293 8.5H2.707l1.147 1.146a.5.5 0 0 1-.708.708l-2-2Z"/>
                                </svg>
                                <%= hike.getDistance() %>km
                            </div>
                            <div class="col-md-3 fs-6"> <!-- duration with icon -->
                                <svg xmlns="http://www.w3.org/2000/svg" width="14" height="14" fill="currentColor" class="bi bi-stopwatch" viewBox="0 0 16 16">
                                    <path d="M8.5 5.6a.5.5 0 1 0-1 0v2.9h-3a.5.5 0 0 0 0 1H8a.5.5 0 0 0 .5-.5V5.6z"/>
                                    <path d="M6.5 1A.5.5 0 0 1 7 .5h2a.5.5 0 0 1 0 1v.57c1.36.196 2.594.78 3.584 1.64a.715.715 0 0 1 .012-.013l.354-.354-.354-.353a.5.5 0 0 1 .707-.708l1.414 1.415a.5.5 0 1 1-.707.707l-.353-.354-.354.354a.512.512 0 0 1-.013.012A7 7 0 1 1 7 2.071V1.5a.5.5 0 0 1-.5-.5zM8 3a6 6 0 1 0 .001 12A6 6 0 0 0 8 3z"/>
                                </svg>
                                <%= hike.getDurationHour() %>h <%= hike.getDurationMin() %>min
                            </div>
                            <div class="col-md-3 fs-6"> <!-- height difference with icon -->
                                <svg xmlns="http://www.w3.org/2000/svg" width="14" height="14" fill="currentColor" class="bi bi-arrows-vertical" viewBox="0 0 16 16">
                                    <path d="M8.354 14.854a.5.5 0 0 1-.708 0l-2-2a.5.5 0 0 1 .708-.708L7.5 13.293V2.707L6.354 3.854a.5.5 0 1 1-.708-.708l2-2a.5.5 0 0 1 .708 0l2 2a.5.5 0 0 1-.708.708L8.5 2.707v10.586l1.146-1.147a.5.5 0 0 1 .708.708l-2 2Z"/>
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

                            <a class="hike-details-link" href="hikeDetails.jsp?trailId=<%= hike.getHike_id() %>"> View Hike Details ></a>
                    </div>
                </div>
            </div>
        </div>
    <% } %>
</div>

<!-- Bootstrap js implementation -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>

</body>
</html>
