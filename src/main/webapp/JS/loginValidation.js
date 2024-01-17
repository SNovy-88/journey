document.addEventListener('DOMContentLoaded', function() {
    if (loginError) {
        $(document).ready(function(){
            $('#loginErrorModal').modal('show');
        });
    }
});