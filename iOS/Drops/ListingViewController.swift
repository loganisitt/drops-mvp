//
//  SSListingViewController.swift
//  swagswap
//
//  Created by Logan Isitt on 3/21/15.
//  Copyright (c) 2015 Logan Isitt. All rights reserved.
//

import UIKit
import ObjectMapper

class ListingViewController: UITableViewController {
    
    var pageControl: UIPageControl!
    
    var listing: Listing! {
        didSet {
            let JSONString = Mapper().toJSONString(listing, prettyPrint: true)
            println(JSONString)
        }
    }
    
    var imgIndex = 0
    var imgHeight: Int = 0
    
    // MARK: - General
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Listing"
        
//        navigationItem.leftBarButtonItem = UIBarButtonItem().SSBackButton("backButtonPressed", target: self)
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 20
        
        tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        
        tableView.backgroundColor = UIColor.SSColor.White
        tableView.backgroundView?.backgroundColor = UIColor.SSColor.White
        
        view.backgroundColor = UIColor.SSColor.White
        
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "CCell")
        tableView.registerNib(UINib(nibName: "ListingDetailCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "LDCell")
        tableView.registerNib(UINib(nibName: "ListingImageCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "LICell")
    }
    
    
    
    // MARK: - Actions
    
    @IBAction func backButtonPressed() {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    func sendMessage(content: String) {
        
        var message: Message = Message()
        
        message.sender = Client.sharedInstance.currentUser
        message.recipient = listing.seller
        message.text = content
    }
    
//    func makeOffer(offer: String) {
//        
//        let val: Double = (offer as NSString).doubleValue
//        
//        var offer: PFObject = PFObject(className: "Offer")
//        
//        offer.setValue(PFUser.currentUser(), forKey: "bidder")
//        offer.setValue(listing, forKey: "listing")
//        offer.setValue(val, forKey: "Value")
//        
//        offer.saveInBackgroundWithBlock({ (success:Bool, error:NSError?) -> Void in
//            
//        })
//    }
    
    @IBAction func nextImageSwipe() {
        let preChange = imgIndex
        let imageCount = count(listing.imagePaths)
        
        imgIndex++
        
        if imgIndex >= imageCount {
            imgIndex = 0
        }
        
        if preChange != imgIndex {
            tableView.beginUpdates()
            pageControl.currentPage = imgIndex
            tableView.reloadRowsAtIndexPaths([NSIndexPath(forRow: 0, inSection: 0)], withRowAnimation: UITableViewRowAnimation.Left)
            tableView.endUpdates()
        }
    }
    
    @IBAction func prevImageSwipe() {
        let preChange = imgIndex
        let imageCount = count(listing.imagePaths)
        
        imgIndex--
        
        if imgIndex < 0 {
            imgIndex = imageCount - 1
        }
        
        if preChange != imgIndex {
            tableView.beginUpdates()
            pageControl.currentPage = imgIndex
            tableView.reloadRowsAtIndexPaths([NSIndexPath(forRow: 0, inSection: 0)], withRowAnimation: UITableViewRowAnimation.Right)
            tableView.endUpdates()
        }
    }
    
    // MARK: UITableView Data Source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 5
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 || section == 2 || section == 3 ? 1 : section == 1 ? 3 : 1
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell: ListingImageCell = tableView.dequeueReusableCellWithIdentifier("LICell") as! ListingImageCell
            
            cell.backgroundColor = UIColor.SSColor.White
            
            var path = listing.imagePaths[imgIndex].substringFromIndex(advance(listing.imagePaths[imgIndex].startIndex, 8))
            
            let url = NSURL(string: Client.sharedInstance.baseUrl + path)!
            
            cell.listingImageView!.hnk_setImageFromURL(url)

            
            let leftSwipe: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: "nextImageSwipe")
            leftSwipe.direction = UISwipeGestureRecognizerDirection.Left
            
            cell.addGestureRecognizer(leftSwipe)
            
            let rightSwipe: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: "prevImageSwipe")
            rightSwipe.direction = UISwipeGestureRecognizerDirection.Right
            
            cell.addGestureRecognizer(rightSwipe)
                        
            return cell
        }
        
        else if indexPath.section == 1 {
            
            let cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier("CCell") as! UITableViewCell
            
            cell.backgroundColor = UIColor.SSColor.White
            
            cell.textLabel?.textColor = UIColor.SSColor.Black
            
            if indexPath.row == 0 {
                cell.textLabel?.text = listing.name
                
                cell.textLabel?.textAlignment = NSTextAlignment.Center
                
                cell.textLabel?.font = UIFont.SSFont.H4
            }
            else if indexPath.row == 1 {
                
                cell.textLabel?.text = "$\(listing.price!)"
                cell.textLabel?.textAlignment = NSTextAlignment.Center
                
                cell.textLabel?.font = UIFont.SSFont.H6
            }
            else { // indexPath.row == 2
                
                let cell: ListingDetailCell = tableView.dequeueReusableCellWithIdentifier("LDCell") as! ListingDetailCell
                
                cell.detailText?.text = listing.description
                cell.detailText.numberOfLines = 0
                
                cell.detailText.font = UIFont.SSFont.H6
                
                return cell
            }
            return cell
        }
        else if indexPath.section == 2 {
            
            let cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier("CCell") as! UITableViewCell
            
            cell.textLabel?.text = "Watch"
            cell.textLabel?.textColor = UIColor.SSColor.White
            cell.textLabel?.textAlignment = NSTextAlignment.Center

            cell.textLabel?.font = UIFont.SSFont.H4
            
            cell.backgroundColor = UIColor.SSColor.Yellow
            
            return cell
        }
        else if indexPath.section == 3 {
            
            let cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier("CCell") as! UITableViewCell
            
            cell.textLabel?.text = "Make Offer"
            cell.textLabel?.textColor = UIColor.SSColor.White
            cell.textLabel?.textAlignment = NSTextAlignment.Center
            
            cell.textLabel?.font = UIFont.SSFont.H4
            
            cell.backgroundColor = UIColor.SSColor.Blue
            
            return cell
        }
        else {
            let cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier("CCell") as! UITableViewCell
            
            cell.backgroundColor = UIColor.SSColor.White
            cell.textLabel?.text = listing.seller.name

            return cell
        }
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 4 ? "Seller" : ""
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }

    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return self.view.bounds.width
        }
        else if indexPath.section == 1 {
            
            let buff = CGFloat(4.0)
            
            if indexPath.row == 0 {
                return UIFont.SSFont.H4!.pointSize + buff
            }
            else if indexPath.row == 1 {
                return UIFont.SSFont.H6!.pointSize + buff
            }
            else {
                return UITableViewAutomaticDimension
            }
        }
        else if indexPath.section == 2 || indexPath.section == 3 {
            return 44
        }
        else {
            return 44
        }
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 4 || section == 0 ? 20 : section == 2 || section == 3 ? 4 : 1
    }
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return section == 0 ? 20 : section == 2 || section == 3 ? 4 : 1
    }
    
    override func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        if (section != 0) {
            return nil
        }
        
        let height = CGFloat(20)
        let buffer = CGFloat(0)
        
        let h = height - (2 * buffer)
        let w = view.bounds.width - (2 * buffer)
        
        var v = UIView(frame: CGRectMake(0, 0, view.bounds.width, height))
        
        if (pageControl == nil) {
            
            pageControl = UIPageControl(frame: CGRectMake(0, 0, self.view.frame.width, 20))
            
            pageControl.currentPage = 0
            pageControl.numberOfPages = count(listing.imagePaths)
            
            pageControl.currentPageIndicatorTintColor = UIColor.SSColor.Blue
            pageControl.pageIndicatorTintColor = UIColor.SSColor.LightBlue
        }
        v.addSubview(pageControl)
        
        return v
    }
    
    // MARK: - UITableView Delegate
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        if indexPath.section == 2 && indexPath.row == 0 {
//            
//            if seller == Client.sharedInstance.currentUser {
//                return
//            }
//            
//            var watch: PFObject = PFObject(className: "Watch")
//            
//            watch.setValue(Client.sharedInstance.currentUser, forKey: "watcher")
//            watch.setValue(listing, forKey: "listing")
//            
//            watch.saveInBackgroundWithBlock({ (success: Bool, error:NSError?) -> Void in
//                
//            })
//        }
//        if indexPath.section == 3 && indexPath.row == 0 {
//
//            if seller == PFUser.currentUser() {
//                return
//            }
//            
//            let name = seller.valueForKey("name") as? String
//            let price = listing.valueForKey("price") as! Double
//            let alertController = UIAlertController(title: "New Offer", message: "Highest bid: $\(price)", preferredStyle: .Alert)
//            
//            let offerAction = UIAlertAction(title: "Make Offer", style: .Default) { (_) in
//                let offerTextField = alertController.textFields![0] as! UITextField
//                self.makeOffer(offerTextField.text)
//            }
//            offerAction.enabled = false
//            
//            let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel) { (_) in }
//            
//            alertController.addTextFieldWithConfigurationHandler { (textField) in
//                textField.placeholder = "Offer..."
//                textField.keyboardType = UIKeyboardType.DecimalPad
//                
//                NSNotificationCenter.defaultCenter().addObserverForName(UITextFieldTextDidChangeNotification, object: textField, queue: NSOperationQueue.mainQueue()) { (notification) in
//                    offerAction.enabled = textField.text != ""
//                }
//            }
//            
//            alertController.addAction(offerAction)
//            alertController.addAction(cancelAction)
//            
//            self.presentViewController(alertController, animated: true, completion: nil)
//        }
        if indexPath.section == 4 && indexPath.row == 3 {
            
            if listing.seller == Client.sharedInstance.currentUser {
                return
            }
            
            let name = listing.seller.name
            let alertController = UIAlertController(title: "New message", message: "Sending a message to \(name)", preferredStyle: .Alert)
            
            let messageAction = UIAlertAction(title: "Send", style: .Default) { (_) in
                let messageTextField = alertController.textFields![0] as! UITextField
                self.sendMessage(messageTextField.text)
            }
            messageAction.enabled = false
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel) { (_) in }
            
            alertController.addTextFieldWithConfigurationHandler { (textField) in
                
                textField.placeholder = "Message..."
                
                NSNotificationCenter.defaultCenter().addObserverForName(UITextFieldTextDidChangeNotification, object: textField, queue: NSOperationQueue.mainQueue()) { (notification) in
                    messageAction.enabled = textField.text != ""
                }
            }
            
            alertController.addAction(messageAction)
            alertController.addAction(cancelAction)
            
            self.presentViewController(alertController, animated: true, completion: nil)
        }
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
}