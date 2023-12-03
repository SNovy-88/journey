<%@ page contentType="text/html;charset=UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="CSS/styles.css">
    <title> Journey | Create your hike </title>
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
    <script src="https://unpkg.com/leaflet-gpx@1.4.0/gpx.js"></script>

    <!-- OpenRouteService JavaScript -->
    <script src="https://maps.openrouteservice.org/assets/js/openrouteservice-leaflet.js"></script>

    <style>
        #mapContainer {
            position: relative;
            height: 400px; /* Set an initial height for the map container */
        }

        #messageContainer {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: #eaffc7; /* Set the background color of the message container to grey */
            border: 2px solid grey; /* Set the border color and width */
            box-sizing: border-box; /* Include the border width in the total height of the container */
        }

        /* Add styles for the text inside the message container */
        #messageContainer p {
            color: black; /* Set the text color */
            margin: 0; /* Remove default margin */
            padding: 20px; /* Add padding to the text */
            font-size: 24px; /* Set the font size */
        }
    </style>
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
                                    <div id="uploadMap" style="height: 400px;"></div>
                                </div>
                                <br>
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
                            <div id="test-l-2" class="content"> <!-- Content of the 2nd stepper part -->

                                    <!-- Hour input -->
                                    <div class="form-floating mb-3">
                                        <input type="number" id="typeNumberHour" class="form-control" name="duration-hr"/>
                                        <label class="form-label" for="typeNumberHour"> Duration Hour </label>
                                    </div>
                                    <!-- Minute input -->
                                    <div class="form-floating mb-3">
                                        <input type="number" id="typeNumberMinute" class="form-control" max="59" name="duration-min"/>
                                        <label class="form-label" for="typeNumberMinute"> Duration Minute </label>
                                    </div>
                                    <!-- Height difference input -->
                                    <div class="input-group mb-3">
                                        <input type="text" class="form-control" placeholder="Height difference" aria-label="Height difference" aria-describedby="basic-addon1" name="height-difference">
                                        <div class="input-group-append">
                                            <span class="input-group-text" id="basic-addon1">m</span>
                                        </div>
                                    </div>
                                    <!-- Distance input -->
                                    <div class="input-group mb-3">
                                        <input type="text" class="form-control" placeholder="Distance" aria-label="Distance" aria-describedby="basic-addon2" step=".1" name="distance">
                                        <div class="input-group-append">
                                            <span class="input-group-text" id="basic-addon2">km</span>
                                        </div>
                                    </div>
                                    <!-- Sliders for several option inputs -->
                                    <label for="customRange1" class="form-label"> Fitness Level </label> <!-- Fitness Level -->
                                    <input type="range" class="form-range" min="1" max="5" id="customRange1" name="fitness-level">
                                    <label for="customRange2" class="form-label"> Stamina </label> <!-- Stamina -->
                                    <input type="range" class="form-range" min="1" max="5" id="customRange2" name="stamina">
                                    <label for="customRange3" class="form-label"> Experience </label> <!-- Experience -->
                                    <input type="range" class="form-range" min="1" max="5" id="customRange3" name="experience">
                                    <label for="customRange4" class="form-label"> Landscape </label> <!-- Landscape -->
                                    <input type="range" class="form-range" min="1" max="5" id="customRange4" name="scenery">

                                    <%--<label for="customRange5" class="form-label"> Preferred months </label> <!-- Preferred months -->
                                    <input type="range" class="form-range" min="1" max="11" id="customRange5">--%>

                                <button class="btn btn-primary" type="button" onclick="stepper1.previous()">Previous</button>
                                <button class="btn btn-primary" type="button" onclick="stepper1.next()">Next</button>
                            </div>
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
                                </p>
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
    <script src="JS/createHikeUploadMap.js"></script>
    <script src="JS/createHikeImage.js"></script>
    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.1/dist/umd/popper.min.js" integrity="sha384-cwmrdGZwrLYKw8X6zXkDo3MeqYTgVMiP+GxBSzLz3l2DE6/72UnZVJ8E+biqU1Kb" crossorigin="anonymous"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
    <!-- Bootstrap stepper script links -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>
    <script src="bs-stepper.min.js"></script>
    <script src="dist/js/bs-stepper.js"></script>
</body>
</html>
