<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="favicon.jsp" %>
<html>
    <head>
        <title> Journey | Success </title>

        <!-- Bootstrap CSS -->
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">

        <!-- CSS -->
        <link rel="stylesheet" href="CSS/styles.css">
        <link rel="stylesheet" href="CSS/success.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">

        <!-- JavaScript -->
        <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>

        <!-- Bootstrap JavaScript -->
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
    </head>
    <body>
        <jsp:include page="navBar.jsp"/>
        <div class="container mt-5">
            <div class="jumbotron" style="background: #FFFFFF; border: 1px solid #494949;">
                <h1 class="display-4">
                    Welcome to <span style="color: #b1ff2e; text-shadow: 2px 2px 2px #494949;"> Journey</span>, <%= session.getAttribute("username") %>!
                </h1>
                <p class="lead"> Enjoy your Journey and discover new adventures. </p>
                <hr class="my-4">
                <p> Choose your path: </p>
                <p class="lead">
                <div class="row justify-content-center">
                    <!-- "Discover" and "Create" button -->
                    <div class="col-lg-6 col-md-6 col-sm-12">
                        <a href="search.jsp" class="option-button" style="text-decoration: none">
                            <i class="fas fa-binoculars fa-3x" style="color: black"></i><br>
                            <span style="color: black"> DISCOVER </span>
                        </a>
                    </div>
                    <div class="col-lg-6 col-md-6 col-sm-12">
                        <a href="createHike.jsp" class="option-button" style="text-decoration: none">
                            <i class="fas fa-map fa-3x" style="color: black"></i><br>
                            <span style="color: black;"> CREATE </span>
                        </a>
                    </div>
                    <!-- Form for logging out -->
                    <form action="logoutServlet" method="post" style="margin-top: 20px;">
                        <button class="option-button">
                            <i class="fas fa-sign-out-alt fa-3x" style="color: black;"></i><br>
                            SIGN OUT
                        </button>
                    </form>
                </div>
            </div>
        </div>
    </body>
</html>