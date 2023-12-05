<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.Objects" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>

<!DOCTYPE html>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" href="CSS/styles.css">
</head>
<body>
<div id="navbar">
    <ul>
        <li><a href="index.jsp"><img class="logo" src="pictures/logo_white.png" alt="Home button"></a></li>
        <li><a class="links" href="search.jsp">DISCOVER</a></li>
        <li><a class="links" href="createHike.jsp">CREATE</a></li>
        <li id="profile">
            <a href="account.jsp">
                <img class="profile" src="pictures/profile.png" alt="profile-account">
            </a>
            <% if (session.getAttribute("username") != null) { %>
            <span class="navbar-text" style="color: #cccccc">
                <%= session.getAttribute("username") %>
                </span>
            <% } %>
        </li>
    </ul>
</div>
</body>
</html>
