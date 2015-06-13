//
//  InboxViewController.swift
//  Drops
//
//  Created by Logan Isitt on 5/10/15.
//  Copyright (c) 2015 Logan Isitt. All rights reserved.
//

import UIKit

class InboxViewController: UITableViewController {
  
    // MARK: - General 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Inbox"
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.backButton(target: self, selector: "backButtonAction")

        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }
    
    // MARK: - Actions
    
    func backButtonAction() {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    // MARK: - UITableViewDelegate
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row == 0 {
            performSegueWithIdentifier("gotoMessages", sender: self)
        }
    }
    
    // MARK: - UITableViewDataSource
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier("Cell") as! UITableViewCell
        
        if indexPath.row == 0 {
            cell.textLabel?.text = "513600"
        }
        
        return cell
    }
}
