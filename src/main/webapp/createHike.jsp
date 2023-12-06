<%@ page contentType="text/html;charset=UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="CSS/styles.css">
    <link rel="stylesheet" href="CSS/createHike.css">

    <title> Journey | Create your hike </title>


    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">

    <!-- Include the bs-stepper CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bs-stepper/dist/css/bs-stepper.min.css">

    <script src="https://cdn.jsdelivr.net/npm/bs-stepper/dist/js/bs-stepper.min.js"></script>

    <!-- Leaflet CSS -->
    <link rel="stylesheet" href="https://unpkg.com/leaflet/dist/leaflet.css" />

    <!-- Leaflet JavaScript -->
    <script src="https://unpkg.com/leaflet/dist/leaflet.js"></script>
    <script src="https://unpkg.com/leaflet-gpx@1.4.0/gpx.js"></script>

    <!-- OpenRouteService JavaScript -->
    <script src="https://maps.openrouteservice.org/assets/js/openrouteservice-leaflet.js"></script>
</head>
<body>
    <jsp:include page="navBar.jsp"/>
    <script src="JS/hikeDetails.js"></script>

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
                                <div class="row">
                                    <div class="col-md-3">
                                        <!-- Bootstrap On/Off switch to enable/disable features -->
                                        <div class="form-check form-switch">
                                            <input class="form-check-input" type="checkbox" role="switch" id="featureSwitch">
                                            <label class="form-check-label" for="featureSwitch">Enable to upload a .gpx file</label>
                                        </div>
                                    </div>
                                    <div class="col-md-9">
                                        <!-- Hidden input to store the switch state -->
                                        <input type="hidden" id="switchState" name="switchState" value="map">
                                        <!-- GPX Upload input (initially hidden) -->
                                        <div class="invalid-feedback" id="fileUploadFeedback">
                                            Please choose a file.
                                        </div>
                                        <div id="fileUploadFeature" style="display: none;">
                                            <div class="input-group custom-file-upload-container" style="width: 75%;">
                                                <input type="file" class="form-control" id="customFileEnd" name="gpxDataUpload"/>
                                                <button type="button" class="btn btn-secondary" onclick="resetFileInput()">Reset</button>
                                                <button type="button" class="btn btn-primary" onclick="showRoute()">Show Route</button>
                                            </div>
                                            <br>

                                        </div>
                                    </div>
                                </div>
                                <div id="mapContainer" style="display: none;">
                                    <div id="messageContainer" class="d-flex align-items-center justify-content-center">
                                        <p> Insert a .gpx file and click on 'Show route' to make the map appear.</p>
                                    </div>
                                    <div id="uploadMap" style="height: 500px;"></div>
                                </div>
                                <br>
                                    <!-- Show Map -->
                                    <div class="invalid-feedback" id="mapFeedback">
                                        Route needs at least one waypoint.
                                    </div>
                                    <div id="mapFeature">
                                        <br>
                                        <div id="map" style="height: 500px;"></div>
                                        <input type="hidden" id="gpxDataInput" name="gpxDataInput"> <!-- hidden input element for transferring gpxData from JS into JSP form element -->
                                        <br>
                                        <button class="btn btn-secondary" type="button" onclick="exportAsGPX()"> Export as GPX </button>
                                        <button class="btn btn-danger" type="button" onclick="deleteLastWaypoint()">Delete Last Waypoint</button>
                                    </div>
                                    <ul id="coordinates-list"></ul> <!-- List of waypoints -->
                                <button class="btn btn-primary" type="button" onclick="if (validateStep1()) stepper1.next()">Next</button>
                                <button class="btn btn-success" type="submit" onclick="createHike()">Create Hike</button> <!-- Create Hike button -->
                            </div>

                            <!-- STEPPER 2 -->
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
                                            <input type="number" aria-label="duration-hour" class="form-control" id="duration-hr" pattern="\d+" inputmode="numeric" step="1" min="0" name="duration-hr">
                                            <span class="input-group-text">hr</span>
                                            <input type="number" aria-label="duration-min" class="form-control" id="duration-min" pattern="\d+" inputmode="numeric" step="1" min="0" max="59" name="duration-min">
                                            <span class="input-group-text">min</span>
                                        </div>
                                    </div>
                                </div>

                                <div class="row g-1">
                                    <div class="col-md-3" style="margin-top: 30px"> <!-- Height difference input -->
                                        <label for="height-difference" class="form-label">Height Difference<sup>*</sup></label>
                                        <div class="invalid-feedback" id="height-difference-feedback">
                                            Please input a whole number.
                                        </div>
                                        <div class="input-group">
                                            <input type="number" pattern="\d+" aria-label="height-difference" class="form-control" id="height-difference" name="height-difference">
                                            <span class="input-group-text">m</span>

                                        </div>
                                    </div>
                                </div>
                                <div class="row g-1">
                                    <div class="col-md-3" style="margin-top: 30px"> <!-- Distance input -->
                                        <label for="distance" class="form-label">Distance<sup>*</sup></label>
                                        <div class="invalid-feedback" id="distance-feedback">
                                            Please input a number i.e. 2.34 or 5.7
                                        </div>
                                        <div class="input-group">
                                            <input type="number" aria-label="distance" class="form-control" id="distance" name="distance" step="any">
                                            <span class="input-group-text">km</span>
                                        </div>
                                        <label for="distance" class="form-text">Input decimals with a dot, i.e. 12.4 or 4.67</label>
                                    </div>
                                </div>
                                <hr>
                                <!-- Drop Down Elements -->
                                <!-- Fitness Level -->
                                <label class="form-label"> Fitness Level<sup>*</sup></label> <!-- Fitness Level -->
                                <br>
                                <div class="invalid-feedback" id="fitness-feedback">
                                    Please choose an option.
                                </div>
                                <div class="row g-2" id="fitness-container">
                                    <input type="hidden" id="drop-down-btn-fitness-hidden" name ="fitness-level" value="0"> <!-- hidden input element for transferring fitness level from JS into JSP form element -->
                                    <div class="col-md-3">
                                        <div class="btn-group dropend">
                                            <button id="drop-down-btn-fitness" data-id="fitness" chosen-value-id="" type="button" class="btn btn-primary dropdown-toggle" data-bs-toggle="dropdown" aria-expanded="false">
                                                Select an option
                                            </button>
                                            <ul class="dropdown-menu">
                                                <!-- updateDropdown(dropdown Button(to change title), this option (to highlight it)) -->
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
                                <label class="form-label"> Stamina<sup>*</sup></label>
                                <br>
                                <div class="invalid-feedback" id="stamina-feedback">
                                    Please choose an option.
                                </div>
                                <div class="row g-2" id="stamina-container">
                                    <input type="hidden" id="drop-down-btn-stamina-hidden" name ="stamina" value="0">
                                    <div class="col-md-3">
                                        <div class="btn-group dropend">
                                            <button id="drop-down-btn-stamina" data-id="stamina" chosen-value-id="" type="button" class="btn btn-primary dropdown-toggle" data-bs-toggle="dropdown" aria-expanded="false">
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
                                        <script>
                                            document.addEventListener("DOMContentLoaded", function () {
                                                insertIcons(0, staminaFullIcon, staminaEmptyIcon, 'stamina-icons');
                                            });
                                        </script>
                                    </div>
                                </div>
                                <br>

                                <!-- Experience -->
                                <label class="form-label"> Experience<sup>*</sup></label>
                                <br>
                                <div class="invalid-feedback" id="experience-feedback">
                                    Please choose an option.
                                </div>
                                <div class="row g-2" id="experience-container">
                                    <input type="hidden" id="drop-down-btn-experience-hidden" name ="experience" value="0">
                                    <div class="col-md-3">
                                        <div class="btn-group dropend">
                                            <button id="drop-down-btn-experience" data-id="experience" chosen-value-id="" type="button" class="btn btn-primary dropdown-toggle" data-bs-toggle="dropdown" aria-expanded="false" >
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
                                        <script>
                                            document.addEventListener("DOMContentLoaded", function () {
                                                insertIcons(0, experienceFullIcon, experienceEmptyIcon, 'experience-icons');
                                            });
                                        </script>
                                    </div>
                                </div>
                                <br>

                                <!-- Landscape -->
                                <label class="form-label"> Scenery<sup>*</sup></label>
                                <br>
                                <div class="invalid-feedback" id="scenery-feedback">
                                    Please choose an option.
                                </div>
                                <div class="row g-2" id="scenery-container">
                                    <input type="hidden" id="drop-down-btn-scenery-hidden" name ="scenery" value="0">
                                    <div class="col-md-3">
                                        <div class="btn-group dropend">
                                            <button id="drop-down-btn-scenery" data-id="scenery" chosen-value-id="" type="button" class="btn btn-primary dropdown-toggle" data-bs-toggle="dropdown" aria-expanded="false">
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
                                        <script>
                                            document.addEventListener("DOMContentLoaded", function () {
                                                insertIcons(0, sceneryFullIcon, sceneryEmptyIcon, 'scenery-icons');
                                            });
                                        </script>
                                    </div>
                                </div>
                                <br>

                                <label>Hike recommended in: </label>
                                <br>
                                <!-- - Checkboxes for month input -->
                                <div class="form-check" id="check-box">
                                    <div class="container text-lg-start">
                                        <div class="row">
                                            <div class="col">
                                                <input class="form-check-input" type="checkbox" name="Jan" value="1" id="Jan">
                                                <label class="form-check-label" for="Jan">
                                                    January
                                                </label>
                                            </div>
                                            <div class="col">
                                                <input class="form-check-input" type="checkbox" name="Feb" value="2" id="Feb">
                                                <label class="form-check-label" for="Feb">
                                                    February
                                                </label>
                                            </div>
                                            <div class="col">
                                                <input class="form-check-input" type="checkbox" name="Mar" value="4" id="Mar">
                                                <label class="form-check-label" for="Mar">
                                                    March
                                                </label>
                                            </div>
                                            <div class="col">
                                                <input class="form-check-input" type="checkbox" name="Apr" value="8" id="Apr">
                                                <label class="form-check-label" for="Apr">
                                                    April
                                                </label>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col">
                                                <input class="form-check-input" type="checkbox" name="May" value="16" id="May">
                                                <label class="form-check-label" for="May">
                                                    May
                                                </label>
                                            </div>
                                            <div class="col">
                                                <input class="form-check-input" type="checkbox" name="Jun" value="32" id="Jun">
                                                <label class="form-check-label" for="Jun">
                                                    June
                                                </label>
                                            </div>
                                            <div class="col">
                                                <input class="form-check-input" type="checkbox" name="Jul" value="64" id="Jul">
                                                <label class="form-check-label" for="Jul">
                                                    July
                                                </label>
                                            </div>
                                            <div class="col">
                                                <input class="form-check-input" type="checkbox" name="Aug" value="128" id="Aug">
                                                <label class="form-check-label" for="Aug">
                                                    August
                                                </label>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col">
                                                <input class="form-check-input" type="checkbox" name="Sep" value="256" id="Sep">
                                                <label class="form-check-label" for="Sep">
                                                    September
                                                </label>
                                            </div>
                                            <div class="col">
                                                <input class="form-check-input" type="checkbox" name="Oct" value="512" id="Oct">
                                                <label class="form-check-label" for="Oct">
                                                    October
                                                </label>
                                            </div>
                                            <div class="col">
                                                <input class="form-check-input" type="checkbox" name="Nov" value="1024" id="Nov">
                                                <label class="form-check-label" for="Nov">
                                                    November
                                                </label>
                                            </div>
                                            <div class="col">
                                                <input class="form-check-input" type="checkbox" name="Dec" value="2048" id="Dec">
                                                <label class="form-check-label" for="Dec">
                                                    December
                                                </label>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <br>
                             <p>Fields marked with an <sup>*</sup> have to be filled in!</p>
                                <button class="btn btn-primary" type="button" onclick="if (validateStep2()) stepper1.previous()">Previous</button>
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
                        <%--suppress HtmlFormInputWithoutLabel --%>
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
    <script src="JS/createHikeUploadMap.js"></script>
    <script src="JS/createHikeImage.js"></script>
    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.1/dist/umd/popper.min.js" integrity="sha384-cwmrdGZwrLYKw8X6zXkDo3MeqYTgVMiP+GxBSzLz3l2DE6/72UnZVJ8E+biqU1Kb" crossorigin="anonymous"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
    <!-- Bootstrap stepper script links -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>
</body>
</html>
