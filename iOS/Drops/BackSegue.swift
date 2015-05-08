//
//  BackSegue.swift
//  Drops
//
//  Created by Logan Isitt on 5/7/15.
//  Copyright (c) 2015 Logan Isitt. All rights reserved.
//

import UIKit

class BackSegue: UIStoryboardSegue {
    
    override func perform()
    {
        (sourceViewController as! UIViewController).navigationController?.popToViewController(destinationViewController as! UIViewController, animated: true)
    }
}
