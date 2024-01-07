<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="favicon.jsp" %>
<link rel="stylesheet" href="CSS/loadingSpinner.css">
<html>
    <head>
        <title>Loading...</title>
       <script src="JS/loadingSpinner.js"></script>
    </head>
    <body class="background">
        <div class="wrapper">
            <jsp:include page="navBar.jsp"/>
            <div class="loading-container">
                <div class="loader"></div>
            </div>
        </div>
    </body>
</html>