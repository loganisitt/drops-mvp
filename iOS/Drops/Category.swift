//
//  Category.swift
//  Drops
//
//  Created by Logan Isitt on 5/27/15.
//  Copyright (c) 2015 Logan Isitt. All rights reserved.
//

import UIKit

import ObjectMapper

class Category: Mappable {
    
    var id: String!

    var name: String!
    var subcategory: String!
    
    var color: String!
    var icon: String!
    
    var createdAt: NSDate!
    var updatedAt: NSDate!
    
    init() {}
    
    required init?(_ map: Map) {
        mapping(map)
    }
    
    func mapping(map: Map) {
        id      <- map["_id"]
        name    <- map["name"]
        subcategory     <- map["subcategory"]
        color   <- map["color"]
        icon    <- map["icon"]
        createdAt    <- map["created_at"]
        updatedAt    <- map["updated_at"]
    }
}