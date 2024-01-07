<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="favicon.jsp" %>
<html>
    <head lang="en">
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">

        <!-- Bootstrap CSS -->
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">

        <!-- CSS -->
        <link rel="stylesheet" href="CSS/styles.css">
        <link rel="stylesheet" href="CSS/login.css">

        <title> Journey | Log in </title>
    </head>
    <body style="background:#1a1a1a">
    <jsp:include page="navBar.jsp"/>
    <video id="background-video" class="fullscreen-bg__video" autoplay loop muted style="width: 100%; height: 100%;">
        <source src="videos/video1.mp4" type="video/mp4">
    </video>
    <div class="login-container">
        <div class="left-box">
            <div class="left-box-header">
                <a class="back-button" onclick="window.location.href = 'index.jsp';">
                    <svg xmlns="http://www.w3.org/2000/svg" height="1em" viewBox="0 0 320 512">
                        <path d="M9.4 233.4c-12.5 12.5-12.5 32.8 0 45.3l192 192c12.5 12.5 32.8 12.5 45.3 0s12.5-32.8 0-45.3L77.3 256 246.6 86.6c12.5-12.5 12.5-32.8 0-45.3s-32.8-12.5-45.3 0l-192 192z"></path>
                    </svg>
                    Back
                </a>
            </div>
            <div class="login-text mb-4 text-center">
                <h2 class="text-light font-weight-bold">Welcome to <span style="color: #b1ff2e;">Journey</span>!</h2>
                <p class="lead" style="color: #ffffff">Embark on your journey. Sign in to Journey now!</p>
            </div>
            <div class="login-form">
                <form action="loginPageServlet" method="post" class="col-md-6 mx-auto d-flex flex-column align-items-center">
                    <div class="form-group">
                        <label for="inputEmail" class="mb-2"></label>
                        <input type="email" class="form-control" id="inputEmail" placeholder="Email Address" name="email" required>
                        <div class="invalid-feedback">
                            Please enter a valid email address.
                        </div>
                        <label for="inputPassword" class="mb-2"></label>
                        <input type="password" class="form-control" id="inputPassword" placeholder="Password" name="password" required>
                        <div class="invalid-feedback">
                            Please enter a valid password.
                        </div>
                    </div>
                    <button class="submit-button">Sign in</button>
                </form>
            </div>
        </div>
    </div>
    <!-- Login failed -->
    <div class="modal fade" id="loginErrorModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">Login Error</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                       <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    Invalid email address or password. Please try again.
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                </div>
            </div>
        </div>
    </div>

    <!-- Bootstrap JS und jQuery -->
    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
    <script>
        var loginError = <%= request.getAttribute("loginError") %>;
    </script>
    <script src="JS/loginValidation.js"></script>
    </body>
</html>