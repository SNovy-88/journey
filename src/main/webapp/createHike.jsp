<%@ page contentType="text/html;charset=UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="CSS/styles.css">
    <link rel="stylesheet" href="CSS/createHike.css">

    <!-- Slider API -->
    <link rel="stylesheet" href="CSS/bootstrap-slider.css">
    <script src="JavaScript/bootstrap-slider.js"></script>

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
    <script>
        document.addEventListener("DOMContentLoaded", function (){
            var slider = new Slider("#ex13", {
                ticks: [1, 2, 3, 4, 5],
                ticks_labels: ['1', '2', '3', '4', '5'],
                ticks_snap_bounds: 49
            });
        });
    </script>



    <!-- Stepper element -->
    <form id="createHike" action="create_hike" method="post">
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
                                    <!-- GPX Upload input -->
                                    <label class="form-label" for="customFileEnd">Upload .gpx file</label>
                                    <input type="file" class="form-control" id="customFileEnd" />
                                </p>
                                <button class="btn btn-primary" type="button" onclick="if (validateStep1()) stepper1.next()">Next</button>
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
                                            Min value needs to be under 60.
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
                                <br>

                                <!-- Sliders for several option inputs -->
                                <label class="form-label"> Physical Condition </label> <!-- Physical Condition -->
                                <br>
                                <input type="range" class="form-range" min="1" max="5" step="1" id="customRange1" >
                                <br>

                                <label for="customRange2" class="form-label"> Stamina </label> <!-- Stamina -->
                                <br>
                                <input type="range" class="form-range" min="1" max="5" id="customRange2" style="width: 600px">
                                <br>

                                <label for="customRange3" class="form-label"> Experience </label> <!-- Experience -->
                                <br>
                                <input type="range" class="form-range" min="1" max="5" id="customRange3" style="width: 600px">
                                <br>

                                <label for="customRange4" class="form-label"> Scenery </label> <!-- Scenery -->
                                <br>
                                <input type="range" class="form-range" min="1" max="5" id="customRange4" style="width: 600px">
                                <br><br>
                                <%--<label for="customRange5" class="form-label"> Preferred months </label> <!-- Preferred months -->
                                <input type="range" class="form-range" min="1" max="11" id="customRange5" style="width: 600px">--%>
                                <p>Fields marked with a <sup>*</sup> have to be filled in!</p>
                                <button class="btn btn-primary" type="button" onclick="if (validateStep2()) stepper1.next()">Next</button>
                                <button class="btn btn-primary" type="button" onclick="stepper1.previous()">Previous</button>
                            </div>

                            <!-- STEPPER 3 -->
                            <div id="test-l-3" class="content"> <!-- Content of the 3rd stepper part -->
                                <p class="text-center"> <!-- not necessary? -->
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
                                    <!-- Image input JS -->
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
                                <button class="btn btn-primary" type="button" onclick="stepper1.next()">Next</button>
                                <button class="btn btn-primary" type="button" onclick="stepper1.previous()">Previous</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Stepper JS -->
        <script>
            const stepper1Node = document.querySelector('#stepper1');
            const stepper1 = new Stepper(document.querySelector('#stepper1'));

            stepper1Node.addEventListener('show.bs-stepper', function (event) {
                console.warn('show.bs-stepper', event);
            });

            stepper1Node.addEventListener('shown.bs-stepper', function (event) {
                console.warn('shown.bs-stepper', event);
            });

            // Function for validation of Name & Description input
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


            const stepper2 = new Stepper(document.querySelector('#stepper2'), {
                linear: false,
                animation: true
            });
            <!-- TODO -->
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


            const stepper3 = new Stepper(document.querySelector('#stepper3'), {
                animation: true
            });

            //const stepper4 = new Stepper(document.querySelector('#stepper4'));
        </script>

        <!-- Bootstrap stepper script links -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>
        <script src="bs-stepper.min.js"></script>
        <script src="dist/js/bs-stepper.js"></script>

        <!-- GraphHopper implementation -->
    <!--
        // Include Leaflet CSS
        <link rel="stylesheet" href="https://unpkg.com/leaflet/dist/leaflet.css" />

        // Include Leaflet JavaScript
        <script src="https://unpkg.com/leaflet/dist/leaflet.js"></script>

        // Add a div for the map
        <div id="map" style="height: 400px;"></div>

        // Add a button to trigger route calculation
        <button onclick="calculateRoute()">Calculate Route</button>

        <script>
            // Initialize the map
            var map = L.map('map').setView([47.366260, 9.746780], 13);

            // Add a base map layer (you can choose other tile providers)
            L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png').addTo(map);

            L.marker([47.366260, 9.746780]).addTo(map)
                .bindPopup('A pretty CSS popup.<br> Easily customizable.')
                .openPopup();

            // Initialize GraphHopper
            var gh = new GraphHopper();

            // Function to calculate route
            function calculateRoute() {
                // Get waypoints or use predefined waypoints
                var waypoints = [
                    { lat: 47.366260, lon: 9.746780 },  // Example waypoint 1
                    { lat: 47.387800, lon: 9.750780 }   // Example waypoint 2
                ];

                // Call GraphHopper API to calculate the route
                gh.calculateRoute({
                    points: waypoints,
                    vehicle: 'foot',  // Specify the vehicle type (foot for hiking)
                    callback: async function (json) {
                        const query = new URLSearchParams({
                            key: '493c4835-011d-4938-a7cb-ec0ce63b6940'
                        }).toString();

                        const resp = await fetch(
                            `https://graphhopper.com/api/1/route?${query}`,
                            {
                                method: 'POST',
                                headers: {
                                    'Content-Type': 'application/json'
                                },
                                body: JSON.stringify({
                                    points: [
                                        [9.746780, 47.366260],
                                        [9.750780, 47.387800]
                                    ],
                                    point_hints: [
                                        'Lindenschmitstraße',
                                        'Thalkirchener Str.'
                                    ],
                                    snap_preventions: [
                                        'motorway',
                                        'ferry',
                                        'tunnel'
                                    ],
                                    details: ['road_class', 'surface'],
                                    vehicle: 'bike',
                                    locale: 'en',
                                    instructions: true,
                                    calc_points: true,
                                    points_encoded: false
                                })
                            }
                        );

                        const data = await resp.json();
                        console.log(data);
                        console.log(json);
                    }
                });
            }
        </script>
    -->

        <div id="map" style="height: 400px;"></div> <!-- Show Map -->
        <button type="button" onclick="exportAsGPX()"> Export as GPX </button> <!-- Export button -->
        <button type="submit" onclick="createHike()">Create Hike</button> <!-- Create Hike button -->
        <ul id="coordinates-list"></ul> <!-- List of waypoints -->

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
        <input type="hidden" id="gpxDataInput" name="gpxData"> <!-- hidden input element for transferring gpxData from JS into JSP form element -->
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

    <!-- JS for map logic -->
    <script>
        // Initialize the map
        const map = L.map('map').setView([47, 11], 7); // Set the initial view

        // Add a tile layer to the map (you can choose a different tile provider)
        L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
            attribution: '&copy; OpenStreetMap contributors'
        }).addTo(map);

        // Initialize an empty array to store waypoints
        const waypoints = [];

        // Initialize a polyline to connect waypoints with lines
        const polyline = L.polyline([], {color: 'blue'}).addTo(map);

        // Get the <ul> element to display coordinates
        const coordinatesList = document.getElementById('coordinates-list');

        // Get the modal and input elements
        const waypointModal = document.getElementById('waypointModal');
        const waypointNameInput = document.getElementById('waypointNameInput');

        // Flag to track unsaved changes
        let unsavedChanges = false;

        // Initialize a variable to store GPX data
        let cachedGPXData = '';

        // Add a click event listener to the map
        map.on('click', function (e) {
            // Open the modal when the map is clicked
            $('#waypointModal').modal('show');

            // Store the clicked location in a variable
            const clickedLatLng = e.latlng;

            // Set up a click event listener for the "Add Waypoint" button in the modal
            $('#waypointModal').on('shown.bs.modal', function () {
                $('#waypointNameInput').focus();
            });

            // Set up a click event listener for the "Cancel" button in the modal
            $('#waypointModal .btn-secondary').on('click', function () {
                // Close the modal without adding the waypoint
                $('#waypointModal').modal('hide');
                unsavedChanges = false;
            });

            $('#waypointModal').on('hidden.bs.modal', function () {
                // Clear the input field when the modal is closed
                waypointNameInput.value = '';
            });

            // Function to be called when the "Add Waypoint" button is clicked
            window.addWaypoint = function () {
                // Get the waypoint name from the input field
                const waypointName = waypointNameInput.value;

                // Close the modal
                $('#waypointModal').modal('hide');

                // Add a marker at the clicked location
                const marker = L.marker(clickedLatLng).addTo(map);

                // Store the waypoint in the array with name
                waypoints.push({ name: waypointName, latlng: clickedLatLng });

                // Update the polyline with the new waypoint
                polyline.setLatLngs(waypoints.map(wp => wp.latlng));

                // If there are at least two waypoints, zoom the map to fit all waypoints
                if (waypoints.length === 2) {
                    map.fitBounds(polyline.getBounds());
                }

                // Update the coordinates list
                updateCoordinatesList();

                // Set the flag for unsaved changes
                unsavedChanges = true;

                // Create GPX data and update the hidden input field
                cachedGPXData = createGPX();
            };
        });

        // Function to update the coordinates list
        function updateCoordinatesList() {
            // Clear the existing list
            coordinatesList.innerHTML = '';

            // Add coordinates to the list
            waypoints.forEach(function (waypoint, index) {
                const li = document.createElement('li');
                li.textContent = 'Waypoint ' + (index + 1) + ': ' + waypoint.name + ' (' + waypoint.latlng.lat + ', ' + waypoint.latlng.lng + ')';
                coordinatesList.appendChild(li);
            });
        }

        // Function to export waypoints as GPX
        function exportAsGPX() {
            // Create a Blob with the GPX data
            const blob = new Blob([cachedGPXData], {type: 'application/gpx+xml'});

            // Create a link for downloading the GPX file
            const link = document.createElement('a');
            link.href = URL.createObjectURL(blob);
            link.download = 'waypoints.gpx';
            link.click();
        }

        // Function to create waypoints as GPX single-handedly
        function createGPX() {
            return '<?xml version="1.0" encoding="UTF-8" standalone="no" ?>' +
                '<gpx version="1.1" creator="Journey">' +
                waypoints.map(function (waypoint, index) {
                    return '<wpt lat="' + waypoint.latlng.lat + '" lon="' + waypoint.latlng.lng + '">' + '<name>' + waypoint.name + '</name>' + '</wpt>';
                }).join('') +
                '</gpx>';
        }

        // Function to update the hidden input field with cached GPX data
        function updateGPXInput() {
            document.getElementById('gpxDataInput').value = cachedGPXData;
        }

        // Function to create hike and send GPX data to the servlet
        function createHike() {
            // Reset the flag
            unsavedChanges = false;

            // Update the hidden input field with cached GPX data
            updateGPXInput();
        }

        // Attach a beforeunload event to show a toast-pop-up warning if there are unsaved changes
        window.addEventListener('beforeunload', function (e) {
            if (unsavedChanges) {
                const confirmationMessage = 'You have unsaved changes. Are you sure you want to leave?';
                (e || window.event).returnValue = confirmationMessage; // Standard
                return confirmationMessage; // IE and Firefox
            }
        });

        // Check if the URL contains a success parameter
        const urlParams = new URLSearchParams(window.location.search);
        const successParam = urlParams.get('success');

        // If the success parameter is present, show the success modal
        if (successParam === 'true') {
            $(document).ready(function () {
                $('#successModal').modal('show');
            });
        }
    </script>

    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.1/dist/umd/popper.min.js" integrity="sha384-cwmrdGZwrLYKw8X6zXkDo3MeqYTgVMiP+GxBSzLz3l2DE6/72UnZVJ8E+biqU1Kb" crossorigin="anonymous"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>

    <!-- Include GraphHopper JavaScript
    <script src="https://graphhopper.com/api/1/client/js/graphhopper-client.js?key=493c4835-011d-4938-a7cb-ec0ce63b6940"></script>
    -->
</body>
</html>
