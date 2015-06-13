//
//  SignUpViewController.swift
//  Drops
//
//  Created by Logan Isitt on 5/6/15.
//  Copyright (c) 2015 Logan Isitt. All rights reserved.
//

import UIKit

import PureLayout
import MaterialKit

class SignUpViewController: UIViewController {

    let shadowOffset = CGSize(width: -2, height: 2)

    var appName: MKLabel!
    
    var nameField: MKTextField!
    var emailField: MKTextField!
    var passwordField: MKTextField!
    var confirmField: MKTextField!
    
    var signupButton: SNButton!
    var facebookLoginButton: SNButton!
    var twitterLoginButton: SNButton!
    
    var exitButton: MKButton!
    
    var orImageView: UIImageView!
    
    // MARK: - General
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.thrift_main_color()
        
        navigationController?.navigationBar.hidden = true
        
        setupViews()
        
        layoutViews()
        
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
    }
    
    // MARK: - Actions
    
    func exitButtonAction() {
        navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func signupButtonAction() {
        if emailField.hasText() && passwordField.hasText() {
            Client.sharedInstance.signUpWith(emailField.text, password: passwordField.text)
        }
        else {
            println("Empty field(s)")
        }
    }
    
    @IBAction func resignFirstResponders() {
        
        for v in view.subviews {
            if v.isFirstResponder() {
                v.resignFirstResponder()
            }
        }
    }
    
    // MARK: - Views
    
    func setupViews() {
        
        let padding = CGSizeMake(21, 21)
        
        exitButton = MKButton()
        exitButton.addTarget(self, action: "exitButtonAction", forControlEvents: .TouchUpInside)
        
        exitButton.setTitle(String.fontAwesomeIconWithName(.Times), forState: .Normal)
        exitButton.titleLabel?.font = UIFont.fontAwesomeOfSize(40)
        exitButton.maskEnabled = false
        exitButton.ripplePercent = 1.2
        exitButton.rippleLocation = .Center
        exitButton.backgroundAniEnabled = false
        
        exitButton.rippleLayerColor = UIColor.grayColor()
        
        exitButton.layer.cornerRadius = 0
        exitButton.layer.shadowOpacity = 0.55
        exitButton.layer.shadowRadius = 0
        exitButton.layer.shadowColor = UIColor.blackColor().CGColor
        exitButton.layer.shadowOffset = shadowOffset
        
        appName = MKLabel()
        appName.text = "Thrift"
        appName.textColor = UIColor.thrift_white()
        appName.textAlignment = .Center
        appName.font = UIFont.boldSystemFontOfSize(40)
        appName.backgroundLayerColor = UIColor.clearColor()
        
        appName.layer.cornerRadius = 0
        appName.layer.shadowOpacity = 0.55
        appName.layer.shadowRadius = 0
        appName.layer.shadowColor = UIColor.blackColor().CGColor
        appName.layer.shadowOffset = shadowOffset
        
        nameField = MKTextField()
        
        nameField.layer.borderColor = UIColor.clearColor().CGColor
        nameField.floatingPlaceholderEnabled = true
        nameField.placeholder = "Full Name"
        nameField.rippleLayerColor = UIColor.grayColor()
        nameField.backgroundColor = UIColor(hex: 0xEEEEEE)
        nameField.padding = padding
        nameField.layer.cornerRadius = 0
        nameField.bottomBorderEnabled = true
        nameField.bottomBorderHighlightWidth = nameField.bottomBorderWidth
        nameField.tintColor = nameField.bottomBorderColor
        
        emailField = MKTextField()
        
        emailField.layer.borderColor = UIColor.clearColor().CGColor
        emailField.floatingPlaceholderEnabled = true
        emailField.placeholder = "Email Address"
        emailField.rippleLayerColor = UIColor.grayColor()
        emailField.tintColor = UIColor.MKColor.Blue
        emailField.backgroundColor = UIColor(hex: 0xEEEEEE)
        emailField.padding = padding
        emailField.layer.cornerRadius = 0
        emailField.bottomBorderEnabled = true
        emailField.bottomBorderHighlightWidth = emailField.bottomBorderWidth
        emailField.tintColor = emailField.bottomBorderColor
        
        passwordField = MKTextField()
        
        passwordField.layer.borderColor = UIColor.clearColor().CGColor
        passwordField.floatingPlaceholderEnabled = true
        passwordField.placeholder = "Password"
        passwordField.rippleLayerColor = UIColor.grayColor()
        passwordField.backgroundColor = UIColor(hex: 0xEEEEEE)
        passwordField.padding = padding
        passwordField.layer.cornerRadius = 0
        passwordField.bottomBorderEnabled = true
        passwordField.bottomBorderHighlightWidth = passwordField.bottomBorderWidth
        passwordField.tintColor = passwordField.bottomBorderColor
        passwordField.secureTextEntry = true
        
        confirmField = MKTextField()
        
        confirmField.layer.borderColor = UIColor.clearColor().CGColor
        confirmField.floatingPlaceholderEnabled = true
        confirmField.placeholder = "Confirm Password"
        confirmField.rippleLayerColor = UIColor.grayColor()
        confirmField.backgroundColor = UIColor(hex: 0xEEEEEE)
        confirmField.padding = padding
        confirmField.layer.cornerRadius = 0
        confirmField.bottomBorderEnabled = true
        confirmField.bottomBorderHighlightWidth = confirmField.bottomBorderWidth
        confirmField.tintColor = confirmField.bottomBorderColor
        confirmField.secureTextEntry = true
        
        signupButton = SNButton()
        signupButton.hasIcon = false
        signupButton.setTitle("Sign up", forState: .Normal)
        signupButton.backgroundColor = UIColor.thrift_orange()
        
        signupButton.addTarget(self, action: "signupButtonAction", forControlEvents: .TouchUpInside)
        
        orImageView = UIImageView(image: UIImage(named: "OR"))
        orImageView.contentMode = UIViewContentMode.ScaleAspectFit
        
        orImageView.layer.cornerRadius = 0
        orImageView.layer.shadowOpacity = 0.55
        orImageView.layer.shadowRadius = 0
        orImageView.layer.shadowColor = UIColor.grayColor().CGColor
        orImageView.layer.shadowOffset = CGSize(width: 0, height: 2.5)
        
        facebookLoginButton = SNButton()
        facebookLoginButton.network = .Facebook
        facebookLoginButton.addTarget(self, action: "facebookButtonAction", forControlEvents: .TouchUpInside)
        
        twitterLoginButton = SNButton()
        twitterLoginButton.network = .Twitter
        
        view.addSubview(exitButton)
        view.addSubview(appName)
        view.addSubview(nameField)
        view.addSubview(emailField)
        view.addSubview(passwordField)
        view.addSubview(confirmField)
        view.addSubview(signupButton)
        view.addSubview(orImageView)
        view.addSubview(facebookLoginButton)
        view.addSubview(twitterLoginButton)
    }
    
    // MARK: - Layout
    
    func layoutViews() {
        
        let buffer = CGFloat(16)
        let spacing = CGFloat(8)
        
        let btnHeight = CGFloat(50)
        
        let z = CGFloat(0)
        
        exitButton.autoPinToTopLayoutGuideOfViewController(self, withInset: 0)
        exitButton.autoPinEdgeToSuperviewEdge(.Left, withInset: 0)
        exitButton.autoSetDimensionsToSize(CGSize(width: btnHeight, height: btnHeight))
        
        appName.autoAlignAxis(.Horizontal, toSameAxisOfView: exitButton)
        appName.autoPinEdgeToSuperviewEdge(.Left, withInset: buffer)
        appName.autoPinEdgeToSuperviewEdge(.Right, withInset: buffer)
        
        nameField.autoPinEdge(.Top, toEdge: .Bottom, ofView: appName, withOffset: z)
        nameField.autoPinEdgeToSuperviewEdge(ALEdge.Left, withInset: z)
        nameField.autoPinEdgeToSuperviewEdge(ALEdge.Right, withInset: z)
        nameField.autoSetDimension(ALDimension.Height, toSize: btnHeight)
        
        emailField.autoPinEdge(.Top, toEdge: .Bottom, ofView: nameField, withOffset: z)
        emailField.autoPinEdgeToSuperviewEdge(ALEdge.Left, withInset: z)
        emailField.autoPinEdgeToSuperviewEdge(ALEdge.Right, withInset: z)
        emailField.autoSetDimension(ALDimension.Height, toSize: btnHeight)
        
        passwordField.autoPinEdge(.Top, toEdge: .Bottom, ofView: emailField, withOffset: z)
        passwordField.autoPinEdgeToSuperviewEdge(.Left, withInset: z)
        passwordField.autoPinEdgeToSuperviewEdge(.Right, withInset: z)
        passwordField.autoSetDimension(.Height, toSize: btnHeight)
        
        confirmField.autoPinEdge(.Top, toEdge: .Bottom, ofView: passwordField, withOffset: z)
        confirmField.autoPinEdgeToSuperviewEdge(.Left, withInset: z)
        confirmField.autoPinEdgeToSuperviewEdge(.Right, withInset: z)
        confirmField.autoSetDimension(.Height, toSize: btnHeight)
        
        signupButton.autoPinEdge(.Top, toEdge: .Bottom, ofView: confirmField, withOffset: spacing)
        signupButton.autoPinEdgeToSuperviewEdge(.Left, withInset: z)
        signupButton.autoPinEdgeToSuperviewEdge(.Right, withInset: z)
        signupButton.autoSetDimension(.Height, toSize: btnHeight)
        
        orImageView.autoPinEdgeToSuperviewEdge(.Left, withInset: z)
        orImageView.autoPinEdgeToSuperviewEdge(.Right, withInset: z)
        //        orImageView.autoSetDimension(.Height, toSize: btnHeight/2)
        
        facebookLoginButton.autoPinEdge(.Top, toEdge: .Bottom, ofView: orImageView, withOffset: spacing)
        facebookLoginButton.autoPinEdgeToSuperviewEdge(.Left, withInset: z)
        facebookLoginButton.autoPinEdgeToSuperviewEdge(.Right, withInset: z)
        facebookLoginButton.autoSetDimension(.Height, toSize: btnHeight)
        
        twitterLoginButton.autoPinEdge(.Top, toEdge: .Bottom, ofView: facebookLoginButton, withOffset: spacing)
        twitterLoginButton.autoPinEdgeToSuperviewEdge(.Left, withInset: z)
        twitterLoginButton.autoPinEdgeToSuperviewEdge(.Right, withInset: z)
        twitterLoginButton.autoPinToBottomLayoutGuideOfViewController(self, withInset: buffer)
        twitterLoginButton.autoSetDimension(.Height, toSize: btnHeight)
    }
}
