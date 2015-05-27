var mongoose = require('mongoose')
var mongoosastic = require('mongoosastic')
var Schema = mongoose.Schema

var Listing = new Schema({
  created_at: Date,
  updated_at: Date,
  userId: String,
  category: String,
  name: {
    type: String,
    es_indexed: true
  },
  description: {
    type: String,
    es_indexed: true
  },
  price: Number,
  bids: [String],
  comments: [String],
  image_paths: [String]
});

// On every save, add the date
Listing.pre('save', function(next) {
  // Get the current date
  var currentDate = new Date();
  // Change the updated_at field to current date
  this.updated_at = currentDate;
  // If created_at doesn't exist, add to that field
  if (!this.created_at)
    this.created_at = currentDate;

  next();
});

Listing.plugin(mongoosastic)

var ListingModel = mongoose.model('Listing', Listing);

/* For Indexing everything */

//var stream = ListingModel.synchronize();
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

module.exports = Listing