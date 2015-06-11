//
//  DashViewController.swift
//  Drops
//
//  Created by Logan Isitt on 5/6/15.
//  Copyright (c) 2015 Logan Isitt. All rights reserved.
//

import UIKit

import PureLayout
import Haneke

class DashViewController: UIViewController,
ClientDelegate,
UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource,
UITableViewDelegate, UITableViewDataSource {
    
    // Views
    var collectionView: UICollectionView!
    var tableView: UITableView!
//    var toolbar: UIToolbar!
//    var optionBar: UISegmentedControl!

    var listings: [Listing] = [Listing]()
    
    // MARK: - General
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Client 
        Client.sharedInstance.delegate = self
        Client.sharedInstance.getAllListings()
        
        // Nav Bar
        navigationItem.title = "Dash"
        navigationItem.hidesBackButton = true
        
        navigationController?.navigationBar.barTintColor = UIColor.SSColor.Red
        navigationController?.navigationBar.hidden = false
        
        var searchBtn = UIBarButtonItem(title: String.fontAwesomeIconWithName(.Search), style: .Done, target: self, action: "searchButtonPressed")
        searchBtn.setTitleTextAttributes([NSFontAttributeName: UIFont.fontAwesomeOfSize(20)], forState: .Normal)
        
        self.navigationItem.rightBarButtonItem  = searchBtn
        
        setupViews()
        
        layoutSubviews()
    }
    
    // MARK: - Views
    
    func setupViews() {
        
        // collectionView
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .Horizontal
        
        collectionView = UICollectionView(frame: CGRect.zeroRect, collectionViewLayout: layout)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.registerNib(UINib(nibName: "ListingCell", bundle: NSBundle.mainBundle()), forCellWithReuseIdentifier: "Cell")

        collectionView.pagingEnabled = true
        
        collectionView.backgroundColor = UIColor.whiteColor()
        
        // tableView
        tableView = UITableView(frame: .zeroRect, style: .Plain)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.registerNib(UINib(nibName: "MenuCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "Cell")
        
        tableView.rowHeight = 60
        tableView.sectionHeaderHeight = 0
        tableView.sectionFooterHeight = 0
        
        tableView.tableFooterView = UIView(frame: .zeroRect)
        
//        // optionBar
//        optionBar = UISegmentedControl(items: ["Trending", "Featured", "Suggested"])
//        
//        optionBar.tintColor = UIColor.SSColor.White
//        optionBar.setTitleTextAttributes([NSFontAttributeName: UIFont.SSFont.H5!], forState: .Normal)
//        optionBar.setTitleTextAttributes([NSFontAttributeName: UIFont.SSFont.H5!], forState: .Highlighted)
//        
//        // toolbar
//        toolbar = UIToolbar(frame: .zeroRect)
//        
//        toolbar.barTintColor = self.navigationController?.navigationBar.barTintColor
//        toolbar.translucent = false
//        
//        var optionBtn: UIBarButtonItem = UIBarButtonItem(customView: optionBar)
//        var flex: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: .FlexibleSpace, target: nil, action: nil)
//        
//        toolbar.items = [flex, optionBtn, flex]
//        
//        view.addSubview(toolbar)
        view.addSubview(collectionView)
        view.addSubview(tableView)
    }
    
    // MARK: - Layout
    
    func layoutSubviews() {
        
        collectionView.autoPinToTopLayoutGuideOfViewController(self, withInset: 0)
        collectionView.autoPinEdgeToSuperviewEdge(.Right)
        collectionView.autoPinEdgeToSuperviewEdge(.Left)
        collectionView.autoSetDimension(.Height, toSize: view.bounds.height/2.0)
    
        tableView.autoPinEdge(.Top, toEdge: .Bottom, ofView: collectionView)
        tableView.autoPinEdgeToSuperviewEdge(.Right)
        tableView.autoPinEdgeToSuperviewEdge(.Left)
        tableView.autoPinToBottomLayoutGuideOfViewController(self, withInset: 0)
    }
    
    // MARK: - Actions
    
    @IBAction func searchButtonPressed() {
        self.performSegueWithIdentifier("gotoSearch", sender: self)
    }
    
    // MARK: - UICollectionViewDataSource
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return count(listings)
    }
    
    // The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        var cell: ListingCell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! ListingCell
        
        let obj = listings[indexPath.row] as Listing
        
        var path = obj.imagePaths[0].substringFromIndex(advance(obj.imagePaths[0].startIndex, 8))
            
        let url = NSURL(string: Client.sharedInstance.baseUrl + path)!
        
        cell.imageView.hnk_setImageFromURL(url)
        cell.titleText.text = obj.name
        cell.priceText.text = "$\(obj.price)"
        
        return cell
    }
    
    // MARK: - UICollectionView Delegate
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("gotoListing", sender: self)
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
        switch indexPath.row {
//        case 0: performSegueWithIdentifier("gotoBuy", sender: self); break
        case 1: performSegueWithIdentifier("gotoSell", sender: self); break
//        case 2: performSegueWithIdentifier("gotoWatch", sender: self); break
//        case 3: performSegueWithIdentifier("gotoInbox", sender: self); break
//        case 5: performSegueWithIdentifier("gotoAccount", sender: self); break
        default: break
        }
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    // MARK: - TableView Data Source
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell: MenuCell = tableView.dequeueReusableCellWithIdentifier("Cell") as! MenuCell
        
        cell.menuItem = MenuCell.MenuItem(rawValue: indexPath.row)
        
        return cell
    }
    
    // MARK: - ClientDelegate
    func receivedListings(listings: [Listing]) {
        self.listings = listings
        
        collectionView.reloadData()
    }
    
    // MARK: - UIViewController
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "gotoListing" {
            let vc = segue.destinationViewController as! ListingViewController
            let index = collectionView.indexPathsForSelectedItems()[0].row
            vc.listing = listings[index!]
        }
    }
}