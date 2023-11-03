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
<!--Navigation bar-->
<jsp:include page="navbar.jsp"/>
<!--end of Navigation bar-->

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
            <h2><%= hike.getName() %></h2>
            <p>
                <%= hike.getDistance() %>km
                <%= hike.getDurationHour() %>h
                <%= hike.getDurationMin() %>min
                <%= getFitnessLevelLabel(hike.getFitnessLevel()) %>
                <%= hike.getHeightDifference() %>m
            </p>
            <!-- Add more properties as needed -->
        </div>
        <% } %>
    </div>
</div>

<%! String getFitnessLevelLabel(int fitnessLevel) {
    switch (fitnessLevel) {
        case 1:
            return "easy";
        case 2:
            return "moderate";
        case 3:
            return "intermediate";
        case 4:
            return "challenging";
        case 5:
            return "expert";
        default:
            return "unknown";
    }
} %>

</body>
</html>
