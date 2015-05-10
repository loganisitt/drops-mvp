module.exports = function(app, passport, io) {
	require('./auth')(app, passport); 
	require('./event')(app); 
	require('./socket')(app, io);
};