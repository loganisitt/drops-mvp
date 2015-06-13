//
//  SSListingCell.swift
//  swagswap
//
//  Created by Logan Isitt on 2/28/15.
//  Copyright (c) 2015 Logan Isitt. All rights reserved.
//

import UIKit

import MaterialKit

class ListingCell: UICollectionViewCell {
    
    let shadowOffset = CGSize(width: -2, height: 2)

    var imageView: UIImageView!
    var titleLabel: MKLabel!
    var priceLabel: MKLabel!
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        layoutViews()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setupViews()
        layoutViews()
    }
    
    // MARK: - Views
    
    func setupViews() {
//        
//        layer.cornerRadius = 0
//        layer.shadowOpacity = 0.55
//        layer.shadowRadius = 0
//        layer.shadowColor = UIColor.blackColor().CGColor
//        layer.shadowOffset = shadowOffset
        
        backgroundView = MKImageView()

        (backgroundView as! MKImageView).contentMode = UIViewContentMode.ScaleAspectFill
        (backgroundView as! MKImageView).rippleLayerColor = UIColor.grayColor()
        
//        (backgroundView as! MKImageView).layer.cornerRadius = 0
//        (backgroundView as! MKImageView).layer.shadowOpacity = 0.55
//        (backgroundView as! MKImageView).layer.shadowRadius = 0
//        (backgroundView as! MKImageView).layer.shadowColor = UIColor.blackColor().CGColor
//        (backgroundView as! MKImageView).layer.shadowOffset = shadowOffset
        
        titleLabel = MKLabel()
        titleLabel.backgroundColor = UIColor.whiteColor()
        titleLabel.textColor = UIColor.blackColor()
        titleLabel.textAlignment = .Left
        titleLabel.font = UIFont.boldSystemFontOfSize(16)
        titleLabel.backgroundLayerColor = UIColor.clearColor()
        
//        titleLabel.layer.cornerRadius = 0
//        titleLabel.layer.shadowOpacity = 0.55
//        titleLabel.layer.shadowRadius = 0
//        titleLabel.layer.shadowColor = UIColor.whiteColor().CGColor
//        titleLabel.layer.shadowOffset = CGSizeMake(-1, 1)
        
        priceLabel = MKLabel()
        priceLabel.backgroundColor = UIColor.whiteColor()
        priceLabel.textColor = UIColor.blackColor()
        priceLabel.textAlignment = .Right
        priceLabel.font = UIFont.boldSystemFontOfSize(16)
        priceLabel.backgroundLayerColor = UIColor.clearColor()
        
//        priceLabel.layer.cornerRadius = 0
//        priceLabel.layer.shadowOpacity = 0.55
//        priceLabel.layer.shadowRadius = 0
//        priceLabel.layer.shadowColor = UIColor.whiteColor().CGColor
//        priceLabel.layer.shadowOffset = CGSizeMake(-1, 1)
        
        addSubview(titleLabel)
        addSubview(priceLabel)
    }
    
    // MARK: - Layout
    
    func layoutViews() {
        
        backgroundView!.autoPinEdgesToSuperviewMargins()
        
        titleLabel.autoPinEdge(.Left, toEdge: .Left, ofView: backgroundView)
        titleLabel.autoPinEdgeToSuperviewEdge(.Bottom)
        
        titleLabel.autoSetDimension(.Height, toSize: 20)
        
        priceLabel.autoPinEdge(.Left, toEdge: .Right, ofView: titleLabel, withOffset: 0)
        priceLabel.autoPinEdge(.Right, toEdge: .Right, ofView: backgroundView)
        priceLabel.autoPinEdgeToSuperviewEdge(.Bottom)
        
        priceLabel.autoSetDimension(.Height, toSize: 20)
        priceLabel.autoSetDimension(.Width, toSize: 50)
    }
}
