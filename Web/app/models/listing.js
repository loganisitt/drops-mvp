var mongoose = require('mongoose');
var mongoosastic = require('mongoosastic');
var Schema = mongoose.Schema;

var Listing = new Schema({
  
  seller: {
    type: Schema.Types.ObjectId,
    ref: 'User',
    required: true
  },
  created_at: Date,
  updated_at: Date,
  category: {
    type: Schema.Types.ObjectId,
    ref: 'Category',
    required: true
  },
  name: {
    type: String,
    es_indexed: true
  },
  description: {
    type: String,
    es_indexed: true
  },
  price: Number,
  bids: {
    type: [String],
    required: false
  },
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

Listing.plugin(mongoosastic, {hydrate:true, hydrateOptions: {lean: true}});

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

module.exports = ListingModel;