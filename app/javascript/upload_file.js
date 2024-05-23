function updateFileName(input) {
    const fileName = document.getElementById('file-name');
    if (input.files.length > 0) {
        fileName.textContent = input.files[0].name;
    } else {
        fileName.textContent = 'No file uploaded';
    }
}

// Attach the event listener to the file input element after the DOM has loaded
document.addEventListener('DOMContentLoaded', () => {
    const fileInput = document.querySelector('.file-input');
    fileInput.addEventListener('change', updateFileName);
});