<%@ page contentType="text/html;charset=UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="CSS/styles.css">
    <link rel="stylesheet" href="CSS/createHike.css">

    <title> Journey | Create</title>

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">

    <!-- Include the bs-stepper CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bs-stepper/dist/css/bs-stepper.min.css">
    <link rel="stylesheet" href="bs-stepper.min.css">

    <!-- Include the bs-stepper JavaScript -->
    <script src="https://cdn.jsdelivr.net/npm/bs-stepper/dist/js/bs-stepper.min.js"></script>

    <!-- Leaflet CSS -->
    <link rel="stylesheet" href="https://unpkg.com/leaflet/dist/leaflet.css" />

    <!-- Leaflet JavaScript -->
    <script src="https://unpkg.com/leaflet/dist/leaflet.js"></script>

</head>
<body>
    <jsp:include page="navBar.jsp"/>




    <!-- Stepper element -->
    <form id="createHike" action="create_hike" method="post" enctype="multipart/form-data">
        <div class="container">
            <div class="row">
                <div class="col-md-12 mt-5">
                    <h2> Create your own journey </h2>
                    <div id="stepper1" class="bs-stepper">
                        <div class="bs-stepper-header"> <!-- Stepper header -->
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
                        <div class="bs-stepper-content"> <!-- Stepper content -->
                            <div id="test-l-1" class="content"> <!-- Content of the 1st stepper part -->
                                <p class="text-center"> <!-- not necessary? -->
                                    <!-- Name input -->
                                    <div class="invalid-feedback" id="inputFeedback">
                                        Please choose a title.
                                    </div>
                                    <div class="form-floating mb-3">
                                        <input class="form-control" id="floatingInput" name="nameInput" placeholder="Name your hike here">
                                        <label for="floatingInput">Title</label>
                                    </div>
                                    <!-- Description input -->
                                    <div class="invalid-feedback" id="textareaFeedback">
                                        Please choose a description.
                                    </div>
                                    <div class="form-floating mb-3">
                                        <textarea class="form-control" placeholder="Leave a description here" id="floatingTextarea2" name="descInput" style="height: 150px" data-mdb-showcounter="true" maxlength="500"></textarea>
                                        <label for="floatingTextarea2">Description</label>
                                    </div>
                                    <br>
                                    <!-- Bootstrap On/Off switch to enable/disable features -->
                                    <div class="form-check form-switch">
                                        <input class="form-check-input" type="checkbox" role="switch" id="featureSwitch">
                                        <label class="form-check-label" for="featureSwitch">Enable to upload a .gpx file</label>
                                    </div>
                                    <!-- Hidden input to store the switch state -->
                                    <input type="hidden" id="switchState" name="switchState" value="map">
                                    <!-- GPX Upload input (initially hidden) -->
                                    <div class="invalid-feedback" id="fileUploadFeedback">
                                        Please choose a file.
                                    </div>
                                    <div id="fileUploadFeature" style="display: none;">
                                        <br>
                                        <label class="form-label" for="customFileEnd">Upload .gpx file</label>
                                        <div class="input-group custom-file-upload-container" style="width: 65%;">
                                            <input type="file" class="form-control" id="customFileEnd" name="gpxDataUpload"/>
                                            <button type="button" class="btn btn-secondary" onclick="resetFileInput()">Reset</button>
                                        </div>
                                        <br>
                                    </div>
                                    <!-- Show Map -->
                                    <div class="invalid-feedback" id="mapFeedback">
                                        Route needs at least one waypoint.
                                    </div>
                                    <div id="mapFeature">
                                        <br>
                                        <div id="map" style="height: 400px;"></div>
                                        <input type="hidden" id="gpxDataInput" name="gpxDataInput"> <!-- hidden input element for transferring gpxData from JS into JSP form element -->
                                        <br>
                                        <button class="btn btn-secondary" type="button" onclick="exportAsGPX()"> Export as GPX </button> <!-- Export button -->
                                    </div>
                                    <ul id="coordinates-list"></ul> <!-- List of waypoints -->
                                </p>
                                <button class="btn btn-primary" type="button" onclick="if (validateStep1()) stepper1.next()">Next</button>
                                <button class="btn btn-success" type="submit" onclick="createHike()">Create Hike</button> <!-- Create Hike button -->
                            </div>

                            <!-- STEPPER 2 -->
                            <!-- TODO -->
                            <div id="test-l-2" class="content"> <!-- Content of the 2nd stepper part -->

                                <div class="row g-2">
                                    <div class="col-md-3" style="margin-top: 30px"> <!-- Group for Duration hr and min -->
                                        <label for="duration-hr" class="form-label">Duration<sup>*</sup></label>
                                        <div class="invalid-feedback" id="duration-hr-feedback">
                                            The hour field is mandatory. If duration is under 1 hour please input 0.
                                        </div>
                                        <div class="invalid-feedback" id="duration-min-feedback">
                                            Minute value needs to be under 60.
                                        </div>
                                        <div class="input-group">
                                            <input type="number" aria-label="duration-hour" class="form-control" id="duration-hr" pattern="\d*" inputmode="numeric">
                                            <span class="input-group-text">hr</span>
                                            <input type="number" aria-label="duration-min" class="form-control" id="duration-min" inputmode="numeric" max="59">
                                            <span class="input-group-text">min</span>
                                        </div>
                                    </div>
                                </div>

                                <div class="row g-1">
                                    <div class="col-md-3" style="margin-top: 30px"> <!-- Height difference input -->
                                        <label for="height-difference" class="form-label">Height Difference<sup>*</sup></label>
                                        <div class="invalid-feedback" id="height-difference-feedback">
                                            This is a mandatory field. Please input a number.
                                        </div>
                                        <div class="input-group">
                                            <input type="number" aria-label="duration-hour" class="form-control" id="height-difference">
                                            <span class="input-group-text">m</span>

                                        </div>
                                    </div>
                                </div>
                                <div class="row g-1">
                                    <div class="col-md-3" style="margin-top: 30px"> <!-- Distance input -->
                                        <label for="distance" class="form-label">Distance<sup>*</sup></label>
                                        <div class="invalid-feedback" id="distance-feedback">
                                            This is a mandatory field. Please input a number.
                                        </div>
                                        <div class="input-group">
                                            <input type="number" aria-label="duration-hour" class="form-control" id="distance">
                                            <span class="input-group-text">km</span>
                                        </div>
                                        <label for="distance" class="form-text">Input decimals with a dot, ie. 12.4 or 4.67</label>
                                    </div>
                                </div>
                                <hr>
                                <!-- Drop Down Elements -->
                                <!-- Fitness Level -->
                                <label class="form-label"> Fitness Level </label> <!-- Fitness Level -->
                                <br>
                                <div class="row g-2" id="fitness-container">
                                    <div class="col-md-3">
                                        <div class="btn-group dropend">
                                            <button id="drop-down-btn-fitness" data-id="fitness" type="button" class="btn btn-primary dropdown-toggle" data-bs-toggle="dropdown" aria-expanded="false">
                                                Select an option
                                            </button>
                                            <ul class="dropdown-menu">
                                                <!-- updateDropdown(dropdown Button(to change title), this option (to highlight it), categorie (to get right icons)) -->
                                                <li><a class="dropdown-item" href="javascript:void(0)" onclick="updateDropdown('drop-down-btn-fitness', this)" data-id="1">Easy</a></li>
                                                <li><a class="dropdown-item" href="javascript:void(0)" onclick="updateDropdown('drop-down-btn-fitness', this)" data-id="2">Moderate</a></li>
                                                <li><a class="dropdown-item" href="javascript:void(0)" onclick="updateDropdown('drop-down-btn-fitness', this)" data-id="3">Intermediate</a></li>
                                                <li><a class="dropdown-item" href="javascript:void(0)" onclick="updateDropdown('drop-down-btn-fitness', this)" data-id="4">Expert</a></li>
                                                <li><a class="dropdown-item" href="javascript:void(0)" onclick="updateDropdown('drop-down-btn-fitness', this)" data-id="5">Challenging</a></li>
                                            </ul>
                                        </div>
                                    </div>
                                    <div class="col-md-3" id="fitness-icons">
                                    </div>
                                </div>
                                <br>
                                <!-- Stamina -->
                                <label class="form-label"> Stamina </label>
                                <br>
                                <div class="row g-2" id="stamina-container">
                                    <div class="col-md-3">
                                        <div class="btn-group dropend">
                                            <button id="drop-down-btn-stamina" data-id="stamina" type="button" class="btn btn-primary dropdown-toggle" data-bs-toggle="dropdown" aria-expanded="false">
                                                Select an option
                                            </button>
                                            <ul class="dropdown-menu">
                                                <!-- updateDropdown(dropdown Button(to change title), this option (to highlight it), categorie (to get right icons)) -->
                                                <li><a class="dropdown-item" href="javascript:void(0)" onclick="updateDropdown('drop-down-btn-stamina', this)" data-id="1">Untrained</a></li>
                                                <li><a class="dropdown-item" href="javascript:void(0)" onclick="updateDropdown('drop-down-btn-stamina', this)" data-id="2">Moderate</a></li>
                                                <li><a class="dropdown-item" href="javascript:void(0)" onclick="updateDropdown('drop-down-btn-stamina', this)" data-id="3">Intermediate</a></li>
                                                <li><a class="dropdown-item" href="javascript:void(0)" onclick="updateDropdown('drop-down-btn-stamina', this)" data-id="4">Athletic</a></li>
                                                <li><a class="dropdown-item" href="javascript:void(0)" onclick="updateDropdown('drop-down-btn-stamina', this)" data-id="5">Elite</a></li>
                                            </ul>
                                        </div>
                                    </div>
                                    <div class="col-md-3" id="stamina-icons">
                                    </div>
                                </div>
                                <br>

                                <!-- Experience -->
                                <label class="form-label"> Experience </label>
                                <br>
                                <div class="row g-2" id="experience-container">
                                    <div class="col-md-3">
                                        <div class="btn-group dropend">
                                            <button id="drop-down-btn-experience" data-id="experience" type="button" class="btn btn-primary dropdown-toggle" data-bs-toggle="dropdown" aria-expanded="false" data-id="experience">
                                                Select an option
                                            </button>
                                            <ul class="dropdown-menu">
                                                <!-- updateDropdown(dropdown Button(to change title), this option (to highlight it), categorie (to get right icons)) -->
                                                <li><a class="dropdown-item" href="javascript:void(0)" onclick="updateDropdown('drop-down-btn-experience', this)" data-id="1">Novice</a></li>
                                                <li><a class="dropdown-item" href="javascript:void(0)" onclick="updateDropdown('drop-down-btn-experience', this)" data-id="2">Practised</a></li>
                                                <li><a class="dropdown-item" href="javascript:void(0)" onclick="updateDropdown('drop-down-btn-experience', this)" data-id="3">Intermediate</a></li>
                                                <li><a class="dropdown-item" href="javascript:void(0)" onclick="updateDropdown('drop-down-btn-experience', this)" data-id="4">Experienced</a></li>
                                                <li><a class="dropdown-item" href="javascript:void(0)" onclick="updateDropdown('drop-down-btn-experience', this)" data-id="5">Expert</a></li>
                                            </ul>
                                        </div>
                                    </div>
                                    <div class="col-md-3" id="experience-icons">
                                    </div>
                                </div>
                                <br>

                                <!-- Landscape -->
                                <label class="form-label"> Scenery </label>
                                <br>
                                <div class="row g-2" id="scenery-container">
                                    <div class="col-md-3">
                                        <div class="btn-group dropend">
                                            <button id="drop-down-btn-scenery" data-id="scenery" type="button" class="btn btn-primary dropdown-toggle" data-bs-toggle="dropdown" aria-expanded="false" data-id="experience">
                                                Select an option
                                            </button>
                                            <ul class="dropdown-menu">
                                                <!-- updateDropdown(dropdown Button(to change title), this option (to highlight it), categorie (to get right icons)) -->
                                                <li><a class="dropdown-item" href="javascript:void(0)" onclick="updateDropdown('drop-down-btn-scenery', this)" data-id="1">Unremarkable</a></li>
                                                <li><a class="dropdown-item" href="javascript:void(0)" onclick="updateDropdown('drop-down-btn-scenery', this)" data-id="2">Ordinary</a></li>
                                                <li><a class="dropdown-item" href="javascript:void(0)" onclick="updateDropdown('drop-down-btn-scenery', this)" data-id="3">Enjoyable</a></li>
                                                <li><a class="dropdown-item" href="javascript:void(0)" onclick="updateDropdown('drop-down-btn-scenery', this)" data-id="4">Beautiful</a></li>
                                                <li><a class="dropdown-item" href="javascript:void(0)" onclick="updateDropdown('drop-down-btn-scenery', this)" data-id="5">Stunning</a></li>
                                            </ul>
                                        </div>
                                    </div>
                                    <div class="col-md-3" id="scenery-icons">
                                    </div>
                                </div>
                                <br>

                                <p>Fields marked with a <sup>*</sup> have to be filled in!</p>
                                <button class="btn btn-primary" type="button" onclick="stepper1.previous()">Previous</button>     
                                <button class="btn btn-primary" type="button" onclick="if (validateStep2()) stepper1.next()">Next</button>
                            </div>

                            <!-- STEPPER 3 -->
                            <div id="test-l-3" class="content"> <!-- Content of the 3rd stepper part -->

                                    <script class="jsbin" src="https://ajax.googleapis.com/ajax/libs/jquery/1/jquery.min.js"></script>
                                    <!-- Image input -->
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
                                <button class="btn btn-primary" type="button" onclick="stepper1.next()">Next</button>
                                <button class="btn btn-primary" type="button" onclick="stepper1.previous()">Previous</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>


        <!-- Bootstrap pop-up-modal for map input -->
        <div class="modal fade" id="waypointModal" tabindex="-1" role="dialog" aria-labelledby="waypointModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="waypointModalLabel"> Enter Waypoint Name </h5>
                    </div>
                    <div class="modal-body">
                        <input type="text" id="waypointNameInput" class="form-control" placeholder="Enter name (optional)"> <!-- evtl. make it non-optional -->
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
                        <button type="button" class="btn btn-primary" onclick="addWaypoint()">Add Waypoint</button>
                    </div>
                </div>
            </div>
        </div>
        <!-- Bootstrap pop-up-modal for the success popup -->
        <div class="modal fade" id="successModal" tabindex="-1" role="dialog" aria-labelledby="successModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="successModalLabel">Success</h5>
                    </div>
                    <div class="modal-body">
                        Hike successfully created!
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-primary" data-dismiss="modal">Close</button>
                    </div>
                </div>
            </div>
        </div>
    </form>

    <script src="JS/createHike.js"></script>
    <script src="JS/createHikeMap.js"></script>
    <script src="JS/createHikeImage.js"></script>
    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.1/dist/umd/popper.min.js" integrity="sha384-cwmrdGZwrLYKw8X6zXkDo3MeqYTgVMiP+GxBSzLz3l2DE6/72UnZVJ8E+biqU1Kb" crossorigin="anonymous"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
    <!-- Bootstrap stepper script links -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>
    <script src="bs-stepper.min.js"></script>
    <script src="dist/js/bs-stepper.js"></script>

    <script>
        function validateStep2() {
            const inputHrElement = document.getElementById('duration-hr');
            const inputHrFeedback = document.getElementById('duration-hr-feedback');

            const inputMinElement = document.getElementById('duration-min');
            const inputMinFeedback = document.getElementById('duration-min-feedback');

            const inputHeightDiffElement = document.getElementById('height-difference');
            const inputHeightDiffFeedback = document.getElementById('height-difference-feedback');

            const inputDistanceElement = document.getElementById('distance');
            const inputDistanceFeedback = document.getElementById('distance-feedback');

            const isInputHrValid = inputHrElement.value.trim() !== '';
            const isInputMinValid = inputMinElement.value.trim() !== '';
            const isInputHeightDiffValid = inputHeightDiffElement.value.trim() !== '';
            const isDistanceValid = inputDistanceElement.value.trim() !== '';

            validation(isInputHrValid, inputHrElement, inputHrFeedback);
            validation(isInputMinValid, inputMinElement, inputMinFeedback);
            validation(isInputHeightDiffValid, inputHeightDiffElement, inputHeightDiffFeedback);
            validation(isDistanceValid, inputDistanceElement, inputDistanceFeedback);

            return isInputHrValid && isInputMinValid && isInputHeightDiffValid && isDistanceValid;
        }

        function validation(valid, input, feedback){
            if(!valid){
                input.classList.add('is-invalid');
                feedback.style.display = 'block';
            } else {
                input.classList.remove('is-invalid');
                feedback.style.display = 'none';
            }
        }
        function updateDropdown(dropdown, element) {
            // Setting the Text of the button to the selected option
            let dropdownButton = document.getElementById(dropdown);
            let selectedValue = element.getAttribute("data-id");
            let valueText = element.innerHTML;
            dropdownButton.innerHTML = valueText;

            // Highlighting the selected option so this is visible when opening dropdown again
            let dropdownItem = document.querySelector("a.dropdown-item.active");
            if (dropdownItem) {
                dropdownItem.classList.remove("active");
            }
            element.classList.add("active");

            //console.log(selectedValue);

            // Inserting the right icons, depending on the hike attribute
            let attribute = dropdownButton.getAttribute("data-id");
            switch (attribute){
                case "stamina":
                    var svgHTMLfull ='';
                    svgHTMLfull += '<svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="#EC3737" class="bi bi-heart-pulse-fill" viewBox="0 0 16 16">' +
                        '<path d="M1.475 9C2.702 10.84 4.779 12.871 8 15c3.221-2.129 5.298-4.16 6.525-6H12a.5.5 0 0 1-.464-.314l-1.457-3.642-1.598 5.593a.5.5 0 0 1-.945.049L5.889 6.568l-1.473 2.21A.5.5 0 0 1 4 9H1.475Z"/>' +
                        '<path d="M.88 8C-2.427 1.68 4.41-2 7.823 1.143c.06.055.119.112.176.171a3.12 3.12 0 0 1 .176-.17C11.59-2 18.426 1.68 15.12 8h-2.783l-1.874-4.686a.5.5 0 0 0-.945.049L7.921 8.956 6.464 5.314a.5.5 0 0 0-.88-.091L3.732 8H.88Z"/>' +
                        '</svg>';
                    var svgHTMLempty ='';
                    svgHTMLempty += '<svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi bi-heart-pulse" viewBox="0 0 16 16">' +
                        '<path d="m8 2.748-.717-.737C5.6.281 2.514.878 1.4 3.053.918 3.995.78 5.323 1.508 7H.43c-2.128-5.697 4.165-8.83 7.394-5.857.06.055.119.112.176.171a3.12 3.12 0 0 1 .176-.17c3.23-2.974 9.522.159 7.394 5.856h-1.078c.728-1.677.59-3.005.108-3.947C13.486.878 10.4.28 8.717 2.01L8 2.748ZM2.212 10h1.315C4.593 11.183 6.05 12.458 8 13.795c1.949-1.337 3.407-2.612 4.473-3.795h1.315c-1.265 1.566-3.14 3.25-5.788 5-2.648-1.75-4.523-3.434-5.788-5Z"/>' +
                        '<path d="M10.464 3.314a.5.5 0 0 0-.945.049L7.921 8.956 6.464 5.314a.5.5 0 0 0-.88-.091L3.732 8H.5a.5.5 0 0 0 0 1H4a.5.5 0 0 0 .416-.223l1.473-2.209 1.647 4.118a.5.5 0 0 0 .945-.049l1.598-5.593 1.457 3.642A.5.5 0 0 0 12 9h3.5a.5.5 0 0 0 0-1h-3.162l-1.874-4.686Z"/>' +
                        '</svg>';
                    insertIcons(selectedValue, svgHTMLfull, svgHTMLempty, 'stamina-icons');
                    break;

                case "experience":
                    var svgHTMLfull='';
                    svgHTMLfull += '<svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="#804E0D" class="bi bi-mortarboard-fill" viewBox="0 0 16 16">' +
                        '<path d="M8.211 2.047a.5.5 0 0 0-.422 0l-7.5 3.5a.5.5 0 0 0 .025.917l7.5 3a.5.5 0 0 0 .372 0L14 7.14V13a1 1 0 0 0-1 1v2h3v-2a1 1 0 0 0-1-1V6.739l.686-.275a.5.5 0 0 0 .025-.917l-7.5-3.5Z"/>' +
                        '<path d="M4.176 9.032a.5.5 0 0 0-.656.327l-.5 1.7a.5.5 0 0 0 .294.605l4.5 1.8a.5.5 0 0 0 .372 0l4.5-1.8a.5.5 0 0 0 .294-.605l-.5-1.7a.5.5 0 0 0-.656-.327L8 10.466 4.176 9.032Z"/>' +
                        '</svg>'
                    var svgHTMLempty='';
                    svgHTMLempty += '<svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi bi-mortarboard" viewBox="0 0 16 16">' +
                        '<path d="M8.211 2.047a.5.5 0 0 0-.422 0l-7.5 3.5a.5.5 0 0 0 .025.917l7.5 3a.5.5 0 0 0 .372 0L14 7.14V13a1 1 0 0 0-1 1v2h3v-2a1 1 0 0 0-1-1V6.739l.686-.275a.5.5 0 0 0 .025-.917l-7.5-3.5ZM8 8.46 1.758 5.965 8 3.052l6.242 2.913L8 8.46Z"/>' +
                        '<path d="M4.176 9.032a.5.5 0 0 0-.656.327l-.5 1.7a.5.5 0 0 0 .294.605l4.5 1.8a.5.5 0 0 0 .372 0l4.5-1.8a.5.5 0 0 0 .294-.605l-.5-1.7a.5.5 0 0 0-.656-.327L8 10.466 4.176 9.032Zm-.068 1.873.22-.748 3.496 1.311a.5.5 0 0 0 .352 0l3.496-1.311.22.748L8 12.46l-3.892-1.556Z"/>' +
                        '</svg>';
                    insertIcons(selectedValue, svgHTMLfull, svgHTMLempty, 'experience-icons');
                    break;

                case "scenery":
                    var svgHTMLfull = '';
                    svgHTMLfull += '<svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="#FFC230" class="bi bi-sun-fill" viewBox="0 0 16 16">';
                    svgHTMLfull += '<path d="M8 12a4 4 0 1 0 0-8 4 4 0 0 0 0 8zM8 0a.5.5 0 0 1 .5.5v2a.5.5 0 0 1-1 0v-2A.5.5 0 0 1 8 0zm0 13a.5.5 0 0 1 .5.5v2a.5.5 0 0 1-1 0v-2A.5.5 0 0 1 8 13zm8-5a.5.5 0 0 1-.5.5h-2a.5.5 0 0 1 0-1h2a.5.5 0 0 1 .5.5zM3 8a.5.5 0 0 1-.5.5h-2a.5.5 0 0 1 0-1h2A.5.5 0 0 1 3 8zm10.657-5.657a.5.5 0 0 1 0 .707l-1.414 1.415a.5.5 0 1 1-.707-.708l1.414-1.414a.5.5 0 0 1 .707 0zm-9.193 9.193a.5.5 0 0 1 0 .707L3.05 13.657a.5.5 0 0 1-.707-.707l1.414-1.414a.5.5 0 0 1 .707 0zm9.193 2.121a.5.5 0 0 1-.707 0l-1.414-1.414a.5.5 0 0 1 .707-.707l1.414 1.414a.5.5 0 0 1 0 .707zM4.464 4.465a.5.5 0 0 1-.707 0L2.343 3.05a.5.5 0 1 1 .707-.707l1.414 1.414a.5.5 0 0 1 0 .708z"/>';
                    svgHTMLfull += '</path></svg>';
                    var svgHTMLempty = '';
                    svgHTMLempty += '<svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi bi-sun" viewBox="0 0 16 16">';
                    svgHTMLempty += '<path d="M8 11a3 3 0 1 1 0-6 3 3 0 0 1 0 6zm0 1a4 4 0 1 0 0-8 4 4 0 0 0 0 8zM8 0a.5.5 0 0 1 .5.5v2a.5.5 0 0 1-1 0v-2A.5.5 0 0 1 8 0zm0 13a.5.5 0 0 1 .5.5v2a.5.5 0 0 1-1 0v-2A.5.5 0 0 1 8 13zm8-5a.5.5 0 0 1-.5.5h-2a.5.5 0 0 1 0-1h2a.5.5 0 0 1 .5.5zM3 8a.5.5 0 0 1-.5.5h-2a.5.5 0 0 1 0-1h2A.5.5 0 0 1 3 8zm10.657-5.657a.5.5 0 0 1 0 .707l-1.414 1.415a.5.5 0 1 1-.707-.708l1.414-1.414a.5.5 0 0 1 .707 0zm-9.193 9.193a.5.5 0 0 1 0 .707L3.05 13.657a.5.5 0 0 1-.707-.707l1.414-1.414a.5.5 0 0 1 .707 0zm9.193 2.121a.5.5 0 0 1-.707 0l-1.414-1.414a.5.5 0 0 1 .707-.707l1.414 1.414a.5.5 0 0 1 0 .707zM4.464 4.465a.5.5 0 0 1-.707 0L2.343 3.05a.5.5 0 1 1 .707-.707l1.414 1.414a.5.5 0 0 1 0 .708z">';
                    svgHTMLempty += '</path></svg>';
                    insertIcons(selectedValue, svgHTMLfull, svgHTMLempty, 'scenery-icons');
                    break;
            }

        }

        //TODO
        //this function is from hike Details and needs to be put in separate JS file
        function insertIcons(value, full, empty, container_id) {
            console.log('insertIcons called with value:', value);
            if (value >= 1 && value <= 5) {
                var svgHTML = '';
                for (var i = 0; i < value; i++) {
                    svgHTML += full;
                }
                for (var j = 0; j < 5 - value; j++) {
                    svgHTML += empty;
                }
                let container = document.getElementById(container_id)
                container.innerHTML = svgHTML;

            }
        }

    </script>
</body>
</html>
