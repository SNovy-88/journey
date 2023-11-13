<%--
  Created by IntelliJ IDEA.
  User: wolfp
  Date: 26.10.2023
  Time: 14:45
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="at.fhv.journey.model.Hike" %>
<%@ page import="at.fhv.journey.hibernate.broker.HikeBrokerJPA" %>
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="static at.fhv.journey.utils.CssClassGetters.getFitnessLevelCSSClass" %>
<%

    int hikeId = Integer.parseInt(request.getParameter("trailId"));
    HikeBrokerJPA hikeBroker = new HikeBrokerJPA();
    Hike hike = hikeBroker.get(hikeId);

%>
<html>
    <head lang="en">
        <meta charset="UTF-8">
        <link rel="stylesheet" href="CSS/styles.css">
        <link rel="stylesheet" href="CSS/hikeDetails.css">
        <title>Journey | Details</title>
    </head>

    <body>
    <!--Navigation bar-->
    <jsp:include page="navBar.jsp"/>
    <!--end of Navigation bar-->

    <!-- Hike Details -->
        <div class ="container">

            <!-- Left Field -->
            <div class = "left-box">
                <a href="/Journey_war_exploded/searchResultList" class="back-button">  <!-- Back-Button to go back to Result-page -->
                    <svg xmlns="http://www.w3.org/2000/svg" height="1em" viewBox="0 0 320 512"><!--! Font Awesome Free 6.4.2 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license (Commercial License) Copyright 2023 Fonticons, Inc. -->
                        <path d="M9.4 233.4c-12.5 12.5-12.5 32.8 0 45.3l192 192c12.5 12.5 32.8 12.5 45.3 0s12.5-32.8 0-45.3L77.3 256 246.6 86.6c12.5-12.5 12.5-32.8 0-45.3s-32.8-12.5-45.3 0l-192 192z"/>
                    </svg>
                    Back
                </a>
                <div class="image-container">
                    <img class="image" src="pictures/examples/ex02.jpg"/>
                </div>
                <div class="description"> <!-- Name and short descprition -->
                    <h1><%= hike.getName() %></h1>
                    <p><%= hike.getDescription()%></p>
                </div>

            </div>
            <!-- Right Field -->
            <div class = "right-box">
                <button class="favorite-button">  <!-- Button to mark Favorites (Does nothing right now!)-->
                    <svg xmlns="http://www.w3.org/2000/svg" height="1em" viewBox="0 0 576 512"><!--! Font Awesome Free 6.4.2 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license (Commercial License) Copyright 2023 Fonticons, Inc. -->
                        <path d="M287.9 0c9.2 0 17.6 5.2 21.6 13.5l68.6 141.3 153.2 22.6c9 1.3 16.5 7.6 19.3 16.3s.5 18.1-5.9 24.5L433.6 328.4l26.2 155.6c1.5 9-2.2 18.1-9.6 23.5s-17.3 6-25.3 1.7l-137-73.2L151 509.1c-8.1 4.3-17.9 3.7-25.3-1.7s-11.2-14.5-9.7-23.5l26.2-155.6L31.1 218.2c-6.5-6.4-8.7-15.9-5.9-24.5s10.3-14.9 19.3-16.3l153.2-22.6L266.3 13.5C270.4 5.2 278.7 0 287.9 0zm0 79L235.4 187.2c-3.5 7.1-10.2 12.1-18.1 13.3L99 217.9 184.9 303c5.5 5.5 8.1 13.3 6.8 21L171.4 443.7l105.2-56.2c7.1-3.8 15.6-3.8 22.6 0l105.2 56.2L384.2 324.1c-1.3-7.7 1.2-15.5 6.8-21l85.9-85.1L358.6 200.5c-7.8-1.2-14.6-6.1-18.1-13.3L287.9 79z"/>
                    </svg>
                    Favorite
                </button>
                <h1 class="pathdetails_title">Path details</h1>
                <div class = "pathdetails"> <!-- Container for Path-details -->
                    <div class="pathdetail">
                        <span class="pathdetail-label">Distance:</span>
                        <span class="pathdetail-value"><%= hike.getDistance() %>km</span>
                    </div>
                    <div class="pathdetail">
                        <span class="pathdetail-label">Duration:</span>
                        <span class="pathdetail-value"><%= hike.getDurationHour() %>h <%= hike.getDurationMin() %>min</span>
                    </div>
                    <div class="pathdetail">
                        <span class="pathdetail-label">Height difference:</span>
                        <span class="pathdetail-value"><%= hike.getHeightDifference() %>m</span>
                    </div>
                    <div class="pathdetail">
                        <span class="pathdetail-label">Fitness level: </span>
                        <p class="fitnesslevel"><span class="<%= getFitnessLevelCSSClass(hike) %>"><%= hike.convertFitnessLevelToString() %></span></p>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>
