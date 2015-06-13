//
//  DataViewController.swift
//  Go
//
//  Created by Logan Isitt on 6/3/15.
//  Copyright (c) 2015 Logan Isitt. All rights reserved.
//

import UIKit

import PureLayout
import MaterialKit

class DataViewController: UIViewController {
    
    let shadowOffset = CGSize(width: -2, height: 2)
    
    var featureLabel: MKLabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        featureLabel = MKLabel()
        featureLabel.text = title
        featureLabel.textColor = UIColor.thrift_white()
        featureLabel.textAlignment = .Center
        featureLabel.font = UIFont.boldSystemFontOfSize(50)
        featureLabel.backgroundLayerColor = UIColor.clearColor()
        
        featureLabel.layer.cornerRadius = 0
        featureLabel.layer.shadowOpacity = 0.55
        featureLabel.layer.shadowRadius = 0
        featureLabel.layer.shadowColor = UIColor.blackColor().CGColor
        featureLabel.layer.shadowOffset = shadowOffset
        
        view.addSubview(featureLabel)

        featureLabel.autoPinEdgesToSuperviewMargins()
        
        view.backgroundColor = UIColor.clearColor()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
}