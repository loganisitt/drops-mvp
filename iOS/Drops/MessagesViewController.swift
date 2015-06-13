//
//  MessagesViewController.swift
//  Drops
//
//  Created by Logan Isitt on 5/10/15.
//  Copyright (c) 2015 Logan Isitt. All rights reserved.
//

import UIKit

class MessageViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, MessageToolbarDelegate {
    
    var tableView: UITableView!
    var messagetoolbar: MessageToolbar!
    
    var mUser: User = User()
    var tUser: User = User()
        {
        willSet(newUser) {
            
        }
        didSet {
            loadMessages()
            self.navigationItem.title = tUser.name
        }
    }
    
    var messages = [Message]()
    
    var bottomConstraint: NSLayoutConstraint!
    
    // MARK: - General
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.backButton(target: self, selector: "backButtonAction")
        
        let notificationCenter = NSNotificationCenter.defaultCenter()
        notificationCenter.addObserver(self, selector: Selector("receivedMessage:"), name:"SSMessageReceivedNotification", object: nil)
        
        // tableView
        tableView = UITableView(frame: CGRect.zeroRect, style: UITableViewStyle.Grouped)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.keyboardDismissMode = UIScrollViewKeyboardDismissMode.OnDrag
        
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        view.addSubview(tableView)
        
        // messagetoolbar
        messagetoolbar = MessageToolbar(frame: CGRect.zeroRect)
        messagetoolbar.delegate = self
        
        view.addSubview(messagetoolbar)
        
        NSNotificationCenter.defaultCenter()
            .addObserver(self, selector: Selector("keyboardWillShow:"), name:UIKeyboardWillShowNotification, object: nil);
        NSNotificationCenter.defaultCenter()
            .addObserver(self, selector: Selector("keyboardWillHide:"), name:UIKeyboardWillHideNotification, object: nil);
        
        NSNotificationCenter.defaultCenter()
            .addObserver(self, selector: Selector("keyboardDidShow:"), name:UIKeyboardDidShowNotification, object: nil);
        NSNotificationCenter.defaultCenter()
            .addObserver(self, selector: Selector("keyboardDidHide:"), name:UIKeyboardDidHideNotification, object: nil);
        
        layoutSubviews()
        
        Client.sharedInstance.connectSocket()
    }
    
    // MARK: - Actions
    
    @IBAction func backButtonAction() {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    func loadMessages() {
        mUser = User() //PFUser.currentUser()
        
        //        var mQuery = PFQuery(className: parseClassName)
        //        mQuery.whereKey("sender", equalTo: mUser)
        //        mQuery.whereKey("recipient", equalTo: tUser)
        //
        //        var tQuery = PFQuery(className: parseClassName)
        //        tQuery.whereKey("sender", equalTo: tUser)
        //        tQuery.whereKey("recipient", equalTo: mUser)
        //
        //        var query = PFQuery.orQueryWithSubqueries([mQuery, tQuery])
        //        query.orderByAscending("createdAt")
        //
        //        query.findObjectsInBackgroundWithBlock { (objects: [AnyObject]?, error: NSError?) -> Void in
        //            self.messages = objects as! [Message]
        //
        //            self.tableView.reloadData()
        //        }
    }
    
    // MARK: - UITableView Data Source
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5 // messages.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier("Cell") as! UITableViewCell
        
        //        cell.textLabel?.text = messages[indexPath.row].text
        //        cell.textLabel?.textAlignment = messages[indexPath.row].sender.id == mUser.id ? NSTextAlignment.Right : NSTextAlignment.Left
        
        return cell
    }
    
    // MARK: - Message Toolbar Delegate
    
    func sendMessage(content: String){
        var message: Message = Message()
        
        message.sender = mUser
        message.recipient = tUser
        message.text = content
        
        Client.sharedInstance.send(message)
        
        //        message.saveInBackgroundWithBlock({ (success: Bool, error: NSError?) -> Void in
        //            if success == true {
        //
        //                self.messages.append(message)
        //
        //                let indexPath: NSIndexPath = NSIndexPath(forRow: self.messages.count-1, inSection: 0)
        //
        //                self.tableView.beginUpdates()
        //                self.tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
        //                self.tableView.endUpdates()
        //
        //                self.tableView.scrollToRowAtIndexPath(indexPath, atScrollPosition: UITableViewScrollPosition.Top, animated: true)
        //            }
        //        })
    }
    
    func scrollUp() {
        
        //        let indexPath: NSIndexPath = NSIndexPath(forRow: self.messages.count-1, inSection: 0)
        
        //        tableView.scrollToRowAtIndexPath(indexPath, atScrollPosition: UITableViewScrollPosition.Bottom, animated: true)
    }
    
    // MARK: - Notifications
    
    func receivedMessage(notification: NSNotification) {
        let userInfo = notification.userInfo!
        
        var message: Message = Message()
        
        message.sender = tUser
        message.recipient = mUser
        message.text = userInfo["content"] as! String
        
        self.messages.append(message)
        
        let indexPath: NSIndexPath = NSIndexPath(forRow: self.messages.count-1, inSection: 0)
        
        self.tableView.beginUpdates()
        self.tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
        self.tableView.endUpdates()
        
        self.tableView.scrollToRowAtIndexPath(indexPath, atScrollPosition: UITableViewScrollPosition.Top, animated: true)
    }
    
    // MARK: - Layout
    
    func layoutSubviews() {
        
        tableView.autoPinToTopLayoutGuideOfViewController(self, withInset: 0)
        tableView.autoPinEdgeToSuperviewEdge(.Left)
        tableView.autoPinEdgeToSuperviewEdge(.Right)
        
        messagetoolbar.autoPinEdge(.Top, toEdge: .Bottom, ofView: tableView)
        messagetoolbar.autoPinEdgeToSuperviewEdge(.Left)
        messagetoolbar.autoPinEdgeToSuperviewEdge(.Right)
        bottomConstraint = messagetoolbar.autoPinToBottomLayoutGuideOfViewController(self, withInset: 0)
        messagetoolbar.autoSetDimension(.Height, toSize: 44)
    }
    
    // MARK: - Keyboard
    
    func keyboardWillShow(notification: NSNotification) {
        
        let userInfo = notification.userInfo!
        
        let animationDuration = (userInfo[UIKeyboardAnimationDurationUserInfoKey] as! NSNumber).doubleValue
        let keyboardEndFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue()
        let convertedKeyboardEndFrame = view.convertRect(keyboardEndFrame, fromView: view)
        let rawAnimationCurve = (notification.userInfo![UIKeyboardAnimationCurveUserInfoKey] as! NSNumber).unsignedIntValue << 16
        let animationCurve = UIViewAnimationOptions.init(UInt(rawAnimationCurve))
        
        bottomConstraint.constant = 0 - keyboardEndFrame.height
        
        UIView.animateWithDuration(animationDuration, delay: 0.0, options: .BeginFromCurrentState | animationCurve, animations: {
            self.view.layoutIfNeeded()
            }, completion: nil)
    }
    
    func keyboardWillHide(notification: NSNotification) {
        
        let userInfo = notification.userInfo!
        
        let animationDuration = (userInfo[UIKeyboardAnimationDurationUserInfoKey] as! NSNumber).doubleValue
        let keyboardEndFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue()
        let convertedKeyboardEndFrame = view.convertRect(keyboardEndFrame, fromView: view)
        let rawAnimationCurve = (notification.userInfo![UIKeyboardAnimationCurveUserInfoKey] as! NSNumber).unsignedIntValue << 16
        let animationCurve = UIViewAnimationOptions.init(UInt(rawAnimationCurve))
        
        bottomConstraint.constant = 0
        
        UIView.animateWithDuration(animationDuration, delay: 0.0, options: .BeginFromCurrentState | animationCurve, animations: {
            self.view.layoutIfNeeded()
            }, completion: nil)
    }
    
    func keyboardDidShow(notification: NSNotification) {
        scrollUp()
    }
    
    func keyboardDidHide(notification: NSNotification) {
        scrollUp()
    }
}