// Grab the user model
var User = require('../../app/models/user');

// Use the authentication codes provided in auth.js
var configAuth = require('../auth');

module.exports = function (passport) {
	
  /* 
   * required for persistent login sessions
   * passport needs ability to serialize and unserialize users out of session
   */

  // used to serialize the user for the session
  passport.serializeUser(function (user, done) {
    done(null, user.id);
  });

  // used to deserialize the user
  passport.deserializeUser(function (id, done) {
    User.findById(id, function (err, user) {
      done(err, user);
    });
  });
  
  require('./local')(passport, User); 
  require('./facebook')(passport, User, configAuth);   
};