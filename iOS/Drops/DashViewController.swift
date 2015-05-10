//
//  DashViewController.swift
//  Drops
//
//  Created by Logan Isitt on 5/6/15.
//  Copyright (c) 2015 Logan Isitt. All rights reserved.
//

import UIKit

import iAd

import Cartography

class DashViewController: UIViewController,
ADBannerViewDelegate, ClientDelegate,
UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource,
UITableViewDelegate, UITableViewDataSource {
    
    // Views
    var collectionView: UICollectionView!
    var tableView: UITableView!
    
    var events: [Event] = [Event]()
    
    var ad: ADBannerView!
    // MARK: - General
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Nav Bar
        navigationItem.title = "Dash"
        navigationItem.hidesBackButton = true
        
        let attributes = [NSFontAttributeName: UIFont.ioniconOfSize(25)] as Dictionary!
        
        let addBtn: UIBarButtonItem = UIBarButtonItem(title: String.ioniconWithName(.Plus), style: .Plain, target: self, action: Selector("addBtnAction"))
        
        addBtn.setTitleTextAttributes(attributes, forState: .Normal)
        
        navigationItem.rightBarButtonItem = addBtn
        
        let profileBtn: UIBarButtonItem = UIBarButtonItem(title: String.ioniconWithName(.Navicon), style: .Plain, target: self, action: Selector("menuBtnAction"))
        
        profileBtn.setTitleTextAttributes(attributes, forState: .Normal)
        
        navigationItem.leftBarButtonItem = profileBtn
        
//        // iAd
//        self.canDisplayBannerAds = true
//        
//        ad = ADBannerView(adType: ADAdType.Banner)
//        
//        ad.delegate = self
        
        // collectionView
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        
        layout.scrollDirection = UICollectionViewScrollDirection.Horizontal

        collectionView = UICollectionView(frame: CGRect.zeroRect, collectionViewLayout: layout)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.pagingEnabled = true
        
        collectionView.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        
        // tableView
        tableView = UITableView(frame: CGRect.zeroRect, style: UITableViewStyle.Grouped)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        view.addSubview(collectionView)
        view.addSubview(tableView)
//        view.addSubview(ad)
        
        layoutSubviews()
        
        Client.sharedInstance.delegate = self
        Client.sharedInstance.getAllEvents()
    }
    
    // MARK: - Actions
    
    @IBAction func addBtnAction() {
        performSegueWithIdentifier("gotoCreate", sender: self)
    }
    
    @IBAction func menuBtnAction() {
        performSegueWithIdentifier("gotoMenu", sender: self)
    }
    
    // MARK: - Layout
    
    func layoutSubviews() {
        layout(collectionView, tableView) { view1, view2 in
            view1.leading == view1.superview!.leading
            view2.leading == view2.superview!.leading
//            view3.leading == view3.superview!.leading
            
            view1.trailing == view1.superview!.trailing
            view2.trailing == view2.superview!.trailing
//            view3.trailing == view3.superview!.trailing
            
            view1.top == view1.superview!.top
            //            view2.top == view1.bottom
            
            view1.height == (view1.superview!.height) / 2
            view2.height == view1.height
            
            view2.bottom == view2.superview!.bottom //view3.top
            
//            view3.bottom == view3.superview!.bottom
//            view3.height == 50
        }
    }
    
    // MARK: - ADBannerViewDelegate
    
    func bannerView(banner: ADBannerView!, didFailToReceiveAdWithError error: NSError!) {
        println("banner: didFailToReceiveAdWithError")
    }
    
    // MARK: - UICollectionViewDelegate
    
    // MARK: - UICollectionViewDataSource
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return events.count
    }
    
    // The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell: UICollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! UICollectionViewCell
        
        cell.backgroundColor = UIColor.redColor()
        
        return cell
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        let height = collectionView.bounds.height - 20.0
        return CGSizeMake(height, height)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 0.0
    }
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSizeZero
        
    }
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSizeZero
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row == 0 {
            performSegueWithIdentifier("gotoInbox", sender: self)
        }
    }
    
    // MARK: - UITableViewDataSource
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier("Cell") as! UITableViewCell
        
        if indexPath.row == 0 {
            cell.textLabel?.text = "Inbox"
        }
        
        return cell
    }
    
    // MARK: - ClientDelegate
    func received(events: [Event]) {
        self.events = events
        
        collectionView.reloadData()
    }
}