<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="favicon.jsp" %>
<html>
    <head lang="en">
        <meta charset="UTF-8">
        <link rel="stylesheet" href="CSS/styles.css">
        <title> Journey | Account </title>
    </head>
    <body>
        <jsp:include page="navBar.jsp"/> <!-- Navigation bar -->
        <%
            if (session != null && session.getAttribute("email") != null) {
                response.sendRedirect("success.jsp");
            }
        %>
    </body>
</html>