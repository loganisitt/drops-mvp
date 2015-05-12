var mongoosastic = require('mongoosastic');
var mongoose = require('mongoose');
var Schema = mongoose.Schema;

var ObjectId = mongoose.Schema.Types.ObjectId;

var Message = new Schema({
//  sender: {
//    type: ObjectId,
//    ref: 'User',
//    required: true
//  },
//  recipient: {
//    type: ObjectId,
//    ref: 'User',
//    required: true
//  },
  text: {
    type: String,
    required: true,
    trim: true
  },
  posted: {
    type: Date,
    default: Date.now,
    index: true
  }
});

Message.plugin(mongoosastic);

var MessageModel = mongoose.model('Message', Message);

module.exports = MessageModel;