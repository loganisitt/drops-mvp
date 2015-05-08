//
//  Client.swift
//  Drops
//
//  Created by Logan Isitt on 5/6/15.
//  Copyright (c) 2015 Logan Isitt. All rights reserved.
//

import UIKit

import Alamofire

import ObjectMapper

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
                var user: User = Mapper<User>().map(data)!
                println(user)
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
                var user: User = Mapper<User>().map(data)!
                println(user)
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
                var user: User = Mapper<User>().map(data)!
                println(user)
                self.delegate.signInSuccessful!()
            }
            else {
                self.delegate.signInFailed!()
            }
        }
    }
    
    // MARK: - Event
    
    // Create Event
    func createEvent(data: Dictionary<String, AnyObject>) {
        
        var url = baseUrl + "/api/event"

        Alamofire.request(.POST, url, parameters: data).responseJSON() {
            (_, _, data, error) in
            
            if (data != nil) {
                var event: Event = Mapper<Event>().map(data)!
                println(event)
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
                
                var events: [Event] = Mapper<Event>().mapArray(data)!
                
                self.delegate.received!(events)
            }
            else {
                println("Error: \(error)")
            }
        }
    }
}