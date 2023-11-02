<%@ page import="at.fhv.journey.model.Hike" %>
<%@ page import="at.fhv.journey.hibernate.broker.HikeBrokerJPA" %><%--
  Created by IntelliJ IDEA.
  User: wolfp
  Date: 26.10.2023
  Time: 14:42
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8"%>
<html>
<head lang="de">
    <meta charset="UTF-8">
    <link rel="stylesheet" href="styles.css">
    <title>Resultate</title>
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
<%
    HikeBrokerJPA hb = new HikeBrokerJPA();
    Hike testHike = hb.get(1);
    String hikeName = testHike.getName();
%>

These are all my current Hikes:
<br>
<%=hikeName%>
</body>
</html>
