var Event = require('../models/event');
var controller = require('../controllers/event');

module.exports = function (app) {
	
    // Returns all of the events that have active dates after or on our current day.
    app.get('/api/event', controller.all);
    
    // Create an event and send back all events after creation
    app.post('/api/event', controller.create);
	
    // Returns events of a specific type.
    app.get('/api/event/:event_type', controller.allOfType);
	
    // Delete the event corresponding to event_id
    app.delete('/api/event/:event_id', controller.remove);
	
    // Our route and mechanism for when we get a request to attend an event.
    app.post('/api/event/join', controller.join);
};