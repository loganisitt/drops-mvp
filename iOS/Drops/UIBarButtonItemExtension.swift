//
//  UIBarButtonItem+UIBarButtonItemExtension.swift
//  Drops
//
//  Created by Logan Isitt on 6/12/15.
//  Copyright (c) 2015 Logan Isitt. All rights reserved.
//

import UIKit

import FontAwesomeKit

extension UIBarButtonItem {
    
    public class func searchButton(#target: AnyObject, selector: Selector) -> UIBarButtonItem {
        
        var searchIcon = FAKIonIcons.searchIconWithSize(25) // FAKFontAwesome.searchIconWithSize(20)
        searchIcon.addAttribute(NSForegroundColorAttributeName, value: UIColor.whiteColor())
        let rightImage = searchIcon.imageWithSize(CGSize(width: 25, height: 25))
        
        var btn = UIButton.buttonWithType(.Custom) as! UIButton
        
        btn.setImage(rightImage, forState: .Normal)
        btn.addTarget(target, action: selector, forControlEvents: .TouchUpInside)
        btn.layer.masksToBounds = false
        btn.layer.cornerRadius = 0
        btn.layer.shadowOffset = CGSizeMake(-1, 1)
        btn.layer.shadowRadius = 0
        btn.layer.shadowOpacity = 0.55
        btn.layer.shadowColor = UIColor.blackColor().CGColor
        btn.sizeToFit()
        
        return UIBarButtonItem(customView: btn)
    }
    
    public class func backButton(#target: AnyObject, selector: Selector) -> UIBarButtonItem {
        
        var caretIcon = FAKIonIcons.arrowLeftBIconWithSize(25)// FAKFontAwesome.caretLeftIconWithSize(30)
        caretIcon.addAttribute(NSForegroundColorAttributeName, value: UIColor.whiteColor())
        let leftImage = caretIcon.imageWithSize(CGSize(width: 25, height: 25))
        
        var btn = UIButton.buttonWithType(.Custom) as! UIButton
        
        btn.setImage(leftImage, forState: .Normal)
        btn.addTarget(target, action: selector, forControlEvents: .TouchUpInside)
        btn.layer.masksToBounds = false
        btn.layer.cornerRadius = 0
        btn.layer.shadowOffset = CGSizeMake(-1, 1)
        btn.layer.shadowRadius = 0
        btn.layer.shadowOpacity = 0.55
        btn.layer.shadowColor = UIColor.blackColor().CGColor
        btn.sizeToFit()
        
        return UIBarButtonItem(customView: btn)
    }
    
    public class func addButton(#target: AnyObject, selector: Selector) -> UIBarButtonItem {
        
        var plusIcon = FAKIonIcons.plusIconWithSize(25) // FAKFontAwesome.plusIconWithSize(25)
        plusIcon.addAttribute(NSForegroundColorAttributeName, value: UIColor.whiteColor())
        let rightImage = plusIcon.imageWithSize(CGSize(width: 25, height: 25))
        
        var btn = UIButton.buttonWithType(.Custom) as! UIButton
        
        btn.setImage(rightImage, forState: .Normal)
        btn.addTarget(target, action: selector, forControlEvents: .TouchUpInside)
        btn.layer.masksToBounds = false
        btn.layer.cornerRadius = 0
        btn.layer.shadowOffset = CGSizeMake(-1, 1)
        btn.layer.shadowRadius = 0
        btn.layer.shadowOpacity = 0.55
        btn.layer.shadowColor = UIColor.blackColor().CGColor
        btn.sizeToFit()
        
        return UIBarButtonItem(customView: btn)
    }
    
    public class func saveButton(#target: AnyObject, selector: Selector) -> UIBarButtonItem {
        
        var icon = FAKIonIcons.checkmarkIconWithSize(25) // FAKFontAwesome.plusIconWithSize(25)
        icon.addAttribute(NSForegroundColorAttributeName, value: UIColor.whiteColor())
        let image = icon.imageWithSize(CGSize(width: 25, height: 25))
        
        var btn = UIButton.buttonWithType(.Custom) as! UIButton
        
        btn.setImage(image, forState: .Normal)
        btn.addTarget(target, action: selector, forControlEvents: .TouchUpInside)
        btn.layer.masksToBounds = false
        btn.layer.cornerRadius = 0
        btn.layer.shadowOffset = CGSizeMake(-1, 1)
        btn.layer.shadowRadius = 0
        btn.layer.shadowOpacity = 0.55
        btn.layer.shadowColor = UIColor.blackColor().CGColor
        btn.sizeToFit()
        
        return UIBarButtonItem(customView: btn)
    }
    
    public class func cancelButton(#target: AnyObject, selector: Selector) -> UIBarButtonItem {
        
        var icon = FAKIonIcons.closeIconWithSize(25) // FAKFontAwesome.plusIconWithSize(25)
        icon.addAttribute(NSForegroundColorAttributeName, value: UIColor.whiteColor())
        let image = icon.imageWithSize(CGSize(width: 25, height: 25))
        
        var btn = UIButton.buttonWithType(.Custom) as! UIButton

        btn.setImage(image, forState: .Normal)
        btn.addTarget(target, action: selector, forControlEvents: .TouchUpInside)
        btn.layer.masksToBounds = false
        btn.layer.cornerRadius = 0
        btn.layer.shadowOffset = CGSizeMake(-1, 1)
        btn.layer.shadowRadius = 0
        btn.layer.shadowOpacity = 0.55
        btn.layer.shadowColor = UIColor.blackColor().CGColor
        btn.sizeToFit()
        
        return UIBarButtonItem(customView: btn)
    }
    
    public class func watchButton(#target: AnyObject, selector: Selector) -> UIBarButtonItem {
        
        var icon = FAKIonIcons.iosGlassesOutlineIconWithSize(35)
        icon.addAttribute(NSForegroundColorAttributeName, value: UIColor.whiteColor())
        let image = icon.imageWithSize(CGSize(width: 35, height: 35))
        
        var btn = UIButton.buttonWithType(.Custom) as! UIButton
        btn.setImage(image, forState: .Normal)
        btn.tintColor = UIColor.whiteColor()
        btn.addTarget(target, action: selector, forControlEvents: .TouchUpInside)
        btn.layer.masksToBounds = false
        btn.layer.cornerRadius = 0
        btn.layer.shadowOffset = CGSizeMake(-1, 1)
        btn.layer.shadowRadius = 0
        btn.layer.shadowOpacity = 0.55
        btn.layer.shadowColor = UIColor.blackColor().CGColor
        btn.sizeToFit()
        
        return UIBarButtonItem(customView: btn)
    }

    public class func menuButton(#target: AnyObject, selector: Selector) -> UIBarButtonItem {
        
        var icon = FAKIonIcons.naviconIconWithSize(35)
        icon.addAttribute(NSForegroundColorAttributeName, value: UIColor.whiteColor())
        let image = icon.imageWithSize(CGSize(width: 35, height: 35))
        
        var btn = UIButton.buttonWithType(.Custom) as! UIButton
        btn.setImage(image, forState: .Normal)
        btn.tintColor = UIColor.whiteColor()
        btn.addTarget(target, action: selector, forControlEvents: .TouchUpInside)
        btn.layer.masksToBounds = false
        btn.layer.cornerRadius = 0
        btn.layer.shadowOffset = CGSizeMake(-1, 1)
        btn.layer.shadowRadius = 0
        btn.layer.shadowOpacity = 0.55
        btn.layer.shadowColor = UIColor.blackColor().CGColor
        btn.sizeToFit()
        
        return UIBarButtonItem(customView: btn)
    }
}
