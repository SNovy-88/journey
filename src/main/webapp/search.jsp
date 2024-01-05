<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="favicon.jsp" %>
<html>
    <head lang="en">
        <meta charset="UTF-8">

        <!-- CSS & JavaScript -->
        <link rel="stylesheet" href="CSS/styles.css">
        <link rel="stylesheet" href="CSS/search.css">
        <script src="JS/search.js"></script>

        <title> Journey | Seek your hike </title>
    </head>
    <body class="search">
        <div class="wrapper">
            <div class="background">
                <jsp:include page="navBar.jsp"/>
                <div class="search-container1">
                    <div class="h2"> Discover the world with Journey – Your path to unforgettable adventures </div>
                    <div class="search-container">
                        <form action="/Journey_war_exploded/searchResultList">
                            <input type="text" class="search-input" name="searchString" placeholder="Enter hike name, city, or region">
                            <button class="search-button" id="btn-search"> Search </button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>