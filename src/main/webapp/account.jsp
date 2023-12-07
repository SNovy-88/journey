<%@ page contentType="text/html;charset=UTF-8"%>
<html>
<head lang="en">
    <meta charset="UTF-8">
    <link rel="stylesheet" href="CSS/styles.css">
    <title>Journey | Account</title>
</head>
<body>
<!-- Navigation bar -->
<jsp:include page="navBar.jsp"/>
<!-- end of Navigation bar -->
<img src="pictures/wireframes/profiledetail.png" alt="Stand-In" class="center">

<!-- Logout Button -->
<form action="logoutServlet" method="post" style="margin-top: 20px;">
    <button type="submit">Sign Out</button>
</form>

</body>
</html>
