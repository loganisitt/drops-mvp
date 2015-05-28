var mongoosastic = require('mongoosastic');
var mongoose = require('mongoose');
var Schema = mongoose.Schema;

var Category = new Schema({
  name: String,
  subcategory: String,
  color: String,
  icon: String,
  created_at: Date,
  updated_at: Date,
});

// On every save, add the date
Category.pre('save', function (next) {
  // Get the current date
  var currentDate = new Date();
  
  // Change the updated_at field to current date
  this.updated_at = currentDate;

  // If created_at doesn't exist, add to that field
  if (!this.created_at)
    this.created_at = currentDate;

  next();
});

Category.plugin(mongoosastic);

var CategoryModel = mongoose.model('Category', Category);

/* For Indexing everything */

//var stream = CategoryModel.synchronize();
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

module.exports = CategoryModel;