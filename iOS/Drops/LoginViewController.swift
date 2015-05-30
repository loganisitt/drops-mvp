//
//  LoginViewController.swift
//  Drops
//
//  Created by Logan Isitt on 5/4/15.
//  Copyright (c) 2015 Logan Isitt. All rights reserved.
//

import UIKit

import Cartography
import PureLayout

import FBSDKCoreKit
import FBSDKLoginKit

class LoginViewController: UIViewController, ClientDelegate {
    
    var logoImageView: UIImageView!
    
    var facebookLoginButton: UIButton!
    var emailLoginButton: UIButton!
    var signUpButton: UIButton!
    
    // MARK: - General
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Client.sharedInstance.delegate = self
        
//        if (FBSDKAccessToken.currentAccessToken() != nil) {
//            // User is already logged in, do work such as go to next view controller.
//            Client.sharedInstance.signinWithFacebook(FBSDKAccessToken.currentAccessToken().tokenString)
//        }
        
        navigationController?.navigationBar.hidden = true
        
        addBackground()
        setupViews()
        
        layoutSubviews()
        
        // Gestures
        
        let singleTap = UITapGestureRecognizer(target: self, action: Selector("resignFirstResponders"))
        singleTap.numberOfTapsRequired = 1
        view.addGestureRecognizer(singleTap)
        
        let downSwipe = UISwipeGestureRecognizer(target: self, action: Selector("resignFirstResponders"))
        downSwipe.direction = UISwipeGestureRecognizerDirection.Down
        view.addGestureRecognizer(downSwipe)
    }
    
    // MARK: - Views
    
    func addBackground() {
        
        var backgroundView = UIImageView(image: UIImage(named: "background"))
        view.addSubview(backgroundView)

        backgroundView.contentMode = .ScaleAspectFill
        
        backgroundView.autoPinEdgesToSuperviewEdgesWithInsets(UIEdgeInsetsZero)
    }
    
    func setupViews() {
        
        logoImageView = UIImageView(image: UIImage(named: "logo"))
        
        facebookLoginButton = UIButton.buttonWithType(.Custom) as! UIButton
        facebookLoginButton.setImage(UIImage(named: "facebookBtn"), forState: .Normal)
        facebookLoginButton.addTarget(self, action: Selector("loginButtonAction"), forControlEvents: UIControlEvents.TouchUpInside)
        
        emailLoginButton = UIButton.buttonWithType(.Custom) as! UIButton
        emailLoginButton.setImage(UIImage(named: "loginInBtn"), forState: .Normal)
//        emailLoginButton.addTarget(self, action: Selector("loginButtonAction"), forControlEvents: UIControlEvents.TouchUpInside)
        
        signUpButton = UIButton.buttonWithType(.Custom) as! UIButton
        signUpButton.setImage(UIImage(named: "signUpBtn"), forState: .Normal)
        signUpButton.addTarget(self, action: Selector("signupButtonAction"), forControlEvents: UIControlEvents.TouchUpInside)
        
        view.addSubview(facebookLoginButton)
        view.addSubview(emailLoginButton)
        view.addSubview(signUpButton)
    }
    
    // MARK: - Layout
    
    func layoutSubviews() {
        
        let buf = CGFloat(16)
        let spacing = CGFloat(-8)
        
        signUpButton.autoPinEdgeToSuperviewEdge(ALEdge.Bottom, withInset: buf)
        signUpButton.autoPinEdgeToSuperviewEdge(ALEdge.Left, withInset: buf)
        signUpButton.autoPinEdgeToSuperviewEdge(ALEdge.Right, withInset: buf)
        signUpButton.autoSetDimension(ALDimension.Height, toSize: 40)
        
        emailLoginButton.autoPinEdge(.Bottom, toEdge: .Top, ofView: signUpButton, withOffset: spacing)
        emailLoginButton.autoPinEdgeToSuperviewEdge(ALEdge.Left, withInset: buf)
        emailLoginButton.autoPinEdgeToSuperviewEdge(ALEdge.Right, withInset: buf)
        emailLoginButton.autoSetDimension(ALDimension.Height, toSize: 40)
        
        facebookLoginButton.autoPinEdge(.Bottom, toEdge: .Top, ofView: emailLoginButton, withOffset: spacing)
        facebookLoginButton.autoPinEdgeToSuperviewEdge(ALEdge.Left, withInset: buf)
        facebookLoginButton.autoPinEdgeToSuperviewEdge(ALEdge.Right, withInset: buf)
        facebookLoginButton.autoSetDimension(ALDimension.Height, toSize: 40)

    }
    
    // MARK: - Actions
    
    @IBAction func signupButtonAction() {
        performSegueWithIdentifier("gotoSignUp", sender: self)
    }
    
    @IBAction func loginButtonAction() {
        
        let login = FBSDKLoginManager()
        login.logInWithReadPermissions(["email"], handler: { (result :FBSDKLoginManagerLoginResult!, error: NSError!) -> Void in
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
        })
    }
    
    @IBAction func resignFirstResponders() {
        
        for v in view.subviews {
            if v.isFirstResponder() {
                v.resignFirstResponder()
            }
        }
    }
    
    // MARK: - ClientDelegate
    func signInSuccessful() {
        println("Sign In Successful!")
        performSegueWithIdentifier("gotoDash", sender: self)
    }
    
    func signInFailed() {
        println("Sign In Failed!")        
    }
}