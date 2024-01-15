// Function to show the image on screen
function showPreview(input) {
    const fileInput = input.files[0];
    const previewContainer = document.getElementById("preview-container");
    const uploadedImage = document.getElementById("uploaded-image");
    const removeBtn = document.getElementById("remove-btn");
    const imageUploadFeedback = document.getElementById('imageUploadFeedback');

    // Clear previous feedback
    imageUploadFeedback.style.display = 'none';

    if (fileInput) {
        const isFileExtensionValid = fileInput.name.toLowerCase().endsWith('.jpg');

        if (!isFileExtensionValid) {
            imageUploadFeedback.textContent = 'Please upload a valid .jpg file.';
            imageUploadFeedback.style.display = 'block';
            return;
        }

        const reader = new FileReader();

        reader.onload = function (e) {
            previewContainer.style.display = "block";
            uploadedImage.src = e.target.result;
            uploadedImage.style.display = "block";
            removeBtn.style.display = "block";
        };

        reader.readAsDataURL(fileInput);
    }
}

// Function to remove the image from screen
function removeImage() {
    const previewContainer = document.getElementById("preview-container");
    const uploadedImage = document.getElementById("uploaded-image");
    const fileInput = document.getElementById("image");
    const removeBtn = document.getElementById("remove-btn");
    const imageUploadFeedback = document.getElementById('imageUploadFeedback');

    // Clear the file input
    fileInput.value = "";

    if (uploadedImage.src.includes("")) {
        previewContainer.style.display = "none";
        removeBtn.style.display = "none";
        imageUploadFeedback.style.display = 'none';
    }

    uploadedImage.src = "";
}