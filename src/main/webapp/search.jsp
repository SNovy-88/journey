<%@ page contentType="text/html;charset=UTF-8"%>
<html>
<head lang="de">
    <meta charset="UTF-8">
    <link rel="stylesheet" href="CSS/styles.css">
    <link rel="stylesheet" href="CSS/search.css">

    <title>Journey | Find your Journey!</title>
</head>
<body>
<!-- Navigation bar -->
<jsp:include page="navBar.jsp"/>
<!-- End of Navigation bar -->

<div class="search-container1">
    <div class="h2">Discover the world with Journey – Your path to unforgettable adventures</div>
    <div class="search-container">
        <input type="text" class="search-input" placeholder="Enter hike name, city or region">
        <button class="search-button" onclick="search()">Search</button>
    </div>
</div>

<script>
    function search() {
        window.location.href = "searchResultList.jsp";
    }
</script>
</body>
</html>
