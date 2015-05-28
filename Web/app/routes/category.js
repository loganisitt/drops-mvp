var controller = require('../controllers/category');

module.exports = function (app) {
	
    // Returns all of the events that have active dates after or on our current day.
    app.get('/api/category', controller.all);
};