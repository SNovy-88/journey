<%@ page import="at.fhv.journey.model.Hike" %>
<%@ page import="java.util.List" %>
<%@ page import="at.fhv.journey.hibernate.facade.DatabaseFacade" %>

<%@ page contentType="text/html;charset=UTF-8"%>

<!--Gets List of all the hikes-->
<%
    DatabaseFacade df = new DatabaseFacade();
    List<Hike> hikeList = df.getAllHikes();
%>

<html>
<head lang="en">
    <meta charset="UTF-8">
    <link rel="stylesheet" href="styles.css">
    <link rel="stylesheet" href="resultlist.css">
    <title>Journey | Discover results</title>
</head>
<body>

<jsp:include page="navbar.jsp"/>

<h1>List of Hike Trails</h1>

<!--hike-box-container contains every hike element from the search results-->
<div class="hike-box-container">
    <% for (Hike hike : hikeList) { %>

    <!--hike-box is one hike in the search results list-->
    <div class="hike-box">

        <!--element containing the hike image-->
        <div class="hike-box-image">
            <img src="pictures/examples/ex02.jpg" alt="Hike image">
        </div>

        <!--contains all the information related to one search result-->
        <div class="hike-box-information">
            <p class="fitnesslevel">
                <span class="<%= getFitnessLevelCSSClass(hike.getFitnessLevel()) %>"><%= getFitnessLevelLabel(hike.getFitnessLevel()) %></span>
            </p>

            <h2><%= hike.getName() %></h2>

            <!--container for distance, duration and height difference-->
            <p class="description">
                <%= hike.getDistance() %>km
                <span class="output-margin"></span>
                <%= hike.getDurationHour() %>h
                <%= hike.getDurationMin() %>min
                <span class="output-margin"></span>
                <%= hike.getHeightDifference() %>m
            </p>
            <hr>

            <!--contains link for the hike details page-->
            <div class="links-container">
                <!--<a class="safe-trail-link" href="#">Safe Trail +</a>--> <!--link for favourites not working yet-->
                <a class="trail-details-link" href="traildetails.jsp?trailId=<%= hike.getHike_id() %>"> View Trail Details ></a>
            </div>
        </div>
    </div>
    <% } %>
</div>


<%! String getFitnessLevelLabel(int fitnessLevel) {
    switch (fitnessLevel) {
        case 1:
            return "EASY";
        case 2:
            return "MODERATE";
        case 3:
            return "INTERMEDIATE";
        case 4:
            return "CHALLENGING";
        case 5:
            return "EXPERT";
        default:
            return "UNKNOWN";
    }
} %>

<%! String getFitnessLevelCSSClass(int fitnessLevel) {
    switch (fitnessLevel) {
        case 1:
            return "fitness-level-easy";
        case 2:
            return "fitness-level-moderate";
        case 3:
            return "fitness-level-intermediate";
        case 4:
            return "fitness-level-challenging";
        case 5:
            return "fitness-level-expert";
        default:
            return "fitness-level-unknown";
    }
} %>


</body>
</html>
