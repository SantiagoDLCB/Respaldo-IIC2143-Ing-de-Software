function toggleDropdown(id) {
    const dropdown = document.getElementById(id);
    dropdown.classList.toggle('is-active');
}

document.addEventListener('click', (event) => {
    const dropdowns = document.querySelectorAll('.dropdown');
    dropdowns.forEach(dropdown => {
        if (!dropdown.contains(event.target)) {
            dropdown.classList.remove('is-active');
        }
    });
});