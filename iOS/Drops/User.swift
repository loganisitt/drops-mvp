//
//  User.swift
//  Drops
//
//  Created by Logan Isitt on 5/7/15.
//  Copyright (c) 2015 Logan Isitt. All rights reserved.
//

import Foundation
import UIKit

import ObjectMapper

class User: Mappable {
    
    var id: String!
    var fbId: String!
    
    var fbToken: String!
    
    var name: String!

    var fbEmail: String!
    var email: String!
    
    init() {}
    
    required init?(_ map: Map) {
        mapping(map)
    }
    
    func mapping(map: Map) {
        id      <- map["_id"]
        fbId    <- map["facebook.id"]
        fbToken <- map["facebook.token"]
        name    <- map["facebook.name"]
        fbEmail <- map["facebook.email"]
        email   <- map["local.email"]
    }
}

func == (left: User, right: User) -> Bool {
    return left.id == right.id
}