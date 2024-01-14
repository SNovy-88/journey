var removeBtn = document.getElementById('remove-btn');

function checkRemoveButtonVisibility() {
    var uploadedImage = document.getElementById('uploaded-image');

    if (uploadedImage.src === "") {
        // No file uploaded, hide the remove button
        removeBtn.style.display = 'none';
    } else {
        // File uploaded, show the remove button
        removeBtn.style.display = 'block';
    }
}

function removeImage() {
    const previewContainer = document.getElementById("preview-container");
    const uploadedImage = document.getElementById("uploaded-image");
    const fileInput = document.getElementById("image");

    // Clear the file input
    fileInput.value = "";

    // Hide the preview container
    previewContainer.style.display = "none";

    // Clear the image source
    uploadedImage.src = "";

    // Hide the remove button
    removeBtn.style.display = 'none';
}

function showPreview(input) {
    const fileInput = input.files[0];
    const previewContainer = document.getElementById("preview-container");
    const uploadedImage = document.getElementById("uploaded-image");

    if (fileInput) {
        const reader = new FileReader();

        reader.onload = function (e) {
            previewContainer.style.display = "block";
            uploadedImage.src = e.target.result;

            // Show the remove button
            removeBtn.style.display = 'block';
        };

        reader.readAsDataURL(fileInput);
    }
}

// Attach the showPreview function to the change event of the file input
document.getElementById("image").addEventListener("change", function () {
    showPreview(this);
});

// Call the function after the page has loaded
document.addEventListener('DOMContentLoaded', function () {
    checkRemoveButtonVisibility();
});