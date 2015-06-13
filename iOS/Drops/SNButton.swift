//
//  SNButton.swift
//  Go
//
//  Created by Logan Isitt on 6/3/15.
//  Copyright (c) 2015 Logan Isitt. All rights reserved.
//

import UIKit

import MaterialKit
//import FontAwesomeKit

import PureLayout

enum Network: Int {
    case Facebook = 0, Twitter, Email
}

class SNButton: MKButton {
    
    let shadowOffset = CGSize(width: -2, height: 2)
    
    var didSetContraints: Bool = false
    
    var padding: CGFloat = 16.0 {
        didSet {
            contentEdgeInsets = UIEdgeInsetsMake(CGFloat(0), padding, CGFloat(0), padding)
        }
    }
    
    var hasIcon: Bool = true {
        didSet {
            if hasIcon {
                titleLabel?.hidden = true
                iconLabel.hidden = false
                promptLabel.hidden = false
            }
            else {
                titleLabel?.hidden = false
                iconLabel.hidden = true
                promptLabel.hidden = true
            }
        }
    }
    
    var iconLabel: UILabel!
    var promptLabel: UILabel!
    
    var network: Network = .Facebook {
        didSet {
            switch(network) {
            case .Facebook:
                iconLabel.text = String.fontAwesomeIconWithName(.Facebook)
                promptLabel.text = "Connect with Facebook"
                backgroundColor = UIColor(hex: 0x3B5998)

            case .Twitter:
                iconLabel.text = String.fontAwesomeIconWithName(.Twitter)
                promptLabel.text = "Connect with Twitter"
                backgroundColor = UIColor(hex: 0x00aced)
                
            case .Email:
                iconLabel.text = String.fontAwesomeIconWithName(.EnvelopeO)
                promptLabel.text = "Connect with Email"
                backgroundColor = UIColor.thrift_red()

            default:
                iconLabel.text = String.fontAwesomeIconWithName(.Twitter)
                promptLabel.text = "Connect with Twitter"
                backgroundColor = UIColor(hex: 0x00aced)

            }
        }
    }
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setup()
    }
    
    init(network: Network) {
        super.init(frame: CGRect.zeroRect)
        self.network = network
    }
    
    // MARK: - Setup
    
    func setup() {
        
        iconLabel = UILabel()
        iconLabel.textColor = UIColor.whiteColor()
        iconLabel.textAlignment = .Center
        iconLabel.font = UIFont.fontAwesomeOfSize(40)
//        iconLabel.adjustsFontSizeToFitWidth = true
        
        iconLabel.layer.cornerRadius = 0
        iconLabel.layer.shadowOpacity = 0.55
        iconLabel.layer.shadowRadius = 0
        iconLabel.layer.shadowColor = UIColor.blackColor().CGColor
        iconLabel.layer.shadowOffset = shadowOffset

        
        promptLabel = UILabel()
        promptLabel.text = "Connect with Twitter"
        promptLabel.textColor = UIColor.whiteColor()
        promptLabel.textAlignment = .Left
        promptLabel.font = UIFont.boldSystemFontOfSize(25)
        promptLabel.adjustsFontSizeToFitWidth = true
        
        promptLabel.layer.cornerRadius = 0
        promptLabel.layer.shadowOpacity = 0.55
        promptLabel.layer.shadowRadius = 0
        promptLabel.layer.shadowColor = UIColor.blackColor().CGColor
        promptLabel.layer.shadowOffset = shadowOffset
        
        titleLabel!.textColor = UIColor.whiteColor()
        titleLabel!.textAlignment = .Center
        titleLabel!.font = UIFont.boldSystemFontOfSize(25)
        titleLabel!.adjustsFontSizeToFitWidth = true
        
        titleLabel!.layer.cornerRadius = 0
        titleLabel!.layer.shadowOpacity = 0.55
        titleLabel!.layer.shadowRadius = 0
        titleLabel!.layer.shadowColor = UIColor.blackColor().CGColor
        titleLabel!.layer.shadowOffset = shadowOffset
        
        addSubview(iconLabel)
        addSubview(promptLabel)
        
        rippleLayerColor = UIColor.grayColor()
       
        layer.cornerRadius = 0
        layer.shadowOpacity = 0.55
        layer.shadowRadius = 0
        layer.shadowColor = UIColor.blackColor().CGColor
        layer.shadowOffset = shadowOffset
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if !CGSizeEqualToSize(bounds.size, .zeroSize)  && !didSetContraints{
            constrainSubviews()
            didSetContraints = true
            padding = 16.0
        }
    }
    
    func constrainSubviews() {

        iconLabel.autoPinEdgeToSuperviewEdge(.Left, withInset: padding)
        iconLabel.autoPinEdgeToSuperviewEdge(.Top)
        iconLabel.autoPinEdgeToSuperviewEdge(.Bottom)
        iconLabel.autoSetDimension(.Width, toSize: bounds.height)
        
        promptLabel.autoPinEdge(.Left, toEdge: .Right, ofView: iconLabel, withOffset: padding)
        promptLabel.autoPinEdgeToSuperviewEdge(.Top)
        promptLabel.autoPinEdgeToSuperviewEdge(.Right, withInset: padding)
        promptLabel.autoPinEdgeToSuperviewEdge(.Bottom)
    }
}
