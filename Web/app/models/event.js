var mongoose = require('mongoose');

var eventSchema = new mongoose.Schema({
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
eventSchema.pre('save', function (next) {
  // Get the current date
  var currentDate = new Date();
  
  // Change the updated_at field to current date
  this.updated_at = currentDate;

  // If created_at doesn't exist, add to that field
  if (!this.created_at)
    this.created_at = currentDate;

  next();
});

module.exports = mongoose.model('Event', eventSchema);