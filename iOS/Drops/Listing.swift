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
    
    var createdAt: NSDate!
    var updatedAt: NSDate!
    
    var name: String!
    var description: String!
    var category: Category!
    var price: Double!
    
    var seller: User!
    
    var bids: [String]!
    var imagePaths: [String]!
    
    init() {}
    
    required init?(_ map: Map) {
        mapping(map)
    }
    
    func mapping(map: Map) {
        createdAt <- map["createdAt"]
        updatedAt <- map["updatedAt"]

        seller <- map["seller"]
        
        name        <- map["name"]
        description <- map["description"]
        category    <- map["category"]
        price       <- map["price"]
        
        bids        <- map["bids"]
        imagePaths  <- map["image_paths"]
    }
}