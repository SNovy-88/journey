<%--
  Created by IntelliJ IDEA.
  User: wolfp
  Date: 26.10.2023
  Time: 14:16
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8"%>
<html>
<head lang="de">
    <meta charset="UTF-8">
    <link rel="stylesheet" href="CSS/styles.css">
    <title>Suche</title>
</head>
<body>
<!--Navigation bar-->
<jsp:include page="navBar.jsp"/>
<!--end of Navigation bar-->

<%--/journey_war_exploded is the context path. when the url is loaded in the browser, its the
    path before the page name. ie.
    http://localhost:8080/Journey_war_exploded/searchResultList--%>
    <a href="/Journey_war_exploded/searchResultList">
        <img src="pictures/search.png" alt="Stand-In" class="center">
    </a>
</body>
</html>
