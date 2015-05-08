var mongoosastic = require('mongoosastic');
var mongoose = require('mongoose');
var Schema = mongoose.Schema;

var Event = new Schema({
  type: String,
  location_name: String,
  location: {},
  adminId: String,
  date: Date,
  created_at: Date,
  updated_at: Date,
  attendees_count: Number,
  attendees: [String]
});

// On every save, add the date
Event.pre('save', function (next) {
  // Get the current date
  var currentDate = new Date();
  
  // Change the updated_at field to current date
  this.updated_at = currentDate;

  // If created_at doesn't exist, add to that field
  if (!this.created_at)
    this.created_at = currentDate;

  next();
});

Event.plugin(mongoosastic);

var EventModel = mongoose.model('Event', Event);

/* For Indexing everything */

//var stream = EventModel.synchronize();
//var count = 0;
//
//stream.on('data', function(err, doc) {
//  count++;
//});
//stream.on('close', function() {
//  console.log('indexed ' + count + ' documents!');
//});
//stream.on('error', function(err) {
//  console.log(err);
//});

module.exports = EventModel