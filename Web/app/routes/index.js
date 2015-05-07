module.exports = function(app, passport) {
	require('./auth')(app, passport); 
	require('./event')(app); 
};