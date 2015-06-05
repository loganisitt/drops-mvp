var controller = require('../controllers/listing');

module.exports = function (app) {
	
    // Returns all of the listings
    app.get('/api/listing', controller.all);
    
    // Create a listing
    app.post('/api/listing', controller.create);
	
    // Search for a listing
    app.get('/api/listing/search', controller.search);

    // Watch a listing
    app.get('/api/listing/bid', controller.bid);
};