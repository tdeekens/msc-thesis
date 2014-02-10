var api = {};

;(function(){
   var mongo = require('mongoskin');

   var db = mongo.db('localhost:27017/msc-interaction-grids?auto_reconnect', {safe:true});

   var fetch = function(callback, options) {
      var defaults = {
         startWeek: 1,
         startDay: 1,
         endWeek: 4,
         endDay: 5,
         roles: ["XFT1", "XFT2", "OPO", "APO", "TPO", "LN", "DM", "SM"]
      };

      var options = _.assign(defaults, options);

      var startMonthDay = (options.startDay + 2) * options.startWeek;
      var endMonthDay   = (options.endDay + 2) * options.endWeek;

      db.collection('grids').find({
         'conversations.createdAt': {'$gte': new Date(2014, 2, startMonthDay), '$lte': new Date(2014, 2, endMonthDay)},
         'conversations.role': {"$in": options.roles}
      }, function(err, response) {
         if (err) throw err;
         else { callback(response); }
      });
   };

   api.fetch = fetch;
})();