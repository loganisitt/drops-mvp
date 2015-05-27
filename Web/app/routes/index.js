module.exports = function(app, passport, io) {
	require('./auth')(app, passport); 
	require('./event')(app); 
	require('./listing')(app); 
	require('./socket')(app, io);
};