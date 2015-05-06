//
//  SignUpViewController.swift
//  Drops
//
//  Created by Logan Isitt on 5/6/15.
//  Copyright (c) 2015 Logan Isitt. All rights reserved.
//

import UIKit

import Cartography

class SignUpViewController: UIViewController {

    var emailField: UITextField!
    var passwordField: UITextField!
    
    var submitBtn: UIButton!
    
    // MARK: - General
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailField = UITextField(frame: CGRect.zeroRect)
        emailField.borderStyle = UITextBorderStyle.Bezel
        
        passwordField = UITextField(frame: CGRect.zeroRect)
        passwordField.borderStyle = UITextBorderStyle.Bezel
        
        submitBtn = UIButton.buttonWithType(UIButtonType.Custom) as! UIButton
        submitBtn.setTitle("Submit", forState: UIControlState.Normal)
        submitBtn.backgroundColor = UIColor.greenColor()
        
        submitBtn.addTarget(self, action: Selector("newSignUp"), forControlEvents: UIControlEvents.TouchUpInside)
        
        view.addSubview(emailField)
        view.addSubview(passwordField)
        view.addSubview(submitBtn)
        
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
    }
    
    // MARK: - Actions
    @IBAction func newSignUp() {
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
    
    // MARK: - Layout
    
    func layoutSubviews() {
        
        layout(emailField, passwordField, submitBtn) { view1, view2, view3 in
            
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
    }
}
