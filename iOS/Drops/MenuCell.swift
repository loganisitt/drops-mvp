//
//  SSMenuCell.swift
//  swagswap
//
//  Created by Logan Isitt on 3/5/15.
//  Copyright (c) 2015 Logan Isitt. All rights reserved.
//

import UIKit

class MenuCell: UITableViewCell {
    
    enum MenuItem:Int {
        case Buy = 0, Sell, Watch, Inbox, Notification, Account, Default
    }
    
    @IBOutlet var title: UILabel!
    @IBOutlet var icon: UILabel!
    @IBOutlet var accessory: UILabel!
    
    var menuItem: MenuItem!
    var indentationLayer: CALayer!
    
    // MARK: - Initialization
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: - Setup
    func setup() {

        defaults()
        
        indentationWidth = 10.0
        indentationLevel = 1
        
        indentationLayer = CALayer()
        indentationLayer.backgroundColor = UIColor.thrift_blue().CGColor
        layer.addSublayer(indentationLayer)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if menuItem == nil {
            menuItem = .Default
        }
        
        title.text = getTitle(menuItem).uppercaseString
        title.textColor = UIColor.blackColor()
        title.textAlignment = NSTextAlignment.Left
        title.font = UIFont.SSFont.H3
        
        accessory.text = String.fontAwesomeIconWithName(.AngleRight)
        accessory.textColor = UIColor.blackColor()
        accessory.textAlignment = NSTextAlignment.Right
        accessory.font = UIFont.fontAwesomeOfSize(30)
        
        icon.text = getIcon(menuItem)
        icon.textColor = UIColor.blackColor()
        icon.textAlignment = NSTextAlignment.Center
        icon.font = UIFont.fontAwesomeOfSize(30)
        
        indentationLayer.backgroundColor = getColor(menuItem).CGColor
    }
    
    // MARK: - Menu Item
    private func getTitle(mi: MenuItem) -> String {
        switch mi {
        case .Buy:          return "Buying"
        case .Sell:         return "Selling"
        case .Watch:        return "Watching"
        case .Inbox:        return "Inbox"
        case .Notification: return "Notifications"
        case .Account:      return "Account"
        default:            return ""
        }
    }
    
    private func getIcon(mi: MenuItem) -> String {
        switch mi {
        case .Buy:          return String.fontAwesomeIconWithName(.ShoppingCart)
        case .Sell:         return String.fontAwesomeIconWithName(.Tag)
        case .Watch:        return String.fontAwesomeIconWithName(.Eye)
        case .Inbox:        return String.fontAwesomeIconWithName(.Inbox)
        case .Notification: return String.fontAwesomeIconWithName(.Bell)
        case .Account:      return String.fontAwesomeIconWithName(.Cogs)
        default:            return ""
        }
    }
    
    private func getColor(mi: MenuItem) -> UIColor {
        switch mi {
        case .Buy:          return UIColor.thrift_yellow()
        case .Sell:         return UIColor.thrift_red()
        case .Watch:        return UIColor.thrift_light_blue()
        case .Inbox:        return UIColor.thrift_blue()
        case .Notification: return UIColor.thrift_light_blue()
        case .Account:      return UIColor.blackColor()
        default:            return UIColor.blackColor()
        }
    }
    
    // MARK: - Draw
    override func drawRect(rect: CGRect) {
        super.drawRect(rect)
        indentationLayer.frame = CGRectMake(0, 0, indentationWidth, rect.height)
    }
    
    // MARK: - Defaults
    func defaults() {
        
        // Remove seperator inset
        if respondsToSelector("setSeparatorInset:") {
            separatorInset = UIEdgeInsetsZero
        }
        // Prevent the cell from inheriting the Table View's margin settings
        if respondsToSelector("setPreservesSuperviewLayoutMargins:") {
            preservesSuperviewLayoutMargins = false
        }
        // Explictly set your cell's layout margins
        if respondsToSelector("setLayoutMargins:") {
            layoutMargins = UIEdgeInsetsZero
        }
    }
}
