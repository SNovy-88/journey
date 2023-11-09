
<%@ page contentType="text/html;charset=UTF-8"%>
<!DOCTYPE html>
<html lang="de">
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="CSS/styles.css">
    <title> Journey | Create your own journey! </title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">

</head>
<body>

    <jsp:include page="navBar.jsp"/>

    <h1> Create your own journey </h1>

    <div class="container">
        <div class="form-floating mb-3">
            <input type="title" class="form-control" id="floatingInput" placeholder="Name your hike here">
            <label for="floatingInput">Title</label>
        </div>
        <div class="invalid-feedback" id="inputFeedback">
            Please choose a title.
        </div>
        <br><br>
        <div class="form-floating">
            <textarea class="form-control" placeholder="Leave a description here" id="floatingTextarea2" style="height: 150px"></textarea>
            <label for="floatingTextarea2">Description</label>
        </div>
        <div class="invalid-feedback" id="textareaFeedback">
            Please choose a description.
        </div>
    </div>

    <br><br>
    <button id="submitBtn">Submit</button>

    <script>
        const submitBtn = document.getElementById('submitBtn');
        const inputElement = document.getElementById('floatingInput');
        const inputFeedback = document.getElementById('inputFeedback');

        const textareaElement = document.getElementById('floatingTextarea2');
        const textareaFeedback = document.getElementById('textareaFeedback');

        submitBtn.addEventListener('click', function(event) {
            if (inputElement.value.trim() === '') {
                event.preventDefault(); // Prevent the form submission
                inputElement.classList.add('is-invalid');
                inputFeedback.style.display = 'block';
            } else {
                inputElement.classList.remove('is-invalid');
                inputFeedback.style.display = 'none';
            }

            if (textareaElement.value.trim() === '') {
                event.preventDefault(); // Prevent the form submission
                textareaElement.classList.add('is-invalid');
                textareaFeedback.style.display = 'block';
            } else {
                textareaElement.classList.remove('is-invalid');
                textareaFeedback.style.display = 'none';
            }
        });
    </script>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>

</body>
</html>
