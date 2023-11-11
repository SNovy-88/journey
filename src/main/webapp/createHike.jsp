
<%@ page contentType="text/html;charset=UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="CSS/styles.css">
    <title> Journey | Create your own journey! </title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
    <link rel="stylesheet" href="bs-stepper.min.css">

    <!-- Include the bs-stepper CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bs-stepper/dist/css/bs-stepper.min.css">

    <!-- Include the bs-stepper JavaScript -->
    <script src="https://cdn.jsdelivr.net/npm/bs-stepper/dist/js/bs-stepper.min.js"></script>

</head>
<body>

    <jsp:include page="navBar.jsp"/>
<!--
    <h1> Create your own journey </h1>

    <div class="container">
        <div id="stepper2" class="bs-stepper">
            <div class="bs-stepper-header" role="tablist">
                <div class="step active" data-target="#test-nl-1">
                    <button type="button" class="step-trigger" role="tab" id="stepper2trigger1" aria-controls="test-nl-1" aria-selected="true">
                <span class="bs-stepper-circle">
                  <span class="fas fa-user" aria-hidden="true"></span>
                </span>
                        <span class="bs-stepper-label">Name</span>
                    </button>
                </div>
                <div class="bs-stepper-line"></div>
                <div class="step" data-target="#test-nl-2">
                    <button type="button" class="step-trigger" role="tab" id="stepper2trigger2" aria-controls="test-nl-2" aria-selected="false">
                <span class="bs-stepper-circle">
                  <span class="fas fa-map-marked" aria-hidden="true"></span>
                </span>
                        <span class="bs-stepper-label">Address</span>
                    </button>
                </div>
                <div class="bs-stepper-line"></div>
                <div class="step" data-target="#test-nl-3">
                    <button type="button" class="step-trigger" role="tab" id="stepper2trigger3" aria-controls="test-nl-3" aria-selected="false">
                <span class="bs-stepper-circle">
                  <span class="fas fa-save" aria-hidden="true"></span>
                </span>
                        <span class="bs-stepper-label">Submit</span>
                    </button>
                </div>
            </div>
            <div class="bs-stepper-content">

                <br><br>
                <div class="invalid-feedback" id="inputFeedback">
                    Please choose a title.
                </div>
                <div class="form-floating mb-3">
                    <input type="title" class="form-control" id="floatingInput" placeholder="Name your hike here">
                    <label for="floatingInput">Title</label>
                </div>
                <div class="invalid-feedback" id="textareaFeedback">
                    Please choose a description.
                </div>
                <div class="form-floating mb-3">
                    <textarea class="form-control" placeholder="Leave a description here" id="floatingTextarea2" style="height: 150px" data-mdb-showcounter="true" maxlength="500"></textarea>
                    <label for="floatingTextarea2">Description</label>
                </div>

                <br>
                <label class="form-label" for="customFile">Starting coordinates: Upload .gpx file</label>
                <input type="file" class="form-control" id="customFileStart" />
                <br>
                <label class="form-label" for="customFile">Finishing coordinates: Upload .gpx file</label>
                <input type="file" class="form-control" id="customFileEnd" />
            </div>
        </div>
    </div>


    <br><br>
    <button id="submitBtn">Submit</button>
-->


    <div class="container">
        <div class="row">
            <div class="col-md-12 mt-5">
                <h2> Create your own journey </h2>
                <div id="stepper1" class="bs-stepper">
                    <div class="bs-stepper-header">
                        <div class="step" data-target="#test-l-1">
                            <button type="button" class="btn step-trigger">
                                <span class="bs-stepper-circle">1</span>
                                <span class="bs-stepper-label"> General Info </span>
                            </button>
                        </div>
                        <div class="line"></div>
                        <div class="step" data-target="#test-l-2">
                            <button type="button" class="btn step-trigger">
                                <span class="bs-stepper-circle">2</span>
                                <span class="bs-stepper-label"> Description </span>
                            </button>
                        </div>
                        <div class="line"></div>
                        <div class="step" data-target="#test-l-3">
                            <button type="button" class="btn step-trigger">
                                <span class="bs-stepper-circle">3</span>
                                <span class="bs-stepper-label"> Images </span>
                            </button>
                        </div>
                    </div>
                    <div class="bs-stepper-content">
                        <div id="test-l-1" class="content">
                            <p class="text-center"> <!-- not necessary? -->
                                <div class="invalid-feedback" id="inputFeedback">
                                    Please choose a title.
                                </div>
                                <div class="form-floating mb-3">
                                    <input type="title" class="form-control" id="floatingInput" placeholder="Name your hike here">
                                    <label for="floatingInput">Title</label>
                                </div>
                                <div class="invalid-feedback" id="textareaFeedback">
                                    Please choose a description.
                                </div>
                                <div class="form-floating mb-3">
                                    <textarea class="form-control" placeholder="Leave a description here" id="floatingTextarea2" style="height: 150px" data-mdb-showcounter="true" maxlength="500"></textarea>
                                    <label for="floatingTextarea2">Description</label>
                                </div>
                                <br>
                                <label class="form-label" for="customFileStart">Starting coordinates: Upload .gpx file</label>
                                <input type="file" class="form-control" id="customFileStart" />
                                <br>
                                <label class="form-label" for="customFileEnd">Finishing coordinates: Upload .gpx file</label>
                                <input type="file" class="form-control" id="customFileEnd" />
                            </p>
                            <button class="btn btn-primary" onclick="if (validateStep1()) stepper1.next()">Next</button>
                        </div>
                        <div id="test-l-2" class="content">
                            <p class="text-center"> <!-- not necessary? -->
                                <div class="form-floating mb-3">
                                    <input type="number" id="typeNumberHour" class="form-control" />
                                    <label class="form-label" for="typeNumberHour"> Duration Hour </label>
                                </div>
                                <div class="form-floating mb-3">
                                    <input type="number" id="typeNumberMinute" class="form-control" />
                                    <label class="form-label" for="typeNumberMinute"> Duration Minute </label>
                                </div>
                                <div class="input-group mb-3">
                                    <input type="text" class="form-control" placeholder="Height difference" aria-label="Height difference" aria-describedby="basic-addon1">
                                    <div class="input-group-append">
                                        <span class="input-group-text" id="basic-addon1">m</span>
                                    </div>
                                </div>
                                <div class="input-group mb-3">
                                    <input type="text" class="form-control" placeholder="Distance" aria-label="Distance" aria-describedby="basic-addon2">
                                    <div class="input-group-append">
                                        <span class="input-group-text" id="basic-addon2">km</span>
                                    </div>
                                </div>
                                <label for="customRange1" class="form-label"> Physical Condition </label>
                                <input type="range" class="form-range" min="0" max="5" id="customRange1">
                                <label for="customRange2" class="form-label"> Stamina </label>
                                <input type="range" class="form-range" min="0" max="5" id="customRange2">
                                <label for="customRange3" class="form-label"> Experience </label>
                                <input type="range" class="form-range" min="0" max="5" id="customRange3">
                                <label for="customRange4" class="form-label"> Landscape </label>
                                <input type="range" class="form-range" min="0" max="5" id="customRange4">
                                <label for="customRange5" class="form-label"> Preferred months </label>
                                <input type="range" class="form-range" min="0" max="11" id="customRange5">
                            </p>
                            <button class="btn btn-primary" onclick="stepper1.next()">Next</button>
                            <button class="btn btn-primary" onclick="stepper1.previous()">Previous</button>
                        </div>
                        <div id="test-l-3" class="content">
                            <p class="text-center"> <!-- not necessary? -->
                                <script class="jsbin" src="https://ajax.googleapis.com/ajax/libs/jquery/1/jquery.min.js"></script>
                                <div class="file-upload">

                                    <button class="file-upload-btn" type="button" onclick="$('.file-upload-input').trigger( 'click' )">Add Image</button>

                                    <div class="image-upload-wrap">
                                        <input class="file-upload-input" type='file' onchange="readURL(this);" accept="image/*" />
                                        <div class="drag-text">
                                            <h3>Drag and drop a file or select add Image</h3>
                                        </div>
                                    </div>
                                    <div class="file-upload-content">
                                        <img class="file-upload-image" src="#" alt="your image" />
                                        <div class="image-title-wrap">
                                            <button type="button" onclick="removeUpload()" class="remove-image">Remove <span class="image-title">Uploaded Image</span></button>
                                        </div>
                                    </div>
                                </div>
                                <script>
                                    function readURL(input) {
                                        if (input.files && input.files[0]) {

                                            var reader = new FileReader();

                                            reader.onload = function(e) {
                                                $('.image-upload-wrap').hide();

                                                $('.file-upload-image').attr('src', e.target.result);
                                                $('.file-upload-content').show();

                                                $('.image-title').html(input.files[0].name);
                                            };

                                            reader.readAsDataURL(input.files[0]);

                                        } else {
                                            removeUpload();
                                        }
                                    }

                                    function removeUpload() {
                                        $('.file-upload-input').replaceWith($('.file-upload-input').clone());
                                        $('.file-upload-content').hide();
                                        $('.image-upload-wrap').show();
                                    }
                                    $('.image-upload-wrap').bind('dragover', function () {
                                        $('.image-upload-wrap').addClass('image-dropping');
                                    });
                                    $('.image-upload-wrap').bind('dragleave', function () {
                                        $('.image-upload-wrap').removeClass('image-dropping');
                                    });
                                </script>
                            </p>
                            <button class="btn btn-primary" onclick="stepper1.next()">Next</button>
                            <button class="btn btn-primary" onclick="stepper1.previous()">Previous</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script>
        var stepper1Node = document.querySelector('#stepper1')
        var stepper1 = new Stepper(document.querySelector('#stepper1'))

        stepper1Node.addEventListener('show.bs-stepper', function (event) {
            console.warn('show.bs-stepper', event);
        });

        stepper1Node.addEventListener('shown.bs-stepper', function (event) {
            console.warn('shown.bs-stepper', event);
        });

        function validateStep1() {
            const inputElement = document.getElementById('floatingInput');
            const inputFeedback = document.getElementById('inputFeedback');

            const textareaElement = document.getElementById('floatingTextarea2');
            const textareaFeedback = document.getElementById('textareaFeedback');

            const isInputValid = inputElement.value.trim() !== '';
            const isTextareaValid = textareaElement.value.trim() !== '';

            if (!isInputValid) {
                inputElement.classList.add('is-invalid');
                inputFeedback.style.display = 'block';
            } else {
                inputElement.classList.remove('is-invalid');
                inputFeedback.style.display = 'none';
            }

            if (!isTextareaValid) {
                textareaElement.classList.add('is-invalid');
                textareaFeedback.style.display = 'block';
            } else {
                textareaElement.classList.remove('is-invalid');
                textareaFeedback.style.display = 'none';
            }

            return isInputValid && isTextareaValid;
        }


        var stepper2 = new Stepper(document.querySelector('#stepper2'), {
            linear: false,
            animation: true
        });

        var stepper3 = new Stepper(document.querySelector('#stepper3'), {
            animation: true
        });

        var stepper4 = new Stepper(document.querySelector('#stepper4'));
    </script>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>
    <script src="bs-stepper.min.js"></script>
    <script src="dist/js/bs-stepper.js"></script>

</body>
</html>
