<%@ page import="at.fhv.journey.model.Hike" %>
<%@ page import="java.util.List" %>

<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="static at.fhv.journey.utils.CssClassGetters.getFitnessLevelCSSClass" %>

<html>
<head lang="en">
    <meta charset="UTF-8">
    <link rel="stylesheet" href="CSS/styles.css">
    <link rel="stylesheet" href="CSS/resultList.css">
    <title>Journey | Discover results</title>
</head>
<body>

<jsp:include page="navBar.jsp"/>

<h1>List of all Hikes</h1>

<!--hike-box-container contains every hike element from the search results-->
<div class="hike-box-container">

    <%--Declaration and Initialisation of List hikeList with parameter from the request
       attribute sent by servlet --%>
    <% List<Hike> hikeList=(List<Hike>) request.getAttribute("hikeList");
    for (Hike hike : hikeList) { %>

    <!--hike-box is one hike in the search results list-->
    <div class="hike-box">

        <!--element containing the hike image-->
        <div class="hike-box-image">
            <img src="pictures/examples/ex02.jpg" alt="Hike image">
        </div>

        <!--contains all the information related to one search result-->
        <div class="hike-box-information">
            <p class="fitnesslevel">
                <span class="<%= getFitnessLevelCSSClass(hike) %>"><%= hike.convertFitnessLevelToString() %></span>
            </p>

                <h2 title="<%=hike.getName()%>"><%= hike.getName() %></h2>

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
    <% } %>
</div>

</body>
</html>
