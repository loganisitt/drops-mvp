module.exports = function(app, passport) {
	
	app.post('/auth/facebook', 
        passport.authenticate(['facebook-token']), 
        function (req, res) {

            if (req.user){
                //you're authenticated! return sensitive secret information here.
                res.json(req.user);
            } else {
                // not authenticated. go away.
                res.send(401);
            }
        });
};