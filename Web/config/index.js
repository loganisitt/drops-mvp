var bodyParser 		= require('body-parser');
var cookieParser	= require('cookie-parser');
var express	= require('express');
var flash	= require('connect-flash');
var morgan 	= require('morgan');
var session = require('express-session');

module.exports = function (app, passport) {

	// set up our express application
	app.use(morgan('dev')); // log every request to the console
	app.use(cookieParser()); // read cookies (needed for auth)
	app.use(bodyParser.json()); // get information from html forms
	app.use(bodyParser.urlencoded({ extended: true }));

	// required for passport
	app.use(session({ secret: 'thisisahugesecret' })); // session secret
	app.use(passport.initialize());
	app.use(passport.session()); // persistent login sessions
	app.use(flash()); // use connect-flash for flash messages stored in session
};