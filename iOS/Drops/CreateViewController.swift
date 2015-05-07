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
        
        let testEvent: Event = Event()
        testEvent.adminId = "123"
        testEvent.locationName = "Park"
        testEvent.maxAttendees = 20
        testEvent.type = "Basketball"
        testEvent.date = NSDate()
        
        Client.sharedInstance.createEvent(testEvent)
    }
}
