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

@objc protocol ClientDelegate {
    
    // Sign In & Sign Up
    optional func signInSuccessful()
    optional func signInFailed()
    
    // Events
    optional func received(events: [Event])
}

class Client {
    
    var baseUrl = "http://localhost:8080"
    var delegate: ClientDelegate!
    
    class var sharedInstance: Client {
        struct Singleton {
            static let instance = Client()
        }
        return Singleton.instance
    }
    
    // MARK: - Authentication
    
    func signinWithFacebook(accessToken: String) {
        
        var url = baseUrl + "/auth/facebook?access_token=" + accessToken
        
        var isSignedIn: Bool = false
        
        Alamofire.request(.POST, url).responseJSON() {
            (_, _, data, error) in
            
            if (data != nil) {
                var json = JSON(data!)
                println(json)
                self.delegate.signInSuccessful!()
            }
            else {
                self.delegate.signInFailed!()
            }
        }
    }
    
    func signinWith(email: String, password: String) {
        
        var url = baseUrl + "/auth/login"
        
        let parameters = [ "email": email, "password": password]
        
        var isSignedIn: Bool = false
        
        Alamofire.request(.POST, url, parameters: parameters).responseJSON() {
            (_, _, data, error) in
            
            if (data != nil) {
                var json = JSON(data!)
                println(json)
                self.delegate.signInSuccessful!()
            }
            else {
                self.delegate.signInFailed!()
            }
        }
    }
    
    func signUpWith(email: String, password: String) {
        
        var url = baseUrl + "/auth/signup"
        
        let parameters = ["email": email, "password": password]
        
        var isSignedIn: Bool = false
        
        Alamofire.request(.POST, url, parameters: parameters).responseJSON() {
            (_, _, data, error) in
            
            if (data != nil) {
                var json = JSON(data!)
                println(json)
                self.delegate.signInSuccessful!()
            }
            else {
                self.delegate.signInFailed!()
            }
        }
    }
    
    // MARK: - Event
    
    // Create Event
    func createEvent(event: Event) {
        
        var url = baseUrl + "/api/event"
        
        let parameters = event.toDictionary()

        Alamofire.request(.POST, url, parameters: parameters).responseJSON() {
            (_, _, data, error) in
            
            if (data != nil) {
                var json = JSON(data!)
                println(json)
            }
            else {
                println("Error: \(error)")
            }
        }
    }
    
    func getAllEvents() {
        
        var url = baseUrl + "/api/event"

        Alamofire.request(.GET, url).responseJSON() {
            (_, _, data, error) in
            
            if (data != nil) {
                
                var json = JSON(data!).array!
                var events = [Event]()
                
                for j in json {
                    let e: Event = Event()
                    e.fromJSON(j)
                    events.append(e)
                }
                
                self.delegate.received!(events)
            }
            else {
                println("Error: \(error)")
            }
        }
    }
}