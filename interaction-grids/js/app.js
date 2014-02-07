$(function() {
   $('.grid-data-selector a').on('click', function(e) {
      e.preventDefault();

      $(this).toggleClass('secondary');
   });
});

$(document).foundation();