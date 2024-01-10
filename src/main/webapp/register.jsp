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

    <title> Journey | Sign up </title>
</head>
<body style="background:#1a1a1a">
<jsp:include page="navBar.jsp"/>
<video id="background-video" class="fullscreen-bg__video" autoplay loop muted style="width: 100%; height: 100%;">
    <source src="videos/video1.mp4" type="video/mp4">
</video>
    <div class="login-container">
        <div class="left-box">
            <div class="left-box-header">
                <a class="back-button" onclick="window.location.href = 'login.jsp';">
                    <svg xmlns="http://www.w3.org/2000/svg" height="1em" viewBox="0 0 320 512">
                        <path d="M9.4 233.4c-12.5 12.5-12.5 32.8 0 45.3l192 192c12.5 12.5 32.8 12.5 45.3 0s12.5-32.8 0-45.3L77.3 256 246.6 86.6c12.5-12.5 12.5-32.8 0-45.3s-32.8-12.5-45.3 0l-192 192z"></path>
                    </svg>
                    Back
                </a>
            </div>
            <div class="login-text mb-4 text-center">
                <h2 class="text-light font-weight-bold">Create an Account</h2>
                <p class="lead" style="color: #ffffff">Enter your details below to create your Journey account.</p>
            </div>
            <div class="login-form">
                <form action="registerPageServlet" method="post" class="col-md-6 mx-auto d-flex flex-column align-items-center">
                    <div class="form-group">
                        <label for="inputUsername" class="mb-3"></label>
                        <input type="text" class="form-control" id="inputUsername" placeholder="Username" name="username" required>
                        <label for="inputEmail" class="mb-3"></label>
                        <input type="email" class="form-control" id="inputEmail" placeholder="Email Address" name="email" required>
                        <div class="invalid-feedback">
                            Please enter a valid email address.
                        </div>
                        <label for="inputPassword" class="mb-3"></label>
                        <input type="password" class="form-control" id="inputPassword" placeholder="Password" name="password" required>
                        <div class="invalid-feedback">
                            Please enter a valid password.
                        </div>
                    </div>
                    <div class="d-flex">
                        <button class="submit-button mr-2">Create Account</button>
                    </div>
                </form>
            </div>
        </div>
    </div>


    <!-- Bootstrap Modal for success message -->
    <div class="modal fade" id="successModal" tabindex="-1" role="dialog" aria-labelledby="successModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="successModalLabel">Success</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    Your account has been successfully created!
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-primary" onclick="window.location.href = 'login.jsp';">OK</button>
                </div>
            </div>
        </div>
    </div>

    <!-- Bootstrap Modal for error message -->
    <div class="modal fade" id="errorModal" tabindex="-1" role="dialog" aria-labelledby="errorModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="errorModalLabel">Error</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    An error occurred while creating your account. Please try again.
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
                </div>
            </div>
        </div>
    </div>

<!-- Bootstrap JS and jQuery -->
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>

<script>
    // Function to show success modal
    function showSuccessModal() {
        $('#successModal').modal('show');
    }

    // Function to show error modal
    function showErrorModal() {
        $('#errorModal').modal('show');
    }

    $(document).ready(function () {
        // Check for registrationSuccess in sessionStorage
        if (sessionStorage.getItem('registrationSuccess') === 'true') {
            // Show success modal
            showSuccessModal();
            // Remove registrationSuccess from sessionStorage
            sessionStorage.removeItem('registrationSuccess');
        }
    });
</script>
</body>
</html>