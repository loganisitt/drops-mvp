var mongoose = require('mongoose')
var Listing = require('../models/listing');
var User = require('../models/listing');
var formidable = require('formidable');
var http = require('http');
var util = require('util');
var fs = require('fs-extra');
var uuid = require('node-uuid');

// GET api/listing/
module.exports.all = function(req, res) {

	Listing.find().populate('seller').populate('category').exec(function(error, listings) {
   		if (error) {
			res.send(error);	   
		}
		else {
			res.status(200);
			res.json(listings);	
		}
  	});
};

// POST api/listing/
module.exports.create = function(req, res) {
	var form = new formidable.IncomingForm();

	var d = new Date();
	var m = d.getUTCMilliseconds() + 1;
	var n = m;
	var str = n + '';

	while (str.length < 12) {
		n *= m;
		str = n + '';
	}
	var new_location = './public/static/uploads/' + str.substr(0, 12) + '/';

	var passFields;

	form.parse(req, function(err, fields, files) {
		passFields = fields;
	});

	form.on('progress', function(byteReceived, byteExpected) {
		// console.log('Uploaded: ' + Math.round(byteReceived / byteExpected * 100) + '%');
	});

	form.on('end', function(fields, files) {
		var filepaths = new Array();

		for (var i = 0; i < this.openedFiles.length; i++) {
			filepaths.push(new_location + uuid.v4() + '.png');
		}

		for (var i = 0; i < this.openedFiles.length; i++) {

			var temp_path = this.openedFiles[i].path;

			// Location where we want to copy the uploaded file
			fs.copy(temp_path, filepaths[i], function(err) {
				if (err) {
					console.error(err);
				} else {
					console.log('Success!')
				}
			});
		}
		
		var listing = Listing({
				seller: passFields.seller,
				category: passFields.category,
				name: passFields.name,
				description: passFields.description,
				price: passFields.price,
				image_paths: filepaths
		});
			
		listing.save();
	});
};

// GET api/listing/
module.exports.search = function(req, res) {

	console.log(req.query.name);
	
	Listing.search({
		query_string: {
			query: req.query.name
		}
	}, function(err, results) {
		res.send(results);
	});
};