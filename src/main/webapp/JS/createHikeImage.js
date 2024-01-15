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
            removeBtn.disabled = false;
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

    // Hide the preview container if the image is empty
    if (uploadedImage.src.includes("empty.png")) {
        previewContainer.style.display = "none";
    }

    // Set the image source to empty.png
    uploadedImage.src = "<%=imagePath.getImagePath()%>empty.png";
    removeBtn.disabled = true;
}

// Attach the showPreview function to the change event of the file input
document.getElementById("image").addEventListener("change", function () {
    showPreview(this);
});




