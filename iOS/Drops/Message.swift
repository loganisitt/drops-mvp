//
//  Message.swift
//  Drops
//
//  Created by Logan Isitt on 5/10/15.
//  Copyright (c) 2015 Logan Isitt. All rights reserved.
//

import UIKit

import ObjectMapper

class Message: Mappable {
    
    var text: String!
    var posted: NSDate!
    var sender: User!
    var recipient: User!
    
    init() {}
    
    required init?(_ map: Map) {
        mapping(map)
    }
    
    func mapping(map: Map) {
        text    <- map["text"]
        posted  <- map["posted"]
        sender  <- map["sender"]
        recipient   <- map["recipient"]
    }
}