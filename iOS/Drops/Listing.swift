//
//  Listing.swift
//  Drops
//
//  Created by Logan Isitt on 5/26/15.
//  Copyright (c) 2015 Logan Isitt. All rights reserved.
//

import UIKit

import ObjectMapper

class Listing: Mappable {
    
//    var createdAt: NSDate!
//    var updatedAt: NSDate!
    
    var userId: String!
    
    var name: String!
    var description: String!
    var category: String!
    var price: Double!

//    var type: String!
//    
//    var bids: [String]!
//    var comments: [String]!
//    var imagePaths: [String]!
    
    init() {}
    
    required init?(_ map: Map) {
        mapping(map)
    }
    
    func mapping(map: Map) {
//        createdAt <- map["createdAt"]
//        updatedAt <- map["updatedAt"]
//        
        userId <- map["user_id"]
        
        name        <- map["name"]
        description <- map["description"]
        category    <- map["category"]
        price       <- map["price"]
        
//        type <- map["type"]
        
//        bids        <- map["bids"]
//        comments    <- map["comments"]
//        imagePaths  <- map["image_paths"]
    }
}