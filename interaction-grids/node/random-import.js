;(function(){
   var _     = require("lodash");
   var randy = require("randy");
   var mongo = require('mongoskin');

   var db = mongo.db('localhost:27017/msc-interaction-grids?auto_reconnect', {safe:true});

   var documents = 10000,
       roles     = {
         "OPO": ["8edd9", "7c54", "5f89"],
         "TPO": ["8547a", "dd128"],
         "APO": ["bb57", "d36d27"],
         "LN": ["252b3", "8f7fce"],
         "DM": ["d27dd"],
         "SM": ["d8547"],
         "XFT1": ["0350", "af32", "8575", "e4086", "de094", "7f209", "d350b", "e505", "97f72"],
         "XFT2": ["2ee50", "d854", "dd12", "c03ef9", "68f7fc", "2c252", "1e4", "094f0", "b7eb"],
       },
       natures   = ["Work", "Give expertise", "Unexpected change", "Coordination"];

   var roleKeys = _.keys(roles);

   var insertHeapMaps = function() {
      var heatMaps = [],
          employeeIds = [];

      _.each(roles, function(role, idx) {
         _.each(role, function(employeeId) {
            var heatMap = {
               role: idx,
               employeeId: employeeId,
               unit: idx,
               createdAt: new Date().toISOString(),
               conversations: []
            };

            heatMaps.push(heatMap);
            employeeIds.push(employeeId);
         });
      });

      db.collection('grids').insert(heatMaps, function(err) {
         if(err) { return console.log('Insertion error: ', err); }

         console.log('Inserted employees: ', employeeIds.join(', '));

         insertConcersations();
      });
   };

   var insertConcersations = function() {
      _.times(documents, function(time) {
         var role = randy.choice(roleKeys);
         var employeeId = randy.choice(roles[role]);

         var roleInteraction = randy.choice(roleKeys);
         var employeeIdInteraction = randy.choice(roles[roleInteraction]);

         var response = {
            employeeId: employeeIdInteraction,
            role: roleInteraction,
            intensity: randy.randInt(1, 6),
            nature: randy.choice(natures),
            unit: roleInteraction,
            initiation: randy.choice([true, false])
         };

         console.log('Adding response to: ' + employeeId + ' with intensity: ' + response.intensity + ' with employee: ', employeeId);

         db.collection('grids').update(
            {'employeeId': employeeId},
            {"$push": {"conversations": response}},
            function(err) {
                if (err) throw err;

                db.close();
            }
         );
      });
   }

   db.collection('grids').remove(function(err) {
      if (err) throw err;
   });

   insertHeapMaps();
})();