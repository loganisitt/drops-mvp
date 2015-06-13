//
//  RootViewController.swift
//  Drops
//
//  Created by Logan Isitt on 6/3/15.
//  Copyright (c) 2015 Logan Isitt. All rights reserved.
//

import UIKit

import PureLayout
import MaterialKit

class RootViewController: UIViewController, ClientDelegate, UIPageViewControllerDelegate {
    
    var pageViewController: UIPageViewController?
    var loginButton: SNButton!
    var signUpButton: SNButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Client.sharedInstance.delegate = self
        
        if (FBSDKAccessToken.currentAccessToken() != nil) {
            // User is already logged in, do work such as go to next view controller.
            Client.sharedInstance.signinWithFacebook(FBSDKAccessToken.currentAccessToken().tokenString)
        }
        
        view.backgroundColor = UIColor.thrift_main_color()
        
        navigationController?.navigationBar.hidden = true
        
        self.pageViewController = UIPageViewController(transitionStyle: .Scroll, navigationOrientation: .Horizontal, options: nil)
        self.pageViewController!.delegate = self
        
        let startingViewController: DataViewController = self.modelController.viewControllerAtIndex(0, storyboard: self.storyboard!)!
        let viewControllers = [startingViewController]
        self.pageViewController!.setViewControllers(viewControllers, direction: .Forward, animated: false, completion: {done in })
        
        self.pageViewController!.dataSource = self.modelController
        
        self.addChildViewController(self.pageViewController!)
        self.view.addSubview(self.pageViewController!.view)
        
        self.pageViewController!.didMoveToParentViewController(self)
        
        self.view.gestureRecognizers = self.pageViewController!.gestureRecognizers
        
        setupSubviews()
        
        layoutSubviews()
    }
    
    // MARK: - Views
    
    func setupSubviews() {
        
        loginButton = SNButton()
        loginButton.hasIcon = false
        loginButton.setTitle("Login", forState: .Normal)
        loginButton.backgroundColor = UIColor.thrift_blue()
        
        loginButton.addTarget(self, action: "loginButtonAction", forControlEvents: .TouchUpInside)
        
        signUpButton = SNButton()
        signUpButton.hasIcon = false
        signUpButton.setTitle("Sign up", forState: .Normal)
        signUpButton.backgroundColor = UIColor.thrift_light_blue()
        
        signUpButton.addTarget(self, action: "signupButtonAction", forControlEvents: .TouchUpInside)
        
        view.addSubview(loginButton)
        view.addSubview(signUpButton)
    }
    
    // MARK: - Layout
    
    func layoutSubviews() {
        let buffer = CGFloat(16)
        let spacing = CGFloat(8)
        
        let btnHeight = CGFloat(50)
        
        pageViewController!.view.autoPinToTopLayoutGuideOfViewController(self, withInset: buffer)
        pageViewController!.view.autoPinEdgeToSuperviewEdge(.Left, withInset: 0)
        pageViewController!.view.autoPinEdgeToSuperviewEdge(.Right, withInset: 0)
        
        loginButton.autoPinEdge(.Top, toEdge: .Bottom, ofView: pageViewController!.view, withOffset: spacing)
        loginButton.autoPinEdgeToSuperviewEdge(.Left, withInset: 0)
        loginButton.autoPinEdgeToSuperviewEdge(.Right, withInset: 0)
        loginButton.autoSetDimension(.Height, toSize: btnHeight)
        
        signUpButton.autoPinEdge(.Top, toEdge: .Bottom, ofView: loginButton, withOffset: spacing)
        signUpButton.autoPinEdgeToSuperviewEdge(.Left, withInset: 0)
        signUpButton.autoPinEdgeToSuperviewEdge(.Right, withInset: 0)
        signUpButton.autoPinToBottomLayoutGuideOfViewController(self, withInset: buffer)
        signUpButton.autoSetDimension(.Height, toSize: btnHeight)
    }
    
    // MARK: - Actions
    func loginButtonAction() {
        performSegueWithIdentifier("gotoSignin", sender: self)
    }
    
    func signupButtonAction() {
        performSegueWithIdentifier("gotoSignup", sender: self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var modelController: ModelController {
        // Return the model controller object, creating it if necessary.
        // In more complex implementations, the model controller may be passed to the view controller.
        if _modelController == nil {
            _modelController = ModelController()
        }
        return _modelController!
    }
    
    var _modelController: ModelController? = nil
    
    // MARK: - UIPageViewController delegate methods
    
    func pageViewController(pageViewController: UIPageViewController, spineLocationForInterfaceOrientation orientation: UIInterfaceOrientation) -> UIPageViewControllerSpineLocation {
        if (orientation == .Portrait) || (orientation == .PortraitUpsideDown) || (UIDevice.currentDevice().userInterfaceIdiom == .Phone) {
            // In portrait orientation or on iPhone: Set the spine position to "min" and the page view controller's view controllers array to contain just one view controller. Setting the spine position to 'UIPageViewControllerSpineLocationMid' in landscape orientation sets the doubleSided property to YES, so set it to NO here.
            let currentViewController = self.pageViewController!.viewControllers[0] as! UIViewController
            let viewControllers = [currentViewController]
            self.pageViewController!.setViewControllers(viewControllers, direction: .Forward, animated: true, completion: {done in })
            
            self.pageViewController!.doubleSided = false
            return .Min
        }
        
        // In landscape orientation: Set set the spine location to "mid" and the page view controller's view controllers array to contain two view controllers. If the current page is even, set it to contain the current and next view controllers; if it is odd, set the array to contain the previous and current view controllers.
        let currentViewController = self.pageViewController!.viewControllers[0] as! DataViewController
        var viewControllers: [AnyObject]
        
        let indexOfCurrentViewController = self.modelController.indexOfViewController(currentViewController)
        if (indexOfCurrentViewController == 0) || (indexOfCurrentViewController % 2 == 0) {
            let nextViewController = self.modelController.pageViewController(self.pageViewController!, viewControllerAfterViewController: currentViewController)
            viewControllers = [currentViewController, nextViewController!]
        } else {
            let previousViewController = self.modelController.pageViewController(self.pageViewController!, viewControllerBeforeViewController: currentViewController)
            viewControllers = [previousViewController!, currentViewController]
        }
        self.pageViewController!.setViewControllers(viewControllers, direction: .Forward, animated: true, completion: {done in })
        
        return .Mid
    }
    
    // MARK: - ClientDelegate
    
    func signInSuccessful() {
        performSegueWithIdentifier("gotoDash", sender: self)
    }
    
    func signInFailed() {
        println("Sign In Failed!")
    }
}