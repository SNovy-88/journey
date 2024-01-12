document.addEventListener('DOMContentLoaded', function() {
    var urlParams = new URLSearchParams(window.location.search);
    var registrationSuccess = urlParams.get('registrationSuccess');
    console.log('Registration Success:', registrationSuccess);

    if (registrationSuccess !== null) {
        if (registrationSuccess === "true") {
            console.log('Showing successModal');
            $('#successModal').modal('show');
        } else if (registrationSuccess === "false") {
            console.log('Showing errorModal');
            $('#errorModal').modal('show');
        }
    }
});

$(document).ready(function() {
    $('#togglePassword').click(function() {
        const passwordField = $('#inputPassword');
        const passwordFieldType = passwordField.attr('type');

        if (passwordFieldType === 'password') {
            passwordField.attr('type', 'text');
            $('#togglePassword').removeClass('fa-eye').addClass('fa-eye-slash');
        } else {
            passwordField.attr('type', 'password');
            $('#togglePassword').removeClass('fa-eye-slash').addClass('fa-eye');
        }
    });
});
