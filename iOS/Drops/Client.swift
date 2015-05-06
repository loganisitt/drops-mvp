//
//  Client.swift
//  Drops
//
//  Created by Logan Isitt on 5/6/15.
//  Copyright (c) 2015 Logan Isitt. All rights reserved.
//

import UIKit

import Alamofire
import SwiftyJSON

class Client {
    
    var baseUrl = "http://localhost:8080"
    
    class var sharedInstance: Client {
        struct Singleton {
            static let instance = Client()
        }
        return Singleton.instance
    }
    
    func signinWithFacebook(accessToken: String) -> Bool {
        
        var url = baseUrl + "/auth/facebook?access_token=" + accessToken
        
        var isSignedIn: Bool = false
        
        Alamofire.request(.POST, url).responseJSON() {
            (_, _, data, error) in
            
            if (data != nil) {
                var json = JSON(data!)
                println(json)
            }
        }
        return true
    }
    
    func signinWith(email: String, password: String) -> Bool {
        
        var url = baseUrl + "/auth/login"
        
        let parameters = [ "email": email, "password": password]
        
        var isSignedIn: Bool = false
        
        Alamofire.request(.POST, url, parameters: parameters).responseJSON() {
            (_, _, data, error) in
            
            if (data != nil) {
                var json = JSON(data!)
                println(json)
            }
        }
        return true
    }
    
    func signUpWith(email: String, password: String) -> Bool {
        
        var url = baseUrl + "/auth/signup"
        
        let parameters = [ "email": email, "password": password]
        
        var isSignedIn: Bool = false
        
        Alamofire.request(.POST, url, parameters: parameters).responseJSON() {
            (_, _, data, error) in
            
            if (data != nil) {
                var json = JSON(data!)
                println(json)
            }
        }
        return true
    }
    
}