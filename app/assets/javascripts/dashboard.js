// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

$.ready().then(function() { 

  var userName = document.querySelector(".user-name");
  var menu = document.querySelector('.menu-card');

  userName.addEventListener("click", function(event) {
    menu.classList.toggle('dropdown-open');
    clearTimeout(timer)
    event.preventDefault();
    return false;
  });

  menu.addEventListener("mouseout", function(event) {
    timer = setTimeout(function(event) {
      menu.classList.remove('dropdown-open');
    }, 2000);
  });

  document.addEventListener("keyup", event => {
    if (event.key === "Escape") {
      menu.classList.remove('dropdown-open');
      clearTimeout(timer)
      return false;
    }
  });

});

