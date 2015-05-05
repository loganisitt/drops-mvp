// Passport Strategy for Authenticating Mobile Devices using Facebook Sign in
var FacebookTokenStrategy = require('passport-facebook-token').Strategy;

// Grab the user model
var User = require('../app/models/user');

// Use the authentication codes provided in auth.js
var configAuth = require('./auth');

// A module with passport being pushed to it
module.exports = function(passport) {
  
    // required for persistent login sessions
  // passport needs ability to serialize and unserialize users out of session

  // used to serialize the user for the session
  passport.serializeUser(function(user, done) {
    done(null, user.id);
  });

  // used to deserialize the user
  passport.deserializeUser(function(id, done) {
    User.findById(id, function(err, user) {
      done(err, user);
    });
  });

	passport.use('facebook-token', new FacebookTokenStrategy({
	    clientID        : configAuth.facebookAuth.clientID,
	    clientSecret    : configAuth.facebookAuth.clientSecret,
		passReqToCallback: true // allows us to pass in the req from our route (lets us check if a user is logged in or not)
	  },
	  doStuff));
	
	function doStuff(req, accessToken, refreshToken, profile, done) {
    // asynchronous
    process.nextTick(function() {
      // check if the user is already logged in
      if (!req.user) {
        User.findOne({
          'facebook.id': profile.id
        }, function(err, user) {
          if (err) {
            return done(err);
          }
          if (user) {

            // if there is a user id already but no token (user was linked at one point and then removed)
            if (!user.facebook.token) {
              user.facebook.token = accessToken;
              user.facebook.name = profile.name.givenName + ' ' + profile.name.familyName;
              user.facebook.email = (profile.emails[0].value || '').toLowerCase();

              user.save(function(err) {
                if (err) {
                  return done(err);
                }
                return done(null, user);
              });
            }

            return done(null, user); // user found, return that user
          } else {
            // if there is no user, create them
            var newUser = new User();

            newUser.facebook.id = profile.id;
            newUser.facebook.token = accessToken;
            newUser.facebook.name = profile.name.givenName + ' ' + profile.name.familyName;
            newUser.facebook.email = (profile.emails[0].value || '').toLowerCase();

            newUser.save(function(err) {
              if (err)
                return done(err);

              return done(null, newUser);
            });
          }
        });

      } else {
        // user already exists and is logged in, we have to link accounts
        var user = req.user; // pull the user out of the session

        user.facebook.id = profile.id;
        user.facebook.token = accessToken;
        user.facebook.name = profile.name.givenName + ' ' + profile.name.familyName;
        user.facebook.email = (profile.emails[0].value || '').toLowerCase();

        user.save(function(err) {
          if (err)
            return done(err);

          return done(null, user);
        });

      }
    });
  }
};