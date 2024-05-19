// Function to open the modal
function openModal(id) {
  // Add is-active class on the modal
  document.getElementById(id)
    .classList.add("is-active");
}

// Function to close the modal
function closeModal(id) {
  document.getElementById(id)
    .classList.remove("is-active");
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
