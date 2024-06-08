function openModal(id) {
  // Add is-active class on the modal
  // Clear form inputs
  // Add is-active class on the modal
  closeModal(id);
  document.getElementById(id)
    .classList.add("is-active");

}

// Function to close the modal
function closeModal(id) {

  document.getElementById(id)
    .classList.remove("is-active");
  history.pushState("", document.title, window.location.pathname);
}

// Add event listeners to close the modal
// whenever user click outside modal
document.querySelectorAll(
  ".modal-background, .modal-close,.modal-card-head .delete, .modal-card-foot .button"
).forEach(($el) => {
  const $modal = $el.closest(".modal");
  $el.addEventListener("click", () => {

    // Remove the is-active class from the modal
    $modal.classList.remove("is-active");
  });
});

// Adding keyboard event listeners to close the modal
document.addEventListener("keydown", (event) => {
  const e = event || window.event;
  if (e.keyCode === 27) {

    // Using escape key 
    closeModal();
  }
});

function handleFlashAndRedirect(message, redirectUrl) {
  // Display the flash message
  displayFlashMessage(message);

  // Redirect to the new URL
  window.location.href = redirectUrl;
}

function displayFlashMessage(message) {
  // Implementation to show flash message, e.g., using a modal or a flash message div
  alert(message); // Simple alert, replace with your flash message display logic
}