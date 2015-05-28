//
//  RootViewController.swift
//  Drops
//
//  Created by Logan Isitt on 5/6/15.
//  Copyright (c) 2015 Logan Isitt. All rights reserved.
//

import UIKit

class RootViewController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationBar.translucent = false
        navigationBar.hideHairline()
        
        navigationBar.barTintColor = UIColor.SSColor.White
        navigationBar.tintColor = UIColor.SSColor.White
        navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont.SSFont.H3!, NSForegroundColorAttributeName: UIColor.SSColor.White]
    }
}
