var express = require('express');
var app = express();
var port = process.env.PORT || 8080;
var path = require('path');
var passport = require('passport');

// pass passport for configuration
require('./config/passport')(passport); 

app.use(express.static(__dirname + '/public'));

app.get('/', function(req, res) {
	res.sendFile(path.join(__dirname + '/public/app/views/index.html'));
});

var flash    = require('connect-flash');

var morgan       = require('morgan');
var path         = require('path');
var cookieParser = require('cookie-parser');
var bodyParser   = require('body-parser');
var session      = require('express-session');

var configDB = require('./config/database.js');

var mongoose = require('mongoose');
mongoose.connect(configDB.url); // connect to our database

// set up our express application
app.use(morgan('dev')); // log every request to the console
app.use(cookieParser()); // read cookies (needed for auth)
app.use(bodyParser.json()); // get information from html forms
app.use(bodyParser.urlencoded({ extended: true }));

// required for passport
app.use(session({ secret:'thisisahugesecret'})); // session secret
app.use(passport.initialize());
app.use(passport.session()); // persistent login sessions
app.use(flash()); // use connect-flash for flash messages stored in session

// load our routes and pass in our app and fully configured passport
require('./app/routes')(app, passport); 

app.listen(port);
console.log('Magic happens on http://localhost:' + port);