<%@ page import="at.fhv.journey.utils.imagePath" %>
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="favicon.jsp" %>
<!DOCTYPE html>
<html lang="en" accept-language="en">
    <head>
        <meta charset="UTF-8">
        <link rel="stylesheet" href="CSS/styles.css">
        <link rel="stylesheet" href="CSS/createHike.css">

        <title> Journey | Create your hike </title>

        <!-- Additional Bootstrap JavaScript -->
        <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>

        <!-- Additional Bootstrap stepper JavaScript -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>

        <!-- Bootstrap -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">

        <!-- Bootstrap stepper JavaScript & CSS -->
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
        <script src="JS/attributeIcons.js"></script> <!-- Remaining JavaScript at the end of the file -->
        <form id="createHike" action="create_hike" method="post" enctype="multipart/form-data">
            <div class="container"> <!-- Start of 3-step form element -->
                <div class="row">
                    <div class="col-md-12 mt-5">
                        <h2> Create your own journey: </h2>
                        <div id="stepper1" class="bs-stepper">
                            <!-- Stepper header -->
                            <div class="bs-stepper-header">
                                <div class="step" data-target="#test-l-1">
                                    <button type="button" class="btn step-trigger">
                                        <span class="bs-stepper-circle"> 1 </span>
                                        <span class="bs-stepper-label"> General Info </span>
                                    </button>
                                </div>
                                <div class="line"></div>
                                <div class="step" data-target="#test-l-2">
                                    <button type="button" class="btn step-trigger">
                                        <span class="bs-stepper-circle"> 2 </span>
                                        <span class="bs-stepper-label"> Description </span>
                                    </button>
                                </div>
                                <div class="line"></div>
                                <div class="step" data-target="#test-l-3">
                                    <button type="button" class="btn step-trigger">
                                        <span class="bs-stepper-circle"> 3 </span>
                                        <span class="bs-stepper-label"> Images </span>
                                    </button>
                                </div>
                            </div>
                            <!-- Stepper content -->
                            <div class="bs-stepper-content">
                                <!-- Content of the 1st stepper part -->
                                <div id="test-l-1" class="content">
                                    <!-- Name input -->
                                    <div class="invalid-feedback" id="inputFeedback">
                                        Please choose a title.
                                    </div>
                                    <div class="form-floating mb-3">
                                        <input class="form-control" id="floatingInput" name="nameInput" placeholder="Name your hike here">
                                        <label for="floatingInput"> Title </label>
                                    </div>
                                    <!-- Description input -->
                                    <div class="invalid-feedback" id="textareaFeedback">
                                        Please choose a description.
                                    </div>
                                    <div class="form-floating mb-3">
                                        <textarea class="form-control" placeholder="Leave a description here" id="floatingTextarea2" name="descInput" style="height: 150px" data-mdb-showcounter="true" maxlength="500"></textarea>
                                        <label for="floatingTextarea2"> Description </label>
                                    </div>
                                    <br>
                                    <!-- Geo data (map) input -->
                                    <div class="row">
                                        <div class="col-md-3">
                                            <!-- Bootstrap On/Off switch to enable/disable map-features -->
                                            <div class="form-check form-switch">
                                                <input class="form-check-input" type="checkbox" role="switch" id="featureSwitch">
                                                <label class="form-check-label" for="featureSwitch"> Enable to upload a .gpx file </label>
                                            </div>
                                        </div>
                                        <div class="col-md-9">
                                            <input type="hidden" id="switchState" name="switchState" value="map"> <!-- Hidden input to store the switch state -->
                                            <!-- GPX Upload input (initially hidden) -->
                                            <div class="invalid-feedback" id="fileUploadFeedback">
                                                Please choose a file.
                                            </div>
                                            <div id="fileUploadFeature" style="display: none;">
                                                <div class="input-group custom-file-upload-container" style="width: 75%;">
                                                    <input type="file" class="form-control" id="customFileEnd" name="gpxDataUpload"/>
                                                    <button type="button" class="btn btn-secondary" onclick="resetFileInput()"> Reset </button>
                                                    <button type="button" class="btn btn-primary" onclick="showRoute()"> Show Route </button>
                                                </div>
                                                <br>
                                            </div>
                                        </div>
                                    </div>
                                    <div id="mapContainer" style="display: none;">
                                        <div id="messageContainer" class="d-flex align-items-center justify-content-center">
                                            <p> Insert a .gpx file and click on 'Show route' to make the map appear. </p>
                                        </div>
                                        <div id="uploadMap" style="height: 500px;"></div>
                                    </div>
                                    <br>
                                        <!-- Manual map input -->
                                        <div id="mapFeature">
                                            <br>
                                            <div>
                                                <p>
                                                    Create your route by adding waypoints to the map! (Hint: Use your mouse to drag a pin after adding it to the map)
                                                </p>
                                            </div>
                                            <div class="invalid-feedback" id="mapFeedback">
                                                Route needs to have at least two waypoints.
                                            </div>
                                            <div id="map" style="height: 500px;"></div>
                                            <input type="hidden" id="gpxDataInput" name="gpxDataInput"> <!-- Hidden input element for transferring gpxData from JavaScript into JSP form element -->
                                            <br>
                                            <button class="btn btn-secondary" type="button" onclick="exportAsGPX()"> Export as GPX </button>
                                            <button class="btn btn-danger" type="button" onclick="deleteLastWaypoint()"> Delete Last Waypoint </button>
                                            <br><br>
                                            <table id="coordinates-table" class="table table-sm table-hover border table-borderless"></table> <!-- Coordinate table under the map -->
                                        </div>
                                    <button class="btn btn-primary" type="button" onclick="if (validateStep1()) nextButtonClick()"> Next </button>
                                </div>
                                <!-- Content of the 2nd stepper part -->
                                <div id="test-l-2" class="content">
                                    <div class="row g-2" style="margin-top: 30px">
                                        <!-- Group for Duration hr and min -->
                                        <label for="duration-hr" class="form-label"> Duration (autom. calculated) </label>
                                        <div class="col-md-2">
                                            <div class="input-group">
                                                <input type="number" aria-label="duration-hour" class="form-control" id="duration-hr" pattern="\d+" inputmode="numeric" step="1" min="0" name="duration-hr" readonly>
                                                <span class="input-group-text"> hr </span>
                                                <input type="number" aria-label="duration-min" class="form-control" id="duration-min" pattern="\d+" inputmode="numeric" step="1" min="0" max="59" name="duration-min" readonly>
                                                <span class="input-group-text"> min </span>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row g-1" style="margin-top: 30px">
                                        <!-- Height difference input -->
                                        <label for="height-difference" class="form-label"> Height Difference (autom. calculated) </label>
                                        <div class="col-md-2">
                                            <div class="input-group">
                                                <input type="number" pattern="\d+" aria-label="height-difference" class="form-control" id="height-difference" name="height-difference" readonly>
                                                <span class="input-group-text"> m </span>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row g-1" style="margin-top: 30px">
                                        <!-- Distance input -->
                                        <label for="distance" class="form-label"> Distance (autom. calculated) </label>
                                        <div class="col-md-2">
                                            <div class="input-group">
                                                <input type="number" aria-label="distance" class="form-control" id="distance" name="distance" step="any" readonly>
                                                <span class="input-group-text"> km </span>
                                            </div>
                                        </div>
                                    </div>
                                    <br><hr>
                                    <!-- Drop Down Elements -->
                                    <!-- Fitness Level -->
                                    <label class="form-label"> Fitness Level <sup> * </sup></label>
                                    <br>
                                    <div class="invalid-feedback" id="fitness-feedback">
                                        Please choose an option.
                                    </div>
                                    <div class="row g-2" id="fitness-container">
                                        <input type="hidden" id="drop-down-btn-fitness-hidden" name ="fitness-level" value="0"> <!-- Hidden input element for transferring fitness level from JavaScript into JSP form element -->
                                        <div class="col-md-3">
                                            <div class="btn-group dropend">
                                                <button id="drop-down-btn-fitness" data-id="fitness" chosen-value-id="" type="button" class="btn btn-primary dropdown-toggle" data-bs-toggle="dropdown" aria-expanded="false">
                                                    Select an option
                                                </button>
                                                <ul class="dropdown-menu">
                                                    <!-- UpdateDropdown(dropdown Button(to change title), this option (to highlight it)) -->
                                                    <li><a class="dropdown-item" href="javascript:void(0)" onclick="updateDropdown('drop-down-btn-fitness', this)" data-id="1"> Easy </a></li>
                                                    <li><a class="dropdown-item" href="javascript:void(0)" onclick="updateDropdown('drop-down-btn-fitness', this)" data-id="2"> Moderate </a></li>
                                                    <li><a class="dropdown-item" href="javascript:void(0)" onclick="updateDropdown('drop-down-btn-fitness', this)" data-id="3"> Intermediate </a></li>
                                                    <li><a class="dropdown-item" href="javascript:void(0)" onclick="updateDropdown('drop-down-btn-fitness', this)" data-id="4"> Expert </a></li>
                                                    <li><a class="dropdown-item" href="javascript:void(0)" onclick="updateDropdown('drop-down-btn-fitness', this)" data-id="5"> Challenging </a></li>
                                                </ul>
                                            </div>
                                        </div>
                                        <div class="col-md-3" id="fitness-icons">
                                        </div>
                                    </div>
                                    <br>
                                    <!-- Stamina -->
                                    <label class="form-label"> Stamina <sup> * </sup></label>
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
                                                    <!-- updateDropdown(dropdown Button(to change title), this option (to highlight it), category (to get right icons)) -->
                                                    <li><a class="dropdown-item" href="javascript:void(0)" onclick="updateDropdown('drop-down-btn-stamina', this)" data-id="1"> Untrained </a></li>
                                                    <li><a class="dropdown-item" href="javascript:void(0)" onclick="updateDropdown('drop-down-btn-stamina', this)" data-id="2"> Moderate </a></li>
                                                    <li><a class="dropdown-item" href="javascript:void(0)" onclick="updateDropdown('drop-down-btn-stamina', this)" data-id="3"> Intermediate </a></li>
                                                    <li><a class="dropdown-item" href="javascript:void(0)" onclick="updateDropdown('drop-down-btn-stamina', this)" data-id="4"> Athletic </a></li>
                                                    <li><a class="dropdown-item" href="javascript:void(0)" onclick="updateDropdown('drop-down-btn-stamina', this)" data-id="5"> Elite </a></li>
                                                </ul>
                                            </div>
                                        </div>
                                        <div class="col-md-3" id="stamina-icons">
                                            <!-- Function call to fill out the right amount of icons based on dropdown value -->
                                            <script>
                                                document.addEventListener("DOMContentLoaded", function () {
                                                    insertIcons(0, staminaFullIcon, staminaEmptyIcon, 'stamina-icons');
                                                });
                                            </script>
                                        </div>
                                    </div>
                                    <br>
                                    <!-- Experience -->
                                    <label class="form-label"> Experience <sup> * </sup></label>
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
                                                    <!-- updateDropdown(dropdown Button(to change title), this option (to highlight it), category (to get right icons)) -->
                                                    <li><a class="dropdown-item" href="javascript:void(0)" onclick="updateDropdown('drop-down-btn-experience', this)" data-id="1"> Novice </a></li>
                                                    <li><a class="dropdown-item" href="javascript:void(0)" onclick="updateDropdown('drop-down-btn-experience', this)" data-id="2"> Practised </a></li>
                                                    <li><a class="dropdown-item" href="javascript:void(0)" onclick="updateDropdown('drop-down-btn-experience', this)" data-id="3"> Intermediate </a></li>
                                                    <li><a class="dropdown-item" href="javascript:void(0)" onclick="updateDropdown('drop-down-btn-experience', this)" data-id="4"> Experienced </a></li>
                                                    <li><a class="dropdown-item" href="javascript:void(0)" onclick="updateDropdown('drop-down-btn-experience', this)" data-id="5"> Expert </a></li>
                                                </ul>
                                            </div>
                                        </div>
                                        <div class="col-md-3" id="experience-icons">
                                            <!-- Function call to fill out the right amount of icons based on dropdown value -->
                                            <script>
                                                document.addEventListener("DOMContentLoaded", function () {
                                                    insertIcons(0, experienceFullIcon, experienceEmptyIcon, 'experience-icons');
                                                });
                                            </script>
                                        </div>
                                    </div>
                                    <br>
                                    <!-- Landscape -->
                                    <label class="form-label"> Scenery <sup> * </sup></label>
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
                                                    <li><a class="dropdown-item" href="javascript:void(0)" onclick="updateDropdown('drop-down-btn-scenery', this)" data-id="1"> Unremarkable </a></li>
                                                    <li><a class="dropdown-item" href="javascript:void(0)" onclick="updateDropdown('drop-down-btn-scenery', this)" data-id="2"> Ordinary </a></li>
                                                    <li><a class="dropdown-item" href="javascript:void(0)" onclick="updateDropdown('drop-down-btn-scenery', this)" data-id="3"> Enjoyable </a></li>
                                                    <li><a class="dropdown-item" href="javascript:void(0)" onclick="updateDropdown('drop-down-btn-scenery', this)" data-id="4"> Beautiful </a></li>
                                                    <li><a class="dropdown-item" href="javascript:void(0)" onclick="updateDropdown('drop-down-btn-scenery', this)" data-id="5"> Stunning </a></li>
                                                </ul>
                                            </div>
                                        </div>
                                        <div class="col-md-3" id="scenery-icons">
                                            <!-- Function call to fill out the right amount of icons based on dropdown value -->
                                            <script>
                                                document.addEventListener("DOMContentLoaded", function () {
                                                    insertIcons(0, sceneryFullIcon, sceneryEmptyIcon, 'scenery-icons');
                                                });
                                            </script>
                                        </div>
                                    </div>
                                    <br>
                                    <label> Hike recommended in: </label>
                                    <br>
                                    <!-- - Checkboxes for month input -->
                                    <div class="form-check" id="check-box">
                                        <div class="container text-lg-start">
                                            <div class="row">
                                                <div class="col-md-2">
                                                    <input class="form-check-input" type="checkbox" name="Jan" value="1" id="Jan">
                                                    <label class="form-check-label" for="Jan">
                                                        January
                                                    </label>
                                                </div>
                                                <div class="col-md-2">
                                                    <input class="form-check-input" type="checkbox" name="Apr" value="8" id="Apr">
                                                    <label class="form-check-label" for="Apr">
                                                        April
                                                    </label>
                                                </div>
                                                <div class="col-md-2">
                                                    <input class="form-check-input" type="checkbox" name="Jul" value="64" id="Jul">
                                                    <label class="form-check-label" for="Jul">
                                                        July
                                                    </label>
                                                </div>
                                                <div class="col-md-2">
                                                    <input class="form-check-input" type="checkbox" name="Oct" value="512" id="Oct">
                                                    <label class="form-check-label" for="Oct">
                                                        October
                                                    </label>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-md-2">
                                                    <input class="form-check-input" type="checkbox" name="Feb" value="2" id="Feb">
                                                    <label class="form-check-label" for="Feb">
                                                        February
                                                    </label>
                                                </div>
                                                <div class="col-md-2">
                                                    <input class="form-check-input" type="checkbox" name="May" value="16" id="May">
                                                    <label class="form-check-label" for="May">
                                                        May
                                                    </label>
                                                </div>
                                                <div class="col-md-2">
                                                    <input class="form-check-input" type="checkbox" name="Aug" value="128" id="Aug">
                                                    <label class="form-check-label" for="Aug">
                                                        August
                                                    </label>
                                                </div>
                                                <div class="col-md-2">
                                                    <input class="form-check-input" type="checkbox" name="Nov" value="1024" id="Nov">
                                                    <label class="form-check-label" for="Nov">
                                                        November
                                                    </label>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-md-2">
                                                    <input class="form-check-input" type="checkbox" name="Mar" value="4" id="Mar">
                                                    <label class="form-check-label" for="Mar">
                                                        March
                                                    </label>
                                                </div>
                                                <div class="col-md-2">
                                                    <input class="form-check-input" type="checkbox" name="Jun" value="32" id="Jun">
                                                    <label class="form-check-label" for="Jun">
                                                        June
                                                    </label>
                                                </div>
                                                <div class="col-md-2">
                                                    <input class="form-check-input" type="checkbox" name="Sep" value="256" id="Sep">
                                                    <label class="form-check-label" for="Sep">
                                                        September
                                                    </label>
                                                </div>
                                                <div class="col-md-2">
                                                    <input class="form-check-input" type="checkbox" name="Dec" value="2048" id="Dec">
                                                    <label class="form-check-label" for="Dec">
                                                        December
                                                    </label>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <br>
                                 <p> Fields marked with a <sup> * </sup> have to be filled in! </p>
                                    <button class="btn btn-primary" type="button" onclick="stepper1.previous()"> Previous </button>
                                    <button class="btn btn-primary" type="button" onclick="if (validateStep2()) stepper1.next()"> Next </button>
                                </div>
                                <!-- Content of the 3rd stepper part -->
                                <div id="test-l-3" class="content">
                                        <script class="jsbin" src="https://ajax.googleapis.com/ajax/libs/jquery/1/jquery.min.js"></script>
                                    <form id="image-form" enctype="multipart/form-data" class="btn btn-primary">
                                        <label for="image">Upload Image:</label>
                                        <br>
                                        <input type="file" id="image" name="image" accept=".jpg, image/*">
                                    </form>
                                    <br>

                                    <div id="preview-container">
                                        <img id="uploaded-image" src="<%=imagePath.getImagePath()%>empty.png" alt="Uploaded Image">
                                        <br>
                                        <div id="remove-btn" class="btn btn-primary" onclick="removeImage()" disabled>Remove Image</div>
                                    </div>

                                    <script>
                                        function showPreview(input) {
                                            const fileInput = input.files[0];
                                            const previewContainer = document.getElementById("preview-container");
                                            const uploadedImage = document.getElementById("uploaded-image");
                                            const removeBtn = document.getElementById("remove-btn");

                                            if (fileInput) {
                                                const reader = new FileReader();

                                                reader.onload = function (e) {
                                                    previewContainer.style.display = "block";
                                                    uploadedImage.src = e.target.result;
                                                    removeBtn.desabled = false;
                                                };

                                                reader.readAsDataURL(fileInput);
                                            }
                                        }

                                        function removeImage() {
                                            const previewContainer = document.getElementById("preview-container");
                                            const uploadedImage = document.getElementById("uploaded-image");
                                            const fileInput = document.getElementById("image");
                                            const removeBtn = document.getElementById("remove-btn");

                                            // Clear the file input
                                            fileInput.value = "";

                                            // Hide the preview container
                                            previewContainer.style.display = "block";

                                            // Clear the image source
                                            uploadedImage.src = "<%=imagePath.getImagePath()%>empty.png";
                                            removeBtn.disabled = true;
                                        }

                                        // Attach the showPreview function to the change event of the file input
                                        document.getElementById("image").addEventListener("change", function () {
                                            showPreview(this);
                                        });
                                    </script>
                                    <br>

                                    <button class="btn btn-primary" type="button" onclick="stepper1.previous()">Previous</button>
                                    <button class="btn btn-success" type="submit" onclick="createHike()">Create Hike</button>
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
                            <h5 class="modal-title" id="waypointModalLabel"> Enter Waypoint Information </h5>
                        </div>
                        <div class="modal-body">
                            <label for="waypointNameInput"> Waypoint Name: </label>
                            <input type="text" id="waypointNameInput" class="form-control" placeholder="Enter name (optional)">
                            <br>
                            <label for="waypointTypeSelect"> Select Waypoint Type: </label>
                            <select id="waypointTypeSelect" class="form-control">
                                <option value="standard"> Standard Waypoint </option>
                                <option value="poi"> Point of Interest </option>
                                <option value="hut"> Hut / Refuge </option>
                            </select>
                            <br>
                            <label for="waypointDescriptionInput"> Waypoint Description: </label>
                            <textarea id="waypointDescriptionInput" class="form-control" placeholder="Enter description (optional)"></textarea>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-dismiss="modal"> Cancel </button>
                            <button type="button" class="btn btn-primary" onclick="addWaypoint()"> Add Waypoint </button>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Bootstrap pop-up-modal for the success popup -->
            <div class="modal fade" id="successModal" tabindex="-1" role="dialog" aria-labelledby="successModalLabel" aria-hidden="true">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="successModalLabel"> Success </h5>
                        </div>
                        <div class="modal-body">
                            Hike successfully created!
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-primary" data-bs-dismiss="modal"> Close </button>
                        </div>
                    </div>
                </div>
            </div>
        </form>

        <!-- Additional JavaScript imports -->
        <script src="JS/createHike.js"></script>
        <script src="JS/createHikeMap.js"></script>
        <script src="JS/createHikeUploadMap.js"></script>
        <script src="JS/parseGPX.js"></script>
        <script src="JS/waypointIcons.js"></script>
        <script src="JS/fetchRoute.js"></script>
        <script src="JS/ORS_API_KEY.js"></script>
        <script src="JS/createHikeImage.js"></script>

    </body>
</html>