var Category = require('../models/category');

module.exports.all = function (req, res) {
    Category.find(function (err, categories) {
        if (err)
            res.send(err);

        res.json(categories);
    });
};

