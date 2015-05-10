//
//  Event.swift
//  Drops
//
//  Created by Logan Isitt on 5/6/15.
//  Copyright (c) 2015 Logan Isitt. All rights reserved.
//

import UIKit

import ObjectMapper

class Event: Mappable {
    
    var adminId: String!
    var type: String!
    var date: NSDate!
    var locationName: String!
    var maxAttendees: Int!
    
//    func toDictionary() -> Dictionary<String, AnyObject> {
//        return ["adminId": adminId, "type": type,
//            "date": date, "locationName": locationName, "maxAttendees": maxAttendees]
//    }
    
    init() {}
    
    required init?(_ map: Map) {
        mapping(map)
    }
    
    func mapping(map: Map) {
        adminId <- map["adminId"]
        type    <- map["type"]
        date    <- map["date"]
        locationName    <- map["locationName"]
        maxAttendees    <- map["maxAttendees"]
    }
}