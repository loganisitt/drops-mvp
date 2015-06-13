//
//  UIColor+Drops.swift
//  Drops
//
//  Created by Logan Isitt on 5/27/15.
//  Copyright (c) 2015 Logan Isitt. All rights reserved.
//

extension UIColor {
    
    convenience init(rgba: String) {
        var red:   CGFloat = 0.0
        var green: CGFloat = 0.0
        var blue:  CGFloat = 0.0
        var alpha: CGFloat = 1.0
        
        if rgba.hasPrefix("#") {
            let index   = advance(rgba.startIndex, 1)
            let hex     = rgba.substringFromIndex(index)
            let scanner = NSScanner(string: hex)
            var hexValue: CUnsignedLongLong = 0
            if scanner.scanHexLongLong(&hexValue) {
                switch (count(hex)) {
                case 3:
                    red   = CGFloat((hexValue & 0xF00) >> 8)       / 15.0
                    green = CGFloat((hexValue & 0x0F0) >> 4)       / 15.0
                    blue  = CGFloat(hexValue & 0x00F)              / 15.0
                case 4:
                    red   = CGFloat((hexValue & 0xF000) >> 12)     / 15.0
                    green = CGFloat((hexValue & 0x0F00) >> 8)      / 15.0
                    blue  = CGFloat((hexValue & 0x00F0) >> 4)      / 15.0
                    alpha = CGFloat(hexValue & 0x000F)             / 15.0
                case 6:
                    red   = CGFloat((hexValue & 0xFF0000) >> 16)   / 255.0
                    green = CGFloat((hexValue & 0x00FF00) >> 8)    / 255.0
                    blue  = CGFloat(hexValue & 0x0000FF)           / 255.0
                case 8:
                    red   = CGFloat((hexValue & 0xFF000000) >> 24) / 255.0
                    green = CGFloat((hexValue & 0x00FF0000) >> 16) / 255.0
                    blue  = CGFloat((hexValue & 0x0000FF00) >> 8)  / 255.0
                    alpha = CGFloat(hexValue & 0x000000FF)         / 255.0
                default:
                    print("Invalid RGB string, number of characters after '#' should be either 3, 4, 6 or 8")
                }
            } else {
                println("Scan hex error")
            }
        } else {
            print("Invalid RGB string, missing '#' as prefix")
        }
        self.init(red:red, green:green, blue:blue, alpha:alpha)
    }
    
    public class func thrift_main_color() -> UIColor {
        return thrift_green()
    }
    
    public class func thrift_red() -> UIColor {
        return UIColor(rgba: "#9C2003")
    }
    
    public class func thrift_yellow() -> UIColor {
        return UIColor(rgba: "#F7CA18")
    }
    
    public class func thrift_orange() -> UIColor {
        return UIColor(rgba: "#E79335")
    }
    
    public class func thrift_blue() -> UIColor {
        return UIColor(rgba: "#267191")
    }
    
    public class func thrift_light_blue() -> UIColor {
        return UIColor(rgba: "#3F829F")
    }
    
    public class func thrift_green() -> UIColor {
        return UIColor(rgba: "#26A65B")
    }
    
    public class func thrift_white() -> UIColor {
        return UIColor(rgba: "#FFFFFF")
    }
    
    public class func thrift_gray() -> UIColor {
        return UIColor(rgba: "#EEEEED")
    }
}
