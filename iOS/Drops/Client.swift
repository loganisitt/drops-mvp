//
//  Client.swift
//  Drops
//
//  Created by Logan Isitt on 5/6/15.
//  Copyright (c) 2015 Logan Isitt. All rights reserved.
//

import UIKit
import MobileCoreServices

import Alamofire

import ObjectMapper

import Socket_IO_Client_Swift

@objc protocol ClientDelegate {
    
    // Sign In & Sign Up
    optional func signInSuccessful()
    optional func signInFailed()
    
    // Events
    optional func received(listings: [Listing])
}

class Client {
    
    let baseUrl = "http://localhost:8080"
//    let baseUrl = "http://10.132.104.97:8080"
    
    var delegate: ClientDelegate!
    
    var socket: SocketIOClient! //(socketURL: baseUrl)
    
    class var sharedInstance: Client {
        struct Singleton {
            static let instance = Client()
        }
        return Singleton.instance
    }
    
    init() {
        println("Client Singleton made!")
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
    
    // MARK: - Listing
    
//    func createEvent(data: Dictionary<String, AnyObject>) {
//        
//        var url = baseUrl + "/api/event"
//
//        Alamofire.request(.POST, url, parameters: data).responseJSON() {
//            (_, _, data, error) in
//            
//            if (data != nil) {
//                var event: Event = Mapper<Event>().map(data)!
//                println(event)
//            }
//            else {
//                println("Error: \(error)")
//            }
//        }
//    }
    
    func createListing(packet: Dictionary<String, AnyObject>, imgPaths: [String]) -> Bool{
        
        var urlString = baseUrl + "/api/listing"
        
        let boundary = generateBoundaryString()
        
        let url = NSURL(string: urlString)
        let request = NSMutableURLRequest(URL: url!)
        request.HTTPMethod = "POST"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        var fileManager = NSFileManager.defaultManager()
        
        var paths = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
        var documentsDirectory: AnyObject = paths[0]
        
        request.HTTPBody = createBodyWithParameters(packet, filePathKey: "file", paths: imgPaths, boundary: boundary)
        
        Alamofire.request(request)
            .validate()
            .progress {
                (bytesWritten, totalBytesWritten, totalBytesExpectedToWrite) in
                
                println(totalBytesWritten)
            }
            .responseJSON() {
                (request, res, data, error) in
                
//                if (data != nil) {
//                    var listing: Listing = Mapper<Listing>().map(data)!
//                    println(listing)
//                }
//                else {
//                    println("Error: \(error)")
//                }
                
                // Clean up saved images
                for path in imgPaths {
                    if fileManager.fileExistsAtPath(path) {
                        fileManager.removeItemAtPath(path, error: nil)
                        println("Removed file at path: \(path)")
                    }
                }
        }
        return true
    }
    
    func basicSearchFor(query: String) -> Bool {
        
        var url = baseUrl + "/api/listing/search"
        
        var parameters = ["name": query]
        Alamofire.request(.GET, url, parameters: parameters ).validate().responseJSON() {
            (_, _, data, error) in
            
            println(data)
        }
        return true
    }
    
    func getAllListings(){
        
        var urlString = baseUrl + "/api/listing"
        
        Alamofire.request(.GET, urlString).validate().responseJSON() {
            (_, _, data, error) in
            
            if (data != nil) {
                
                var listings: [Listing] = Mapper<Listing>().mapArray(data)!
                
                self.delegate.received!(listings)
            }
            else {
                println("Error: \(error)")
            }
        }
    }
    
    // MARK: - Socket
    
    func connectSocket() {
        socket = SocketIOClient(socketURL: baseUrl)
        
        socket.onAny(socketHandler)
        
        socket.connect()
    }
    
    func disconnectSocket() {
        if socket.connected {
            socket.disconnect(fast: false)
        }
    }
    
    func socketHandler(anyEvent: SocketAnyEvent) -> Void {
        if anyEvent.event == "connect" {
            println("Event: \(anyEvent.event)")
            println("\tItems: \(anyEvent.items)")
            
            socket.emit("load", ["a": "c", "b": "d"])
        }
        else if anyEvent.event == "peopleinchat" {
            println("Event: \(anyEvent.event)")
            println("\tItems: \(anyEvent.items)")
            
            socket.emit("login", ["user":"Sim", "avatar":"laisitt@gmail.com", "id":["a": "c", "b": "d"]])
        }
        else if anyEvent.event == "receive" {
            println("Event: \(anyEvent.event)")
            println("\tItem: \(anyEvent.items![0])")
            
            let message = Mapper<Message>().map(anyEvent.items![0])
        }
        else {
            println("Event: \(anyEvent.event)")
            println("\tItems: \(anyEvent.items)")
        }
    }
    
    func send(message: Message) {
        println("Sending: \(message)")
        
        let JSONString = Mapper().toJSONString(message, prettyPrint: true)
        let JSONData = Mapper().toJSON(message)
        
        socket.emit("msg", JSONData)
    }
    
    // MARK: - Helpers
    func createBodyWithParameters(parameters: [String: AnyObject]?, filePathKey: String?, paths: [String]?, boundary: String) -> NSData {
        
        let body = NSMutableData()
        
        if parameters != nil {
            for (key, value) in parameters! {
                body.appendString("--\(boundary)\r\n")
                body.appendString("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
                body.appendString("\(value)\r\n")
            }
        }
        
        if paths != nil {
            for path in paths! {
                let filename = path.lastPathComponent
                let data = NSData(contentsOfFile: path)
                let mimetype = mimeTypeForPath(path)
                
                body.appendString("--\(boundary)\r\n")
                body.appendString("Content-Disposition: form-data; name=\"\(filePathKey!)\"; filename=\"\(filename)\"\r\n")
                body.appendString("Content-Type: \(mimetype)\r\n\r\n")
                body.appendData(data!)
                body.appendString("\r\n")
            }
        }
        
        body.appendString("--\(boundary)--\r\n")
        return body
    }
    
    /// Create boundary string for multipart/form-data request
    ///
    /// :returns:            The boundary string that consists of "Boundary-" followed by a UUID string.
    
    func generateBoundaryString() -> String {
        return "Boundary-\(NSUUID().UUIDString)"
    }
    
    /// Determine mime type on the basis of extension of a file.
    ///
    /// This requires MobileCoreServices framework.
    ///
    /// :param: path         The path of the file for which we are going to determine the mime type.
    ///
    /// :returns:            Returns the mime type if successful. Returns application/octet-stream if unable to determine mime type.
    
    func mimeTypeForPath(path: String) -> String {
        let pathExtension = path.pathExtension
        
        if let uti = UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension, pathExtension as NSString, nil)?.takeRetainedValue() {
            if let mimetype = UTTypeCopyPreferredTagWithClass(uti, kUTTagClassMIMEType)?.takeRetainedValue() {
                return mimetype as String
            }
        }
        return "application/octet-stream";
    }
}