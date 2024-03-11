document.addEventListener('DOMContentLoaded', function() {
    var menuToggle = document.querySelector('.menu-toggle');
    var sidebar = document.querySelector('.sidebar');

    menuToggle.addEventListener('click', function() {
        if (sidebar.style.right === '0px') {
            sidebar.style.right = '-250px';
        } else {
            sidebar.style.right = '0px';
        }
    });
});