//
//  MainNavigationController.swift
//  Drops
//
//  Created by Logan Isitt on 6/12/15.
//  Copyright (c) 2015 Logan Isitt. All rights reserved.
//

import UIKit

import PureLayout
import FontAwesomeKit

class MainNavigationController: UINavigationController {

    var menuView: UIView!
    
    var menuConstraint: NSLayoutConstraint!
    
    var homeButton: SNButton!
    var buyButton: SNButton!
    var sellButton: SNButton!
    var inboxButton: SNButton!
    var notificationButton: SNButton!
    var accountButton: SNButton!
    
    var fillerButton: SNButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        var shadow = NSShadow()
        shadow.shadowOffset = CGSize(width: -1, height: 1)
        shadow.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.55)
        
        // Nav Bar
        navigationBar.hidden = false
        navigationBar.hideHairline()
        navigationBar.addShadows()
        navigationBar.barTintColor = UIColor.thrift_main_color()
        navigationBar.tintColor = UIColor.whiteColor()
        navigationBar.translucent = false
        navigationBar.setTitleVerticalPositionAdjustment(5, forBarMetrics: .Default)
        navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont.boldSystemFontOfSize(30), NSForegroundColorAttributeName: UIColor.whiteColor(), NSShadowAttributeName: shadow]
        
        toolbar.barTintColor = navigationBar.barTintColor
        toolbar.tintColor = navigationBar.tintColor
        toolbar.translucent = false
        
        addShadows(toView: toolbar)
        
        setupMenuView()
        layoutMenuViews()
    }
    
    // MARK: - Actions
    
    func menuButtonAction() {
        
        if menuConstraint.constant == 0 {
            menuConstraint.constant =  (menuView.bounds.height - fillerButton.bounds.height) //- (menuView.bounds.height - fillerButton.bounds.height)
        }
        else {
            menuConstraint.constant = 0
        }
        
        UIView.animateWithDuration(0.7,
            delay: 0.0,
            usingSpringWithDamping: 0.6,
            initialSpringVelocity: 12.0,
            options: UIViewAnimationOptions.CurveEaseOut,
            animations: { () -> Void in
//                self.toolbar.layoutIfNeeded()
                self.navigationBar.layoutIfNeeded()
            },
            completion: nil)
    }
    
    // MARK: - Views
    
    func setupMenuView() {

        menuView = UIView()
        
        menuView.backgroundColor = UIColor.thrift_green()
        
        navigationBar.addSubview(menuView)
        navigationBar.sendSubviewToBack(menuView)
        
        homeButton = SNButton()
        homeButton.backgroundColor = UIColor.thrift_gray()
        homeButton.iconLabel.text = String.fontAwesomeIconWithName(FontAwesome.Home)
        homeButton.promptLabel.text = "Home"
        
        buyButton = SNButton()
        buyButton.backgroundColor = UIColor.thrift_orange()
        buyButton.iconLabel.text = String.fontAwesomeIconWithName(FontAwesome.ShoppingCart)
        buyButton.promptLabel.text = "Buying"
        
        sellButton = SNButton()
        sellButton.backgroundColor = UIColor.thrift_blue()
        sellButton.iconLabel.text = String.fontAwesomeIconWithName(FontAwesome.Tag)
        sellButton.promptLabel.text = "Selling"
        
        inboxButton = SNButton()
        inboxButton.backgroundColor = UIColor.thrift_yellow()
        inboxButton.iconLabel.text = String.fontAwesomeIconWithName(FontAwesome.Inbox)
        inboxButton.promptLabel.text = "Inbox"
        
        notificationButton = SNButton()
        notificationButton.backgroundColor = UIColor.thrift_light_blue()
        notificationButton.iconLabel.text = String.fontAwesomeIconWithName(FontAwesome.Bell)
        notificationButton.promptLabel.text = "Notifications"
        
        accountButton = SNButton()
        accountButton.backgroundColor = UIColor.blackColor()
        accountButton.iconLabel.text = String.fontAwesomeIconWithName(FontAwesome.Cogs)
        accountButton.promptLabel.text = "Account"
        
        fillerButton = SNButton()
        fillerButton.hasIcon = false

        menuView.addSubview(accountButton)
        menuView.addSubview(notificationButton)
        menuView.addSubview(inboxButton)
        menuView.addSubview(sellButton)
        menuView.addSubview(buyButton)
        menuView.addSubview(homeButton)
        
        menuView.addSubview(fillerButton)
    }
    
    // MARK: - Layout
    
    func layoutMenuViews() {
        
        menuConstraint = menuView.autoPinEdgeToSuperviewEdge(.Bottom)
        menuView.autoPinEdgeToSuperviewEdge(.Left)
        menuView.autoPinEdgeToSuperviewEdge(.Right)
        
        fillerButton.autoPinEdgeToSuperviewEdge(.Top)
        fillerButton.autoPinEdgeToSuperviewEdge(.Left)
        fillerButton.autoPinEdgeToSuperviewEdge(.Right)
//        fillerButton.autoPinEdgeToSuperviewEdge(.Bottom)
        fillerButton.autoSetDimension(.Height, toSize: 50)
        
        homeButton.autoPinEdge(.Top, toEdge: .Bottom, ofView: fillerButton)
//        homeButton.autoPinEdgeToSuperviewEdge(.Top)
        homeButton.autoPinEdgeToSuperviewEdge(.Left)
        homeButton.autoPinEdgeToSuperviewEdge(.Right)
        homeButton.autoSetDimension(.Height, toSize: 50)
        
        buyButton.autoPinEdge(.Top, toEdge: .Bottom, ofView: homeButton)
        buyButton.autoPinEdgeToSuperviewEdge(.Left)
        buyButton.autoPinEdgeToSuperviewEdge(.Right)
        buyButton.autoSetDimension(.Height, toSize: 50)
        
        sellButton.autoPinEdge(.Top, toEdge: .Bottom, ofView: buyButton)
        sellButton.autoPinEdgeToSuperviewEdge(.Left)
        sellButton.autoPinEdgeToSuperviewEdge(.Right)
        sellButton.autoSetDimension(.Height, toSize: 50)
        
        inboxButton.autoPinEdge(.Top, toEdge: .Bottom, ofView: sellButton)
        inboxButton.autoPinEdgeToSuperviewEdge(.Left)
        inboxButton.autoPinEdgeToSuperviewEdge(.Right)
        inboxButton.autoSetDimension(.Height, toSize: 50)
        
        notificationButton.autoPinEdge(.Top, toEdge: .Bottom, ofView: inboxButton)
        notificationButton.autoPinEdgeToSuperviewEdge(.Left)
        notificationButton.autoPinEdgeToSuperviewEdge(.Right)
        notificationButton.autoSetDimension(.Height, toSize: 50)
        
        accountButton.autoPinEdge(.Top, toEdge: .Bottom, ofView: notificationButton)
        accountButton.autoPinEdgeToSuperviewEdge(.Left)
        accountButton.autoPinEdgeToSuperviewEdge(.Right)
        accountButton.autoSetDimension(.Height, toSize: 50)
        accountButton.autoPinEdgeToSuperviewEdge(.Bottom)

//        fillerButton.autoPinEdge(.Top, toEdge: .Bottom, ofView: accountButton)
//        fillerButton.autoPinEdgeToSuperviewEdge(.Left)
//        fillerButton.autoPinEdgeToSuperviewEdge(.Right)
//        fillerButton.autoPinEdgeToSuperviewEdge(.Bottom)
//        fillerButton.autoSetDimension(.Height, toSize: 50)
    }
    
    // MARK: - Toolbar
    
    override func setToolbarHidden(hidden: Bool, animated: Bool) {
        super.setToolbarHidden(true, animated: animated)
        
        if !hidden {
            visibleViewController.navigationItem.leftBarButtonItem = UIBarButtonItem.menuButton(target: self, selector: "menuButtonAction")
//            visibleViewController.setToolbarItems([UIBarButtonItem.menuButton(target: self, selector: "menuButtonAction")], animated: false)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func addShadows(toView view: UIView) {
        
        if !(view is UIImageView) && !(view.bounds.size.height <= 1.0) {
            view.layer.cornerRadius = 0
            view.layer.shadowOpacity = 0.75
            view.layer.shadowRadius = 0
            view.layer.shadowColor = UIColor.blackColor().CGColor
            view.layer.shadowOffset = CGSize(width: 0, height: -2)
        }
        
        for subview in view.subviews {
            addShadows(toView: subview as! UIView)
        }
    }
}
