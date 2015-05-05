//
//  ViewController.swift
//  Drops
//
//  Created by Logan Isitt on 5/4/15.
//  Copyright (c) 2015 Logan Isitt. All rights reserved.
//

import UIKit

import Alamofire
import SwiftyJSON
import FBSDKCoreKit
import FBSDKLoginKit

class ViewController: UIViewController, FBSDKLoginButtonDelegate {
    
    var loginBtn: FBSDKLoginButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let loginView : FBSDKLoginButton = FBSDKLoginButton()
        self.view.addSubview(loginView)
        loginView.center = self.view.center
        loginView.readPermissions = ["public_profile", "email", "user_friends"]
        loginView.delegate = self
        
        if (FBSDKAccessToken.currentAccessToken() != nil) {
            // User is already logged in, do work such as go to next view controller.
            println("CurrentAccessToken: \(FBSDKAccessToken.currentAccessToken().tokenString)")
            trialTestThing(FBSDKAccessToken.currentAccessToken().tokenString)
        } else {
            
        }
        
        //        Alamofire.request(.GET, "http://httpbin.org/get")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - FBSDKLoginButtonDelegate
    
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
        
        println("User Logged In")
        
        if ((error) != nil){
            // Process error
        } else if result.isCancelled {
            // Handle cancellations
        } else {
            println("CurrentAccessToken: \(FBSDKAccessToken.currentAccessToken().tokenString)")
            trialTestThing(FBSDKAccessToken.currentAccessToken().tokenString)
            // If you ask for multiple permissions at once, you
            // should check if specific permissions missing
            if result.grantedPermissions.contains("email")
            {
                // Do work
            }
        }
    }
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        println("User Logged Out")
    }
    
    func returnUserData()
    {
        let graphRequest:FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me", parameters: nil)
        graphRequest.startWithCompletionHandler({ (connection, result, error) -> Void in
            
            if ((error) != nil) {
                // Process error
                println("Error: \(error)")
            }
            else {
                println("fetched user: \(result)")
                let userName : NSString = result.valueForKey("name") as! NSString
                println("User Name is: \(userName)")
                let userEmail : NSString = result.valueForKey("email") as! NSString
                println("User Email is: \(userEmail)")
            }
        })
    }
    
    // Server 
    
    func trialTestThing(token: String) {
        
        var baseUrl = "http://localhost:8080" // Dev

        var url = "http://localhost:8080/auth/facebook?access_token=" + token
        
        println("Requesting from \(url)")
        
        Alamofire.request(.POST, url)
            .responseJSON { (request, response, data, error) in
                println(request)
                println(response)
                println(data)
                println(error)
        }
    }
}

