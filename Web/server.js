var passport = require('passport');
var mongoose = require('mongoose');
var express  = require('express');
var path 	 = require('path');

var app = express();

var server = require('http').createServer(app);
server.listen(port, 'localhost');

var port = process.env.PORT || 8080;

var io = require('socket.io').listen(app.listen(port));

require('./config/passport')(passport);
require('./config')(app, passport);
require('./app/routes')(app, passport, io);

var configDB = require('./config/database.js');
mongoose.connect(configDB.url); // connect to our database

// Set .html as the default template extension
app.set('view engine', 'html');

// Initialize the ejs template engine
app.engine('html', require('ejs').renderFile);
	
app.use(express.static(__dirname + '/public'));

// Tell express where it can find the templates
app.set('views', __dirname + '/public/app/views/');

app.get('/', function (req, res) {
	res.sendFile(path.join(__dirname + '/public/app/index.html'));
});

console.log('Application is running on http://localhost:' + port);