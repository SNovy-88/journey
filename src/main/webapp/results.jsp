<%@ page import="at.fhv.journey.model.Hike" %>
<%@ page import="at.fhv.journey.hibernate.broker.HikeBrokerJPA" %>
<%@ page import="java.util.List" %>

<%@ page contentType="text/html;charset=UTF-8"%>

<%
    HikeBrokerJPA hb = new HikeBrokerJPA();
    List<Hike> hikeList = hb.getAll();
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

<!--
    <a href="traildetails.jsp">
    <img src="pictures/results1.png" alt="Stand-In" class="center">
    <img src="pictures/results2.png" alt="Stand-In" class="center">
    </a>
-->

<div class="hike-list">
    <h1>List of Hike Trails</h1>
    <div class="hike-box-container">
        <% for (Hike hike : hikeList) { %>
        <div class="hike-box">
            <p class="fitnesslevel">
                <span class="<%= getFitnessLevelCSSClass(hike.getFitnessLevel()) %>"><%= getFitnessLevelLabel(hike.getFitnessLevel()) %></span>
            </p>

            <h2><%= hike.getName() %></h2>
            <p class="description">
                <%= hike.getDistance() %>km
                <span class="output-margin"></span>
                <%= hike.getDurationHour() %>h
                <%= hike.getDurationMin() %>min
                <span class="output-margin"></span>
                <%= hike.getHeightDifference() %>m
            </p>
            <hr>
            <div class="links-container">
                <!--<a class="safe-trail-link" href="#">Safe Trail +</a>-->
                <a class="trail-details-link" href="traildetails.jsp?trailId=<%= hike.getHike_id() %>"> View Trail Details ></a>
            </div>
        </div>
        <% } %>
    </div>
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
