<%@ page contentType="text/html;charset=UTF-8"%>
<html>
<head lang="en">
    <meta charset="UTF-8">
    <link rel="stylesheet" href="CSS/styles.css">
    <link rel="stylesheet" href="CSS/search.css">

    <title>Journey | Discover</title>
</head>
<body class="search">
<div class="wrapper">
    <div class="background">
        <!-- Navigation bar -->
        <jsp:include page="navBar.jsp"/>
        <!-- End of Navigation bar -->
        <div class="search-container1">
            <div class="h2">Discover the world with Journey – Your path to unforgettable adventures</div>
            <div class="search-container">
                <form action="/Journey_war_exploded/searchResultList">
                    <input type="text" class="search-input" name="searchString" placeholder="Enter hike name, city, or region">
                    <button class="search-button" id="btn-search">Search</button>
                </form>
            </div>
        </div>
    </div>
</div>
</body>
</html>