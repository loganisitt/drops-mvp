var Event = require('../models/event');

module.exports.all = function (req, res) {
    Event.find(function (err, events) {
        if (err)
            res.send(err);

        res.json(events);
    });
};

module.exports.allOfType = function (req, res) {
    Event.find({ type: event_type }, function (err, events) {
        if (err)
            res.send(err);

        res.json(events);
    });
};

module.exports.create = function (req, res) {
    // Create the event with the information coming from the AJAX request from Angular
    Event.create({
        type: req.body.type,
        location_name: req.body.locationName,
        adminId: req.body.adminId,
        date: req.body.date,
        max_attendees: req.body.maxAttendees
    }, function (err, event) {
            if (err)
                res.send(err);

            // Get and return all the events after you create another
            Event.find(function (err, events) {
                if (err)
                    res.send(err);

                res.json(events);
            });
        });
};

module.exports.remove = function (req, res) {
    // Delete the event.
    Event.remove({
        _id: req.params.event_id
    }, function (err, event) {
            if (err)
                res.send(err);

            // After removing one, we return all the remaining events.
            Event.find(function (err, events) {
                if (err)
                    res.send(err);

                res.json(events);
            });
        });
};

module.exports.join = function (req, res) {
    Event.findByIdAndUpdate(req.body.eId, { $addToSet: { attendees: req.body.uId } },
        function (err, event) {
            if (err)
                res.send(err);

            res.json(event);
        });
};