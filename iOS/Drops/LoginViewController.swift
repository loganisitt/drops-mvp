//
//  LoginViewController.swift
//  Drops
//
//  Created by Logan Isitt on 5/4/15.
//  Copyright (c) 2015 Logan Isitt. All rights reserved.
//

import UIKit

import Cartography

import FBSDKCoreKit
import FBSDKLoginKit

class LoginViewController: UIViewController, FBSDKLoginButtonDelegate {
    
    var emailField: UITextField!
    var passwordField: UITextField!
    
    var epLoginBtn: UIButton!
    var fbLoginBtn: FBSDKLoginButton!
    var signupBtn: UIButton!
    
    // MARK: - General
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fbLoginBtn = FBSDKLoginButton()
        self.view.addSubview(fbLoginBtn)
        fbLoginBtn.center = self.view.center
        fbLoginBtn.readPermissions = ["public_profile", "email", "user_friends"]
        fbLoginBtn.delegate = self
        
        if (FBSDKAccessToken.currentAccessToken() != nil) {
            // User is already logged in, do work such as go to next view controller.
            Client.sharedInstance.signinWithFacebook(FBSDKAccessToken.currentAccessToken().tokenString)
        }
        
        emailField = UITextField(frame: CGRect.zeroRect)
        emailField.borderStyle = UITextBorderStyle.Bezel
        
        passwordField = UITextField(frame: CGRect.zeroRect)
        passwordField.borderStyle = UITextBorderStyle.Bezel
        
        epLoginBtn = UIButton.buttonWithType(UIButtonType.Custom) as! UIButton
        epLoginBtn.setTitle("Login", forState: UIControlState.Normal)
        epLoginBtn.backgroundColor = UIColor.greenColor()
        
        epLoginBtn.addTarget(self, action: Selector("signInwithEP"), forControlEvents: UIControlEvents.TouchUpInside)
        
        signupBtn = UIButton.buttonWithType(UIButtonType.Custom) as! UIButton
        signupBtn.setTitle("Sign up", forState: UIControlState.Normal)
        signupBtn.backgroundColor = UIColor.redColor()
        
        signupBtn.addTarget(self, action: Selector("signUpwithEP"), forControlEvents: UIControlEvents.TouchUpInside)
        
        view.addSubview(emailField)
        view.addSubview(passwordField)
        view.addSubview(epLoginBtn)
        view.addSubview(signupBtn)
        
        layoutSubviews()
        
        // Gestures
        
        let singleTap = UITapGestureRecognizer(target: self, action: Selector("resignFirstResponders"))
        singleTap.numberOfTapsRequired = 1
        view.addGestureRecognizer(singleTap)
        
        let downSwipe = UISwipeGestureRecognizer(target: self, action: Selector("resignFirstResponders"))
        downSwipe.direction = UISwipeGestureRecognizerDirection.Down
        view.addGestureRecognizer(downSwipe)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Actions
    @IBAction func signInwithEP() {
        
        if (emailField.hasText() && passwordField.hasText()) {
            Client.sharedInstance.signinWith(emailField.text, password: passwordField.text)
        }
        else {
            println("Empty textfield(s)")
        }
    }
    
    @IBAction func signUpwithEP() {
        performSegueWithIdentifier("gotoSignUp", sender: self)
    }
    
    @IBAction func resignFirstResponders() {
        
        for v in view.subviews {
            if v.isFirstResponder() {
                v.resignFirstResponder()
            }
        }
    }
    
    // MARK: - FBSDKLoginButtonDelegate
    
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
        
        println("User Logged In")
        
        if ((error) != nil){
            // Process error
        } else if result.isCancelled {
            // Handle cancellations
        } else {
            
            Client.sharedInstance.signinWithFacebook(FBSDKAccessToken.currentAccessToken().tokenString)
            
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
    
    // MARK: - Layout
    
    func layoutSubviews() {
        
        layout(emailField, passwordField, epLoginBtn) { view1, view2, view3 in
            
            view1.width   == view1.superview!.width - 32
            view2.width   == view2.superview!.width - 32
            view3.width   == view3.superview!.width - 32
            
            view1.height  == 40
            view2.height  == view1.height
            view3.height  == view1.height
            
            view1.centerX == view1.superview!.centerX
            view2.centerX == view1.centerX
            view3.centerX == view1.centerX
            
            view1.top >= view1.superview!.top + 20
            view2.top == view1.bottom + 8
            view3.top == view2.bottom + 8
        }
        
        layout(epLoginBtn, signupBtn) { view1, view2 in
            view2.width   == view2.superview!.width - 32
            
            view2.height  == view1.height
            
            view2.centerX == view1.centerX
            
            view2.top == view1.bottom + 8
        }
    }
}