var bcrypt = require('bcrypt-nodejs');

var mongoosastic = require('mongoosastic');
var mongoose = require('mongoose');
var Schema = mongoose.Schema;

// define the schema for our user model
var User = new Schema({

    local: {
        email: String,
        password: String,
    },
    facebook: {
        id: String,
        token: String,
        email: String,
        name: String
    }

});

// generating a hash
User.methods.generateHash = function (password) {
    return bcrypt.hashSync(password, bcrypt.genSaltSync(8), null);
};

// checking if password is valid
User.methods.validPassword = function (password) {
    return bcrypt.compareSync(password, this.local.password);
};

User.plugin(mongoosastic);

// create the model for users and expose it to our app
var UserModel = mongoose.model('User', User);

/* For Indexing everything */

var stream = UserModel.synchronize();
var count = 0;

stream.on('data', function (err, doc) {
    count++;
});
stream.on('close', function () {
    console.log('indexed ' + count + ' documents!');
});
stream.on('error', function (err) {
    console.log(err);
});

module.exports = UserModel