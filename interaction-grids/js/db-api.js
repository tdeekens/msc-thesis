var api = {};

;(function(){
   var MongoClient = require('mongodb').MongoClient
   var       _     = require("lodash");

   var dbUri = 'mongodb://localhost:27017/msc-interaction-grids';

   var aggregateRoles = function(callback, options) {
      var options = getParams(options),
          responseCache = {};

      var totalIntensity = function() {
         MongoClient.connect(dbUri, function(err, db) {
            if(err) throw err;

            db.collection('grids', function(err, grids) {
               grids.aggregate([
                  { $match: {
                     'conversations.role': {'$in': options.roles}/*,
                     'conversations.createdAt': {
                        '$gte': new Date(2014, options.startMonth, options.startMonthDay),
                        '$lte': new Date(2014, options.endMonth, options.endMonthDay)
                     }*/
                  }},
                  { $unwind: '$conversations' },
                  { $group: {
                     _id: null,
                     totalIntensity: {
                        $sum: '$conversations.intensity'
                     }
                  }}
                ], function(err, response) {
                  if (err) throw err;
                  else {
                     options.totalIntensity       = response[0].totalIntensity;
                     responseCache.totalIntensity = response[0].totalIntensity;

                     db.close();

                     calculateRoleIntensities(options);
                  };
               });
            });
         });
      };

      var calculateRoleIntensities = function(options) {
         var lastRole = _.last(options.roles);
         responseCache.roleIntensities = {};

         _.each(options.roles, function(roleX, idxX) {
            options.role = roleX;

            _.each(options.roles, function(roleY, idxY) {
               options.conversationRole = roleY;

               aggregateRole(responseCache, function(response) {
                  responseCache[roleX + "-" + roleY] = response;

                  if ( roleX === lastRole && roleY === lastRole ) { callback(responseCache); }
               }, options);
            });
         });
      };

      totalIntensity();
   };

   var aggregateRole = function(responseCache, callback, options) {
      var options         = getParams(options),
          partialResponse = {};

      MongoClient.connect(dbUri, function(err, db) {
         if(err) throw err;

         db.collection('grids', function(err, grids) {
            grids.aggregate([
               { $match: {
                  role : options.role,
                  'conversations.role': options.conversationRole/*,
                  'conversations.createdAt': {
                     '$gte': new Date(2014, options.startMonth, options.startMonthDay),
                     '$lte': new Date(2014, options.endMonth, options.endMonthDay)
                  }*/
               }},
               { $unwind: "$conversations" },
               { $group: {
                  _id: '$role',
                  roleIntensity: {
                     $sum: '$conversations.intensity'
                  }
               }}
            ], function(err, response) {
               if (err) throw err;
               else {
                  var gridCell = {};

                  _.each(response, function(elem, idx) {
                     gridCell = {
                        absolute: elem.roleIntensity,
                        percentage: elem.roleIntensity / responseCache.totalIntensity,
                        color: undefined
                     };

                     gridCell.percentage  = Math.round(gridCell.percentage * 100) / 100
                     gridCell.color       = colorCode(gridCell.percentage);
                  });

                  db.close();

                  callback(gridCell);
               };
            });
         });
      });
   };

   var colorCode = function(percentage) {
      var hue = ( (1 - percentage) * 120 ).toString(10);

      return ["hsl(",hue,",100%,50%)"].join("");
   };

   var getParams = function(options) {
      var defaults = {
         startMonth: 0,
         endMonth: 2,
         startWeek: 1,
         startDay: 1,
         endWeek: 4,
         endDay: 5,
         roles: ["XFT1", "XFT2", "OPO", "APO", "TPO", "LN", "DM", "SM"]
      };

      var options = _.assign(defaults, options);

      var startMonthDay = (options.startDay + 2) * options.startWeek;
      var endMonthDay   = (options.endDay + 2) * options.endWeek;

      options.startMonthDay = startMonthDay;
      options.endMonthDay = endMonthDay;

      return options;
   };

   api.aggregate = aggregateRoles;

   api.aggregate(function(response) {
      console.log(response);
   }, {});
})();