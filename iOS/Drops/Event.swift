//
//  Event.swift
//  Drops
//
//  Created by Logan Isitt on 5/6/15.
//  Copyright (c) 2015 Logan Isitt. All rights reserved.
//

import UIKit
import SwiftyJSON

class Event: NSObject {
    
    var adminId: String!
    var type: String!
    var date: NSDate!
    var locationName: String!
    var maxAttendees: Int!
    
    override init() {
        super.init()
    }
    
    func toDictionary() -> Dictionary<String, AnyObject> {
        return ["adminId": adminId, "type": type,
            "date": date, "locationName": locationName, "maxAttendees": maxAttendees]
    }
    
    func fromJSON(json: JSON) {
        adminId = json["adminId"].string
        type    = json["type"].string
//        date            = json["date"].object as! NSDate
        locationName    = json["locationName"].string
        maxAttendees    = json["maxAttendees"].int
    }
}