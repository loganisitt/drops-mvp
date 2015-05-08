//
//  CreateViewController.swift
//  Drops
//
//  Created by Logan Isitt on 5/6/15.
//  Copyright (c) 2015 Logan Isitt. All rights reserved.
//

import UIKit

class CreateViewController: UIViewController {
    
    // MARK: - General
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Nav Bar
        navigationItem.title = "Create"
        
        let saveBtn: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Save, target: self, action: Selector("saveEventBtn"))
        navigationItem.rightBarButtonItem = saveBtn
    }
    
    // MARK: - Actions
    @IBAction func saveEventBtn() {
        
        let eventData = ["adminId": "123", "type": "Park",
            "date": NSDate(), "locationName": "Park", "maxAttendees": 20]
        
        Client.sharedInstance.createEvent(eventData)
    }
}
