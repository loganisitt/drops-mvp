module.exports = function (app, passport) {

  app.post('/auth/facebook',
    passport.authenticate(['facebook-token']),
    returnUser);

  app.post('/auth/login',
    passport.authenticate(['local-login']),
    returnUser);

  app.post('/auth/signup',
    passport.authenticate(['local-signup']),
    returnUser
    );

  function returnUser(req, res) {
    if (req.user) {
      //you're authenticated! return sensitive secret information here.
      res.json(req.user);
    } else {
      // not authenticated. go away.
      res.send(401);
    }
  }
};