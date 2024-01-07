<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.Objects" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>
<%@ include file="favicon.jsp" %>
<!DOCTYPE html>
<html>
    <head>
        <title></title>
        <link rel="stylesheet" href="CSS/styles.css">
    </head>
    <body>
        <div id="navbar">
            <ul>
                <li><a href="index.jsp"><img class="logo" src="pictures/logo_white.png" alt="Home button"></a></li>
                <li><a class="links" href="search.jsp"> DISCOVER </a></li>
                <li><a class="links" href="createHike.jsp"> CREATE </a></li>
                <li id="profile">
                    <% if (session.getAttribute("username") != null) { %>
                    <span class="navbar-text" style="color: white; margin-right: 15px">
                        <%= session.getAttribute("username") %>
                    </span>
                    <% } %>
                    <a href="account.jsp">
                        <img class="profile" src="pictures/profile.png" alt="profile-account" width="40">
                    </a>
                </li>
            </ul>
        </div>
    </body>
</html>