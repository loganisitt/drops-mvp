//
//  UINavigationBarExtension.swift
//  Drops
//
//  Created by Logan Isitt on 5/6/15.
//  Copyright (c) 2015 Logan Isitt. All rights reserved.
//

import UIKit

extension UINavigationBar {
    
    func hideHairline() {
        if let hairlineView: UIImageView = self.findHairlineImageView(containedIn: self) {
            hairlineView.hidden = true
        }
    }
    
    func findHairlineImageView(containedIn view: UIView) -> UIImageView? {
        
        if view is UIImageView && view.bounds.size.height <= 1.0 {
            return view as? UIImageView
        }
        
        for subview in view.subviews {
            if let imageView: UIImageView = self.findHairlineImageView(containedIn: subview as! UIView) {
                return imageView
            }
        }
        return nil
    }
    
    func addShadows() {
        addShadows(toView: self)
    }
    
    func addShadows(toView view: UIView) {
        
        if !(view is UIImageView) && !(view.bounds.size.height <= 1.0) {
            view.layer.cornerRadius = 0
            view.layer.shadowOpacity = 0.75
            view.layer.shadowRadius = 0
            view.layer.shadowColor = UIColor.blackColor().CGColor
            view.layer.shadowOffset = CGSize(width: 0, height: 2)
        }
        
        for subview in view.subviews {
            addShadows(toView: subview as! UIView)
        }
    }
}
