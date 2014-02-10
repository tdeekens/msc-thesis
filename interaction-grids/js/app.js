$(function() {
   window.apiParams = {
      startWeek: 1,
      startDay: 1,
      endWeek: 4,
      endDay: 5,
      roles: ["XFT1", "XFT2", "OPO", "APO", "TPO", "LN", "DM", "SM"]
   };

   $('.grid-data-selector a').on('click', function(e) {
      e.preventDefault();

      $(this).toggleClass('secondary');

      apiParams.roles = [];
      $('.grid-data-selector a')
         .filter(':not(.secondary):not(.alert)').each(function(idx, elem) {
            apiParams.push($(elem).data('apiparam'));
         });
   });

   $('.grid-range-selector .f-dropdown a').on('click', function(e) {
      e.preventDefault();

      var $this   = $(this);
      var $parent = $this.parents('ul');

      apiParams[$parent.data('apiparam')] = $this.data('apiparam');
   });

   $('#js-draw').on('click', function(e) {
      e.preventDefault();

      console.log(apiParams);
   });
});

$(document).foundation();